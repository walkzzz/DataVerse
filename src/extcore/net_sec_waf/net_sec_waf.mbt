///===
/// extcore/net_sec_waf

pub(all) struct NetsecwafPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_waf_make_point(x : Double, y : Double) -> NetsecwafPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_waf_make_point3(x : Double, y : Double, z : Double) -> NetsecwafPoint {
  { x, y, z, label: 0 }
}

pub fn net_sec_waf_point_x(pt : NetsecwafPoint) -> Double { pt.x }

pub fn net_sec_waf_point_y(pt : NetsecwafPoint) -> Double { pt.y }

pub fn net_sec_waf_point_z(pt : NetsecwafPoint) -> Double { pt.z }

pub fn net_sec_waf_point_label(pt : NetsecwafPoint) -> Int { pt.label }

pub fn net_sec_waf_point_dist(a : NetsecwafPoint, b : NetsecwafPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_sec_waf_point_add(a : NetsecwafPoint, b : NetsecwafPoint) -> NetsecwafPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_sec_waf_point_sub(a : NetsecwafPoint, b : NetsecwafPoint) -> NetsecwafPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_sec_waf_point_scale(pt : NetsecwafPoint, s : Double) -> NetsecwafPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_sec_waf_point_dot(a : NetsecwafPoint, b : NetsecwafPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_sec_waf_point_cross(a : NetsecwafPoint, b : NetsecwafPoint) -> NetsecwafPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_sec_waf_point_norm(pt : NetsecwafPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_sec_waf_point_normalize(pt : NetsecwafPoint) -> NetsecwafPoint {
  let n = net_sec_waf_point_norm(pt)
  if n < 0.0000001 { pt } else { net_sec_waf_point_scale(pt, 1.0 / n) }
}

pub fn net_sec_waf_point_negate(pt : NetsecwafPoint) -> NetsecwafPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_sec_waf_point_mid(a : NetsecwafPoint, b : NetsecwafPoint) -> NetsecwafPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_sec_waf_point_lerp(a : NetsecwafPoint, b : NetsecwafPoint, t : Double) -> NetsecwafPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_sec_waf_point_to_string(pt : NetsecwafPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetsecwafSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_waf_make_series(vals : Array[Double], name : String) -> NetsecwafSeries {
  { vals, name, meta: 0 }
}

pub fn net_sec_waf_series_len(s : NetsecwafSeries) -> Int { s.vals.length() }

pub fn net_sec_waf_series_sum(s : NetsecwafSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_sec_waf_series_mean(s : NetsecwafSeries) -> Double {
  let n = net_sec_waf_series_len(s)
  if n == 0 { 0.0 } else { net_sec_waf_series_sum(s) / n.to_double() }
}

pub fn net_sec_waf_series_min(s : NetsecwafSeries) -> Double {
  let n = net_sec_waf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_sec_waf_series_max(s : NetsecwafSeries) -> Double {
  let n = net_sec_waf_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_sec_waf_series_range(s : NetsecwafSeries) -> Double {
  net_sec_waf_series_max(s) - net_sec_waf_series_min(s)
}

pub fn net_sec_waf_series_var(s : NetsecwafSeries) -> Double {
  let n = net_sec_waf_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_sec_waf_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_sec_waf_series_std(s : NetsecwafSeries) -> Double { @_common.sqrt(net_sec_waf_series_var(s)) }

pub fn net_sec_waf_series_median(s : NetsecwafSeries) -> Double {
  let n = net_sec_waf_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_sec_waf_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_sec_waf_series_scale(s : NetsecwafSeries, f : Double) -> NetsecwafSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_sec_waf_series_add(a : NetsecwafSeries, b : NetsecwafSeries) -> NetsecwafSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_sec_waf_series_sub(a : NetsecwafSeries, b : NetsecwafSeries) -> NetsecwafSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_sec_waf_series_normalize(s : NetsecwafSeries) -> NetsecwafSeries {
  let mn = net_sec_waf_series_min(s)
  let mx = net_sec_waf_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_sec_waf_series_cumsum(s : NetsecwafSeries) -> NetsecwafSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_sec_waf_series_to_string(s : NetsecwafSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecwafMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_waf_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecwafMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_waf_matrix_identity(n : Int) -> NetsecwafMatrix {
  let m = net_sec_waf_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_sec_waf_matrix_get(m : NetsecwafMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_sec_waf_matrix_transpose(m : NetsecwafMatrix) -> NetsecwafMatrix {
  let result = net_sec_waf_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_sec_waf_matrix_add(a : NetsecwafMatrix, b : NetsecwafMatrix) -> NetsecwafMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_sec_waf_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_sec_waf_matrix_scale(m : NetsecwafMatrix, s : Double) -> NetsecwafMatrix {
  let result = net_sec_waf_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_sec_waf_matrix_multiply(a : NetsecwafMatrix, b : NetsecwafMatrix) -> NetsecwafMatrix {
  if a.cols != b.rows { return net_sec_waf_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_sec_waf_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_sec_waf_matrix_trace(m : NetsecwafMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_sec_waf_matrix_det(m : NetsecwafMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_sec_waf_matrix_norm(m : NetsecwafMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_sec_waf_matrix_to_string(m : NetsecwafMatrix) -> String {
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

pub(all) struct NetsecwafVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_waf_make_vector(comps : Array[Double]) -> NetsecwafVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_waf_vector_zero(dim : Int) -> NetsecwafVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_sec_waf_vector_add(a : NetsecwafVector, b : NetsecwafVector) -> NetsecwafVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_waf_vector_sub(a : NetsecwafVector, b : NetsecwafVector) -> NetsecwafVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_waf_vector_scale(v : NetsecwafVector, s : Double) -> NetsecwafVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_sec_waf_vector_dot(a : NetsecwafVector, b : NetsecwafVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_sec_waf_vector_norm(v : NetsecwafVector) -> Double { @_common.sqrt(net_sec_waf_vector_dot(v, v)) }

pub fn net_sec_waf_vector_normalize(v : NetsecwafVector) -> NetsecwafVector {
  let n = net_sec_waf_vector_norm(v)
  if n < 0.0000001 { v } else { net_sec_waf_vector_scale(v, 1.0 / n) }
}

pub fn net_sec_waf_vector_dist(a : NetsecwafVector, b : NetsecwafVector) -> Double {
  net_sec_waf_vector_norm(net_sec_waf_vector_sub(a, b))
}

pub fn net_sec_waf_vector_to_string(v : NetsecwafVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_waf_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_sec_waf_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_sec_waf_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_sec_waf_std(data : Array[Double]) -> Double { @_common.sqrt(net_sec_waf_var(data)) }

pub fn net_sec_waf_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_sec_waf_mean(a); let mb = net_sec_waf_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_sec_waf_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_sec_waf_std(a); let sb = net_sec_waf_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_sec_waf_cov(a, b) / (sa * sb) }
}

pub fn net_sec_waf_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_sec_waf_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_sec_waf_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_sec_waf_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_sec_waf_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(net_sec_waf_mse(pred, labels))
}

pub fn net_sec_waf_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_sec_waf_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_sec_waf_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_sec_waf_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_sec_waf_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_sec_waf_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_sec_waf_precision(pred, labels, pos); let r = net_sec_waf_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_sec_waf_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_sec_waf_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_sec_waf_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_sec_waf_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_sec_waf_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_sec_waf_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_sec_waf_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_sec_waf_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_sec_waf_fibonacci(n : Int) -> Int {
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

pub fn net_sec_waf_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_sec_waf_min(data); let mx = net_sec_waf_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_sec_waf_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_sec_waf_mean(data); let sd = net_sec_waf_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_sec_waf_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_sec_waf_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_sec_waf_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_sec_waf_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_sec_waf_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_sec_waf_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NetsecwafFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_frame_make(size : Int) -> NetsecwafFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_frame_len(s : NetsecwafFrame) -> Int { s.size }

pub fn net_sec_waf_frame_get(s : NetsecwafFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_frame_set(s : NetsecwafFrame, i : Int, v : Double) -> NetsecwafFrame {
  let result = net_sec_waf_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_frame_sum(s : NetsecwafFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_frame_mean(s : NetsecwafFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_frame_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_frame_scale(s : NetsecwafFrame, f : Double) -> NetsecwafFrame {
  let result = net_sec_waf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_frame_add(a : NetsecwafFrame, b : NetsecwafFrame) -> NetsecwafFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_frame_copy(s : NetsecwafFrame) -> NetsecwafFrame {
  let result = net_sec_waf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_frame_fill(s : NetsecwafFrame, v : Double) -> NetsecwafFrame {
  let result = net_sec_waf_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_frame_min(s : NetsecwafFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_frame_max(s : NetsecwafFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_frame_to_string(s : NetsecwafFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_table_make(size : Int) -> NetsecwafTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_table_len(s : NetsecwafTable) -> Int { s.size }

pub fn net_sec_waf_table_get(s : NetsecwafTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_table_set(s : NetsecwafTable, i : Int, v : Double) -> NetsecwafTable {
  let result = net_sec_waf_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_table_sum(s : NetsecwafTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_table_mean(s : NetsecwafTable) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_table_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_table_scale(s : NetsecwafTable, f : Double) -> NetsecwafTable {
  let result = net_sec_waf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_table_add(a : NetsecwafTable, b : NetsecwafTable) -> NetsecwafTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_table_copy(s : NetsecwafTable) -> NetsecwafTable {
  let result = net_sec_waf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_table_fill(s : NetsecwafTable, v : Double) -> NetsecwafTable {
  let result = net_sec_waf_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_table_min(s : NetsecwafTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_table_max(s : NetsecwafTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_table_to_string(s : NetsecwafTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_graphn_make(size : Int) -> NetsecwafGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_graphn_len(s : NetsecwafGraphN) -> Int { s.size }

pub fn net_sec_waf_graphn_get(s : NetsecwafGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_graphn_set(s : NetsecwafGraphN, i : Int, v : Double) -> NetsecwafGraphN {
  let result = net_sec_waf_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_graphn_sum(s : NetsecwafGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_graphn_mean(s : NetsecwafGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_graphn_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_graphn_scale(s : NetsecwafGraphN, f : Double) -> NetsecwafGraphN {
  let result = net_sec_waf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_graphn_add(a : NetsecwafGraphN, b : NetsecwafGraphN) -> NetsecwafGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_graphn_copy(s : NetsecwafGraphN) -> NetsecwafGraphN {
  let result = net_sec_waf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_graphn_fill(s : NetsecwafGraphN, v : Double) -> NetsecwafGraphN {
  let result = net_sec_waf_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_graphn_min(s : NetsecwafGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_graphn_max(s : NetsecwafGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_graphn_to_string(s : NetsecwafGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_node_make(size : Int) -> NetsecwafNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_node_len(s : NetsecwafNode) -> Int { s.size }

pub fn net_sec_waf_node_get(s : NetsecwafNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_node_set(s : NetsecwafNode, i : Int, v : Double) -> NetsecwafNode {
  let result = net_sec_waf_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_node_sum(s : NetsecwafNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_node_mean(s : NetsecwafNode) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_node_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_node_scale(s : NetsecwafNode, f : Double) -> NetsecwafNode {
  let result = net_sec_waf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_node_add(a : NetsecwafNode, b : NetsecwafNode) -> NetsecwafNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_node_copy(s : NetsecwafNode) -> NetsecwafNode {
  let result = net_sec_waf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_node_fill(s : NetsecwafNode, v : Double) -> NetsecwafNode {
  let result = net_sec_waf_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_node_min(s : NetsecwafNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_node_max(s : NetsecwafNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_node_to_string(s : NetsecwafNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_edge_make(size : Int) -> NetsecwafEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_edge_len(s : NetsecwafEdge) -> Int { s.size }

pub fn net_sec_waf_edge_get(s : NetsecwafEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_edge_set(s : NetsecwafEdge, i : Int, v : Double) -> NetsecwafEdge {
  let result = net_sec_waf_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_edge_sum(s : NetsecwafEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_edge_mean(s : NetsecwafEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_edge_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_edge_scale(s : NetsecwafEdge, f : Double) -> NetsecwafEdge {
  let result = net_sec_waf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_edge_add(a : NetsecwafEdge, b : NetsecwafEdge) -> NetsecwafEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_edge_copy(s : NetsecwafEdge) -> NetsecwafEdge {
  let result = net_sec_waf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_edge_fill(s : NetsecwafEdge, v : Double) -> NetsecwafEdge {
  let result = net_sec_waf_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_edge_min(s : NetsecwafEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_edge_max(s : NetsecwafEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_edge_to_string(s : NetsecwafEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_path_make(size : Int) -> NetsecwafPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_path_len(s : NetsecwafPath) -> Int { s.size }

pub fn net_sec_waf_path_get(s : NetsecwafPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_path_set(s : NetsecwafPath, i : Int, v : Double) -> NetsecwafPath {
  let result = net_sec_waf_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_path_sum(s : NetsecwafPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_path_mean(s : NetsecwafPath) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_path_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_path_scale(s : NetsecwafPath, f : Double) -> NetsecwafPath {
  let result = net_sec_waf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_path_add(a : NetsecwafPath, b : NetsecwafPath) -> NetsecwafPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_path_copy(s : NetsecwafPath) -> NetsecwafPath {
  let result = net_sec_waf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_path_fill(s : NetsecwafPath, v : Double) -> NetsecwafPath {
  let result = net_sec_waf_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_path_min(s : NetsecwafPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_path_max(s : NetsecwafPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_path_to_string(s : NetsecwafPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_cluster_make(size : Int) -> NetsecwafCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_cluster_len(s : NetsecwafCluster) -> Int { s.size }

pub fn net_sec_waf_cluster_get(s : NetsecwafCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_cluster_set(s : NetsecwafCluster, i : Int, v : Double) -> NetsecwafCluster {
  let result = net_sec_waf_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_cluster_sum(s : NetsecwafCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_cluster_mean(s : NetsecwafCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_cluster_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_cluster_scale(s : NetsecwafCluster, f : Double) -> NetsecwafCluster {
  let result = net_sec_waf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_cluster_add(a : NetsecwafCluster, b : NetsecwafCluster) -> NetsecwafCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_cluster_copy(s : NetsecwafCluster) -> NetsecwafCluster {
  let result = net_sec_waf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_cluster_fill(s : NetsecwafCluster, v : Double) -> NetsecwafCluster {
  let result = net_sec_waf_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_cluster_min(s : NetsecwafCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_cluster_max(s : NetsecwafCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_cluster_to_string(s : NetsecwafCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_model_make(size : Int) -> NetsecwafModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_model_len(s : NetsecwafModel) -> Int { s.size }

pub fn net_sec_waf_model_get(s : NetsecwafModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_model_set(s : NetsecwafModel, i : Int, v : Double) -> NetsecwafModel {
  let result = net_sec_waf_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_model_sum(s : NetsecwafModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_model_mean(s : NetsecwafModel) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_model_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_model_scale(s : NetsecwafModel, f : Double) -> NetsecwafModel {
  let result = net_sec_waf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_model_add(a : NetsecwafModel, b : NetsecwafModel) -> NetsecwafModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_model_copy(s : NetsecwafModel) -> NetsecwafModel {
  let result = net_sec_waf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_model_fill(s : NetsecwafModel, v : Double) -> NetsecwafModel {
  let result = net_sec_waf_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_model_min(s : NetsecwafModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_model_max(s : NetsecwafModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_model_to_string(s : NetsecwafModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_layer_make(size : Int) -> NetsecwafLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_layer_len(s : NetsecwafLayer) -> Int { s.size }

pub fn net_sec_waf_layer_get(s : NetsecwafLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_layer_set(s : NetsecwafLayer, i : Int, v : Double) -> NetsecwafLayer {
  let result = net_sec_waf_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_layer_sum(s : NetsecwafLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_layer_mean(s : NetsecwafLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_layer_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_layer_scale(s : NetsecwafLayer, f : Double) -> NetsecwafLayer {
  let result = net_sec_waf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_layer_add(a : NetsecwafLayer, b : NetsecwafLayer) -> NetsecwafLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_layer_copy(s : NetsecwafLayer) -> NetsecwafLayer {
  let result = net_sec_waf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_layer_fill(s : NetsecwafLayer, v : Double) -> NetsecwafLayer {
  let result = net_sec_waf_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_layer_min(s : NetsecwafLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_layer_max(s : NetsecwafLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_layer_to_string(s : NetsecwafLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_buffer_make(size : Int) -> NetsecwafBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_buffer_len(s : NetsecwafBuffer) -> Int { s.size }

pub fn net_sec_waf_buffer_get(s : NetsecwafBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_buffer_set(s : NetsecwafBuffer, i : Int, v : Double) -> NetsecwafBuffer {
  let result = net_sec_waf_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_buffer_sum(s : NetsecwafBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_buffer_mean(s : NetsecwafBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_buffer_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_buffer_scale(s : NetsecwafBuffer, f : Double) -> NetsecwafBuffer {
  let result = net_sec_waf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_buffer_add(a : NetsecwafBuffer, b : NetsecwafBuffer) -> NetsecwafBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_buffer_copy(s : NetsecwafBuffer) -> NetsecwafBuffer {
  let result = net_sec_waf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_buffer_fill(s : NetsecwafBuffer, v : Double) -> NetsecwafBuffer {
  let result = net_sec_waf_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_buffer_min(s : NetsecwafBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_buffer_max(s : NetsecwafBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_buffer_to_string(s : NetsecwafBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_cursor_make(size : Int) -> NetsecwafCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_cursor_len(s : NetsecwafCursor) -> Int { s.size }

pub fn net_sec_waf_cursor_get(s : NetsecwafCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_cursor_set(s : NetsecwafCursor, i : Int, v : Double) -> NetsecwafCursor {
  let result = net_sec_waf_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_cursor_sum(s : NetsecwafCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_cursor_mean(s : NetsecwafCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_cursor_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_cursor_scale(s : NetsecwafCursor, f : Double) -> NetsecwafCursor {
  let result = net_sec_waf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_cursor_add(a : NetsecwafCursor, b : NetsecwafCursor) -> NetsecwafCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_cursor_copy(s : NetsecwafCursor) -> NetsecwafCursor {
  let result = net_sec_waf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_cursor_fill(s : NetsecwafCursor, v : Double) -> NetsecwafCursor {
  let result = net_sec_waf_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_cursor_min(s : NetsecwafCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_cursor_max(s : NetsecwafCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_cursor_to_string(s : NetsecwafCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_view_make(size : Int) -> NetsecwafView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_view_len(s : NetsecwafView) -> Int { s.size }

pub fn net_sec_waf_view_get(s : NetsecwafView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_view_set(s : NetsecwafView, i : Int, v : Double) -> NetsecwafView {
  let result = net_sec_waf_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_view_sum(s : NetsecwafView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_view_mean(s : NetsecwafView) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_view_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_view_scale(s : NetsecwafView, f : Double) -> NetsecwafView {
  let result = net_sec_waf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_view_add(a : NetsecwafView, b : NetsecwafView) -> NetsecwafView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_view_copy(s : NetsecwafView) -> NetsecwafView {
  let result = net_sec_waf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_view_fill(s : NetsecwafView, v : Double) -> NetsecwafView {
  let result = net_sec_waf_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_view_min(s : NetsecwafView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_view_max(s : NetsecwafView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_view_to_string(s : NetsecwafView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_range_make(size : Int) -> NetsecwafRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_range_len(s : NetsecwafRange) -> Int { s.size }

pub fn net_sec_waf_range_get(s : NetsecwafRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_range_set(s : NetsecwafRange, i : Int, v : Double) -> NetsecwafRange {
  let result = net_sec_waf_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_range_sum(s : NetsecwafRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_range_mean(s : NetsecwafRange) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_range_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_range_scale(s : NetsecwafRange, f : Double) -> NetsecwafRange {
  let result = net_sec_waf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_range_add(a : NetsecwafRange, b : NetsecwafRange) -> NetsecwafRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_range_copy(s : NetsecwafRange) -> NetsecwafRange {
  let result = net_sec_waf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_range_fill(s : NetsecwafRange, v : Double) -> NetsecwafRange {
  let result = net_sec_waf_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_range_min(s : NetsecwafRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_range_max(s : NetsecwafRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_range_to_string(s : NetsecwafRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecwafSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_waf_slice_make(size : Int) -> NetsecwafSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_waf_slice_len(s : NetsecwafSlice) -> Int { s.size }

pub fn net_sec_waf_slice_get(s : NetsecwafSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_waf_slice_set(s : NetsecwafSlice, i : Int, v : Double) -> NetsecwafSlice {
  let result = net_sec_waf_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_slice_sum(s : NetsecwafSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_waf_slice_mean(s : NetsecwafSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_waf_slice_sum(s) / s.size.to_double() }
}

pub fn net_sec_waf_slice_scale(s : NetsecwafSlice, f : Double) -> NetsecwafSlice {
  let result = net_sec_waf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_waf_slice_add(a : NetsecwafSlice, b : NetsecwafSlice) -> NetsecwafSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_waf_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_waf_slice_copy(s : NetsecwafSlice) -> NetsecwafSlice {
  let result = net_sec_waf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_waf_slice_fill(s : NetsecwafSlice, v : Double) -> NetsecwafSlice {
  let result = net_sec_waf_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_waf_slice_min(s : NetsecwafSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_slice_max(s : NetsecwafSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_waf_slice_to_string(s : NetsecwafSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

