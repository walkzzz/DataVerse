///===
/// extcore/geo_proj_cylindrical

pub(all) struct GeoprojcylindricalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_proj_cylindrical_make_point(x : Double, y : Double) -> GeoprojcylindricalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_proj_cylindrical_make_point3(x : Double, y : Double, z : Double) -> GeoprojcylindricalPoint {
  { x, y, z, label: 0 }
}

pub fn geo_proj_cylindrical_point_x(pt : GeoprojcylindricalPoint) -> Double { pt.x }

pub fn geo_proj_cylindrical_point_y(pt : GeoprojcylindricalPoint) -> Double { pt.y }

pub fn geo_proj_cylindrical_point_z(pt : GeoprojcylindricalPoint) -> Double { pt.z }

pub fn geo_proj_cylindrical_point_label(pt : GeoprojcylindricalPoint) -> Int { pt.label }

pub fn geo_proj_cylindrical_point_dist(a : GeoprojcylindricalPoint, b : GeoprojcylindricalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_proj_cylindrical_point_add(a : GeoprojcylindricalPoint, b : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_proj_cylindrical_point_sub(a : GeoprojcylindricalPoint, b : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_proj_cylindrical_point_scale(pt : GeoprojcylindricalPoint, s : Double) -> GeoprojcylindricalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_proj_cylindrical_point_dot(a : GeoprojcylindricalPoint, b : GeoprojcylindricalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_proj_cylindrical_point_cross(a : GeoprojcylindricalPoint, b : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_proj_cylindrical_point_norm(pt : GeoprojcylindricalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_proj_cylindrical_point_normalize(pt : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  let n = geo_proj_cylindrical_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_proj_cylindrical_point_scale(pt, 1.0 / n) }
}

pub fn geo_proj_cylindrical_point_negate(pt : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_proj_cylindrical_point_mid(a : GeoprojcylindricalPoint, b : GeoprojcylindricalPoint) -> GeoprojcylindricalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_proj_cylindrical_point_lerp(a : GeoprojcylindricalPoint, b : GeoprojcylindricalPoint, t : Double) -> GeoprojcylindricalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_proj_cylindrical_point_to_string(pt : GeoprojcylindricalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeoprojcylindricalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_proj_cylindrical_make_series(vals : Array[Double], name : String) -> GeoprojcylindricalSeries {
  { vals, name, meta: 0 }
}

pub fn geo_proj_cylindrical_series_len(s : GeoprojcylindricalSeries) -> Int { s.vals.length() }

pub fn geo_proj_cylindrical_series_sum(s : GeoprojcylindricalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_proj_cylindrical_series_mean(s : GeoprojcylindricalSeries) -> Double {
  let n = geo_proj_cylindrical_series_len(s)
  if n == 0 { 0.0 } else { geo_proj_cylindrical_series_sum(s) / n.to_double() }
}

pub fn geo_proj_cylindrical_series_min(s : GeoprojcylindricalSeries) -> Double {
  let n = geo_proj_cylindrical_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_series_max(s : GeoprojcylindricalSeries) -> Double {
  let n = geo_proj_cylindrical_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_series_range(s : GeoprojcylindricalSeries) -> Double {
  geo_proj_cylindrical_series_max(s) - geo_proj_cylindrical_series_min(s)
}

pub fn geo_proj_cylindrical_series_var(s : GeoprojcylindricalSeries) -> Double {
  let n = geo_proj_cylindrical_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_proj_cylindrical_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_proj_cylindrical_series_std(s : GeoprojcylindricalSeries) -> Double { @_common.sqrt(geo_proj_cylindrical_series_var(s)) }

pub fn geo_proj_cylindrical_series_median(s : GeoprojcylindricalSeries) -> Double {
  let n = geo_proj_cylindrical_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_proj_cylindrical_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_proj_cylindrical_series_scale(s : GeoprojcylindricalSeries, f : Double) -> GeoprojcylindricalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_proj_cylindrical_series_add(a : GeoprojcylindricalSeries, b : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_proj_cylindrical_series_sub(a : GeoprojcylindricalSeries, b : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_proj_cylindrical_series_normalize(s : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  let mn = geo_proj_cylindrical_series_min(s)
  let mx = geo_proj_cylindrical_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_proj_cylindrical_series_cumsum(s : GeoprojcylindricalSeries) -> GeoprojcylindricalSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_proj_cylindrical_series_to_string(s : GeoprojcylindricalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeoprojcylindricalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_proj_cylindrical_make_matrix(rows : Int, cols : Int, val : Double) -> GeoprojcylindricalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_proj_cylindrical_matrix_identity(n : Int) -> GeoprojcylindricalMatrix {
  let m = geo_proj_cylindrical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_proj_cylindrical_matrix_get(m : GeoprojcylindricalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_proj_cylindrical_matrix_transpose(m : GeoprojcylindricalMatrix) -> GeoprojcylindricalMatrix {
  let result = geo_proj_cylindrical_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_proj_cylindrical_matrix_add(a : GeoprojcylindricalMatrix, b : GeoprojcylindricalMatrix) -> GeoprojcylindricalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_proj_cylindrical_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_proj_cylindrical_matrix_scale(m : GeoprojcylindricalMatrix, s : Double) -> GeoprojcylindricalMatrix {
  let result = geo_proj_cylindrical_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_proj_cylindrical_matrix_multiply(a : GeoprojcylindricalMatrix, b : GeoprojcylindricalMatrix) -> GeoprojcylindricalMatrix {
  if a.cols != b.rows { return geo_proj_cylindrical_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_proj_cylindrical_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_proj_cylindrical_matrix_trace(m : GeoprojcylindricalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_proj_cylindrical_matrix_det(m : GeoprojcylindricalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_proj_cylindrical_matrix_norm(m : GeoprojcylindricalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_proj_cylindrical_matrix_to_string(m : GeoprojcylindricalMatrix) -> String {
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

pub(all) struct GeoprojcylindricalVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_proj_cylindrical_make_vector(comps : Array[Double]) -> GeoprojcylindricalVector {
  { comps, dim: comps.length() }
}

pub fn geo_proj_cylindrical_vector_zero(dim : Int) -> GeoprojcylindricalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_proj_cylindrical_vector_add(a : GeoprojcylindricalVector, b : GeoprojcylindricalVector) -> GeoprojcylindricalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_cylindrical_vector_sub(a : GeoprojcylindricalVector, b : GeoprojcylindricalVector) -> GeoprojcylindricalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_proj_cylindrical_vector_scale(v : GeoprojcylindricalVector, s : Double) -> GeoprojcylindricalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_proj_cylindrical_vector_dot(a : GeoprojcylindricalVector, b : GeoprojcylindricalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_proj_cylindrical_vector_norm(v : GeoprojcylindricalVector) -> Double { @_common.sqrt(geo_proj_cylindrical_vector_dot(v, v)) }

pub fn geo_proj_cylindrical_vector_normalize(v : GeoprojcylindricalVector) -> GeoprojcylindricalVector {
  let n = geo_proj_cylindrical_vector_norm(v)
  if n < 0.0000001 { v } else { geo_proj_cylindrical_vector_scale(v, 1.0 / n) }
}

pub fn geo_proj_cylindrical_vector_dist(a : GeoprojcylindricalVector, b : GeoprojcylindricalVector) -> Double {
  geo_proj_cylindrical_vector_norm(geo_proj_cylindrical_vector_sub(a, b))
}

pub fn geo_proj_cylindrical_vector_to_string(v : GeoprojcylindricalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_proj_cylindrical_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_proj_cylindrical_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_proj_cylindrical_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_proj_cylindrical_std(data : Array[Double]) -> Double { @_common.sqrt(geo_proj_cylindrical_var(data)) }

pub fn geo_proj_cylindrical_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_proj_cylindrical_mean(a); let mb = geo_proj_cylindrical_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_proj_cylindrical_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_proj_cylindrical_std(a); let sb = geo_proj_cylindrical_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_proj_cylindrical_cov(a, b) / (sa * sb) }
}

pub fn geo_proj_cylindrical_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_proj_cylindrical_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_proj_cylindrical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_proj_cylindrical_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_proj_cylindrical_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(geo_proj_cylindrical_mse(pred, labels))
}

pub fn geo_proj_cylindrical_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_proj_cylindrical_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_proj_cylindrical_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_proj_cylindrical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_proj_cylindrical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_proj_cylindrical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_proj_cylindrical_precision(pred, labels, pos); let r = geo_proj_cylindrical_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_proj_cylindrical_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_proj_cylindrical_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_proj_cylindrical_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_proj_cylindrical_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_proj_cylindrical_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_proj_cylindrical_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_proj_cylindrical_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_proj_cylindrical_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_proj_cylindrical_fibonacci(n : Int) -> Int {
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

pub fn geo_proj_cylindrical_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_proj_cylindrical_min(data); let mx = geo_proj_cylindrical_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_proj_cylindrical_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_proj_cylindrical_mean(data); let sd = geo_proj_cylindrical_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_proj_cylindrical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_proj_cylindrical_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_proj_cylindrical_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_proj_cylindrical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GeoprojcylindricalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_frame_make(size : Int) -> GeoprojcylindricalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_frame_len(s : GeoprojcylindricalFrame) -> Int { s.size }

pub fn geo_proj_cylindrical_frame_get(s : GeoprojcylindricalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_frame_set(s : GeoprojcylindricalFrame, i : Int, v : Double) -> GeoprojcylindricalFrame {
  let result = geo_proj_cylindrical_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_frame_sum(s : GeoprojcylindricalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_frame_mean(s : GeoprojcylindricalFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_frame_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_frame_scale(s : GeoprojcylindricalFrame, f : Double) -> GeoprojcylindricalFrame {
  let result = geo_proj_cylindrical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_frame_add(a : GeoprojcylindricalFrame, b : GeoprojcylindricalFrame) -> GeoprojcylindricalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_frame_copy(s : GeoprojcylindricalFrame) -> GeoprojcylindricalFrame {
  let result = geo_proj_cylindrical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_frame_fill(s : GeoprojcylindricalFrame, v : Double) -> GeoprojcylindricalFrame {
  let result = geo_proj_cylindrical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_frame_min(s : GeoprojcylindricalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_frame_max(s : GeoprojcylindricalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_frame_to_string(s : GeoprojcylindricalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_table_make(size : Int) -> GeoprojcylindricalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_table_len(s : GeoprojcylindricalTable) -> Int { s.size }

pub fn geo_proj_cylindrical_table_get(s : GeoprojcylindricalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_table_set(s : GeoprojcylindricalTable, i : Int, v : Double) -> GeoprojcylindricalTable {
  let result = geo_proj_cylindrical_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_table_sum(s : GeoprojcylindricalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_table_mean(s : GeoprojcylindricalTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_table_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_table_scale(s : GeoprojcylindricalTable, f : Double) -> GeoprojcylindricalTable {
  let result = geo_proj_cylindrical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_table_add(a : GeoprojcylindricalTable, b : GeoprojcylindricalTable) -> GeoprojcylindricalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_table_copy(s : GeoprojcylindricalTable) -> GeoprojcylindricalTable {
  let result = geo_proj_cylindrical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_table_fill(s : GeoprojcylindricalTable, v : Double) -> GeoprojcylindricalTable {
  let result = geo_proj_cylindrical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_table_min(s : GeoprojcylindricalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_table_max(s : GeoprojcylindricalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_table_to_string(s : GeoprojcylindricalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_graphn_make(size : Int) -> GeoprojcylindricalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_graphn_len(s : GeoprojcylindricalGraphN) -> Int { s.size }

pub fn geo_proj_cylindrical_graphn_get(s : GeoprojcylindricalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_graphn_set(s : GeoprojcylindricalGraphN, i : Int, v : Double) -> GeoprojcylindricalGraphN {
  let result = geo_proj_cylindrical_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_graphn_sum(s : GeoprojcylindricalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_graphn_mean(s : GeoprojcylindricalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_graphn_scale(s : GeoprojcylindricalGraphN, f : Double) -> GeoprojcylindricalGraphN {
  let result = geo_proj_cylindrical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_graphn_add(a : GeoprojcylindricalGraphN, b : GeoprojcylindricalGraphN) -> GeoprojcylindricalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_graphn_copy(s : GeoprojcylindricalGraphN) -> GeoprojcylindricalGraphN {
  let result = geo_proj_cylindrical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_graphn_fill(s : GeoprojcylindricalGraphN, v : Double) -> GeoprojcylindricalGraphN {
  let result = geo_proj_cylindrical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_graphn_min(s : GeoprojcylindricalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_graphn_max(s : GeoprojcylindricalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_graphn_to_string(s : GeoprojcylindricalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_node_make(size : Int) -> GeoprojcylindricalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_node_len(s : GeoprojcylindricalNode) -> Int { s.size }

pub fn geo_proj_cylindrical_node_get(s : GeoprojcylindricalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_node_set(s : GeoprojcylindricalNode, i : Int, v : Double) -> GeoprojcylindricalNode {
  let result = geo_proj_cylindrical_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_node_sum(s : GeoprojcylindricalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_node_mean(s : GeoprojcylindricalNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_node_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_node_scale(s : GeoprojcylindricalNode, f : Double) -> GeoprojcylindricalNode {
  let result = geo_proj_cylindrical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_node_add(a : GeoprojcylindricalNode, b : GeoprojcylindricalNode) -> GeoprojcylindricalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_node_copy(s : GeoprojcylindricalNode) -> GeoprojcylindricalNode {
  let result = geo_proj_cylindrical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_node_fill(s : GeoprojcylindricalNode, v : Double) -> GeoprojcylindricalNode {
  let result = geo_proj_cylindrical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_node_min(s : GeoprojcylindricalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_node_max(s : GeoprojcylindricalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_node_to_string(s : GeoprojcylindricalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_edge_make(size : Int) -> GeoprojcylindricalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_edge_len(s : GeoprojcylindricalEdge) -> Int { s.size }

pub fn geo_proj_cylindrical_edge_get(s : GeoprojcylindricalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_edge_set(s : GeoprojcylindricalEdge, i : Int, v : Double) -> GeoprojcylindricalEdge {
  let result = geo_proj_cylindrical_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_edge_sum(s : GeoprojcylindricalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_edge_mean(s : GeoprojcylindricalEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_edge_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_edge_scale(s : GeoprojcylindricalEdge, f : Double) -> GeoprojcylindricalEdge {
  let result = geo_proj_cylindrical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_edge_add(a : GeoprojcylindricalEdge, b : GeoprojcylindricalEdge) -> GeoprojcylindricalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_edge_copy(s : GeoprojcylindricalEdge) -> GeoprojcylindricalEdge {
  let result = geo_proj_cylindrical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_edge_fill(s : GeoprojcylindricalEdge, v : Double) -> GeoprojcylindricalEdge {
  let result = geo_proj_cylindrical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_edge_min(s : GeoprojcylindricalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_edge_max(s : GeoprojcylindricalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_edge_to_string(s : GeoprojcylindricalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_path_make(size : Int) -> GeoprojcylindricalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_path_len(s : GeoprojcylindricalPath) -> Int { s.size }

pub fn geo_proj_cylindrical_path_get(s : GeoprojcylindricalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_path_set(s : GeoprojcylindricalPath, i : Int, v : Double) -> GeoprojcylindricalPath {
  let result = geo_proj_cylindrical_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_path_sum(s : GeoprojcylindricalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_path_mean(s : GeoprojcylindricalPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_path_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_path_scale(s : GeoprojcylindricalPath, f : Double) -> GeoprojcylindricalPath {
  let result = geo_proj_cylindrical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_path_add(a : GeoprojcylindricalPath, b : GeoprojcylindricalPath) -> GeoprojcylindricalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_path_copy(s : GeoprojcylindricalPath) -> GeoprojcylindricalPath {
  let result = geo_proj_cylindrical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_path_fill(s : GeoprojcylindricalPath, v : Double) -> GeoprojcylindricalPath {
  let result = geo_proj_cylindrical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_path_min(s : GeoprojcylindricalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_path_max(s : GeoprojcylindricalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_path_to_string(s : GeoprojcylindricalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_cluster_make(size : Int) -> GeoprojcylindricalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_cluster_len(s : GeoprojcylindricalCluster) -> Int { s.size }

pub fn geo_proj_cylindrical_cluster_get(s : GeoprojcylindricalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_cluster_set(s : GeoprojcylindricalCluster, i : Int, v : Double) -> GeoprojcylindricalCluster {
  let result = geo_proj_cylindrical_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_cluster_sum(s : GeoprojcylindricalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_cluster_mean(s : GeoprojcylindricalCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_cluster_scale(s : GeoprojcylindricalCluster, f : Double) -> GeoprojcylindricalCluster {
  let result = geo_proj_cylindrical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_cluster_add(a : GeoprojcylindricalCluster, b : GeoprojcylindricalCluster) -> GeoprojcylindricalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_cluster_copy(s : GeoprojcylindricalCluster) -> GeoprojcylindricalCluster {
  let result = geo_proj_cylindrical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_cluster_fill(s : GeoprojcylindricalCluster, v : Double) -> GeoprojcylindricalCluster {
  let result = geo_proj_cylindrical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_cluster_min(s : GeoprojcylindricalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_cluster_max(s : GeoprojcylindricalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_cluster_to_string(s : GeoprojcylindricalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_model_make(size : Int) -> GeoprojcylindricalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_model_len(s : GeoprojcylindricalModel) -> Int { s.size }

pub fn geo_proj_cylindrical_model_get(s : GeoprojcylindricalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_model_set(s : GeoprojcylindricalModel, i : Int, v : Double) -> GeoprojcylindricalModel {
  let result = geo_proj_cylindrical_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_model_sum(s : GeoprojcylindricalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_model_mean(s : GeoprojcylindricalModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_model_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_model_scale(s : GeoprojcylindricalModel, f : Double) -> GeoprojcylindricalModel {
  let result = geo_proj_cylindrical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_model_add(a : GeoprojcylindricalModel, b : GeoprojcylindricalModel) -> GeoprojcylindricalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_model_copy(s : GeoprojcylindricalModel) -> GeoprojcylindricalModel {
  let result = geo_proj_cylindrical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_model_fill(s : GeoprojcylindricalModel, v : Double) -> GeoprojcylindricalModel {
  let result = geo_proj_cylindrical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_model_min(s : GeoprojcylindricalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_model_max(s : GeoprojcylindricalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_model_to_string(s : GeoprojcylindricalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_layer_make(size : Int) -> GeoprojcylindricalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_layer_len(s : GeoprojcylindricalLayer) -> Int { s.size }

pub fn geo_proj_cylindrical_layer_get(s : GeoprojcylindricalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_layer_set(s : GeoprojcylindricalLayer, i : Int, v : Double) -> GeoprojcylindricalLayer {
  let result = geo_proj_cylindrical_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_layer_sum(s : GeoprojcylindricalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_layer_mean(s : GeoprojcylindricalLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_layer_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_layer_scale(s : GeoprojcylindricalLayer, f : Double) -> GeoprojcylindricalLayer {
  let result = geo_proj_cylindrical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_layer_add(a : GeoprojcylindricalLayer, b : GeoprojcylindricalLayer) -> GeoprojcylindricalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_layer_copy(s : GeoprojcylindricalLayer) -> GeoprojcylindricalLayer {
  let result = geo_proj_cylindrical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_layer_fill(s : GeoprojcylindricalLayer, v : Double) -> GeoprojcylindricalLayer {
  let result = geo_proj_cylindrical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_layer_min(s : GeoprojcylindricalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_layer_max(s : GeoprojcylindricalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_layer_to_string(s : GeoprojcylindricalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_buffer_make(size : Int) -> GeoprojcylindricalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_buffer_len(s : GeoprojcylindricalBuffer) -> Int { s.size }

pub fn geo_proj_cylindrical_buffer_get(s : GeoprojcylindricalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_buffer_set(s : GeoprojcylindricalBuffer, i : Int, v : Double) -> GeoprojcylindricalBuffer {
  let result = geo_proj_cylindrical_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_buffer_sum(s : GeoprojcylindricalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_buffer_mean(s : GeoprojcylindricalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_buffer_scale(s : GeoprojcylindricalBuffer, f : Double) -> GeoprojcylindricalBuffer {
  let result = geo_proj_cylindrical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_buffer_add(a : GeoprojcylindricalBuffer, b : GeoprojcylindricalBuffer) -> GeoprojcylindricalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_buffer_copy(s : GeoprojcylindricalBuffer) -> GeoprojcylindricalBuffer {
  let result = geo_proj_cylindrical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_buffer_fill(s : GeoprojcylindricalBuffer, v : Double) -> GeoprojcylindricalBuffer {
  let result = geo_proj_cylindrical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_buffer_min(s : GeoprojcylindricalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_buffer_max(s : GeoprojcylindricalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_buffer_to_string(s : GeoprojcylindricalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_cursor_make(size : Int) -> GeoprojcylindricalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_cursor_len(s : GeoprojcylindricalCursor) -> Int { s.size }

pub fn geo_proj_cylindrical_cursor_get(s : GeoprojcylindricalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_cursor_set(s : GeoprojcylindricalCursor, i : Int, v : Double) -> GeoprojcylindricalCursor {
  let result = geo_proj_cylindrical_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_cursor_sum(s : GeoprojcylindricalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_cursor_mean(s : GeoprojcylindricalCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_cursor_scale(s : GeoprojcylindricalCursor, f : Double) -> GeoprojcylindricalCursor {
  let result = geo_proj_cylindrical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_cursor_add(a : GeoprojcylindricalCursor, b : GeoprojcylindricalCursor) -> GeoprojcylindricalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_cursor_copy(s : GeoprojcylindricalCursor) -> GeoprojcylindricalCursor {
  let result = geo_proj_cylindrical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_cursor_fill(s : GeoprojcylindricalCursor, v : Double) -> GeoprojcylindricalCursor {
  let result = geo_proj_cylindrical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_cursor_min(s : GeoprojcylindricalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_cursor_max(s : GeoprojcylindricalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_cursor_to_string(s : GeoprojcylindricalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_view_make(size : Int) -> GeoprojcylindricalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_view_len(s : GeoprojcylindricalView) -> Int { s.size }

pub fn geo_proj_cylindrical_view_get(s : GeoprojcylindricalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_view_set(s : GeoprojcylindricalView, i : Int, v : Double) -> GeoprojcylindricalView {
  let result = geo_proj_cylindrical_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_view_sum(s : GeoprojcylindricalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_view_mean(s : GeoprojcylindricalView) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_view_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_view_scale(s : GeoprojcylindricalView, f : Double) -> GeoprojcylindricalView {
  let result = geo_proj_cylindrical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_view_add(a : GeoprojcylindricalView, b : GeoprojcylindricalView) -> GeoprojcylindricalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_view_copy(s : GeoprojcylindricalView) -> GeoprojcylindricalView {
  let result = geo_proj_cylindrical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_view_fill(s : GeoprojcylindricalView, v : Double) -> GeoprojcylindricalView {
  let result = geo_proj_cylindrical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_view_min(s : GeoprojcylindricalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_view_max(s : GeoprojcylindricalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_view_to_string(s : GeoprojcylindricalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_range_make(size : Int) -> GeoprojcylindricalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_range_len(s : GeoprojcylindricalRange) -> Int { s.size }

pub fn geo_proj_cylindrical_range_get(s : GeoprojcylindricalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_range_set(s : GeoprojcylindricalRange, i : Int, v : Double) -> GeoprojcylindricalRange {
  let result = geo_proj_cylindrical_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_range_sum(s : GeoprojcylindricalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_range_mean(s : GeoprojcylindricalRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_range_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_range_scale(s : GeoprojcylindricalRange, f : Double) -> GeoprojcylindricalRange {
  let result = geo_proj_cylindrical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_range_add(a : GeoprojcylindricalRange, b : GeoprojcylindricalRange) -> GeoprojcylindricalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_range_copy(s : GeoprojcylindricalRange) -> GeoprojcylindricalRange {
  let result = geo_proj_cylindrical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_range_fill(s : GeoprojcylindricalRange, v : Double) -> GeoprojcylindricalRange {
  let result = geo_proj_cylindrical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_range_min(s : GeoprojcylindricalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_range_max(s : GeoprojcylindricalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_range_to_string(s : GeoprojcylindricalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeoprojcylindricalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_proj_cylindrical_slice_make(size : Int) -> GeoprojcylindricalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_proj_cylindrical_slice_len(s : GeoprojcylindricalSlice) -> Int { s.size }

pub fn geo_proj_cylindrical_slice_get(s : GeoprojcylindricalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_proj_cylindrical_slice_set(s : GeoprojcylindricalSlice, i : Int, v : Double) -> GeoprojcylindricalSlice {
  let result = geo_proj_cylindrical_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_slice_sum(s : GeoprojcylindricalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_proj_cylindrical_slice_mean(s : GeoprojcylindricalSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_proj_cylindrical_slice_sum(s) / s.size.to_double() }
}

pub fn geo_proj_cylindrical_slice_scale(s : GeoprojcylindricalSlice, f : Double) -> GeoprojcylindricalSlice {
  let result = geo_proj_cylindrical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_proj_cylindrical_slice_add(a : GeoprojcylindricalSlice, b : GeoprojcylindricalSlice) -> GeoprojcylindricalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_proj_cylindrical_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_proj_cylindrical_slice_copy(s : GeoprojcylindricalSlice) -> GeoprojcylindricalSlice {
  let result = geo_proj_cylindrical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_proj_cylindrical_slice_fill(s : GeoprojcylindricalSlice, v : Double) -> GeoprojcylindricalSlice {
  let result = geo_proj_cylindrical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_proj_cylindrical_slice_min(s : GeoprojcylindricalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_slice_max(s : GeoprojcylindricalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_proj_cylindrical_slice_to_string(s : GeoprojcylindricalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

