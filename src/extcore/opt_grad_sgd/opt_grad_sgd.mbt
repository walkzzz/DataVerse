///===
/// extcore/opt_grad_sgd

pub(all) struct OptgradsgdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_grad_sgd_make_point(x : Double, y : Double) -> OptgradsgdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_grad_sgd_make_point3(x : Double, y : Double, z : Double) -> OptgradsgdPoint {
  { x, y, z, label: 0 }
}

pub fn opt_grad_sgd_point_x(pt : OptgradsgdPoint) -> Double { pt.x }

pub fn opt_grad_sgd_point_y(pt : OptgradsgdPoint) -> Double { pt.y }

pub fn opt_grad_sgd_point_z(pt : OptgradsgdPoint) -> Double { pt.z }

pub fn opt_grad_sgd_point_label(pt : OptgradsgdPoint) -> Int { pt.label }

pub fn opt_grad_sgd_point_dist(a : OptgradsgdPoint, b : OptgradsgdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_grad_sgd_point_add(a : OptgradsgdPoint, b : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_grad_sgd_point_sub(a : OptgradsgdPoint, b : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_grad_sgd_point_scale(pt : OptgradsgdPoint, s : Double) -> OptgradsgdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_grad_sgd_point_dot(a : OptgradsgdPoint, b : OptgradsgdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_grad_sgd_point_cross(a : OptgradsgdPoint, b : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_grad_sgd_point_norm(pt : OptgradsgdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_grad_sgd_point_normalize(pt : OptgradsgdPoint) -> OptgradsgdPoint {
  let n = opt_grad_sgd_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_grad_sgd_point_scale(pt, 1.0 / n) }
}

pub fn opt_grad_sgd_point_negate(pt : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_grad_sgd_point_mid(a : OptgradsgdPoint, b : OptgradsgdPoint) -> OptgradsgdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_grad_sgd_point_lerp(a : OptgradsgdPoint, b : OptgradsgdPoint, t : Double) -> OptgradsgdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_grad_sgd_point_to_string(pt : OptgradsgdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptgradsgdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_grad_sgd_make_series(vals : Array[Double], name : String) -> OptgradsgdSeries {
  { vals, name, meta: 0 }
}

pub fn opt_grad_sgd_series_len(s : OptgradsgdSeries) -> Int { s.vals.length() }

pub fn opt_grad_sgd_series_sum(s : OptgradsgdSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_grad_sgd_series_mean(s : OptgradsgdSeries) -> Double {
  let n = opt_grad_sgd_series_len(s)
  if n == 0 { 0.0 } else { opt_grad_sgd_series_sum(s) / n.to_double() }
}

pub fn opt_grad_sgd_series_min(s : OptgradsgdSeries) -> Double {
  let n = opt_grad_sgd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_sgd_series_max(s : OptgradsgdSeries) -> Double {
  let n = opt_grad_sgd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_grad_sgd_series_range(s : OptgradsgdSeries) -> Double {
  opt_grad_sgd_series_max(s) - opt_grad_sgd_series_min(s)
}

pub fn opt_grad_sgd_series_var(s : OptgradsgdSeries) -> Double {
  let n = opt_grad_sgd_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_grad_sgd_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_grad_sgd_series_std(s : OptgradsgdSeries) -> Double { @_common.sqrt(opt_grad_sgd_series_var(s)) }

pub fn opt_grad_sgd_series_median(s : OptgradsgdSeries) -> Double {
  let n = opt_grad_sgd_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_sgd_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_sgd_series_scale(s : OptgradsgdSeries, f : Double) -> OptgradsgdSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_grad_sgd_series_add(a : OptgradsgdSeries, b : OptgradsgdSeries) -> OptgradsgdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_grad_sgd_series_sub(a : OptgradsgdSeries, b : OptgradsgdSeries) -> OptgradsgdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_grad_sgd_series_normalize(s : OptgradsgdSeries) -> OptgradsgdSeries {
  let mn = opt_grad_sgd_series_min(s)
  let mx = opt_grad_sgd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_grad_sgd_series_cumsum(s : OptgradsgdSeries) -> OptgradsgdSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_grad_sgd_series_to_string(s : OptgradsgdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptgradsgdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_grad_sgd_make_matrix(rows : Int, cols : Int, val : Double) -> OptgradsgdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_grad_sgd_matrix_identity(n : Int) -> OptgradsgdMatrix {
  let m = opt_grad_sgd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_grad_sgd_matrix_get(m : OptgradsgdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_grad_sgd_matrix_transpose(m : OptgradsgdMatrix) -> OptgradsgdMatrix {
  let result = opt_grad_sgd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_grad_sgd_matrix_add(a : OptgradsgdMatrix, b : OptgradsgdMatrix) -> OptgradsgdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_grad_sgd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_grad_sgd_matrix_scale(m : OptgradsgdMatrix, s : Double) -> OptgradsgdMatrix {
  let result = opt_grad_sgd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_grad_sgd_matrix_multiply(a : OptgradsgdMatrix, b : OptgradsgdMatrix) -> OptgradsgdMatrix {
  if a.cols != b.rows { return opt_grad_sgd_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_grad_sgd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_grad_sgd_matrix_trace(m : OptgradsgdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_grad_sgd_matrix_det(m : OptgradsgdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_grad_sgd_matrix_norm(m : OptgradsgdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_grad_sgd_matrix_to_string(m : OptgradsgdMatrix) -> String {
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

pub(all) struct OptgradsgdVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_grad_sgd_make_vector(comps : Array[Double]) -> OptgradsgdVector {
  { comps, dim: comps.length() }
}

pub fn opt_grad_sgd_vector_zero(dim : Int) -> OptgradsgdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_grad_sgd_vector_add(a : OptgradsgdVector, b : OptgradsgdVector) -> OptgradsgdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_sgd_vector_sub(a : OptgradsgdVector, b : OptgradsgdVector) -> OptgradsgdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_grad_sgd_vector_scale(v : OptgradsgdVector, s : Double) -> OptgradsgdVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_grad_sgd_vector_dot(a : OptgradsgdVector, b : OptgradsgdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_grad_sgd_vector_norm(v : OptgradsgdVector) -> Double { @_common.sqrt(opt_grad_sgd_vector_dot(v, v)) }

pub fn opt_grad_sgd_vector_normalize(v : OptgradsgdVector) -> OptgradsgdVector {
  let n = opt_grad_sgd_vector_norm(v)
  if n < 0.0000001 { v } else { opt_grad_sgd_vector_scale(v, 1.0 / n) }
}

pub fn opt_grad_sgd_vector_dist(a : OptgradsgdVector, b : OptgradsgdVector) -> Double {
  opt_grad_sgd_vector_norm(opt_grad_sgd_vector_sub(a, b))
}

pub fn opt_grad_sgd_vector_to_string(v : OptgradsgdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_grad_sgd_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_grad_sgd_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_grad_sgd_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_sgd_std(data : Array[Double]) -> Double { @_common.sqrt(opt_grad_sgd_var(data)) }

pub fn opt_grad_sgd_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_grad_sgd_mean(a); let mb = opt_grad_sgd_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_grad_sgd_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_grad_sgd_std(a); let sb = opt_grad_sgd_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_grad_sgd_cov(a, b) / (sa * sb) }
}

pub fn opt_grad_sgd_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_grad_sgd_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_grad_sgd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_grad_sgd_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_grad_sgd_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(opt_grad_sgd_mse(pred, labels))
}

pub fn opt_grad_sgd_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_grad_sgd_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_grad_sgd_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_grad_sgd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_grad_sgd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_grad_sgd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_grad_sgd_precision(pred, labels, pos); let r = opt_grad_sgd_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_grad_sgd_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_grad_sgd_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_grad_sgd_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_grad_sgd_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_grad_sgd_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_grad_sgd_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_grad_sgd_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_grad_sgd_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_grad_sgd_fibonacci(n : Int) -> Int {
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

pub fn opt_grad_sgd_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_grad_sgd_min(data); let mx = opt_grad_sgd_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_grad_sgd_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_grad_sgd_mean(data); let sd = opt_grad_sgd_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_grad_sgd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_grad_sgd_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_grad_sgd_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_grad_sgd_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_grad_sgd_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_grad_sgd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct OptgradsgdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_frame_make(size : Int) -> OptgradsgdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_frame_len(s : OptgradsgdFrame) -> Int { s.size }

pub fn opt_grad_sgd_frame_get(s : OptgradsgdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_frame_set(s : OptgradsgdFrame, i : Int, v : Double) -> OptgradsgdFrame {
  let result = opt_grad_sgd_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_frame_sum(s : OptgradsgdFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_frame_mean(s : OptgradsgdFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_frame_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_frame_scale(s : OptgradsgdFrame, f : Double) -> OptgradsgdFrame {
  let result = opt_grad_sgd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_frame_add(a : OptgradsgdFrame, b : OptgradsgdFrame) -> OptgradsgdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_frame_copy(s : OptgradsgdFrame) -> OptgradsgdFrame {
  let result = opt_grad_sgd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_frame_fill(s : OptgradsgdFrame, v : Double) -> OptgradsgdFrame {
  let result = opt_grad_sgd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_frame_min(s : OptgradsgdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_frame_max(s : OptgradsgdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_frame_to_string(s : OptgradsgdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_table_make(size : Int) -> OptgradsgdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_table_len(s : OptgradsgdTable) -> Int { s.size }

pub fn opt_grad_sgd_table_get(s : OptgradsgdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_table_set(s : OptgradsgdTable, i : Int, v : Double) -> OptgradsgdTable {
  let result = opt_grad_sgd_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_table_sum(s : OptgradsgdTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_table_mean(s : OptgradsgdTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_table_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_table_scale(s : OptgradsgdTable, f : Double) -> OptgradsgdTable {
  let result = opt_grad_sgd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_table_add(a : OptgradsgdTable, b : OptgradsgdTable) -> OptgradsgdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_table_copy(s : OptgradsgdTable) -> OptgradsgdTable {
  let result = opt_grad_sgd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_table_fill(s : OptgradsgdTable, v : Double) -> OptgradsgdTable {
  let result = opt_grad_sgd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_table_min(s : OptgradsgdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_table_max(s : OptgradsgdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_table_to_string(s : OptgradsgdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_graphn_make(size : Int) -> OptgradsgdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_graphn_len(s : OptgradsgdGraphN) -> Int { s.size }

pub fn opt_grad_sgd_graphn_get(s : OptgradsgdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_graphn_set(s : OptgradsgdGraphN, i : Int, v : Double) -> OptgradsgdGraphN {
  let result = opt_grad_sgd_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_graphn_sum(s : OptgradsgdGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_graphn_mean(s : OptgradsgdGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_graphn_scale(s : OptgradsgdGraphN, f : Double) -> OptgradsgdGraphN {
  let result = opt_grad_sgd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_graphn_add(a : OptgradsgdGraphN, b : OptgradsgdGraphN) -> OptgradsgdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_graphn_copy(s : OptgradsgdGraphN) -> OptgradsgdGraphN {
  let result = opt_grad_sgd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_graphn_fill(s : OptgradsgdGraphN, v : Double) -> OptgradsgdGraphN {
  let result = opt_grad_sgd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_graphn_min(s : OptgradsgdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_graphn_max(s : OptgradsgdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_graphn_to_string(s : OptgradsgdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_node_make(size : Int) -> OptgradsgdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_node_len(s : OptgradsgdNode) -> Int { s.size }

pub fn opt_grad_sgd_node_get(s : OptgradsgdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_node_set(s : OptgradsgdNode, i : Int, v : Double) -> OptgradsgdNode {
  let result = opt_grad_sgd_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_node_sum(s : OptgradsgdNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_node_mean(s : OptgradsgdNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_node_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_node_scale(s : OptgradsgdNode, f : Double) -> OptgradsgdNode {
  let result = opt_grad_sgd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_node_add(a : OptgradsgdNode, b : OptgradsgdNode) -> OptgradsgdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_node_copy(s : OptgradsgdNode) -> OptgradsgdNode {
  let result = opt_grad_sgd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_node_fill(s : OptgradsgdNode, v : Double) -> OptgradsgdNode {
  let result = opt_grad_sgd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_node_min(s : OptgradsgdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_node_max(s : OptgradsgdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_node_to_string(s : OptgradsgdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_edge_make(size : Int) -> OptgradsgdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_edge_len(s : OptgradsgdEdge) -> Int { s.size }

pub fn opt_grad_sgd_edge_get(s : OptgradsgdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_edge_set(s : OptgradsgdEdge, i : Int, v : Double) -> OptgradsgdEdge {
  let result = opt_grad_sgd_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_edge_sum(s : OptgradsgdEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_edge_mean(s : OptgradsgdEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_edge_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_edge_scale(s : OptgradsgdEdge, f : Double) -> OptgradsgdEdge {
  let result = opt_grad_sgd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_edge_add(a : OptgradsgdEdge, b : OptgradsgdEdge) -> OptgradsgdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_edge_copy(s : OptgradsgdEdge) -> OptgradsgdEdge {
  let result = opt_grad_sgd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_edge_fill(s : OptgradsgdEdge, v : Double) -> OptgradsgdEdge {
  let result = opt_grad_sgd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_edge_min(s : OptgradsgdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_edge_max(s : OptgradsgdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_edge_to_string(s : OptgradsgdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_path_make(size : Int) -> OptgradsgdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_path_len(s : OptgradsgdPath) -> Int { s.size }

pub fn opt_grad_sgd_path_get(s : OptgradsgdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_path_set(s : OptgradsgdPath, i : Int, v : Double) -> OptgradsgdPath {
  let result = opt_grad_sgd_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_path_sum(s : OptgradsgdPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_path_mean(s : OptgradsgdPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_path_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_path_scale(s : OptgradsgdPath, f : Double) -> OptgradsgdPath {
  let result = opt_grad_sgd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_path_add(a : OptgradsgdPath, b : OptgradsgdPath) -> OptgradsgdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_path_copy(s : OptgradsgdPath) -> OptgradsgdPath {
  let result = opt_grad_sgd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_path_fill(s : OptgradsgdPath, v : Double) -> OptgradsgdPath {
  let result = opt_grad_sgd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_path_min(s : OptgradsgdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_path_max(s : OptgradsgdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_path_to_string(s : OptgradsgdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_cluster_make(size : Int) -> OptgradsgdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_cluster_len(s : OptgradsgdCluster) -> Int { s.size }

pub fn opt_grad_sgd_cluster_get(s : OptgradsgdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_cluster_set(s : OptgradsgdCluster, i : Int, v : Double) -> OptgradsgdCluster {
  let result = opt_grad_sgd_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_cluster_sum(s : OptgradsgdCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_cluster_mean(s : OptgradsgdCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_cluster_scale(s : OptgradsgdCluster, f : Double) -> OptgradsgdCluster {
  let result = opt_grad_sgd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_cluster_add(a : OptgradsgdCluster, b : OptgradsgdCluster) -> OptgradsgdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_cluster_copy(s : OptgradsgdCluster) -> OptgradsgdCluster {
  let result = opt_grad_sgd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_cluster_fill(s : OptgradsgdCluster, v : Double) -> OptgradsgdCluster {
  let result = opt_grad_sgd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_cluster_min(s : OptgradsgdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_cluster_max(s : OptgradsgdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_cluster_to_string(s : OptgradsgdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_model_make(size : Int) -> OptgradsgdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_model_len(s : OptgradsgdModel) -> Int { s.size }

pub fn opt_grad_sgd_model_get(s : OptgradsgdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_model_set(s : OptgradsgdModel, i : Int, v : Double) -> OptgradsgdModel {
  let result = opt_grad_sgd_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_model_sum(s : OptgradsgdModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_model_mean(s : OptgradsgdModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_model_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_model_scale(s : OptgradsgdModel, f : Double) -> OptgradsgdModel {
  let result = opt_grad_sgd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_model_add(a : OptgradsgdModel, b : OptgradsgdModel) -> OptgradsgdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_model_copy(s : OptgradsgdModel) -> OptgradsgdModel {
  let result = opt_grad_sgd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_model_fill(s : OptgradsgdModel, v : Double) -> OptgradsgdModel {
  let result = opt_grad_sgd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_model_min(s : OptgradsgdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_model_max(s : OptgradsgdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_model_to_string(s : OptgradsgdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_layer_make(size : Int) -> OptgradsgdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_layer_len(s : OptgradsgdLayer) -> Int { s.size }

pub fn opt_grad_sgd_layer_get(s : OptgradsgdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_layer_set(s : OptgradsgdLayer, i : Int, v : Double) -> OptgradsgdLayer {
  let result = opt_grad_sgd_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_layer_sum(s : OptgradsgdLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_layer_mean(s : OptgradsgdLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_layer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_layer_scale(s : OptgradsgdLayer, f : Double) -> OptgradsgdLayer {
  let result = opt_grad_sgd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_layer_add(a : OptgradsgdLayer, b : OptgradsgdLayer) -> OptgradsgdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_layer_copy(s : OptgradsgdLayer) -> OptgradsgdLayer {
  let result = opt_grad_sgd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_layer_fill(s : OptgradsgdLayer, v : Double) -> OptgradsgdLayer {
  let result = opt_grad_sgd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_layer_min(s : OptgradsgdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_layer_max(s : OptgradsgdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_layer_to_string(s : OptgradsgdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_buffer_make(size : Int) -> OptgradsgdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_buffer_len(s : OptgradsgdBuffer) -> Int { s.size }

pub fn opt_grad_sgd_buffer_get(s : OptgradsgdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_buffer_set(s : OptgradsgdBuffer, i : Int, v : Double) -> OptgradsgdBuffer {
  let result = opt_grad_sgd_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_buffer_sum(s : OptgradsgdBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_buffer_mean(s : OptgradsgdBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_buffer_scale(s : OptgradsgdBuffer, f : Double) -> OptgradsgdBuffer {
  let result = opt_grad_sgd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_buffer_add(a : OptgradsgdBuffer, b : OptgradsgdBuffer) -> OptgradsgdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_buffer_copy(s : OptgradsgdBuffer) -> OptgradsgdBuffer {
  let result = opt_grad_sgd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_buffer_fill(s : OptgradsgdBuffer, v : Double) -> OptgradsgdBuffer {
  let result = opt_grad_sgd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_buffer_min(s : OptgradsgdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_buffer_max(s : OptgradsgdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_buffer_to_string(s : OptgradsgdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_cursor_make(size : Int) -> OptgradsgdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_cursor_len(s : OptgradsgdCursor) -> Int { s.size }

pub fn opt_grad_sgd_cursor_get(s : OptgradsgdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_cursor_set(s : OptgradsgdCursor, i : Int, v : Double) -> OptgradsgdCursor {
  let result = opt_grad_sgd_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_cursor_sum(s : OptgradsgdCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_cursor_mean(s : OptgradsgdCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_cursor_scale(s : OptgradsgdCursor, f : Double) -> OptgradsgdCursor {
  let result = opt_grad_sgd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_cursor_add(a : OptgradsgdCursor, b : OptgradsgdCursor) -> OptgradsgdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_cursor_copy(s : OptgradsgdCursor) -> OptgradsgdCursor {
  let result = opt_grad_sgd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_cursor_fill(s : OptgradsgdCursor, v : Double) -> OptgradsgdCursor {
  let result = opt_grad_sgd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_cursor_min(s : OptgradsgdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_cursor_max(s : OptgradsgdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_cursor_to_string(s : OptgradsgdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_view_make(size : Int) -> OptgradsgdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_view_len(s : OptgradsgdView) -> Int { s.size }

pub fn opt_grad_sgd_view_get(s : OptgradsgdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_view_set(s : OptgradsgdView, i : Int, v : Double) -> OptgradsgdView {
  let result = opt_grad_sgd_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_view_sum(s : OptgradsgdView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_view_mean(s : OptgradsgdView) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_view_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_view_scale(s : OptgradsgdView, f : Double) -> OptgradsgdView {
  let result = opt_grad_sgd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_view_add(a : OptgradsgdView, b : OptgradsgdView) -> OptgradsgdView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_view_copy(s : OptgradsgdView) -> OptgradsgdView {
  let result = opt_grad_sgd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_view_fill(s : OptgradsgdView, v : Double) -> OptgradsgdView {
  let result = opt_grad_sgd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_view_min(s : OptgradsgdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_view_max(s : OptgradsgdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_view_to_string(s : OptgradsgdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_range_make(size : Int) -> OptgradsgdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_range_len(s : OptgradsgdRange) -> Int { s.size }

pub fn opt_grad_sgd_range_get(s : OptgradsgdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_range_set(s : OptgradsgdRange, i : Int, v : Double) -> OptgradsgdRange {
  let result = opt_grad_sgd_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_range_sum(s : OptgradsgdRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_range_mean(s : OptgradsgdRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_range_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_range_scale(s : OptgradsgdRange, f : Double) -> OptgradsgdRange {
  let result = opt_grad_sgd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_range_add(a : OptgradsgdRange, b : OptgradsgdRange) -> OptgradsgdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_range_copy(s : OptgradsgdRange) -> OptgradsgdRange {
  let result = opt_grad_sgd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_range_fill(s : OptgradsgdRange, v : Double) -> OptgradsgdRange {
  let result = opt_grad_sgd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_range_min(s : OptgradsgdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_range_max(s : OptgradsgdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_range_to_string(s : OptgradsgdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptgradsgdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_grad_sgd_slice_make(size : Int) -> OptgradsgdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_grad_sgd_slice_len(s : OptgradsgdSlice) -> Int { s.size }

pub fn opt_grad_sgd_slice_get(s : OptgradsgdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_grad_sgd_slice_set(s : OptgradsgdSlice, i : Int, v : Double) -> OptgradsgdSlice {
  let result = opt_grad_sgd_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_slice_sum(s : OptgradsgdSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_grad_sgd_slice_mean(s : OptgradsgdSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_grad_sgd_slice_sum(s) / s.size.to_double() }
}

pub fn opt_grad_sgd_slice_scale(s : OptgradsgdSlice, f : Double) -> OptgradsgdSlice {
  let result = opt_grad_sgd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_grad_sgd_slice_add(a : OptgradsgdSlice, b : OptgradsgdSlice) -> OptgradsgdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_grad_sgd_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_grad_sgd_slice_copy(s : OptgradsgdSlice) -> OptgradsgdSlice {
  let result = opt_grad_sgd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_grad_sgd_slice_fill(s : OptgradsgdSlice, v : Double) -> OptgradsgdSlice {
  let result = opt_grad_sgd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_grad_sgd_slice_min(s : OptgradsgdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_slice_max(s : OptgradsgdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_grad_sgd_slice_to_string(s : OptgradsgdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

