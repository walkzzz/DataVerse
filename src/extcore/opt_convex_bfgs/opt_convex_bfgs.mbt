///===
/// extcore/opt_convex_bfgs

pub(all) struct OptconvexbfgsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn opt_convex_bfgs_make_point(x : Double, y : Double) -> OptconvexbfgsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn opt_convex_bfgs_make_point3(x : Double, y : Double, z : Double) -> OptconvexbfgsPoint {
  { x, y, z, label: 0 }
}

pub fn opt_convex_bfgs_point_x(pt : OptconvexbfgsPoint) -> Double { pt.x }

pub fn opt_convex_bfgs_point_y(pt : OptconvexbfgsPoint) -> Double { pt.y }

pub fn opt_convex_bfgs_point_z(pt : OptconvexbfgsPoint) -> Double { pt.z }

pub fn opt_convex_bfgs_point_label(pt : OptconvexbfgsPoint) -> Int { pt.label }

pub fn opt_convex_bfgs_point_dist(a : OptconvexbfgsPoint, b : OptconvexbfgsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn opt_convex_bfgs_point_add(a : OptconvexbfgsPoint, b : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn opt_convex_bfgs_point_sub(a : OptconvexbfgsPoint, b : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn opt_convex_bfgs_point_scale(pt : OptconvexbfgsPoint, s : Double) -> OptconvexbfgsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn opt_convex_bfgs_point_dot(a : OptconvexbfgsPoint, b : OptconvexbfgsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn opt_convex_bfgs_point_cross(a : OptconvexbfgsPoint, b : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn opt_convex_bfgs_point_norm(pt : OptconvexbfgsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn opt_convex_bfgs_point_normalize(pt : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  let n = opt_convex_bfgs_point_norm(pt)
  if n < 0.0000001 { pt } else { opt_convex_bfgs_point_scale(pt, 1.0 / n) }
}

pub fn opt_convex_bfgs_point_negate(pt : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn opt_convex_bfgs_point_mid(a : OptconvexbfgsPoint, b : OptconvexbfgsPoint) -> OptconvexbfgsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn opt_convex_bfgs_point_lerp(a : OptconvexbfgsPoint, b : OptconvexbfgsPoint, t : Double) -> OptconvexbfgsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn opt_convex_bfgs_point_to_string(pt : OptconvexbfgsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct OptconvexbfgsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn opt_convex_bfgs_make_series(vals : Array[Double], name : String) -> OptconvexbfgsSeries {
  { vals, name, meta: 0 }
}

pub fn opt_convex_bfgs_series_len(s : OptconvexbfgsSeries) -> Int { s.vals.length() }

pub fn opt_convex_bfgs_series_sum(s : OptconvexbfgsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn opt_convex_bfgs_series_mean(s : OptconvexbfgsSeries) -> Double {
  let n = opt_convex_bfgs_series_len(s)
  if n == 0 { 0.0 } else { opt_convex_bfgs_series_sum(s) / n.to_double() }
}

pub fn opt_convex_bfgs_series_min(s : OptconvexbfgsSeries) -> Double {
  let n = opt_convex_bfgs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn opt_convex_bfgs_series_max(s : OptconvexbfgsSeries) -> Double {
  let n = opt_convex_bfgs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn opt_convex_bfgs_series_range(s : OptconvexbfgsSeries) -> Double {
  opt_convex_bfgs_series_max(s) - opt_convex_bfgs_series_min(s)
}

pub fn opt_convex_bfgs_series_var(s : OptconvexbfgsSeries) -> Double {
  let n = opt_convex_bfgs_series_len(s)
  if n == 0 { 0.0 } else {
    let m = opt_convex_bfgs_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn opt_convex_bfgs_series_std(s : OptconvexbfgsSeries) -> Double { @_common.sqrt(opt_convex_bfgs_series_var(s)) }

pub fn opt_convex_bfgs_series_median(s : OptconvexbfgsSeries) -> Double {
  let n = opt_convex_bfgs_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = opt_convex_bfgs_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_convex_bfgs_series_scale(s : OptconvexbfgsSeries, f : Double) -> OptconvexbfgsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn opt_convex_bfgs_series_add(a : OptconvexbfgsSeries, b : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn opt_convex_bfgs_series_sub(a : OptconvexbfgsSeries, b : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn opt_convex_bfgs_series_normalize(s : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  let mn = opt_convex_bfgs_series_min(s)
  let mx = opt_convex_bfgs_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn opt_convex_bfgs_series_cumsum(s : OptconvexbfgsSeries) -> OptconvexbfgsSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn opt_convex_bfgs_series_to_string(s : OptconvexbfgsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct OptconvexbfgsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn opt_convex_bfgs_make_matrix(rows : Int, cols : Int, val : Double) -> OptconvexbfgsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn opt_convex_bfgs_matrix_identity(n : Int) -> OptconvexbfgsMatrix {
  let m = opt_convex_bfgs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn opt_convex_bfgs_matrix_get(m : OptconvexbfgsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn opt_convex_bfgs_matrix_transpose(m : OptconvexbfgsMatrix) -> OptconvexbfgsMatrix {
  let result = opt_convex_bfgs_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn opt_convex_bfgs_matrix_add(a : OptconvexbfgsMatrix, b : OptconvexbfgsMatrix) -> OptconvexbfgsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = opt_convex_bfgs_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn opt_convex_bfgs_matrix_scale(m : OptconvexbfgsMatrix, s : Double) -> OptconvexbfgsMatrix {
  let result = opt_convex_bfgs_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn opt_convex_bfgs_matrix_multiply(a : OptconvexbfgsMatrix, b : OptconvexbfgsMatrix) -> OptconvexbfgsMatrix {
  if a.cols != b.rows { return opt_convex_bfgs_make_matrix(a.rows, b.cols, 0.0) }
  let result = opt_convex_bfgs_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn opt_convex_bfgs_matrix_trace(m : OptconvexbfgsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn opt_convex_bfgs_matrix_det(m : OptconvexbfgsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn opt_convex_bfgs_matrix_norm(m : OptconvexbfgsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn opt_convex_bfgs_matrix_to_string(m : OptconvexbfgsMatrix) -> String {
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

pub(all) struct OptconvexbfgsVector {
  comps : Array[Double]
  dim : Int
}

pub fn opt_convex_bfgs_make_vector(comps : Array[Double]) -> OptconvexbfgsVector {
  { comps, dim: comps.length() }
}

pub fn opt_convex_bfgs_vector_zero(dim : Int) -> OptconvexbfgsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn opt_convex_bfgs_vector_add(a : OptconvexbfgsVector, b : OptconvexbfgsVector) -> OptconvexbfgsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_bfgs_vector_sub(a : OptconvexbfgsVector, b : OptconvexbfgsVector) -> OptconvexbfgsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn opt_convex_bfgs_vector_scale(v : OptconvexbfgsVector, s : Double) -> OptconvexbfgsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn opt_convex_bfgs_vector_dot(a : OptconvexbfgsVector, b : OptconvexbfgsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn opt_convex_bfgs_vector_norm(v : OptconvexbfgsVector) -> Double { @_common.sqrt(opt_convex_bfgs_vector_dot(v, v)) }

pub fn opt_convex_bfgs_vector_normalize(v : OptconvexbfgsVector) -> OptconvexbfgsVector {
  let n = opt_convex_bfgs_vector_norm(v)
  if n < 0.0000001 { v } else { opt_convex_bfgs_vector_scale(v, 1.0 / n) }
}

pub fn opt_convex_bfgs_vector_dist(a : OptconvexbfgsVector, b : OptconvexbfgsVector) -> Double {
  opt_convex_bfgs_vector_norm(opt_convex_bfgs_vector_sub(a, b))
}

pub fn opt_convex_bfgs_vector_to_string(v : OptconvexbfgsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn opt_convex_bfgs_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn opt_convex_bfgs_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = opt_convex_bfgs_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_convex_bfgs_std(data : Array[Double]) -> Double { @_common.sqrt(opt_convex_bfgs_var(data)) }

pub fn opt_convex_bfgs_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = opt_convex_bfgs_mean(a); let mb = opt_convex_bfgs_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn opt_convex_bfgs_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = opt_convex_bfgs_std(a); let sb = opt_convex_bfgs_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { opt_convex_bfgs_cov(a, b) / (sa * sb) }
}

pub fn opt_convex_bfgs_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = opt_convex_bfgs_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn opt_convex_bfgs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn opt_convex_bfgs_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn opt_convex_bfgs_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(opt_convex_bfgs_mse(pred, labels))
}

pub fn opt_convex_bfgs_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn opt_convex_bfgs_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = opt_convex_bfgs_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn opt_convex_bfgs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn opt_convex_bfgs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn opt_convex_bfgs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = opt_convex_bfgs_precision(pred, labels, pos); let r = opt_convex_bfgs_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn opt_convex_bfgs_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn opt_convex_bfgs_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = opt_convex_bfgs_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn opt_convex_bfgs_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn opt_convex_bfgs_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn opt_convex_bfgs_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = opt_convex_bfgs_gcd(a, b)
    (a / g) * b
  }
}

pub fn opt_convex_bfgs_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn opt_convex_bfgs_fibonacci(n : Int) -> Int {
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

pub fn opt_convex_bfgs_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = opt_convex_bfgs_min(data); let mx = opt_convex_bfgs_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn opt_convex_bfgs_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = opt_convex_bfgs_mean(data); let sd = opt_convex_bfgs_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn opt_convex_bfgs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn opt_convex_bfgs_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn opt_convex_bfgs_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn opt_convex_bfgs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct OptconvexbfgsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_frame_make(size : Int) -> OptconvexbfgsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_frame_len(s : OptconvexbfgsFrame) -> Int { s.size }

pub fn opt_convex_bfgs_frame_get(s : OptconvexbfgsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_frame_set(s : OptconvexbfgsFrame, i : Int, v : Double) -> OptconvexbfgsFrame {
  let result = opt_convex_bfgs_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_frame_sum(s : OptconvexbfgsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_frame_mean(s : OptconvexbfgsFrame) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_frame_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_frame_scale(s : OptconvexbfgsFrame, f : Double) -> OptconvexbfgsFrame {
  let result = opt_convex_bfgs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_frame_add(a : OptconvexbfgsFrame, b : OptconvexbfgsFrame) -> OptconvexbfgsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_frame_copy(s : OptconvexbfgsFrame) -> OptconvexbfgsFrame {
  let result = opt_convex_bfgs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_frame_fill(s : OptconvexbfgsFrame, v : Double) -> OptconvexbfgsFrame {
  let result = opt_convex_bfgs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_frame_min(s : OptconvexbfgsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_frame_max(s : OptconvexbfgsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_frame_to_string(s : OptconvexbfgsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_table_make(size : Int) -> OptconvexbfgsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_table_len(s : OptconvexbfgsTable) -> Int { s.size }

pub fn opt_convex_bfgs_table_get(s : OptconvexbfgsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_table_set(s : OptconvexbfgsTable, i : Int, v : Double) -> OptconvexbfgsTable {
  let result = opt_convex_bfgs_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_table_sum(s : OptconvexbfgsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_table_mean(s : OptconvexbfgsTable) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_table_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_table_scale(s : OptconvexbfgsTable, f : Double) -> OptconvexbfgsTable {
  let result = opt_convex_bfgs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_table_add(a : OptconvexbfgsTable, b : OptconvexbfgsTable) -> OptconvexbfgsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_table_copy(s : OptconvexbfgsTable) -> OptconvexbfgsTable {
  let result = opt_convex_bfgs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_table_fill(s : OptconvexbfgsTable, v : Double) -> OptconvexbfgsTable {
  let result = opt_convex_bfgs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_table_min(s : OptconvexbfgsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_table_max(s : OptconvexbfgsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_table_to_string(s : OptconvexbfgsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_graphn_make(size : Int) -> OptconvexbfgsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_graphn_len(s : OptconvexbfgsGraphN) -> Int { s.size }

pub fn opt_convex_bfgs_graphn_get(s : OptconvexbfgsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_graphn_set(s : OptconvexbfgsGraphN, i : Int, v : Double) -> OptconvexbfgsGraphN {
  let result = opt_convex_bfgs_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_graphn_sum(s : OptconvexbfgsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_graphn_mean(s : OptconvexbfgsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_graphn_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_graphn_scale(s : OptconvexbfgsGraphN, f : Double) -> OptconvexbfgsGraphN {
  let result = opt_convex_bfgs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_graphn_add(a : OptconvexbfgsGraphN, b : OptconvexbfgsGraphN) -> OptconvexbfgsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_graphn_copy(s : OptconvexbfgsGraphN) -> OptconvexbfgsGraphN {
  let result = opt_convex_bfgs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_graphn_fill(s : OptconvexbfgsGraphN, v : Double) -> OptconvexbfgsGraphN {
  let result = opt_convex_bfgs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_graphn_min(s : OptconvexbfgsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_graphn_max(s : OptconvexbfgsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_graphn_to_string(s : OptconvexbfgsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_node_make(size : Int) -> OptconvexbfgsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_node_len(s : OptconvexbfgsNode) -> Int { s.size }

pub fn opt_convex_bfgs_node_get(s : OptconvexbfgsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_node_set(s : OptconvexbfgsNode, i : Int, v : Double) -> OptconvexbfgsNode {
  let result = opt_convex_bfgs_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_node_sum(s : OptconvexbfgsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_node_mean(s : OptconvexbfgsNode) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_node_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_node_scale(s : OptconvexbfgsNode, f : Double) -> OptconvexbfgsNode {
  let result = opt_convex_bfgs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_node_add(a : OptconvexbfgsNode, b : OptconvexbfgsNode) -> OptconvexbfgsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_node_copy(s : OptconvexbfgsNode) -> OptconvexbfgsNode {
  let result = opt_convex_bfgs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_node_fill(s : OptconvexbfgsNode, v : Double) -> OptconvexbfgsNode {
  let result = opt_convex_bfgs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_node_min(s : OptconvexbfgsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_node_max(s : OptconvexbfgsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_node_to_string(s : OptconvexbfgsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_edge_make(size : Int) -> OptconvexbfgsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_edge_len(s : OptconvexbfgsEdge) -> Int { s.size }

pub fn opt_convex_bfgs_edge_get(s : OptconvexbfgsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_edge_set(s : OptconvexbfgsEdge, i : Int, v : Double) -> OptconvexbfgsEdge {
  let result = opt_convex_bfgs_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_edge_sum(s : OptconvexbfgsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_edge_mean(s : OptconvexbfgsEdge) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_edge_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_edge_scale(s : OptconvexbfgsEdge, f : Double) -> OptconvexbfgsEdge {
  let result = opt_convex_bfgs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_edge_add(a : OptconvexbfgsEdge, b : OptconvexbfgsEdge) -> OptconvexbfgsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_edge_copy(s : OptconvexbfgsEdge) -> OptconvexbfgsEdge {
  let result = opt_convex_bfgs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_edge_fill(s : OptconvexbfgsEdge, v : Double) -> OptconvexbfgsEdge {
  let result = opt_convex_bfgs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_edge_min(s : OptconvexbfgsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_edge_max(s : OptconvexbfgsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_edge_to_string(s : OptconvexbfgsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_path_make(size : Int) -> OptconvexbfgsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_path_len(s : OptconvexbfgsPath) -> Int { s.size }

pub fn opt_convex_bfgs_path_get(s : OptconvexbfgsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_path_set(s : OptconvexbfgsPath, i : Int, v : Double) -> OptconvexbfgsPath {
  let result = opt_convex_bfgs_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_path_sum(s : OptconvexbfgsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_path_mean(s : OptconvexbfgsPath) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_path_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_path_scale(s : OptconvexbfgsPath, f : Double) -> OptconvexbfgsPath {
  let result = opt_convex_bfgs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_path_add(a : OptconvexbfgsPath, b : OptconvexbfgsPath) -> OptconvexbfgsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_path_copy(s : OptconvexbfgsPath) -> OptconvexbfgsPath {
  let result = opt_convex_bfgs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_path_fill(s : OptconvexbfgsPath, v : Double) -> OptconvexbfgsPath {
  let result = opt_convex_bfgs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_path_min(s : OptconvexbfgsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_path_max(s : OptconvexbfgsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_path_to_string(s : OptconvexbfgsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_cluster_make(size : Int) -> OptconvexbfgsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_cluster_len(s : OptconvexbfgsCluster) -> Int { s.size }

pub fn opt_convex_bfgs_cluster_get(s : OptconvexbfgsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_cluster_set(s : OptconvexbfgsCluster, i : Int, v : Double) -> OptconvexbfgsCluster {
  let result = opt_convex_bfgs_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_cluster_sum(s : OptconvexbfgsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_cluster_mean(s : OptconvexbfgsCluster) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_cluster_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_cluster_scale(s : OptconvexbfgsCluster, f : Double) -> OptconvexbfgsCluster {
  let result = opt_convex_bfgs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_cluster_add(a : OptconvexbfgsCluster, b : OptconvexbfgsCluster) -> OptconvexbfgsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_cluster_copy(s : OptconvexbfgsCluster) -> OptconvexbfgsCluster {
  let result = opt_convex_bfgs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_cluster_fill(s : OptconvexbfgsCluster, v : Double) -> OptconvexbfgsCluster {
  let result = opt_convex_bfgs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_cluster_min(s : OptconvexbfgsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_cluster_max(s : OptconvexbfgsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_cluster_to_string(s : OptconvexbfgsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_model_make(size : Int) -> OptconvexbfgsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_model_len(s : OptconvexbfgsModel) -> Int { s.size }

pub fn opt_convex_bfgs_model_get(s : OptconvexbfgsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_model_set(s : OptconvexbfgsModel, i : Int, v : Double) -> OptconvexbfgsModel {
  let result = opt_convex_bfgs_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_model_sum(s : OptconvexbfgsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_model_mean(s : OptconvexbfgsModel) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_model_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_model_scale(s : OptconvexbfgsModel, f : Double) -> OptconvexbfgsModel {
  let result = opt_convex_bfgs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_model_add(a : OptconvexbfgsModel, b : OptconvexbfgsModel) -> OptconvexbfgsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_model_copy(s : OptconvexbfgsModel) -> OptconvexbfgsModel {
  let result = opt_convex_bfgs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_model_fill(s : OptconvexbfgsModel, v : Double) -> OptconvexbfgsModel {
  let result = opt_convex_bfgs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_model_min(s : OptconvexbfgsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_model_max(s : OptconvexbfgsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_model_to_string(s : OptconvexbfgsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_layer_make(size : Int) -> OptconvexbfgsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_layer_len(s : OptconvexbfgsLayer) -> Int { s.size }

pub fn opt_convex_bfgs_layer_get(s : OptconvexbfgsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_layer_set(s : OptconvexbfgsLayer, i : Int, v : Double) -> OptconvexbfgsLayer {
  let result = opt_convex_bfgs_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_layer_sum(s : OptconvexbfgsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_layer_mean(s : OptconvexbfgsLayer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_layer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_layer_scale(s : OptconvexbfgsLayer, f : Double) -> OptconvexbfgsLayer {
  let result = opt_convex_bfgs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_layer_add(a : OptconvexbfgsLayer, b : OptconvexbfgsLayer) -> OptconvexbfgsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_layer_copy(s : OptconvexbfgsLayer) -> OptconvexbfgsLayer {
  let result = opt_convex_bfgs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_layer_fill(s : OptconvexbfgsLayer, v : Double) -> OptconvexbfgsLayer {
  let result = opt_convex_bfgs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_layer_min(s : OptconvexbfgsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_layer_max(s : OptconvexbfgsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_layer_to_string(s : OptconvexbfgsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_buffer_make(size : Int) -> OptconvexbfgsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_buffer_len(s : OptconvexbfgsBuffer) -> Int { s.size }

pub fn opt_convex_bfgs_buffer_get(s : OptconvexbfgsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_buffer_set(s : OptconvexbfgsBuffer, i : Int, v : Double) -> OptconvexbfgsBuffer {
  let result = opt_convex_bfgs_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_buffer_sum(s : OptconvexbfgsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_buffer_mean(s : OptconvexbfgsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_buffer_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_buffer_scale(s : OptconvexbfgsBuffer, f : Double) -> OptconvexbfgsBuffer {
  let result = opt_convex_bfgs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_buffer_add(a : OptconvexbfgsBuffer, b : OptconvexbfgsBuffer) -> OptconvexbfgsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_buffer_copy(s : OptconvexbfgsBuffer) -> OptconvexbfgsBuffer {
  let result = opt_convex_bfgs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_buffer_fill(s : OptconvexbfgsBuffer, v : Double) -> OptconvexbfgsBuffer {
  let result = opt_convex_bfgs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_buffer_min(s : OptconvexbfgsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_buffer_max(s : OptconvexbfgsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_buffer_to_string(s : OptconvexbfgsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_cursor_make(size : Int) -> OptconvexbfgsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_cursor_len(s : OptconvexbfgsCursor) -> Int { s.size }

pub fn opt_convex_bfgs_cursor_get(s : OptconvexbfgsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_cursor_set(s : OptconvexbfgsCursor, i : Int, v : Double) -> OptconvexbfgsCursor {
  let result = opt_convex_bfgs_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_cursor_sum(s : OptconvexbfgsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_cursor_mean(s : OptconvexbfgsCursor) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_cursor_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_cursor_scale(s : OptconvexbfgsCursor, f : Double) -> OptconvexbfgsCursor {
  let result = opt_convex_bfgs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_cursor_add(a : OptconvexbfgsCursor, b : OptconvexbfgsCursor) -> OptconvexbfgsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_cursor_copy(s : OptconvexbfgsCursor) -> OptconvexbfgsCursor {
  let result = opt_convex_bfgs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_cursor_fill(s : OptconvexbfgsCursor, v : Double) -> OptconvexbfgsCursor {
  let result = opt_convex_bfgs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_cursor_min(s : OptconvexbfgsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_cursor_max(s : OptconvexbfgsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_cursor_to_string(s : OptconvexbfgsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_view_make(size : Int) -> OptconvexbfgsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_view_len(s : OptconvexbfgsView) -> Int { s.size }

pub fn opt_convex_bfgs_view_get(s : OptconvexbfgsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_view_set(s : OptconvexbfgsView, i : Int, v : Double) -> OptconvexbfgsView {
  let result = opt_convex_bfgs_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_view_sum(s : OptconvexbfgsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_view_mean(s : OptconvexbfgsView) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_view_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_view_scale(s : OptconvexbfgsView, f : Double) -> OptconvexbfgsView {
  let result = opt_convex_bfgs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_view_add(a : OptconvexbfgsView, b : OptconvexbfgsView) -> OptconvexbfgsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_view_copy(s : OptconvexbfgsView) -> OptconvexbfgsView {
  let result = opt_convex_bfgs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_view_fill(s : OptconvexbfgsView, v : Double) -> OptconvexbfgsView {
  let result = opt_convex_bfgs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_view_min(s : OptconvexbfgsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_view_max(s : OptconvexbfgsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_view_to_string(s : OptconvexbfgsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_range_make(size : Int) -> OptconvexbfgsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_range_len(s : OptconvexbfgsRange) -> Int { s.size }

pub fn opt_convex_bfgs_range_get(s : OptconvexbfgsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_range_set(s : OptconvexbfgsRange, i : Int, v : Double) -> OptconvexbfgsRange {
  let result = opt_convex_bfgs_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_range_sum(s : OptconvexbfgsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_range_mean(s : OptconvexbfgsRange) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_range_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_range_scale(s : OptconvexbfgsRange, f : Double) -> OptconvexbfgsRange {
  let result = opt_convex_bfgs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_range_add(a : OptconvexbfgsRange, b : OptconvexbfgsRange) -> OptconvexbfgsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_range_copy(s : OptconvexbfgsRange) -> OptconvexbfgsRange {
  let result = opt_convex_bfgs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_range_fill(s : OptconvexbfgsRange, v : Double) -> OptconvexbfgsRange {
  let result = opt_convex_bfgs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_range_min(s : OptconvexbfgsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_range_max(s : OptconvexbfgsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_range_to_string(s : OptconvexbfgsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct OptconvexbfgsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn opt_convex_bfgs_slice_make(size : Int) -> OptconvexbfgsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn opt_convex_bfgs_slice_len(s : OptconvexbfgsSlice) -> Int { s.size }

pub fn opt_convex_bfgs_slice_get(s : OptconvexbfgsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn opt_convex_bfgs_slice_set(s : OptconvexbfgsSlice, i : Int, v : Double) -> OptconvexbfgsSlice {
  let result = opt_convex_bfgs_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_slice_sum(s : OptconvexbfgsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn opt_convex_bfgs_slice_mean(s : OptconvexbfgsSlice) -> Double {
  if s.size == 0 { 0.0 } else { opt_convex_bfgs_slice_sum(s) / s.size.to_double() }
}

pub fn opt_convex_bfgs_slice_scale(s : OptconvexbfgsSlice, f : Double) -> OptconvexbfgsSlice {
  let result = opt_convex_bfgs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn opt_convex_bfgs_slice_add(a : OptconvexbfgsSlice, b : OptconvexbfgsSlice) -> OptconvexbfgsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = opt_convex_bfgs_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn opt_convex_bfgs_slice_copy(s : OptconvexbfgsSlice) -> OptconvexbfgsSlice {
  let result = opt_convex_bfgs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn opt_convex_bfgs_slice_fill(s : OptconvexbfgsSlice, v : Double) -> OptconvexbfgsSlice {
  let result = opt_convex_bfgs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn opt_convex_bfgs_slice_min(s : OptconvexbfgsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_slice_max(s : OptconvexbfgsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn opt_convex_bfgs_slice_to_string(s : OptconvexbfgsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

