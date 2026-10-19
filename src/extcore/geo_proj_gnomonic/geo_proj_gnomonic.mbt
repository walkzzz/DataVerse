///===
/// extcore/geo_proj_gnomonic

pub(all) struct GeoprojgnomonicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_gnomonic_make_point(x : Double, y : Double) -> GeoprojgnomonicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_gnomonic_make_point3(x : Double, y : Double, z : Double) -> GeoprojgnomonicPoint {
  { x, y, z, label: 0 }
}

pub fn geo_proj_gnomonic_point_x(pt : GeoprojgnomonicPoint) -> Double { pt.x }

pub fn geo_proj_gnomonic_point_y(pt : GeoprojgnomonicPoint) -> Double { pt.y }

pub fn geo_proj_gnomonic_point_z(pt : GeoprojgnomonicPoint) -> Double { pt.z }

pub fn geo_proj_gnomonic_point_label(pt : GeoprojgnomonicPoint) -> Int { pt.label }

pub fn geo_proj_gnomonic_point_dist(a : GeoprojgnomonicPoint, b : GeoprojgnomonicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_proj_gnomonic_point_add(a : GeoprojgnomonicPoint, b : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_proj_gnomonic_point_sub(a : GeoprojgnomonicPoint, b : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_proj_gnomonic_point_scale(pt : GeoprojgnomonicPoint, s : Double) -> GeoprojgnomonicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_proj_gnomonic_point_dot(a : GeoprojgnomonicPoint, b : GeoprojgnomonicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_proj_gnomonic_point_cross(a : GeoprojgnomonicPoint, b : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_proj_gnomonic_point_norm(pt : GeoprojgnomonicPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_proj_gnomonic_point_normalize(pt : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  let n = geo_proj_gnomonic_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_proj_gnomonic_point_scale(pt, 1.0 / n) }
}

pub fn geo_proj_gnomonic_point_negate(pt : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_proj_gnomonic_point_mid(a : GeoprojgnomonicPoint, b : GeoprojgnomonicPoint) -> GeoprojgnomonicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_proj_gnomonic_point_lerp(a : GeoprojgnomonicPoint, b : GeoprojgnomonicPoint, t : Double) -> GeoprojgnomonicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_proj_gnomonic_point_to_string(pt : GeoprojgnomonicPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeoprojgnomonicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_gnomonic_make_series(vals : Array[Double], name : String) -> GeoprojgnomonicSeries {
  { vals, name, meta: 0 }
}

pub fn geo_proj_gnomonic_series_len(s : GeoprojgnomonicSeries) -> Int { s.vals.length() }

pub fn geo_proj_gnomonic_series_sum(s : GeoprojgnomonicSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_proj_gnomonic_series_mean(s : GeoprojgnomonicSeries) -> Double {
  let n = geo_proj_gnomonic_series_len(s)
  if n == 0 { 0.0 } else { geo_proj_gnomonic_series_sum(s) / n.to_double() }
}

pub fn geo_proj_gnomonic_series_min(s : GeoprojgnomonicSeries) -> Double {
  let n = geo_proj_gnomonic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_series_max(s : GeoprojgnomonicSeries) -> Double {
  let n = geo_proj_gnomonic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_series_range(s : GeoprojgnomonicSeries) -> Double {
  geo_proj_gnomonic_series_max(s) - geo_proj_gnomonic_series_min(s)
}

pub fn geo_proj_gnomonic_series_var(s : GeoprojgnomonicSeries) -> Double {
  let n = geo_proj_gnomonic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_proj_gnomonic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_proj_gnomonic_series_std(s : GeoprojgnomonicSeries) -> Double { @_common.sqrt(geo_proj_gnomonic_series_var(s)) }

pub fn geo_proj_gnomonic_series_median(s : GeoprojgnomonicSeries) -> Double {
  let n = geo_proj_gnomonic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_proj_gnomonic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_proj_gnomonic_series_scale(s : GeoprojgnomonicSeries, f : Double) -> GeoprojgnomonicSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_proj_gnomonic_series_add(a : GeoprojgnomonicSeries, b : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_proj_gnomonic_series_sub(a : GeoprojgnomonicSeries, b : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_proj_gnomonic_series_normalize(s : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  let mn = geo_proj_gnomonic_series_min(s)
  let mx = geo_proj_gnomonic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_proj_gnomonic_series_cumsum(s : GeoprojgnomonicSeries) -> GeoprojgnomonicSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_proj_gnomonic_series_to_string(s : GeoprojgnomonicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojgnomonicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_gnomonic_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojgnomonicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_gnomonic_matrix_identity(n : Int) -> GeoprojgnomonicMatrix {
  let m = geo_proj_gnomonic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_proj_gnomonic_matrix_get(m : GeoprojgnomonicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_proj_gnomonic_matrix_transpose(m : GeoprojgnomonicMatrix) -> GeoprojgnomonicMatrix {
  let result = geo_proj_gnomonic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_proj_gnomonic_matrix_add(a : GeoprojgnomonicMatrix, b : GeoprojgnomonicMatrix) -> GeoprojgnomonicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_proj_gnomonic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_proj_gnomonic_matrix_scale(m : GeoprojgnomonicMatrix, s : Double) -> GeoprojgnomonicMatrix {
  let result = geo_proj_gnomonic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_proj_gnomonic_matrix_multiply(a : GeoprojgnomonicMatrix, b : GeoprojgnomonicMatrix) -> GeoprojgnomonicMatrix {
  if a.cols != b.rows { return geo_proj_gnomonic_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_proj_gnomonic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_proj_gnomonic_matrix_trace(m : GeoprojgnomonicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_proj_gnomonic_matrix_det(m : GeoprojgnomonicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_proj_gnomonic_matrix_norm(m : GeoprojgnomonicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_proj_gnomonic_matrix_to_string(m : GeoprojgnomonicMatrix) -> String {
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

pub(all) struct GeoprojgnomonicVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_gnomonic_make_vector(comps : Array[Double]) -> GeoprojgnomonicVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_gnomonic_vector_zero(dim : Int) -> GeoprojgnomonicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_proj_gnomonic_vector_add(a : GeoprojgnomonicVector, b : GeoprojgnomonicVector) -> GeoprojgnomonicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_gnomonic_vector_sub(a : GeoprojgnomonicVector, b : GeoprojgnomonicVector) -> GeoprojgnomonicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_gnomonic_vector_scale(v : GeoprojgnomonicVector, s : Double) -> GeoprojgnomonicVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_proj_gnomonic_vector_dot(a : GeoprojgnomonicVector, b : GeoprojgnomonicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_proj_gnomonic_vector_norm(v : GeoprojgnomonicVector) -> Double { @_common.sqrt(geo_proj_gnomonic_vector_dot(v, v)) }

pub fn geo_proj_gnomonic_vector_normalize(v : GeoprojgnomonicVector) -> GeoprojgnomonicVector {
  let n = geo_proj_gnomonic_vector_norm(v)
  if n < 0.0000001 { v } else { geo_proj_gnomonic_vector_scale(v, 1.0 / n) }
}

pub fn geo_proj_gnomonic_vector_dist(a : GeoprojgnomonicVector, b : GeoprojgnomonicVector) -> Double {
  geo_proj_gnomonic_vector_norm(geo_proj_gnomonic_vector_sub(a, b))
}

pub fn geo_proj_gnomonic_vector_to_string(v : GeoprojgnomonicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_gnomonic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_proj_gnomonic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_proj_gnomonic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_proj_gnomonic_std(data : Array[Double]) -> Double { @_common.sqrt(geo_proj_gnomonic_var(data)) }

pub fn geo_proj_gnomonic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_proj_gnomonic_mean(a); let mb = geo_proj_gnomonic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_proj_gnomonic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_proj_gnomonic_std(a); let sb = geo_proj_gnomonic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_proj_gnomonic_cov(a, b) / (sa * sb) }
}

pub fn geo_proj_gnomonic_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_proj_gnomonic_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_proj_gnomonic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_proj_gnomonic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_proj_gnomonic_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(geo_proj_gnomonic_mse(pred, labels))
}

pub fn geo_proj_gnomonic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_proj_gnomonic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_proj_gnomonic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_proj_gnomonic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_proj_gnomonic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_proj_gnomonic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_proj_gnomonic_precision(pred, labels, pos); let r = geo_proj_gnomonic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_proj_gnomonic_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_proj_gnomonic_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_proj_gnomonic_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_proj_gnomonic_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_proj_gnomonic_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_proj_gnomonic_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_proj_gnomonic_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_proj_gnomonic_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_proj_gnomonic_fibonacci(n : Int) -> Int {
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

pub fn geo_proj_gnomonic_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_proj_gnomonic_min(data); let mx = geo_proj_gnomonic_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_proj_gnomonic_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_proj_gnomonic_mean(data); let sd = geo_proj_gnomonic_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_proj_gnomonic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_proj_gnomonic_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_proj_gnomonic_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_proj_gnomonic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GeoprojgnomonicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_frame_make(size : Int) -> GeoprojgnomonicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_frame_len(s : GeoprojgnomonicFrame) -> Int { s.size }

pub fn geo_proj_gnomonic_frame_get(s : GeoprojgnomonicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_frame_set(s : GeoprojgnomonicFrame, i : Int, v : Double) -> GeoprojgnomonicFrame {
  let result = geo_proj_gnomonic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_frame_sum(s : GeoprojgnomonicFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_frame_mean(s : GeoprojgnomonicFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_frame_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_frame_scale(s : GeoprojgnomonicFrame, f : Double) -> GeoprojgnomonicFrame {
  let result = geo_proj_gnomonic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_frame_add(a : GeoprojgnomonicFrame, b : GeoprojgnomonicFrame) -> GeoprojgnomonicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_frame_copy(s : GeoprojgnomonicFrame) -> GeoprojgnomonicFrame {
  let result = geo_proj_gnomonic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_frame_fill(s : GeoprojgnomonicFrame, v : Double) -> GeoprojgnomonicFrame {
  let result = geo_proj_gnomonic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_frame_min(s : GeoprojgnomonicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_frame_max(s : GeoprojgnomonicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_frame_to_string(s : GeoprojgnomonicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_table_make(size : Int) -> GeoprojgnomonicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_table_len(s : GeoprojgnomonicTable) -> Int { s.size }

pub fn geo_proj_gnomonic_table_get(s : GeoprojgnomonicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_table_set(s : GeoprojgnomonicTable, i : Int, v : Double) -> GeoprojgnomonicTable {
  let result = geo_proj_gnomonic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_table_sum(s : GeoprojgnomonicTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_table_mean(s : GeoprojgnomonicTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_table_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_table_scale(s : GeoprojgnomonicTable, f : Double) -> GeoprojgnomonicTable {
  let result = geo_proj_gnomonic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_table_add(a : GeoprojgnomonicTable, b : GeoprojgnomonicTable) -> GeoprojgnomonicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_table_copy(s : GeoprojgnomonicTable) -> GeoprojgnomonicTable {
  let result = geo_proj_gnomonic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_table_fill(s : GeoprojgnomonicTable, v : Double) -> GeoprojgnomonicTable {
  let result = geo_proj_gnomonic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_table_min(s : GeoprojgnomonicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_table_max(s : GeoprojgnomonicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_table_to_string(s : GeoprojgnomonicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_graphn_make(size : Int) -> GeoprojgnomonicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_graphn_len(s : GeoprojgnomonicGraphN) -> Int { s.size }

pub fn geo_proj_gnomonic_graphn_get(s : GeoprojgnomonicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_graphn_set(s : GeoprojgnomonicGraphN, i : Int, v : Double) -> GeoprojgnomonicGraphN {
  let result = geo_proj_gnomonic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_graphn_sum(s : GeoprojgnomonicGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_graphn_mean(s : GeoprojgnomonicGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_graphn_scale(s : GeoprojgnomonicGraphN, f : Double) -> GeoprojgnomonicGraphN {
  let result = geo_proj_gnomonic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_graphn_add(a : GeoprojgnomonicGraphN, b : GeoprojgnomonicGraphN) -> GeoprojgnomonicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_graphn_copy(s : GeoprojgnomonicGraphN) -> GeoprojgnomonicGraphN {
  let result = geo_proj_gnomonic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_graphn_fill(s : GeoprojgnomonicGraphN, v : Double) -> GeoprojgnomonicGraphN {
  let result = geo_proj_gnomonic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_graphn_min(s : GeoprojgnomonicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_graphn_max(s : GeoprojgnomonicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_graphn_to_string(s : GeoprojgnomonicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_node_make(size : Int) -> GeoprojgnomonicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_node_len(s : GeoprojgnomonicNode) -> Int { s.size }

pub fn geo_proj_gnomonic_node_get(s : GeoprojgnomonicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_node_set(s : GeoprojgnomonicNode, i : Int, v : Double) -> GeoprojgnomonicNode {
  let result = geo_proj_gnomonic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_node_sum(s : GeoprojgnomonicNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_node_mean(s : GeoprojgnomonicNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_node_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_node_scale(s : GeoprojgnomonicNode, f : Double) -> GeoprojgnomonicNode {
  let result = geo_proj_gnomonic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_node_add(a : GeoprojgnomonicNode, b : GeoprojgnomonicNode) -> GeoprojgnomonicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_node_copy(s : GeoprojgnomonicNode) -> GeoprojgnomonicNode {
  let result = geo_proj_gnomonic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_node_fill(s : GeoprojgnomonicNode, v : Double) -> GeoprojgnomonicNode {
  let result = geo_proj_gnomonic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_node_min(s : GeoprojgnomonicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_node_max(s : GeoprojgnomonicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_node_to_string(s : GeoprojgnomonicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_edge_make(size : Int) -> GeoprojgnomonicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_edge_len(s : GeoprojgnomonicEdge) -> Int { s.size }

pub fn geo_proj_gnomonic_edge_get(s : GeoprojgnomonicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_edge_set(s : GeoprojgnomonicEdge, i : Int, v : Double) -> GeoprojgnomonicEdge {
  let result = geo_proj_gnomonic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_edge_sum(s : GeoprojgnomonicEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_edge_mean(s : GeoprojgnomonicEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_edge_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_edge_scale(s : GeoprojgnomonicEdge, f : Double) -> GeoprojgnomonicEdge {
  let result = geo_proj_gnomonic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_edge_add(a : GeoprojgnomonicEdge, b : GeoprojgnomonicEdge) -> GeoprojgnomonicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_edge_copy(s : GeoprojgnomonicEdge) -> GeoprojgnomonicEdge {
  let result = geo_proj_gnomonic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_edge_fill(s : GeoprojgnomonicEdge, v : Double) -> GeoprojgnomonicEdge {
  let result = geo_proj_gnomonic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_edge_min(s : GeoprojgnomonicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_edge_max(s : GeoprojgnomonicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_edge_to_string(s : GeoprojgnomonicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_path_make(size : Int) -> GeoprojgnomonicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_path_len(s : GeoprojgnomonicPath) -> Int { s.size }

pub fn geo_proj_gnomonic_path_get(s : GeoprojgnomonicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_path_set(s : GeoprojgnomonicPath, i : Int, v : Double) -> GeoprojgnomonicPath {
  let result = geo_proj_gnomonic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_path_sum(s : GeoprojgnomonicPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_path_mean(s : GeoprojgnomonicPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_path_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_path_scale(s : GeoprojgnomonicPath, f : Double) -> GeoprojgnomonicPath {
  let result = geo_proj_gnomonic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_path_add(a : GeoprojgnomonicPath, b : GeoprojgnomonicPath) -> GeoprojgnomonicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_path_copy(s : GeoprojgnomonicPath) -> GeoprojgnomonicPath {
  let result = geo_proj_gnomonic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_path_fill(s : GeoprojgnomonicPath, v : Double) -> GeoprojgnomonicPath {
  let result = geo_proj_gnomonic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_path_min(s : GeoprojgnomonicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_path_max(s : GeoprojgnomonicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_path_to_string(s : GeoprojgnomonicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_cluster_make(size : Int) -> GeoprojgnomonicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_cluster_len(s : GeoprojgnomonicCluster) -> Int { s.size }

pub fn geo_proj_gnomonic_cluster_get(s : GeoprojgnomonicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_cluster_set(s : GeoprojgnomonicCluster, i : Int, v : Double) -> GeoprojgnomonicCluster {
  let result = geo_proj_gnomonic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_cluster_sum(s : GeoprojgnomonicCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_cluster_mean(s : GeoprojgnomonicCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_cluster_scale(s : GeoprojgnomonicCluster, f : Double) -> GeoprojgnomonicCluster {
  let result = geo_proj_gnomonic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_cluster_add(a : GeoprojgnomonicCluster, b : GeoprojgnomonicCluster) -> GeoprojgnomonicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_cluster_copy(s : GeoprojgnomonicCluster) -> GeoprojgnomonicCluster {
  let result = geo_proj_gnomonic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_cluster_fill(s : GeoprojgnomonicCluster, v : Double) -> GeoprojgnomonicCluster {
  let result = geo_proj_gnomonic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_cluster_min(s : GeoprojgnomonicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_cluster_max(s : GeoprojgnomonicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_cluster_to_string(s : GeoprojgnomonicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_model_make(size : Int) -> GeoprojgnomonicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_model_len(s : GeoprojgnomonicModel) -> Int { s.size }

pub fn geo_proj_gnomonic_model_get(s : GeoprojgnomonicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_model_set(s : GeoprojgnomonicModel, i : Int, v : Double) -> GeoprojgnomonicModel {
  let result = geo_proj_gnomonic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_model_sum(s : GeoprojgnomonicModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_model_mean(s : GeoprojgnomonicModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_model_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_model_scale(s : GeoprojgnomonicModel, f : Double) -> GeoprojgnomonicModel {
  let result = geo_proj_gnomonic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_model_add(a : GeoprojgnomonicModel, b : GeoprojgnomonicModel) -> GeoprojgnomonicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_model_copy(s : GeoprojgnomonicModel) -> GeoprojgnomonicModel {
  let result = geo_proj_gnomonic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_model_fill(s : GeoprojgnomonicModel, v : Double) -> GeoprojgnomonicModel {
  let result = geo_proj_gnomonic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_model_min(s : GeoprojgnomonicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_model_max(s : GeoprojgnomonicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_model_to_string(s : GeoprojgnomonicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_layer_make(size : Int) -> GeoprojgnomonicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_layer_len(s : GeoprojgnomonicLayer) -> Int { s.size }

pub fn geo_proj_gnomonic_layer_get(s : GeoprojgnomonicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_layer_set(s : GeoprojgnomonicLayer, i : Int, v : Double) -> GeoprojgnomonicLayer {
  let result = geo_proj_gnomonic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_layer_sum(s : GeoprojgnomonicLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_layer_mean(s : GeoprojgnomonicLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_layer_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_layer_scale(s : GeoprojgnomonicLayer, f : Double) -> GeoprojgnomonicLayer {
  let result = geo_proj_gnomonic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_layer_add(a : GeoprojgnomonicLayer, b : GeoprojgnomonicLayer) -> GeoprojgnomonicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_layer_copy(s : GeoprojgnomonicLayer) -> GeoprojgnomonicLayer {
  let result = geo_proj_gnomonic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_layer_fill(s : GeoprojgnomonicLayer, v : Double) -> GeoprojgnomonicLayer {
  let result = geo_proj_gnomonic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_layer_min(s : GeoprojgnomonicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_layer_max(s : GeoprojgnomonicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_layer_to_string(s : GeoprojgnomonicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_buffer_make(size : Int) -> GeoprojgnomonicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_buffer_len(s : GeoprojgnomonicBuffer) -> Int { s.size }

pub fn geo_proj_gnomonic_buffer_get(s : GeoprojgnomonicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_buffer_set(s : GeoprojgnomonicBuffer, i : Int, v : Double) -> GeoprojgnomonicBuffer {
  let result = geo_proj_gnomonic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_buffer_sum(s : GeoprojgnomonicBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_buffer_mean(s : GeoprojgnomonicBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_buffer_scale(s : GeoprojgnomonicBuffer, f : Double) -> GeoprojgnomonicBuffer {
  let result = geo_proj_gnomonic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_buffer_add(a : GeoprojgnomonicBuffer, b : GeoprojgnomonicBuffer) -> GeoprojgnomonicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_buffer_copy(s : GeoprojgnomonicBuffer) -> GeoprojgnomonicBuffer {
  let result = geo_proj_gnomonic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_buffer_fill(s : GeoprojgnomonicBuffer, v : Double) -> GeoprojgnomonicBuffer {
  let result = geo_proj_gnomonic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_buffer_min(s : GeoprojgnomonicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_buffer_max(s : GeoprojgnomonicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_buffer_to_string(s : GeoprojgnomonicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_cursor_make(size : Int) -> GeoprojgnomonicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_cursor_len(s : GeoprojgnomonicCursor) -> Int { s.size }

pub fn geo_proj_gnomonic_cursor_get(s : GeoprojgnomonicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_cursor_set(s : GeoprojgnomonicCursor, i : Int, v : Double) -> GeoprojgnomonicCursor {
  let result = geo_proj_gnomonic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_cursor_sum(s : GeoprojgnomonicCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_cursor_mean(s : GeoprojgnomonicCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_cursor_scale(s : GeoprojgnomonicCursor, f : Double) -> GeoprojgnomonicCursor {
  let result = geo_proj_gnomonic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_cursor_add(a : GeoprojgnomonicCursor, b : GeoprojgnomonicCursor) -> GeoprojgnomonicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_cursor_copy(s : GeoprojgnomonicCursor) -> GeoprojgnomonicCursor {
  let result = geo_proj_gnomonic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_cursor_fill(s : GeoprojgnomonicCursor, v : Double) -> GeoprojgnomonicCursor {
  let result = geo_proj_gnomonic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_cursor_min(s : GeoprojgnomonicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_cursor_max(s : GeoprojgnomonicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_cursor_to_string(s : GeoprojgnomonicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_view_make(size : Int) -> GeoprojgnomonicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_view_len(s : GeoprojgnomonicView) -> Int { s.size }

pub fn geo_proj_gnomonic_view_get(s : GeoprojgnomonicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_view_set(s : GeoprojgnomonicView, i : Int, v : Double) -> GeoprojgnomonicView {
  let result = geo_proj_gnomonic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_view_sum(s : GeoprojgnomonicView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_view_mean(s : GeoprojgnomonicView) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_view_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_view_scale(s : GeoprojgnomonicView, f : Double) -> GeoprojgnomonicView {
  let result = geo_proj_gnomonic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_view_add(a : GeoprojgnomonicView, b : GeoprojgnomonicView) -> GeoprojgnomonicView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_view_copy(s : GeoprojgnomonicView) -> GeoprojgnomonicView {
  let result = geo_proj_gnomonic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_view_fill(s : GeoprojgnomonicView, v : Double) -> GeoprojgnomonicView {
  let result = geo_proj_gnomonic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_view_min(s : GeoprojgnomonicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_view_max(s : GeoprojgnomonicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_view_to_string(s : GeoprojgnomonicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_range_make(size : Int) -> GeoprojgnomonicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_range_len(s : GeoprojgnomonicRange) -> Int { s.size }

pub fn geo_proj_gnomonic_range_get(s : GeoprojgnomonicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_range_set(s : GeoprojgnomonicRange, i : Int, v : Double) -> GeoprojgnomonicRange {
  let result = geo_proj_gnomonic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_range_sum(s : GeoprojgnomonicRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_range_mean(s : GeoprojgnomonicRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_range_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_range_scale(s : GeoprojgnomonicRange, f : Double) -> GeoprojgnomonicRange {
  let result = geo_proj_gnomonic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_range_add(a : GeoprojgnomonicRange, b : GeoprojgnomonicRange) -> GeoprojgnomonicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_range_copy(s : GeoprojgnomonicRange) -> GeoprojgnomonicRange {
  let result = geo_proj_gnomonic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_range_fill(s : GeoprojgnomonicRange, v : Double) -> GeoprojgnomonicRange {
  let result = geo_proj_gnomonic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_range_min(s : GeoprojgnomonicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_range_max(s : GeoprojgnomonicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_range_to_string(s : GeoprojgnomonicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojgnomonicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_gnomonic_slice_make(size : Int) -> GeoprojgnomonicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_gnomonic_slice_len(s : GeoprojgnomonicSlice) -> Int { s.size }

pub fn geo_proj_gnomonic_slice_get(s : GeoprojgnomonicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_gnomonic_slice_set(s : GeoprojgnomonicSlice, i : Int, v : Double) -> GeoprojgnomonicSlice {
  let result = geo_proj_gnomonic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_slice_sum(s : GeoprojgnomonicSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_gnomonic_slice_mean(s : GeoprojgnomonicSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_gnomonic_slice_sum(s) / s.size.to_double() }
}

pub fn geo_proj_gnomonic_slice_scale(s : GeoprojgnomonicSlice, f : Double) -> GeoprojgnomonicSlice {
  let result = geo_proj_gnomonic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_gnomonic_slice_add(a : GeoprojgnomonicSlice, b : GeoprojgnomonicSlice) -> GeoprojgnomonicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_gnomonic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_gnomonic_slice_copy(s : GeoprojgnomonicSlice) -> GeoprojgnomonicSlice {
  let result = geo_proj_gnomonic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_gnomonic_slice_fill(s : GeoprojgnomonicSlice, v : Double) -> GeoprojgnomonicSlice {
  let result = geo_proj_gnomonic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_gnomonic_slice_min(s : GeoprojgnomonicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_slice_max(s : GeoprojgnomonicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_gnomonic_slice_to_string(s : GeoprojgnomonicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

