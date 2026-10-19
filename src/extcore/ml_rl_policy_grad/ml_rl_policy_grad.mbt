///===
/// extcore/ml_rl_policy_grad

pub(all) struct MlrlpolicygradPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ml_rl_policy_grad_make_point(x : Double, y : Double) -> MlrlpolicygradPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ml_rl_policy_grad_make_point3(x : Double, y : Double, z : Double) -> MlrlpolicygradPoint {
  { x, y, z, label: 0 }
}

pub fn ml_rl_policy_grad_point_x(pt : MlrlpolicygradPoint) -> Double { pt.x }

pub fn ml_rl_policy_grad_point_y(pt : MlrlpolicygradPoint) -> Double { pt.y }

pub fn ml_rl_policy_grad_point_z(pt : MlrlpolicygradPoint) -> Double { pt.z }

pub fn ml_rl_policy_grad_point_label(pt : MlrlpolicygradPoint) -> Int { pt.label }

pub fn ml_rl_policy_grad_point_dist(a : MlrlpolicygradPoint, b : MlrlpolicygradPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ml_rl_policy_grad_point_add(a : MlrlpolicygradPoint, b : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ml_rl_policy_grad_point_sub(a : MlrlpolicygradPoint, b : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ml_rl_policy_grad_point_scale(pt : MlrlpolicygradPoint, s : Double) -> MlrlpolicygradPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ml_rl_policy_grad_point_dot(a : MlrlpolicygradPoint, b : MlrlpolicygradPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ml_rl_policy_grad_point_cross(a : MlrlpolicygradPoint, b : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ml_rl_policy_grad_point_norm(pt : MlrlpolicygradPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ml_rl_policy_grad_point_normalize(pt : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  let n = ml_rl_policy_grad_point_norm(pt)
  if n < 0.0000001 { pt } else { ml_rl_policy_grad_point_scale(pt, 1.0 / n) }
}

pub fn ml_rl_policy_grad_point_negate(pt : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ml_rl_policy_grad_point_mid(a : MlrlpolicygradPoint, b : MlrlpolicygradPoint) -> MlrlpolicygradPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ml_rl_policy_grad_point_lerp(a : MlrlpolicygradPoint, b : MlrlpolicygradPoint, t : Double) -> MlrlpolicygradPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ml_rl_policy_grad_point_to_string(pt : MlrlpolicygradPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct MlrlpolicygradSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ml_rl_policy_grad_make_series(vals : Array[Double], name : String) -> MlrlpolicygradSeries {
  { vals, name, meta: 0 }
}

pub fn ml_rl_policy_grad_series_len(s : MlrlpolicygradSeries) -> Int { s.vals.length() }

pub fn ml_rl_policy_grad_series_sum(s : MlrlpolicygradSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ml_rl_policy_grad_series_mean(s : MlrlpolicygradSeries) -> Double {
  let n = ml_rl_policy_grad_series_len(s)
  if n == 0 { 0.0 } else { ml_rl_policy_grad_series_sum(s) / n.to_double() }
}

pub fn ml_rl_policy_grad_series_min(s : MlrlpolicygradSeries) -> Double {
  let n = ml_rl_policy_grad_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_series_max(s : MlrlpolicygradSeries) -> Double {
  let n = ml_rl_policy_grad_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_series_range(s : MlrlpolicygradSeries) -> Double {
  ml_rl_policy_grad_series_max(s) - ml_rl_policy_grad_series_min(s)
}

pub fn ml_rl_policy_grad_series_var(s : MlrlpolicygradSeries) -> Double {
  let n = ml_rl_policy_grad_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ml_rl_policy_grad_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ml_rl_policy_grad_series_std(s : MlrlpolicygradSeries) -> Double { @_common.sqrt(ml_rl_policy_grad_series_var(s)) }

pub fn ml_rl_policy_grad_series_median(s : MlrlpolicygradSeries) -> Double {
  let n = ml_rl_policy_grad_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ml_rl_policy_grad_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_rl_policy_grad_series_scale(s : MlrlpolicygradSeries, f : Double) -> MlrlpolicygradSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ml_rl_policy_grad_series_add(a : MlrlpolicygradSeries, b : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ml_rl_policy_grad_series_sub(a : MlrlpolicygradSeries, b : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ml_rl_policy_grad_series_normalize(s : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  let mn = ml_rl_policy_grad_series_min(s)
  let mx = ml_rl_policy_grad_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ml_rl_policy_grad_series_cumsum(s : MlrlpolicygradSeries) -> MlrlpolicygradSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ml_rl_policy_grad_series_to_string(s : MlrlpolicygradSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct MlrlpolicygradMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ml_rl_policy_grad_make_matrix(rows : Int, cols : Int, val : Double) -> MlrlpolicygradMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ml_rl_policy_grad_matrix_identity(n : Int) -> MlrlpolicygradMatrix {
  let m = ml_rl_policy_grad_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ml_rl_policy_grad_matrix_get(m : MlrlpolicygradMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ml_rl_policy_grad_matrix_transpose(m : MlrlpolicygradMatrix) -> MlrlpolicygradMatrix {
  let result = ml_rl_policy_grad_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ml_rl_policy_grad_matrix_add(a : MlrlpolicygradMatrix, b : MlrlpolicygradMatrix) -> MlrlpolicygradMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ml_rl_policy_grad_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ml_rl_policy_grad_matrix_scale(m : MlrlpolicygradMatrix, s : Double) -> MlrlpolicygradMatrix {
  let result = ml_rl_policy_grad_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ml_rl_policy_grad_matrix_multiply(a : MlrlpolicygradMatrix, b : MlrlpolicygradMatrix) -> MlrlpolicygradMatrix {
  if a.cols != b.rows { return ml_rl_policy_grad_make_matrix(a.rows, b.cols, 0.0) }
  let result = ml_rl_policy_grad_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ml_rl_policy_grad_matrix_trace(m : MlrlpolicygradMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ml_rl_policy_grad_matrix_det(m : MlrlpolicygradMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ml_rl_policy_grad_matrix_norm(m : MlrlpolicygradMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ml_rl_policy_grad_matrix_to_string(m : MlrlpolicygradMatrix) -> String {
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

pub(all) struct MlrlpolicygradVector {
  comps : Array[Double]
  dim : Int
}

pub fn ml_rl_policy_grad_make_vector(comps : Array[Double]) -> MlrlpolicygradVector {
  { comps, dim: comps.length() }
}

pub fn ml_rl_policy_grad_vector_zero(dim : Int) -> MlrlpolicygradVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ml_rl_policy_grad_vector_add(a : MlrlpolicygradVector, b : MlrlpolicygradVector) -> MlrlpolicygradVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_policy_grad_vector_sub(a : MlrlpolicygradVector, b : MlrlpolicygradVector) -> MlrlpolicygradVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ml_rl_policy_grad_vector_scale(v : MlrlpolicygradVector, s : Double) -> MlrlpolicygradVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ml_rl_policy_grad_vector_dot(a : MlrlpolicygradVector, b : MlrlpolicygradVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ml_rl_policy_grad_vector_norm(v : MlrlpolicygradVector) -> Double { @_common.sqrt(ml_rl_policy_grad_vector_dot(v, v)) }

pub fn ml_rl_policy_grad_vector_normalize(v : MlrlpolicygradVector) -> MlrlpolicygradVector {
  let n = ml_rl_policy_grad_vector_norm(v)
  if n < 0.0000001 { v } else { ml_rl_policy_grad_vector_scale(v, 1.0 / n) }
}

pub fn ml_rl_policy_grad_vector_dist(a : MlrlpolicygradVector, b : MlrlpolicygradVector) -> Double {
  ml_rl_policy_grad_vector_norm(ml_rl_policy_grad_vector_sub(a, b))
}

pub fn ml_rl_policy_grad_vector_to_string(v : MlrlpolicygradVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ml_rl_policy_grad_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ml_rl_policy_grad_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ml_rl_policy_grad_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_rl_policy_grad_std(data : Array[Double]) -> Double { @_common.sqrt(ml_rl_policy_grad_var(data)) }

pub fn ml_rl_policy_grad_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ml_rl_policy_grad_mean(a); let mb = ml_rl_policy_grad_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ml_rl_policy_grad_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ml_rl_policy_grad_std(a); let sb = ml_rl_policy_grad_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ml_rl_policy_grad_cov(a, b) / (sa * sb) }
}

pub fn ml_rl_policy_grad_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ml_rl_policy_grad_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ml_rl_policy_grad_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ml_rl_policy_grad_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ml_rl_policy_grad_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ml_rl_policy_grad_mse(pred, labels))
}

pub fn ml_rl_policy_grad_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ml_rl_policy_grad_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ml_rl_policy_grad_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ml_rl_policy_grad_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ml_rl_policy_grad_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ml_rl_policy_grad_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ml_rl_policy_grad_precision(pred, labels, pos); let r = ml_rl_policy_grad_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ml_rl_policy_grad_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ml_rl_policy_grad_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ml_rl_policy_grad_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ml_rl_policy_grad_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ml_rl_policy_grad_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ml_rl_policy_grad_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ml_rl_policy_grad_gcd(a, b)
    (a / g) * b
  }
}

pub fn ml_rl_policy_grad_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ml_rl_policy_grad_fibonacci(n : Int) -> Int {
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

pub fn ml_rl_policy_grad_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ml_rl_policy_grad_min(data); let mx = ml_rl_policy_grad_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ml_rl_policy_grad_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ml_rl_policy_grad_mean(data); let sd = ml_rl_policy_grad_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ml_rl_policy_grad_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ml_rl_policy_grad_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ml_rl_policy_grad_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ml_rl_policy_grad_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct MlrlpolicygradFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_frame_make(size : Int) -> MlrlpolicygradFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_frame_len(s : MlrlpolicygradFrame) -> Int { s.size }

pub fn ml_rl_policy_grad_frame_get(s : MlrlpolicygradFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_frame_set(s : MlrlpolicygradFrame, i : Int, v : Double) -> MlrlpolicygradFrame {
  let result = ml_rl_policy_grad_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_frame_sum(s : MlrlpolicygradFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_frame_mean(s : MlrlpolicygradFrame) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_frame_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_frame_scale(s : MlrlpolicygradFrame, f : Double) -> MlrlpolicygradFrame {
  let result = ml_rl_policy_grad_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_frame_add(a : MlrlpolicygradFrame, b : MlrlpolicygradFrame) -> MlrlpolicygradFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_frame_copy(s : MlrlpolicygradFrame) -> MlrlpolicygradFrame {
  let result = ml_rl_policy_grad_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_frame_fill(s : MlrlpolicygradFrame, v : Double) -> MlrlpolicygradFrame {
  let result = ml_rl_policy_grad_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_frame_min(s : MlrlpolicygradFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_frame_max(s : MlrlpolicygradFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_frame_to_string(s : MlrlpolicygradFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_table_make(size : Int) -> MlrlpolicygradTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_table_len(s : MlrlpolicygradTable) -> Int { s.size }

pub fn ml_rl_policy_grad_table_get(s : MlrlpolicygradTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_table_set(s : MlrlpolicygradTable, i : Int, v : Double) -> MlrlpolicygradTable {
  let result = ml_rl_policy_grad_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_table_sum(s : MlrlpolicygradTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_table_mean(s : MlrlpolicygradTable) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_table_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_table_scale(s : MlrlpolicygradTable, f : Double) -> MlrlpolicygradTable {
  let result = ml_rl_policy_grad_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_table_add(a : MlrlpolicygradTable, b : MlrlpolicygradTable) -> MlrlpolicygradTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_table_copy(s : MlrlpolicygradTable) -> MlrlpolicygradTable {
  let result = ml_rl_policy_grad_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_table_fill(s : MlrlpolicygradTable, v : Double) -> MlrlpolicygradTable {
  let result = ml_rl_policy_grad_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_table_min(s : MlrlpolicygradTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_table_max(s : MlrlpolicygradTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_table_to_string(s : MlrlpolicygradTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_graphn_make(size : Int) -> MlrlpolicygradGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_graphn_len(s : MlrlpolicygradGraphN) -> Int { s.size }

pub fn ml_rl_policy_grad_graphn_get(s : MlrlpolicygradGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_graphn_set(s : MlrlpolicygradGraphN, i : Int, v : Double) -> MlrlpolicygradGraphN {
  let result = ml_rl_policy_grad_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_graphn_sum(s : MlrlpolicygradGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_graphn_mean(s : MlrlpolicygradGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_graphn_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_graphn_scale(s : MlrlpolicygradGraphN, f : Double) -> MlrlpolicygradGraphN {
  let result = ml_rl_policy_grad_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_graphn_add(a : MlrlpolicygradGraphN, b : MlrlpolicygradGraphN) -> MlrlpolicygradGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_graphn_copy(s : MlrlpolicygradGraphN) -> MlrlpolicygradGraphN {
  let result = ml_rl_policy_grad_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_graphn_fill(s : MlrlpolicygradGraphN, v : Double) -> MlrlpolicygradGraphN {
  let result = ml_rl_policy_grad_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_graphn_min(s : MlrlpolicygradGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_graphn_max(s : MlrlpolicygradGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_graphn_to_string(s : MlrlpolicygradGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_node_make(size : Int) -> MlrlpolicygradNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_node_len(s : MlrlpolicygradNode) -> Int { s.size }

pub fn ml_rl_policy_grad_node_get(s : MlrlpolicygradNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_node_set(s : MlrlpolicygradNode, i : Int, v : Double) -> MlrlpolicygradNode {
  let result = ml_rl_policy_grad_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_node_sum(s : MlrlpolicygradNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_node_mean(s : MlrlpolicygradNode) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_node_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_node_scale(s : MlrlpolicygradNode, f : Double) -> MlrlpolicygradNode {
  let result = ml_rl_policy_grad_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_node_add(a : MlrlpolicygradNode, b : MlrlpolicygradNode) -> MlrlpolicygradNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_node_copy(s : MlrlpolicygradNode) -> MlrlpolicygradNode {
  let result = ml_rl_policy_grad_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_node_fill(s : MlrlpolicygradNode, v : Double) -> MlrlpolicygradNode {
  let result = ml_rl_policy_grad_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_node_min(s : MlrlpolicygradNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_node_max(s : MlrlpolicygradNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_node_to_string(s : MlrlpolicygradNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_edge_make(size : Int) -> MlrlpolicygradEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_edge_len(s : MlrlpolicygradEdge) -> Int { s.size }

pub fn ml_rl_policy_grad_edge_get(s : MlrlpolicygradEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_edge_set(s : MlrlpolicygradEdge, i : Int, v : Double) -> MlrlpolicygradEdge {
  let result = ml_rl_policy_grad_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_edge_sum(s : MlrlpolicygradEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_edge_mean(s : MlrlpolicygradEdge) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_edge_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_edge_scale(s : MlrlpolicygradEdge, f : Double) -> MlrlpolicygradEdge {
  let result = ml_rl_policy_grad_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_edge_add(a : MlrlpolicygradEdge, b : MlrlpolicygradEdge) -> MlrlpolicygradEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_edge_copy(s : MlrlpolicygradEdge) -> MlrlpolicygradEdge {
  let result = ml_rl_policy_grad_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_edge_fill(s : MlrlpolicygradEdge, v : Double) -> MlrlpolicygradEdge {
  let result = ml_rl_policy_grad_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_edge_min(s : MlrlpolicygradEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_edge_max(s : MlrlpolicygradEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_edge_to_string(s : MlrlpolicygradEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_path_make(size : Int) -> MlrlpolicygradPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_path_len(s : MlrlpolicygradPath) -> Int { s.size }

pub fn ml_rl_policy_grad_path_get(s : MlrlpolicygradPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_path_set(s : MlrlpolicygradPath, i : Int, v : Double) -> MlrlpolicygradPath {
  let result = ml_rl_policy_grad_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_path_sum(s : MlrlpolicygradPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_path_mean(s : MlrlpolicygradPath) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_path_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_path_scale(s : MlrlpolicygradPath, f : Double) -> MlrlpolicygradPath {
  let result = ml_rl_policy_grad_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_path_add(a : MlrlpolicygradPath, b : MlrlpolicygradPath) -> MlrlpolicygradPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_path_copy(s : MlrlpolicygradPath) -> MlrlpolicygradPath {
  let result = ml_rl_policy_grad_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_path_fill(s : MlrlpolicygradPath, v : Double) -> MlrlpolicygradPath {
  let result = ml_rl_policy_grad_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_path_min(s : MlrlpolicygradPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_path_max(s : MlrlpolicygradPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_path_to_string(s : MlrlpolicygradPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_cluster_make(size : Int) -> MlrlpolicygradCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_cluster_len(s : MlrlpolicygradCluster) -> Int { s.size }

pub fn ml_rl_policy_grad_cluster_get(s : MlrlpolicygradCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_cluster_set(s : MlrlpolicygradCluster, i : Int, v : Double) -> MlrlpolicygradCluster {
  let result = ml_rl_policy_grad_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_cluster_sum(s : MlrlpolicygradCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_cluster_mean(s : MlrlpolicygradCluster) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_cluster_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_cluster_scale(s : MlrlpolicygradCluster, f : Double) -> MlrlpolicygradCluster {
  let result = ml_rl_policy_grad_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_cluster_add(a : MlrlpolicygradCluster, b : MlrlpolicygradCluster) -> MlrlpolicygradCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_cluster_copy(s : MlrlpolicygradCluster) -> MlrlpolicygradCluster {
  let result = ml_rl_policy_grad_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_cluster_fill(s : MlrlpolicygradCluster, v : Double) -> MlrlpolicygradCluster {
  let result = ml_rl_policy_grad_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_cluster_min(s : MlrlpolicygradCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_cluster_max(s : MlrlpolicygradCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_cluster_to_string(s : MlrlpolicygradCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_model_make(size : Int) -> MlrlpolicygradModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_model_len(s : MlrlpolicygradModel) -> Int { s.size }

pub fn ml_rl_policy_grad_model_get(s : MlrlpolicygradModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_model_set(s : MlrlpolicygradModel, i : Int, v : Double) -> MlrlpolicygradModel {
  let result = ml_rl_policy_grad_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_model_sum(s : MlrlpolicygradModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_model_mean(s : MlrlpolicygradModel) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_model_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_model_scale(s : MlrlpolicygradModel, f : Double) -> MlrlpolicygradModel {
  let result = ml_rl_policy_grad_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_model_add(a : MlrlpolicygradModel, b : MlrlpolicygradModel) -> MlrlpolicygradModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_model_copy(s : MlrlpolicygradModel) -> MlrlpolicygradModel {
  let result = ml_rl_policy_grad_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_model_fill(s : MlrlpolicygradModel, v : Double) -> MlrlpolicygradModel {
  let result = ml_rl_policy_grad_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_model_min(s : MlrlpolicygradModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_model_max(s : MlrlpolicygradModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_model_to_string(s : MlrlpolicygradModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_layer_make(size : Int) -> MlrlpolicygradLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_layer_len(s : MlrlpolicygradLayer) -> Int { s.size }

pub fn ml_rl_policy_grad_layer_get(s : MlrlpolicygradLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_layer_set(s : MlrlpolicygradLayer, i : Int, v : Double) -> MlrlpolicygradLayer {
  let result = ml_rl_policy_grad_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_layer_sum(s : MlrlpolicygradLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_layer_mean(s : MlrlpolicygradLayer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_layer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_layer_scale(s : MlrlpolicygradLayer, f : Double) -> MlrlpolicygradLayer {
  let result = ml_rl_policy_grad_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_layer_add(a : MlrlpolicygradLayer, b : MlrlpolicygradLayer) -> MlrlpolicygradLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_layer_copy(s : MlrlpolicygradLayer) -> MlrlpolicygradLayer {
  let result = ml_rl_policy_grad_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_layer_fill(s : MlrlpolicygradLayer, v : Double) -> MlrlpolicygradLayer {
  let result = ml_rl_policy_grad_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_layer_min(s : MlrlpolicygradLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_layer_max(s : MlrlpolicygradLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_layer_to_string(s : MlrlpolicygradLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_buffer_make(size : Int) -> MlrlpolicygradBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_buffer_len(s : MlrlpolicygradBuffer) -> Int { s.size }

pub fn ml_rl_policy_grad_buffer_get(s : MlrlpolicygradBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_buffer_set(s : MlrlpolicygradBuffer, i : Int, v : Double) -> MlrlpolicygradBuffer {
  let result = ml_rl_policy_grad_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_buffer_sum(s : MlrlpolicygradBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_buffer_mean(s : MlrlpolicygradBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_buffer_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_buffer_scale(s : MlrlpolicygradBuffer, f : Double) -> MlrlpolicygradBuffer {
  let result = ml_rl_policy_grad_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_buffer_add(a : MlrlpolicygradBuffer, b : MlrlpolicygradBuffer) -> MlrlpolicygradBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_buffer_copy(s : MlrlpolicygradBuffer) -> MlrlpolicygradBuffer {
  let result = ml_rl_policy_grad_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_buffer_fill(s : MlrlpolicygradBuffer, v : Double) -> MlrlpolicygradBuffer {
  let result = ml_rl_policy_grad_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_buffer_min(s : MlrlpolicygradBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_buffer_max(s : MlrlpolicygradBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_buffer_to_string(s : MlrlpolicygradBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_cursor_make(size : Int) -> MlrlpolicygradCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_cursor_len(s : MlrlpolicygradCursor) -> Int { s.size }

pub fn ml_rl_policy_grad_cursor_get(s : MlrlpolicygradCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_cursor_set(s : MlrlpolicygradCursor, i : Int, v : Double) -> MlrlpolicygradCursor {
  let result = ml_rl_policy_grad_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_cursor_sum(s : MlrlpolicygradCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_cursor_mean(s : MlrlpolicygradCursor) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_cursor_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_cursor_scale(s : MlrlpolicygradCursor, f : Double) -> MlrlpolicygradCursor {
  let result = ml_rl_policy_grad_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_cursor_add(a : MlrlpolicygradCursor, b : MlrlpolicygradCursor) -> MlrlpolicygradCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_cursor_copy(s : MlrlpolicygradCursor) -> MlrlpolicygradCursor {
  let result = ml_rl_policy_grad_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_cursor_fill(s : MlrlpolicygradCursor, v : Double) -> MlrlpolicygradCursor {
  let result = ml_rl_policy_grad_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_cursor_min(s : MlrlpolicygradCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_cursor_max(s : MlrlpolicygradCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_cursor_to_string(s : MlrlpolicygradCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_view_make(size : Int) -> MlrlpolicygradView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_view_len(s : MlrlpolicygradView) -> Int { s.size }

pub fn ml_rl_policy_grad_view_get(s : MlrlpolicygradView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_view_set(s : MlrlpolicygradView, i : Int, v : Double) -> MlrlpolicygradView {
  let result = ml_rl_policy_grad_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_view_sum(s : MlrlpolicygradView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_view_mean(s : MlrlpolicygradView) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_view_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_view_scale(s : MlrlpolicygradView, f : Double) -> MlrlpolicygradView {
  let result = ml_rl_policy_grad_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_view_add(a : MlrlpolicygradView, b : MlrlpolicygradView) -> MlrlpolicygradView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_view_copy(s : MlrlpolicygradView) -> MlrlpolicygradView {
  let result = ml_rl_policy_grad_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_view_fill(s : MlrlpolicygradView, v : Double) -> MlrlpolicygradView {
  let result = ml_rl_policy_grad_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_view_min(s : MlrlpolicygradView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_view_max(s : MlrlpolicygradView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_view_to_string(s : MlrlpolicygradView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_range_make(size : Int) -> MlrlpolicygradRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_range_len(s : MlrlpolicygradRange) -> Int { s.size }

pub fn ml_rl_policy_grad_range_get(s : MlrlpolicygradRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_range_set(s : MlrlpolicygradRange, i : Int, v : Double) -> MlrlpolicygradRange {
  let result = ml_rl_policy_grad_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_range_sum(s : MlrlpolicygradRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_range_mean(s : MlrlpolicygradRange) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_range_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_range_scale(s : MlrlpolicygradRange, f : Double) -> MlrlpolicygradRange {
  let result = ml_rl_policy_grad_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_range_add(a : MlrlpolicygradRange, b : MlrlpolicygradRange) -> MlrlpolicygradRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_range_copy(s : MlrlpolicygradRange) -> MlrlpolicygradRange {
  let result = ml_rl_policy_grad_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_range_fill(s : MlrlpolicygradRange, v : Double) -> MlrlpolicygradRange {
  let result = ml_rl_policy_grad_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_range_min(s : MlrlpolicygradRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_range_max(s : MlrlpolicygradRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_range_to_string(s : MlrlpolicygradRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct MlrlpolicygradSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ml_rl_policy_grad_slice_make(size : Int) -> MlrlpolicygradSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ml_rl_policy_grad_slice_len(s : MlrlpolicygradSlice) -> Int { s.size }

pub fn ml_rl_policy_grad_slice_get(s : MlrlpolicygradSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ml_rl_policy_grad_slice_set(s : MlrlpolicygradSlice, i : Int, v : Double) -> MlrlpolicygradSlice {
  let result = ml_rl_policy_grad_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_slice_sum(s : MlrlpolicygradSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ml_rl_policy_grad_slice_mean(s : MlrlpolicygradSlice) -> Double {
  if s.size == 0 { 0.0 } else { ml_rl_policy_grad_slice_sum(s) / s.size.to_double() }
}

pub fn ml_rl_policy_grad_slice_scale(s : MlrlpolicygradSlice, f : Double) -> MlrlpolicygradSlice {
  let result = ml_rl_policy_grad_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ml_rl_policy_grad_slice_add(a : MlrlpolicygradSlice, b : MlrlpolicygradSlice) -> MlrlpolicygradSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ml_rl_policy_grad_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ml_rl_policy_grad_slice_copy(s : MlrlpolicygradSlice) -> MlrlpolicygradSlice {
  let result = ml_rl_policy_grad_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ml_rl_policy_grad_slice_fill(s : MlrlpolicygradSlice, v : Double) -> MlrlpolicygradSlice {
  let result = ml_rl_policy_grad_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ml_rl_policy_grad_slice_min(s : MlrlpolicygradSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_slice_max(s : MlrlpolicygradSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ml_rl_policy_grad_slice_to_string(s : MlrlpolicygradSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

