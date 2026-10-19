///===
/// extcore/opt_grad_rmsprop

pub(all) struct OptgradrmspropPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_rmsprop_make_point(x : Double, y : Double) -> OptgradrmspropPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_rmsprop_make_point3(x : Double, y : Double, z : Double) -> OptgradrmspropPoint {
  { x, y, z, label: 0 }
}

pub fn opt_grad_rmsprop_point_x(pt : OptgradrmspropPoint) -> Double { pt.x }

pub fn opt_grad_rmsprop_point_y(pt : OptgradrmspropPoint) -> Double { pt.y }

pub fn opt_grad_rmsprop_point_z(pt : OptgradrmspropPoint) -> Double { pt.z }

pub fn opt_grad_rmsprop_point_label(pt : OptgradrmspropPoint) -> Int { pt.label }

pub fn opt_grad_rmsprop_point_dist(a : OptgradrmspropPoint, b : OptgradrmspropPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  opt_grad_rmsprop_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_grad_rmsprop_point_add(a : OptgradrmspropPoint, b : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_grad_rmsprop_point_sub(a : OptgradrmspropPoint, b : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_grad_rmsprop_point_scale(pt : OptgradrmspropPoint, s : Double) -> OptgradrmspropPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_grad_rmsprop_point_dot(a : OptgradrmspropPoint, b : OptgradrmspropPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_grad_rmsprop_point_cross(a : OptgradrmspropPoint, b : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_grad_rmsprop_point_norm(pt : OptgradrmspropPoint) -> Double {
  opt_grad_rmsprop_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_grad_rmsprop_point_normalize(pt : OptgradrmspropPoint) -> OptgradrmspropPoint {
  let n = opt_grad_rmsprop_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_grad_rmsprop_point_scale(pt, 1.0 / n) }
}

pub fn opt_grad_rmsprop_point_negate(pt : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_grad_rmsprop_point_mid(a : OptgradrmspropPoint, b : OptgradrmspropPoint) -> OptgradrmspropPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_grad_rmsprop_point_lerp(a : OptgradrmspropPoint, b : OptgradrmspropPoint, t : Double) -> OptgradrmspropPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_grad_rmsprop_point_to_string(pt : OptgradrmspropPoint) -> String {
  "(" + opt_grad_rmsprop_dbl(pt.x) + ", " + opt_grad_rmsprop_dbl(pt.y) + ", " + opt_grad_rmsprop_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptgradrmspropSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_rmsprop_make_series(vals : Array[Double], name : String) -> OptgradrmspropSeries {
  { vals, name, meta: 0 }
}

pub fn opt_grad_rmsprop_series_len(s : OptgradrmspropSeries) -> Int { s.vals.length() }

pub fn opt_grad_rmsprop_series_sum(s : OptgradrmspropSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_grad_rmsprop_series_mean(s : OptgradrmspropSeries) -> Double {
  let n = opt_grad_rmsprop_series_len(s)
  if n == 0 { 0.0 } else { opt_grad_rmsprop_series_sum(s) / n.to_double() }
}

pub fn opt_grad_rmsprop_series_min(s : OptgradrmspropSeries) -> Double {
  let n = opt_grad_rmsprop_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_series_max(s : OptgradrmspropSeries) -> Double {
  let n = opt_grad_rmsprop_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_series_range(s : OptgradrmspropSeries) -> Double {
  opt_grad_rmsprop_series_max(s) - opt_grad_rmsprop_series_min(s)
}

pub fn opt_grad_rmsprop_series_var(s : OptgradrmspropSeries) -> Double {
  let n = opt_grad_rmsprop_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_grad_rmsprop_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_grad_rmsprop_series_std(s : OptgradrmspropSeries) -> Double { opt_grad_rmsprop_sqrt(opt_grad_rmsprop_series_var(s)) }

pub fn opt_grad_rmsprop_series_median(s : OptgradrmspropSeries) -> Double {
  let n = opt_grad_rmsprop_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_rmsprop_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_rmsprop_series_scale(s : OptgradrmspropSeries, f : Double) -> OptgradrmspropSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = opt_grad_rmsprop_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_grad_rmsprop_series_add(a : OptgradrmspropSeries, b : OptgradrmspropSeries) -> OptgradrmspropSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_grad_rmsprop_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_grad_rmsprop_series_sub(a : OptgradrmspropSeries, b : OptgradrmspropSeries) -> OptgradrmspropSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = opt_grad_rmsprop_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_grad_rmsprop_series_normalize(s : OptgradrmspropSeries) -> OptgradrmspropSeries {
  let mn = opt_grad_rmsprop_series_min(s)
  let mx = opt_grad_rmsprop_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = opt_grad_rmsprop_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_grad_rmsprop_series_cumsum(s : OptgradrmspropSeries) -> OptgradrmspropSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = opt_grad_rmsprop_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_grad_rmsprop_series_to_string(s : OptgradrmspropSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_grad_rmsprop_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradrmspropMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_rmsprop_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradrmspropMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_rmsprop_matrix_identity(n : Int) -> OptgradrmspropMatrix {
  let m = opt_grad_rmsprop_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_grad_rmsprop_matrix_get(m : OptgradrmspropMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_grad_rmsprop_matrix_transpose(m : OptgradrmspropMatrix) -> OptgradrmspropMatrix {
  let result = opt_grad_rmsprop_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_grad_rmsprop_matrix_add(a : OptgradrmspropMatrix, b : OptgradrmspropMatrix) -> OptgradrmspropMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_grad_rmsprop_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_grad_rmsprop_matrix_scale(m : OptgradrmspropMatrix, s : Double) -> OptgradrmspropMatrix {
  let result = opt_grad_rmsprop_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_grad_rmsprop_matrix_multiply(a : OptgradrmspropMatrix, b : OptgradrmspropMatrix) -> OptgradrmspropMatrix {
  if a.cols != b.rows { return opt_grad_rmsprop_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_grad_rmsprop_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_grad_rmsprop_matrix_trace(m : OptgradrmspropMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_grad_rmsprop_matrix_det(m : OptgradrmspropMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_grad_rmsprop_matrix_norm(m : OptgradrmspropMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  opt_grad_rmsprop_sqrt(sum)
}

pub fn opt_grad_rmsprop_matrix_to_string(m : OptgradrmspropMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + opt_grad_rmsprop_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct OptgradrmspropVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_rmsprop_make_vector(comps : Array[Double]) -> OptgradrmspropVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_rmsprop_vector_zero(dim : Int) -> OptgradrmspropVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_grad_rmsprop_vector_add(a : OptgradrmspropVector, b : OptgradrmspropVector) -> OptgradrmspropVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_grad_rmsprop_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_rmsprop_vector_sub(a : OptgradrmspropVector, b : OptgradrmspropVector) -> OptgradrmspropVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = opt_grad_rmsprop_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_rmsprop_vector_scale(v : OptgradrmspropVector, s : Double) -> OptgradrmspropVector {
  let mut result = []
  for i in 0..<v.dim { result = opt_grad_rmsprop_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_grad_rmsprop_vector_dot(a : OptgradrmspropVector, b : OptgradrmspropVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_grad_rmsprop_vector_norm(v : OptgradrmspropVector) -> Double { opt_grad_rmsprop_sqrt(opt_grad_rmsprop_vector_dot(v, v)) }

pub fn opt_grad_rmsprop_vector_normalize(v : OptgradrmspropVector) -> OptgradrmspropVector {
  let n = opt_grad_rmsprop_vector_norm(v)
  if n < 0.0000001 { v } else { opt_grad_rmsprop_vector_scale(v, 1.0 / n) }
}

pub fn opt_grad_rmsprop_vector_dist(a : OptgradrmspropVector, b : OptgradrmspropVector) -> Double {
  opt_grad_rmsprop_vector_norm(opt_grad_rmsprop_vector_sub(a, b))
}

pub fn opt_grad_rmsprop_vector_to_string(v : OptgradrmspropVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + opt_grad_rmsprop_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_rmsprop_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_grad_rmsprop_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_grad_rmsprop_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_rmsprop_std(data : Array[Double]) -> Double { opt_grad_rmsprop_sqrt(opt_grad_rmsprop_var(data)) }

pub fn opt_grad_rmsprop_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_grad_rmsprop_mean(a); let mb = opt_grad_rmsprop_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_grad_rmsprop_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_grad_rmsprop_std(a); let sb = opt_grad_rmsprop_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_grad_rmsprop_cov(a, b) / (sa * sb) }
}

pub fn opt_grad_rmsprop_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_rmsprop_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_rmsprop_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_grad_rmsprop_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_rmsprop_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  opt_grad_rmsprop_sqrt(opt_grad_rmsprop_mse(pred, labels))
}

pub fn opt_grad_rmsprop_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + opt_grad_rmsprop_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_grad_rmsprop_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_grad_rmsprop_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_grad_rmsprop_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_grad_rmsprop_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_grad_rmsprop_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_grad_rmsprop_precision(pred, labels, pos); let r = opt_grad_rmsprop_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_grad_rmsprop_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_grad_rmsprop_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_grad_rmsprop_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_grad_rmsprop_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_grad_rmsprop_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_grad_rmsprop_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_grad_rmsprop_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_grad_rmsprop_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_grad_rmsprop_fibonacci(n : Int) -> Int {
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

pub fn opt_grad_rmsprop_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_grad_rmsprop_min(data); let mx = opt_grad_rmsprop_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_grad_rmsprop_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_grad_rmsprop_mean(data); let sd = opt_grad_rmsprop_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_grad_rmsprop_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_grad_rmsprop_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_grad_rmsprop_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_grad_rmsprop_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn opt_grad_rmsprop_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn opt_grad_rmsprop_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn opt_grad_rmsprop_dbl(x : Double) -> String {
  let i = if x >= 0.0 { opt_grad_rmsprop_int(x) } else { -opt_grad_rmsprop_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { opt_grad_rmsprop_int(f * 1000000.0) } else { opt_grad_rmsprop_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn opt_grad_rmsprop_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn opt_grad_rmsprop_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct OptgradrmspropFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_frame_make(size : Int) -> OptgradrmspropFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_frame_len(s : OptgradrmspropFrame) -> Int { s.size }

pub fn opt_grad_rmsprop_frame_get(s : OptgradrmspropFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_frame_set(s : OptgradrmspropFrame, i : Int, v : Double) -> OptgradrmspropFrame {
  let result = opt_grad_rmsprop_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_frame_sum(s : OptgradrmspropFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_frame_mean(s : OptgradrmspropFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_frame_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_frame_scale(s : OptgradrmspropFrame, f : Double) -> OptgradrmspropFrame {
  let result = opt_grad_rmsprop_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_frame_add(a : OptgradrmspropFrame, b : OptgradrmspropFrame) -> OptgradrmspropFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_frame_copy(s : OptgradrmspropFrame) -> OptgradrmspropFrame {
  let result = opt_grad_rmsprop_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_frame_fill(s : OptgradrmspropFrame, v : Double) -> OptgradrmspropFrame {
  let result = opt_grad_rmsprop_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_frame_min(s : OptgradrmspropFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_frame_max(s : OptgradrmspropFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_frame_to_string(s : OptgradrmspropFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_table_make(size : Int) -> OptgradrmspropTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_table_len(s : OptgradrmspropTable) -> Int { s.size }

pub fn opt_grad_rmsprop_table_get(s : OptgradrmspropTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_table_set(s : OptgradrmspropTable, i : Int, v : Double) -> OptgradrmspropTable {
  let result = opt_grad_rmsprop_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_table_sum(s : OptgradrmspropTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_table_mean(s : OptgradrmspropTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_table_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_table_scale(s : OptgradrmspropTable, f : Double) -> OptgradrmspropTable {
  let result = opt_grad_rmsprop_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_table_add(a : OptgradrmspropTable, b : OptgradrmspropTable) -> OptgradrmspropTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_table_copy(s : OptgradrmspropTable) -> OptgradrmspropTable {
  let result = opt_grad_rmsprop_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_table_fill(s : OptgradrmspropTable, v : Double) -> OptgradrmspropTable {
  let result = opt_grad_rmsprop_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_table_min(s : OptgradrmspropTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_table_max(s : OptgradrmspropTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_table_to_string(s : OptgradrmspropTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_graphn_make(size : Int) -> OptgradrmspropGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_graphn_len(s : OptgradrmspropGraphN) -> Int { s.size }

pub fn opt_grad_rmsprop_graphn_get(s : OptgradrmspropGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_graphn_set(s : OptgradrmspropGraphN, i : Int, v : Double) -> OptgradrmspropGraphN {
  let result = opt_grad_rmsprop_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_graphn_sum(s : OptgradrmspropGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_graphn_mean(s : OptgradrmspropGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_graphn_scale(s : OptgradrmspropGraphN, f : Double) -> OptgradrmspropGraphN {
  let result = opt_grad_rmsprop_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_graphn_add(a : OptgradrmspropGraphN, b : OptgradrmspropGraphN) -> OptgradrmspropGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_graphn_copy(s : OptgradrmspropGraphN) -> OptgradrmspropGraphN {
  let result = opt_grad_rmsprop_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_graphn_fill(s : OptgradrmspropGraphN, v : Double) -> OptgradrmspropGraphN {
  let result = opt_grad_rmsprop_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_graphn_min(s : OptgradrmspropGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_graphn_max(s : OptgradrmspropGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_graphn_to_string(s : OptgradrmspropGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_node_make(size : Int) -> OptgradrmspropNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_node_len(s : OptgradrmspropNode) -> Int { s.size }

pub fn opt_grad_rmsprop_node_get(s : OptgradrmspropNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_node_set(s : OptgradrmspropNode, i : Int, v : Double) -> OptgradrmspropNode {
  let result = opt_grad_rmsprop_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_node_sum(s : OptgradrmspropNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_node_mean(s : OptgradrmspropNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_node_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_node_scale(s : OptgradrmspropNode, f : Double) -> OptgradrmspropNode {
  let result = opt_grad_rmsprop_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_node_add(a : OptgradrmspropNode, b : OptgradrmspropNode) -> OptgradrmspropNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_node_copy(s : OptgradrmspropNode) -> OptgradrmspropNode {
  let result = opt_grad_rmsprop_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_node_fill(s : OptgradrmspropNode, v : Double) -> OptgradrmspropNode {
  let result = opt_grad_rmsprop_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_node_min(s : OptgradrmspropNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_node_max(s : OptgradrmspropNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_node_to_string(s : OptgradrmspropNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_edge_make(size : Int) -> OptgradrmspropEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_edge_len(s : OptgradrmspropEdge) -> Int { s.size }

pub fn opt_grad_rmsprop_edge_get(s : OptgradrmspropEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_edge_set(s : OptgradrmspropEdge, i : Int, v : Double) -> OptgradrmspropEdge {
  let result = opt_grad_rmsprop_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_edge_sum(s : OptgradrmspropEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_edge_mean(s : OptgradrmspropEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_edge_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_edge_scale(s : OptgradrmspropEdge, f : Double) -> OptgradrmspropEdge {
  let result = opt_grad_rmsprop_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_edge_add(a : OptgradrmspropEdge, b : OptgradrmspropEdge) -> OptgradrmspropEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_edge_copy(s : OptgradrmspropEdge) -> OptgradrmspropEdge {
  let result = opt_grad_rmsprop_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_edge_fill(s : OptgradrmspropEdge, v : Double) -> OptgradrmspropEdge {
  let result = opt_grad_rmsprop_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_edge_min(s : OptgradrmspropEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_edge_max(s : OptgradrmspropEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_edge_to_string(s : OptgradrmspropEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_path_make(size : Int) -> OptgradrmspropPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_path_len(s : OptgradrmspropPath) -> Int { s.size }

pub fn opt_grad_rmsprop_path_get(s : OptgradrmspropPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_path_set(s : OptgradrmspropPath, i : Int, v : Double) -> OptgradrmspropPath {
  let result = opt_grad_rmsprop_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_path_sum(s : OptgradrmspropPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_path_mean(s : OptgradrmspropPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_path_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_path_scale(s : OptgradrmspropPath, f : Double) -> OptgradrmspropPath {
  let result = opt_grad_rmsprop_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_path_add(a : OptgradrmspropPath, b : OptgradrmspropPath) -> OptgradrmspropPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_path_copy(s : OptgradrmspropPath) -> OptgradrmspropPath {
  let result = opt_grad_rmsprop_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_path_fill(s : OptgradrmspropPath, v : Double) -> OptgradrmspropPath {
  let result = opt_grad_rmsprop_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_path_min(s : OptgradrmspropPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_path_max(s : OptgradrmspropPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_path_to_string(s : OptgradrmspropPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_cluster_make(size : Int) -> OptgradrmspropCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_cluster_len(s : OptgradrmspropCluster) -> Int { s.size }

pub fn opt_grad_rmsprop_cluster_get(s : OptgradrmspropCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_cluster_set(s : OptgradrmspropCluster, i : Int, v : Double) -> OptgradrmspropCluster {
  let result = opt_grad_rmsprop_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_cluster_sum(s : OptgradrmspropCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_cluster_mean(s : OptgradrmspropCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_cluster_scale(s : OptgradrmspropCluster, f : Double) -> OptgradrmspropCluster {
  let result = opt_grad_rmsprop_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_cluster_add(a : OptgradrmspropCluster, b : OptgradrmspropCluster) -> OptgradrmspropCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_cluster_copy(s : OptgradrmspropCluster) -> OptgradrmspropCluster {
  let result = opt_grad_rmsprop_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_cluster_fill(s : OptgradrmspropCluster, v : Double) -> OptgradrmspropCluster {
  let result = opt_grad_rmsprop_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_cluster_min(s : OptgradrmspropCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_cluster_max(s : OptgradrmspropCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_cluster_to_string(s : OptgradrmspropCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_model_make(size : Int) -> OptgradrmspropModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_model_len(s : OptgradrmspropModel) -> Int { s.size }

pub fn opt_grad_rmsprop_model_get(s : OptgradrmspropModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_model_set(s : OptgradrmspropModel, i : Int, v : Double) -> OptgradrmspropModel {
  let result = opt_grad_rmsprop_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_model_sum(s : OptgradrmspropModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_model_mean(s : OptgradrmspropModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_model_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_model_scale(s : OptgradrmspropModel, f : Double) -> OptgradrmspropModel {
  let result = opt_grad_rmsprop_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_model_add(a : OptgradrmspropModel, b : OptgradrmspropModel) -> OptgradrmspropModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_model_copy(s : OptgradrmspropModel) -> OptgradrmspropModel {
  let result = opt_grad_rmsprop_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_model_fill(s : OptgradrmspropModel, v : Double) -> OptgradrmspropModel {
  let result = opt_grad_rmsprop_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_model_min(s : OptgradrmspropModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_model_max(s : OptgradrmspropModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_model_to_string(s : OptgradrmspropModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_layer_make(size : Int) -> OptgradrmspropLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_layer_len(s : OptgradrmspropLayer) -> Int { s.size }

pub fn opt_grad_rmsprop_layer_get(s : OptgradrmspropLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_layer_set(s : OptgradrmspropLayer, i : Int, v : Double) -> OptgradrmspropLayer {
  let result = opt_grad_rmsprop_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_layer_sum(s : OptgradrmspropLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_layer_mean(s : OptgradrmspropLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_layer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_layer_scale(s : OptgradrmspropLayer, f : Double) -> OptgradrmspropLayer {
  let result = opt_grad_rmsprop_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_layer_add(a : OptgradrmspropLayer, b : OptgradrmspropLayer) -> OptgradrmspropLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_layer_copy(s : OptgradrmspropLayer) -> OptgradrmspropLayer {
  let result = opt_grad_rmsprop_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_layer_fill(s : OptgradrmspropLayer, v : Double) -> OptgradrmspropLayer {
  let result = opt_grad_rmsprop_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_layer_min(s : OptgradrmspropLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_layer_max(s : OptgradrmspropLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_layer_to_string(s : OptgradrmspropLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_buffer_make(size : Int) -> OptgradrmspropBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_buffer_len(s : OptgradrmspropBuffer) -> Int { s.size }

pub fn opt_grad_rmsprop_buffer_get(s : OptgradrmspropBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_buffer_set(s : OptgradrmspropBuffer, i : Int, v : Double) -> OptgradrmspropBuffer {
  let result = opt_grad_rmsprop_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_buffer_sum(s : OptgradrmspropBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_buffer_mean(s : OptgradrmspropBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_buffer_scale(s : OptgradrmspropBuffer, f : Double) -> OptgradrmspropBuffer {
  let result = opt_grad_rmsprop_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_buffer_add(a : OptgradrmspropBuffer, b : OptgradrmspropBuffer) -> OptgradrmspropBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_buffer_copy(s : OptgradrmspropBuffer) -> OptgradrmspropBuffer {
  let result = opt_grad_rmsprop_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_buffer_fill(s : OptgradrmspropBuffer, v : Double) -> OptgradrmspropBuffer {
  let result = opt_grad_rmsprop_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_buffer_min(s : OptgradrmspropBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_buffer_max(s : OptgradrmspropBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_buffer_to_string(s : OptgradrmspropBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_cursor_make(size : Int) -> OptgradrmspropCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_cursor_len(s : OptgradrmspropCursor) -> Int { s.size }

pub fn opt_grad_rmsprop_cursor_get(s : OptgradrmspropCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_cursor_set(s : OptgradrmspropCursor, i : Int, v : Double) -> OptgradrmspropCursor {
  let result = opt_grad_rmsprop_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_cursor_sum(s : OptgradrmspropCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_cursor_mean(s : OptgradrmspropCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_cursor_scale(s : OptgradrmspropCursor, f : Double) -> OptgradrmspropCursor {
  let result = opt_grad_rmsprop_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_cursor_add(a : OptgradrmspropCursor, b : OptgradrmspropCursor) -> OptgradrmspropCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_cursor_copy(s : OptgradrmspropCursor) -> OptgradrmspropCursor {
  let result = opt_grad_rmsprop_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_cursor_fill(s : OptgradrmspropCursor, v : Double) -> OptgradrmspropCursor {
  let result = opt_grad_rmsprop_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_cursor_min(s : OptgradrmspropCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_cursor_max(s : OptgradrmspropCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_cursor_to_string(s : OptgradrmspropCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_view_make(size : Int) -> OptgradrmspropView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_view_len(s : OptgradrmspropView) -> Int { s.size }

pub fn opt_grad_rmsprop_view_get(s : OptgradrmspropView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_view_set(s : OptgradrmspropView, i : Int, v : Double) -> OptgradrmspropView {
  let result = opt_grad_rmsprop_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_view_sum(s : OptgradrmspropView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_view_mean(s : OptgradrmspropView) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_view_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_view_scale(s : OptgradrmspropView, f : Double) -> OptgradrmspropView {
  let result = opt_grad_rmsprop_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_view_add(a : OptgradrmspropView, b : OptgradrmspropView) -> OptgradrmspropView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_view_copy(s : OptgradrmspropView) -> OptgradrmspropView {
  let result = opt_grad_rmsprop_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_view_fill(s : OptgradrmspropView, v : Double) -> OptgradrmspropView {
  let result = opt_grad_rmsprop_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_view_min(s : OptgradrmspropView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_view_max(s : OptgradrmspropView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_view_to_string(s : OptgradrmspropView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_range_make(size : Int) -> OptgradrmspropRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_range_len(s : OptgradrmspropRange) -> Int { s.size }

pub fn opt_grad_rmsprop_range_get(s : OptgradrmspropRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_range_set(s : OptgradrmspropRange, i : Int, v : Double) -> OptgradrmspropRange {
  let result = opt_grad_rmsprop_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_range_sum(s : OptgradrmspropRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_range_mean(s : OptgradrmspropRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_range_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_range_scale(s : OptgradrmspropRange, f : Double) -> OptgradrmspropRange {
  let result = opt_grad_rmsprop_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_range_add(a : OptgradrmspropRange, b : OptgradrmspropRange) -> OptgradrmspropRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_range_copy(s : OptgradrmspropRange) -> OptgradrmspropRange {
  let result = opt_grad_rmsprop_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_range_fill(s : OptgradrmspropRange, v : Double) -> OptgradrmspropRange {
  let result = opt_grad_rmsprop_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_range_min(s : OptgradrmspropRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_range_max(s : OptgradrmspropRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_range_to_string(s : OptgradrmspropRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradrmspropSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_rmsprop_slice_make(size : Int) -> OptgradrmspropSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_rmsprop_slice_len(s : OptgradrmspropSlice) -> Int { s.size }

pub fn opt_grad_rmsprop_slice_get(s : OptgradrmspropSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_rmsprop_slice_set(s : OptgradrmspropSlice, i : Int, v : Double) -> OptgradrmspropSlice {
  let result = opt_grad_rmsprop_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_slice_sum(s : OptgradrmspropSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_rmsprop_slice_mean(s : OptgradrmspropSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_rmsprop_slice_sum(s) / s.size.to_double() }
}

pub fn opt_grad_rmsprop_slice_scale(s : OptgradrmspropSlice, f : Double) -> OptgradrmspropSlice {
  let result = opt_grad_rmsprop_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_rmsprop_slice_add(a : OptgradrmspropSlice, b : OptgradrmspropSlice) -> OptgradrmspropSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_rmsprop_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_rmsprop_slice_copy(s : OptgradrmspropSlice) -> OptgradrmspropSlice {
  let result = opt_grad_rmsprop_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_rmsprop_slice_fill(s : OptgradrmspropSlice, v : Double) -> OptgradrmspropSlice {
  let result = opt_grad_rmsprop_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_rmsprop_slice_min(s : OptgradrmspropSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_slice_max(s : OptgradrmspropSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_rmsprop_slice_to_string(s : OptgradrmspropSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn opt_grad_rmsprop_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn opt_grad_rmsprop_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

