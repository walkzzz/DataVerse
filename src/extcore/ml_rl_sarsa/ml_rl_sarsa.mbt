///===
/// extcore/ml_rl_sarsa

pub(all) struct MlrlsarsaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_sarsa_make_point(x : Double, y : Double) -> MlrlsarsaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_sarsa_make_point3(x : Double, y : Double, z : Double) -> MlrlsarsaPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_sarsa_point_x(pt : MlrlsarsaPoint) -> Double { pt.x }

pub fn ml_rl_sarsa_point_y(pt : MlrlsarsaPoint) -> Double { pt.y }

pub fn ml_rl_sarsa_point_z(pt : MlrlsarsaPoint) -> Double { pt.z }

pub fn ml_rl_sarsa_point_label(pt : MlrlsarsaPoint) -> Int { pt.label }

pub fn ml_rl_sarsa_point_dist(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ml_rl_sarsa_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_sarsa_point_add(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> MlrlsarsaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_sarsa_point_sub(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> MlrlsarsaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_sarsa_point_scale(pt : MlrlsarsaPoint, s : Double) -> MlrlsarsaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_sarsa_point_dot(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_sarsa_point_cross(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> MlrlsarsaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_sarsa_point_norm(pt : MlrlsarsaPoint) -> Double {
  ml_rl_sarsa_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_sarsa_point_normalize(pt : MlrlsarsaPoint) -> MlrlsarsaPoint {
  let n = ml_rl_sarsa_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_sarsa_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_sarsa_point_negate(pt : MlrlsarsaPoint) -> MlrlsarsaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_sarsa_point_mid(a : MlrlsarsaPoint, b : MlrlsarsaPoint) -> MlrlsarsaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_sarsa_point_lerp(a : MlrlsarsaPoint, b : MlrlsarsaPoint, t : Double) -> MlrlsarsaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_sarsa_point_to_string(pt : MlrlsarsaPoint) -> String {
  "(" + ml_rl_sarsa_dbl(pt.x) + ", " + ml_rl_sarsa_dbl(pt.y) + ", " + ml_rl_sarsa_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrlsarsaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_sarsa_make_series(vals : Array[Double], name : String) -> MlrlsarsaSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_sarsa_series_len(s : MlrlsarsaSeries) -> Int { s.vals.length() }

pub fn ml_rl_sarsa_series_sum(s : MlrlsarsaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_rl_sarsa_series_mean(s : MlrlsarsaSeries) -> Double {
  let n = ml_rl_sarsa_series_len(s)
  if n == 0 { 0.0 } else { ml_rl_sarsa_series_sum(s) / n.to_double() }
}

pub fn ml_rl_sarsa_series_min(s : MlrlsarsaSeries) -> Double {
  let n = ml_rl_sarsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_rl_sarsa_series_max(s : MlrlsarsaSeries) -> Double {
  let n = ml_rl_sarsa_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_rl_sarsa_series_range(s : MlrlsarsaSeries) -> Double {
  ml_rl_sarsa_series_max(s) - ml_rl_sarsa_series_min(s)
}

pub fn ml_rl_sarsa_series_var(s : MlrlsarsaSeries) -> Double {
  let n = ml_rl_sarsa_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_rl_sarsa_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_rl_sarsa_series_std(s : MlrlsarsaSeries) -> Double { ml_rl_sarsa_sqrt(ml_rl_sarsa_series_var(s)) }

pub fn ml_rl_sarsa_series_median(s : MlrlsarsaSeries) -> Double {
  let n = ml_rl_sarsa_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_rl_sarsa_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_rl_sarsa_series_scale(s : MlrlsarsaSeries, f : Double) -> MlrlsarsaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ml_rl_sarsa_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_rl_sarsa_series_add(a : MlrlsarsaSeries, b : MlrlsarsaSeries) -> MlrlsarsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_rl_sarsa_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_sarsa_series_sub(a : MlrlsarsaSeries, b : MlrlsarsaSeries) -> MlrlsarsaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ml_rl_sarsa_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_sarsa_series_normalize(s : MlrlsarsaSeries) -> MlrlsarsaSeries {
  let mn = ml_rl_sarsa_series_min(s)
  let mx = ml_rl_sarsa_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ml_rl_sarsa_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_sarsa_series_cumsum(s : MlrlsarsaSeries) -> MlrlsarsaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ml_rl_sarsa_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_sarsa_series_to_string(s : MlrlsarsaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_rl_sarsa_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlsarsaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_sarsa_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlsarsaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_sarsa_matrix_identity(n : Int) -> MlrlsarsaMatrix {
  let m = ml_rl_sarsa_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_sarsa_matrix_get(m : MlrlsarsaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_sarsa_matrix_transpose(m : MlrlsarsaMatrix) -> MlrlsarsaMatrix {
  let result = ml_rl_sarsa_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_sarsa_matrix_add(a : MlrlsarsaMatrix, b : MlrlsarsaMatrix) -> MlrlsarsaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_sarsa_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_sarsa_matrix_scale(m : MlrlsarsaMatrix, s : Double) -> MlrlsarsaMatrix {
  let result = ml_rl_sarsa_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_sarsa_matrix_multiply(a : MlrlsarsaMatrix, b : MlrlsarsaMatrix) -> MlrlsarsaMatrix {
  if a.cols != b.rows { return ml_rl_sarsa_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_sarsa_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_sarsa_matrix_trace(m : MlrlsarsaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_sarsa_matrix_det(m : MlrlsarsaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_sarsa_matrix_norm(m : MlrlsarsaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ml_rl_sarsa_sqrt(sum)
}

pub fn ml_rl_sarsa_matrix_to_string(m : MlrlsarsaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ml_rl_sarsa_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct MlrlsarsaVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_sarsa_make_vector(comps : Array[Double]) -> MlrlsarsaVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_sarsa_vector_zero(dim : Int) -> MlrlsarsaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_sarsa_vector_add(a : MlrlsarsaVector, b : MlrlsarsaVector) -> MlrlsarsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_rl_sarsa_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_sarsa_vector_sub(a : MlrlsarsaVector, b : MlrlsarsaVector) -> MlrlsarsaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ml_rl_sarsa_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_sarsa_vector_scale(v : MlrlsarsaVector, s : Double) -> MlrlsarsaVector {
  let mut result = []
  for i in 0..<v.dim { result = ml_rl_sarsa_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_rl_sarsa_vector_dot(a : MlrlsarsaVector, b : MlrlsarsaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_sarsa_vector_norm(v : MlrlsarsaVector) -> Double { ml_rl_sarsa_sqrt(ml_rl_sarsa_vector_dot(v, v)) }

pub fn ml_rl_sarsa_vector_normalize(v : MlrlsarsaVector) -> MlrlsarsaVector {
  let n = ml_rl_sarsa_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_sarsa_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_sarsa_vector_dist(a : MlrlsarsaVector, b : MlrlsarsaVector) -> Double {
  ml_rl_sarsa_vector_norm(ml_rl_sarsa_vector_sub(a, b))
}

pub fn ml_rl_sarsa_vector_to_string(v : MlrlsarsaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ml_rl_sarsa_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_sarsa_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_rl_sarsa_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_rl_sarsa_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_rl_sarsa_std(data : Array[Double]) -> Double { ml_rl_sarsa_sqrt(ml_rl_sarsa_var(data)) }

pub fn ml_rl_sarsa_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_rl_sarsa_mean(a); let mb = ml_rl_sarsa_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_rl_sarsa_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_rl_sarsa_std(a); let sb = ml_rl_sarsa_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_rl_sarsa_cov(a, b) / (sa * sb) }
}

pub fn ml_rl_sarsa_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_rl_sarsa_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_rl_sarsa_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_rl_sarsa_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_rl_sarsa_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ml_rl_sarsa_sqrt(ml_rl_sarsa_mse(pred, labels))
}

pub fn ml_rl_sarsa_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ml_rl_sarsa_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_rl_sarsa_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_rl_sarsa_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_rl_sarsa_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_rl_sarsa_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_rl_sarsa_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_rl_sarsa_precision(pred, labels, pos); let r = ml_rl_sarsa_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_rl_sarsa_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_rl_sarsa_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_rl_sarsa_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_rl_sarsa_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_rl_sarsa_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_rl_sarsa_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_rl_sarsa_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_rl_sarsa_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_rl_sarsa_fibonacci(n : Int) -> Int {
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

pub fn ml_rl_sarsa_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_rl_sarsa_min(data); let mx = ml_rl_sarsa_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_rl_sarsa_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_rl_sarsa_mean(data); let sd = ml_rl_sarsa_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_rl_sarsa_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_rl_sarsa_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_rl_sarsa_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_rl_sarsa_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ml_rl_sarsa_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ml_rl_sarsa_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ml_rl_sarsa_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ml_rl_sarsa_int(x) } else { -ml_rl_sarsa_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ml_rl_sarsa_int(f * 1000000.0) } else { ml_rl_sarsa_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ml_rl_sarsa_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ml_rl_sarsa_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct MlrlsarsaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_frame_make(size : Int) -> MlrlsarsaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_frame_len(s : MlrlsarsaFrame) -> Int { s.size }

pub fn ml_rl_sarsa_frame_get(s : MlrlsarsaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_frame_set(s : MlrlsarsaFrame, i : Int, v : Double) -> MlrlsarsaFrame {
  let result = ml_rl_sarsa_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_frame_sum(s : MlrlsarsaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_frame_mean(s : MlrlsarsaFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_frame_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_frame_scale(s : MlrlsarsaFrame, f : Double) -> MlrlsarsaFrame {
  let result = ml_rl_sarsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_frame_add(a : MlrlsarsaFrame, b : MlrlsarsaFrame) -> MlrlsarsaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_frame_copy(s : MlrlsarsaFrame) -> MlrlsarsaFrame {
  let result = ml_rl_sarsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_frame_fill(s : MlrlsarsaFrame, v : Double) -> MlrlsarsaFrame {
  let result = ml_rl_sarsa_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_frame_min(s : MlrlsarsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_frame_max(s : MlrlsarsaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_frame_to_string(s : MlrlsarsaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_table_make(size : Int) -> MlrlsarsaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_table_len(s : MlrlsarsaTable) -> Int { s.size }

pub fn ml_rl_sarsa_table_get(s : MlrlsarsaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_table_set(s : MlrlsarsaTable, i : Int, v : Double) -> MlrlsarsaTable {
  let result = ml_rl_sarsa_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_table_sum(s : MlrlsarsaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_table_mean(s : MlrlsarsaTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_table_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_table_scale(s : MlrlsarsaTable, f : Double) -> MlrlsarsaTable {
  let result = ml_rl_sarsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_table_add(a : MlrlsarsaTable, b : MlrlsarsaTable) -> MlrlsarsaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_table_copy(s : MlrlsarsaTable) -> MlrlsarsaTable {
  let result = ml_rl_sarsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_table_fill(s : MlrlsarsaTable, v : Double) -> MlrlsarsaTable {
  let result = ml_rl_sarsa_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_table_min(s : MlrlsarsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_table_max(s : MlrlsarsaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_table_to_string(s : MlrlsarsaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_graphn_make(size : Int) -> MlrlsarsaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_graphn_len(s : MlrlsarsaGraphN) -> Int { s.size }

pub fn ml_rl_sarsa_graphn_get(s : MlrlsarsaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_graphn_set(s : MlrlsarsaGraphN, i : Int, v : Double) -> MlrlsarsaGraphN {
  let result = ml_rl_sarsa_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_graphn_sum(s : MlrlsarsaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_graphn_mean(s : MlrlsarsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_graphn_scale(s : MlrlsarsaGraphN, f : Double) -> MlrlsarsaGraphN {
  let result = ml_rl_sarsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_graphn_add(a : MlrlsarsaGraphN, b : MlrlsarsaGraphN) -> MlrlsarsaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_graphn_copy(s : MlrlsarsaGraphN) -> MlrlsarsaGraphN {
  let result = ml_rl_sarsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_graphn_fill(s : MlrlsarsaGraphN, v : Double) -> MlrlsarsaGraphN {
  let result = ml_rl_sarsa_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_graphn_min(s : MlrlsarsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_graphn_max(s : MlrlsarsaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_graphn_to_string(s : MlrlsarsaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_node_make(size : Int) -> MlrlsarsaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_node_len(s : MlrlsarsaNode) -> Int { s.size }

pub fn ml_rl_sarsa_node_get(s : MlrlsarsaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_node_set(s : MlrlsarsaNode, i : Int, v : Double) -> MlrlsarsaNode {
  let result = ml_rl_sarsa_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_node_sum(s : MlrlsarsaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_node_mean(s : MlrlsarsaNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_node_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_node_scale(s : MlrlsarsaNode, f : Double) -> MlrlsarsaNode {
  let result = ml_rl_sarsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_node_add(a : MlrlsarsaNode, b : MlrlsarsaNode) -> MlrlsarsaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_node_copy(s : MlrlsarsaNode) -> MlrlsarsaNode {
  let result = ml_rl_sarsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_node_fill(s : MlrlsarsaNode, v : Double) -> MlrlsarsaNode {
  let result = ml_rl_sarsa_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_node_min(s : MlrlsarsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_node_max(s : MlrlsarsaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_node_to_string(s : MlrlsarsaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_edge_make(size : Int) -> MlrlsarsaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_edge_len(s : MlrlsarsaEdge) -> Int { s.size }

pub fn ml_rl_sarsa_edge_get(s : MlrlsarsaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_edge_set(s : MlrlsarsaEdge, i : Int, v : Double) -> MlrlsarsaEdge {
  let result = ml_rl_sarsa_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_edge_sum(s : MlrlsarsaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_edge_mean(s : MlrlsarsaEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_edge_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_edge_scale(s : MlrlsarsaEdge, f : Double) -> MlrlsarsaEdge {
  let result = ml_rl_sarsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_edge_add(a : MlrlsarsaEdge, b : MlrlsarsaEdge) -> MlrlsarsaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_edge_copy(s : MlrlsarsaEdge) -> MlrlsarsaEdge {
  let result = ml_rl_sarsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_edge_fill(s : MlrlsarsaEdge, v : Double) -> MlrlsarsaEdge {
  let result = ml_rl_sarsa_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_edge_min(s : MlrlsarsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_edge_max(s : MlrlsarsaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_edge_to_string(s : MlrlsarsaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_path_make(size : Int) -> MlrlsarsaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_path_len(s : MlrlsarsaPath) -> Int { s.size }

pub fn ml_rl_sarsa_path_get(s : MlrlsarsaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_path_set(s : MlrlsarsaPath, i : Int, v : Double) -> MlrlsarsaPath {
  let result = ml_rl_sarsa_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_path_sum(s : MlrlsarsaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_path_mean(s : MlrlsarsaPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_path_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_path_scale(s : MlrlsarsaPath, f : Double) -> MlrlsarsaPath {
  let result = ml_rl_sarsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_path_add(a : MlrlsarsaPath, b : MlrlsarsaPath) -> MlrlsarsaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_path_copy(s : MlrlsarsaPath) -> MlrlsarsaPath {
  let result = ml_rl_sarsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_path_fill(s : MlrlsarsaPath, v : Double) -> MlrlsarsaPath {
  let result = ml_rl_sarsa_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_path_min(s : MlrlsarsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_path_max(s : MlrlsarsaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_path_to_string(s : MlrlsarsaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_cluster_make(size : Int) -> MlrlsarsaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_cluster_len(s : MlrlsarsaCluster) -> Int { s.size }

pub fn ml_rl_sarsa_cluster_get(s : MlrlsarsaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_cluster_set(s : MlrlsarsaCluster, i : Int, v : Double) -> MlrlsarsaCluster {
  let result = ml_rl_sarsa_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_cluster_sum(s : MlrlsarsaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_cluster_mean(s : MlrlsarsaCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_cluster_scale(s : MlrlsarsaCluster, f : Double) -> MlrlsarsaCluster {
  let result = ml_rl_sarsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_cluster_add(a : MlrlsarsaCluster, b : MlrlsarsaCluster) -> MlrlsarsaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_cluster_copy(s : MlrlsarsaCluster) -> MlrlsarsaCluster {
  let result = ml_rl_sarsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_cluster_fill(s : MlrlsarsaCluster, v : Double) -> MlrlsarsaCluster {
  let result = ml_rl_sarsa_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_cluster_min(s : MlrlsarsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_cluster_max(s : MlrlsarsaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_cluster_to_string(s : MlrlsarsaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_model_make(size : Int) -> MlrlsarsaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_model_len(s : MlrlsarsaModel) -> Int { s.size }

pub fn ml_rl_sarsa_model_get(s : MlrlsarsaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_model_set(s : MlrlsarsaModel, i : Int, v : Double) -> MlrlsarsaModel {
  let result = ml_rl_sarsa_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_model_sum(s : MlrlsarsaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_model_mean(s : MlrlsarsaModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_model_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_model_scale(s : MlrlsarsaModel, f : Double) -> MlrlsarsaModel {
  let result = ml_rl_sarsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_model_add(a : MlrlsarsaModel, b : MlrlsarsaModel) -> MlrlsarsaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_model_copy(s : MlrlsarsaModel) -> MlrlsarsaModel {
  let result = ml_rl_sarsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_model_fill(s : MlrlsarsaModel, v : Double) -> MlrlsarsaModel {
  let result = ml_rl_sarsa_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_model_min(s : MlrlsarsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_model_max(s : MlrlsarsaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_model_to_string(s : MlrlsarsaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_layer_make(size : Int) -> MlrlsarsaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_layer_len(s : MlrlsarsaLayer) -> Int { s.size }

pub fn ml_rl_sarsa_layer_get(s : MlrlsarsaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_layer_set(s : MlrlsarsaLayer, i : Int, v : Double) -> MlrlsarsaLayer {
  let result = ml_rl_sarsa_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_layer_sum(s : MlrlsarsaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_layer_mean(s : MlrlsarsaLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_layer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_layer_scale(s : MlrlsarsaLayer, f : Double) -> MlrlsarsaLayer {
  let result = ml_rl_sarsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_layer_add(a : MlrlsarsaLayer, b : MlrlsarsaLayer) -> MlrlsarsaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_layer_copy(s : MlrlsarsaLayer) -> MlrlsarsaLayer {
  let result = ml_rl_sarsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_layer_fill(s : MlrlsarsaLayer, v : Double) -> MlrlsarsaLayer {
  let result = ml_rl_sarsa_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_layer_min(s : MlrlsarsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_layer_max(s : MlrlsarsaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_layer_to_string(s : MlrlsarsaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_buffer_make(size : Int) -> MlrlsarsaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_buffer_len(s : MlrlsarsaBuffer) -> Int { s.size }

pub fn ml_rl_sarsa_buffer_get(s : MlrlsarsaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_buffer_set(s : MlrlsarsaBuffer, i : Int, v : Double) -> MlrlsarsaBuffer {
  let result = ml_rl_sarsa_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_buffer_sum(s : MlrlsarsaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_buffer_mean(s : MlrlsarsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_buffer_scale(s : MlrlsarsaBuffer, f : Double) -> MlrlsarsaBuffer {
  let result = ml_rl_sarsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_buffer_add(a : MlrlsarsaBuffer, b : MlrlsarsaBuffer) -> MlrlsarsaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_buffer_copy(s : MlrlsarsaBuffer) -> MlrlsarsaBuffer {
  let result = ml_rl_sarsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_buffer_fill(s : MlrlsarsaBuffer, v : Double) -> MlrlsarsaBuffer {
  let result = ml_rl_sarsa_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_buffer_min(s : MlrlsarsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_buffer_max(s : MlrlsarsaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_buffer_to_string(s : MlrlsarsaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_cursor_make(size : Int) -> MlrlsarsaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_cursor_len(s : MlrlsarsaCursor) -> Int { s.size }

pub fn ml_rl_sarsa_cursor_get(s : MlrlsarsaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_cursor_set(s : MlrlsarsaCursor, i : Int, v : Double) -> MlrlsarsaCursor {
  let result = ml_rl_sarsa_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_cursor_sum(s : MlrlsarsaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_cursor_mean(s : MlrlsarsaCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_cursor_scale(s : MlrlsarsaCursor, f : Double) -> MlrlsarsaCursor {
  let result = ml_rl_sarsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_cursor_add(a : MlrlsarsaCursor, b : MlrlsarsaCursor) -> MlrlsarsaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_cursor_copy(s : MlrlsarsaCursor) -> MlrlsarsaCursor {
  let result = ml_rl_sarsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_cursor_fill(s : MlrlsarsaCursor, v : Double) -> MlrlsarsaCursor {
  let result = ml_rl_sarsa_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_cursor_min(s : MlrlsarsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_cursor_max(s : MlrlsarsaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_cursor_to_string(s : MlrlsarsaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_view_make(size : Int) -> MlrlsarsaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_view_len(s : MlrlsarsaView) -> Int { s.size }

pub fn ml_rl_sarsa_view_get(s : MlrlsarsaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_view_set(s : MlrlsarsaView, i : Int, v : Double) -> MlrlsarsaView {
  let result = ml_rl_sarsa_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_view_sum(s : MlrlsarsaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_view_mean(s : MlrlsarsaView) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_view_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_view_scale(s : MlrlsarsaView, f : Double) -> MlrlsarsaView {
  let result = ml_rl_sarsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_view_add(a : MlrlsarsaView, b : MlrlsarsaView) -> MlrlsarsaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_view_copy(s : MlrlsarsaView) -> MlrlsarsaView {
  let result = ml_rl_sarsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_view_fill(s : MlrlsarsaView, v : Double) -> MlrlsarsaView {
  let result = ml_rl_sarsa_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_view_min(s : MlrlsarsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_view_max(s : MlrlsarsaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_view_to_string(s : MlrlsarsaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_range_make(size : Int) -> MlrlsarsaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_range_len(s : MlrlsarsaRange) -> Int { s.size }

pub fn ml_rl_sarsa_range_get(s : MlrlsarsaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_range_set(s : MlrlsarsaRange, i : Int, v : Double) -> MlrlsarsaRange {
  let result = ml_rl_sarsa_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_range_sum(s : MlrlsarsaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_range_mean(s : MlrlsarsaRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_range_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_range_scale(s : MlrlsarsaRange, f : Double) -> MlrlsarsaRange {
  let result = ml_rl_sarsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_range_add(a : MlrlsarsaRange, b : MlrlsarsaRange) -> MlrlsarsaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_range_copy(s : MlrlsarsaRange) -> MlrlsarsaRange {
  let result = ml_rl_sarsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_range_fill(s : MlrlsarsaRange, v : Double) -> MlrlsarsaRange {
  let result = ml_rl_sarsa_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_range_min(s : MlrlsarsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_range_max(s : MlrlsarsaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_range_to_string(s : MlrlsarsaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlsarsaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_sarsa_slice_make(size : Int) -> MlrlsarsaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_sarsa_slice_len(s : MlrlsarsaSlice) -> Int { s.size }

pub fn ml_rl_sarsa_slice_get(s : MlrlsarsaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_sarsa_slice_set(s : MlrlsarsaSlice, i : Int, v : Double) -> MlrlsarsaSlice {
  let result = ml_rl_sarsa_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_slice_sum(s : MlrlsarsaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_sarsa_slice_mean(s : MlrlsarsaSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_sarsa_slice_sum(s) / s.size.to_double() }
}

pub fn ml_rl_sarsa_slice_scale(s : MlrlsarsaSlice, f : Double) -> MlrlsarsaSlice {
  let result = ml_rl_sarsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_sarsa_slice_add(a : MlrlsarsaSlice, b : MlrlsarsaSlice) -> MlrlsarsaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_sarsa_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_sarsa_slice_copy(s : MlrlsarsaSlice) -> MlrlsarsaSlice {
  let result = ml_rl_sarsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_sarsa_slice_fill(s : MlrlsarsaSlice, v : Double) -> MlrlsarsaSlice {
  let result = ml_rl_sarsa_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_sarsa_slice_min(s : MlrlsarsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_slice_max(s : MlrlsarsaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_sarsa_slice_to_string(s : MlrlsarsaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ml_rl_sarsa_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ml_rl_sarsa_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

