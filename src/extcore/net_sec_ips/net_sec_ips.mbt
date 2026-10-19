///===
/// extcore/net_sec_ips

pub(all) struct NetsecipsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_ips_make_point(x : Double, y : Double) -> NetsecipsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_ips_make_point3(x : Double, y : Double, z : Double) -> NetsecipsPoint {
  { x, y, z, label: 0 }
}

pub fn net_sec_ips_point_x(pt : NetsecipsPoint) -> Double { pt.x }

pub fn net_sec_ips_point_y(pt : NetsecipsPoint) -> Double { pt.y }

pub fn net_sec_ips_point_z(pt : NetsecipsPoint) -> Double { pt.z }

pub fn net_sec_ips_point_label(pt : NetsecipsPoint) -> Int { pt.label }

pub fn net_sec_ips_point_dist(a : NetsecipsPoint, b : NetsecipsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_sec_ips_point_add(a : NetsecipsPoint, b : NetsecipsPoint) -> NetsecipsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_sec_ips_point_sub(a : NetsecipsPoint, b : NetsecipsPoint) -> NetsecipsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_sec_ips_point_scale(pt : NetsecipsPoint, s : Double) -> NetsecipsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_sec_ips_point_dot(a : NetsecipsPoint, b : NetsecipsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_sec_ips_point_cross(a : NetsecipsPoint, b : NetsecipsPoint) -> NetsecipsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_sec_ips_point_norm(pt : NetsecipsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_sec_ips_point_normalize(pt : NetsecipsPoint) -> NetsecipsPoint {
  let n = net_sec_ips_point_norm(pt)
  if n < 0.0000001 { pt } else { net_sec_ips_point_scale(pt, 1.0 / n) }
}

pub fn net_sec_ips_point_negate(pt : NetsecipsPoint) -> NetsecipsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_sec_ips_point_mid(a : NetsecipsPoint, b : NetsecipsPoint) -> NetsecipsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_sec_ips_point_lerp(a : NetsecipsPoint, b : NetsecipsPoint, t : Double) -> NetsecipsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_sec_ips_point_to_string(pt : NetsecipsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetsecipsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_ips_make_series(vals : Array[Double], name : String) -> NetsecipsSeries {
  { vals, name, meta: 0 }
}

pub fn net_sec_ips_series_len(s : NetsecipsSeries) -> Int { s.vals.length() }

pub fn net_sec_ips_series_sum(s : NetsecipsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_sec_ips_series_mean(s : NetsecipsSeries) -> Double {
  let n = net_sec_ips_series_len(s)
  if n == 0 { 0.0 } else { net_sec_ips_series_sum(s) / n.to_double() }
}

pub fn net_sec_ips_series_min(s : NetsecipsSeries) -> Double {
  let n = net_sec_ips_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_sec_ips_series_max(s : NetsecipsSeries) -> Double {
  let n = net_sec_ips_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_sec_ips_series_range(s : NetsecipsSeries) -> Double {
  net_sec_ips_series_max(s) - net_sec_ips_series_min(s)
}

pub fn net_sec_ips_series_var(s : NetsecipsSeries) -> Double {
  let n = net_sec_ips_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_sec_ips_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_sec_ips_series_std(s : NetsecipsSeries) -> Double { @_common.sqrt(net_sec_ips_series_var(s)) }

pub fn net_sec_ips_series_median(s : NetsecipsSeries) -> Double {
  let n = net_sec_ips_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_sec_ips_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_sec_ips_series_scale(s : NetsecipsSeries, f : Double) -> NetsecipsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_sec_ips_series_add(a : NetsecipsSeries, b : NetsecipsSeries) -> NetsecipsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_sec_ips_series_sub(a : NetsecipsSeries, b : NetsecipsSeries) -> NetsecipsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_sec_ips_series_normalize(s : NetsecipsSeries) -> NetsecipsSeries {
  let mn = net_sec_ips_series_min(s)
  let mx = net_sec_ips_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_sec_ips_series_cumsum(s : NetsecipsSeries) -> NetsecipsSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_sec_ips_series_to_string(s : NetsecipsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecipsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_ips_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecipsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_ips_matrix_identity(n : Int) -> NetsecipsMatrix {
  let m = net_sec_ips_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_sec_ips_matrix_get(m : NetsecipsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_sec_ips_matrix_transpose(m : NetsecipsMatrix) -> NetsecipsMatrix {
  let result = net_sec_ips_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_sec_ips_matrix_add(a : NetsecipsMatrix, b : NetsecipsMatrix) -> NetsecipsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_sec_ips_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_sec_ips_matrix_scale(m : NetsecipsMatrix, s : Double) -> NetsecipsMatrix {
  let result = net_sec_ips_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_sec_ips_matrix_multiply(a : NetsecipsMatrix, b : NetsecipsMatrix) -> NetsecipsMatrix {
  if a.cols != b.rows { return net_sec_ips_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_sec_ips_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_sec_ips_matrix_trace(m : NetsecipsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_sec_ips_matrix_det(m : NetsecipsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_sec_ips_matrix_norm(m : NetsecipsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_sec_ips_matrix_to_string(m : NetsecipsMatrix) -> String {
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

pub(all) struct NetsecipsVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_ips_make_vector(comps : Array[Double]) -> NetsecipsVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_ips_vector_zero(dim : Int) -> NetsecipsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_sec_ips_vector_add(a : NetsecipsVector, b : NetsecipsVector) -> NetsecipsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_ips_vector_sub(a : NetsecipsVector, b : NetsecipsVector) -> NetsecipsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_ips_vector_scale(v : NetsecipsVector, s : Double) -> NetsecipsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_sec_ips_vector_dot(a : NetsecipsVector, b : NetsecipsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_sec_ips_vector_norm(v : NetsecipsVector) -> Double { @_common.sqrt(net_sec_ips_vector_dot(v, v)) }

pub fn net_sec_ips_vector_normalize(v : NetsecipsVector) -> NetsecipsVector {
  let n = net_sec_ips_vector_norm(v)
  if n < 0.0000001 { v } else { net_sec_ips_vector_scale(v, 1.0 / n) }
}

pub fn net_sec_ips_vector_dist(a : NetsecipsVector, b : NetsecipsVector) -> Double {
  net_sec_ips_vector_norm(net_sec_ips_vector_sub(a, b))
}

pub fn net_sec_ips_vector_to_string(v : NetsecipsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_ips_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_sec_ips_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_sec_ips_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_sec_ips_std(data : Array[Double]) -> Double { @_common.sqrt(net_sec_ips_var(data)) }

pub fn net_sec_ips_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_sec_ips_mean(a); let mb = net_sec_ips_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_sec_ips_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_sec_ips_std(a); let sb = net_sec_ips_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_sec_ips_cov(a, b) / (sa * sb) }
}

pub fn net_sec_ips_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_sec_ips_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_sec_ips_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_sec_ips_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_sec_ips_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(net_sec_ips_mse(pred, labels))
}

pub fn net_sec_ips_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_sec_ips_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_sec_ips_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_sec_ips_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_sec_ips_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_sec_ips_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_sec_ips_precision(pred, labels, pos); let r = net_sec_ips_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_sec_ips_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_sec_ips_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_sec_ips_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_sec_ips_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_sec_ips_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_sec_ips_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_sec_ips_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_sec_ips_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_sec_ips_fibonacci(n : Int) -> Int {
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

pub fn net_sec_ips_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_sec_ips_min(data); let mx = net_sec_ips_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_sec_ips_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_sec_ips_mean(data); let sd = net_sec_ips_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_sec_ips_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_sec_ips_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_sec_ips_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_sec_ips_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_sec_ips_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_sec_ips_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NetsecipsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_frame_make(size : Int) -> NetsecipsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_frame_len(s : NetsecipsFrame) -> Int { s.size }

pub fn net_sec_ips_frame_get(s : NetsecipsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_frame_set(s : NetsecipsFrame, i : Int, v : Double) -> NetsecipsFrame {
  let result = net_sec_ips_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_frame_sum(s : NetsecipsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_frame_mean(s : NetsecipsFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_frame_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_frame_scale(s : NetsecipsFrame, f : Double) -> NetsecipsFrame {
  let result = net_sec_ips_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_frame_add(a : NetsecipsFrame, b : NetsecipsFrame) -> NetsecipsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_frame_copy(s : NetsecipsFrame) -> NetsecipsFrame {
  let result = net_sec_ips_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_frame_fill(s : NetsecipsFrame, v : Double) -> NetsecipsFrame {
  let result = net_sec_ips_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_frame_min(s : NetsecipsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_frame_max(s : NetsecipsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_frame_to_string(s : NetsecipsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_table_make(size : Int) -> NetsecipsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_table_len(s : NetsecipsTable) -> Int { s.size }

pub fn net_sec_ips_table_get(s : NetsecipsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_table_set(s : NetsecipsTable, i : Int, v : Double) -> NetsecipsTable {
  let result = net_sec_ips_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_table_sum(s : NetsecipsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_table_mean(s : NetsecipsTable) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_table_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_table_scale(s : NetsecipsTable, f : Double) -> NetsecipsTable {
  let result = net_sec_ips_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_table_add(a : NetsecipsTable, b : NetsecipsTable) -> NetsecipsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_table_copy(s : NetsecipsTable) -> NetsecipsTable {
  let result = net_sec_ips_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_table_fill(s : NetsecipsTable, v : Double) -> NetsecipsTable {
  let result = net_sec_ips_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_table_min(s : NetsecipsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_table_max(s : NetsecipsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_table_to_string(s : NetsecipsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_graphn_make(size : Int) -> NetsecipsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_graphn_len(s : NetsecipsGraphN) -> Int { s.size }

pub fn net_sec_ips_graphn_get(s : NetsecipsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_graphn_set(s : NetsecipsGraphN, i : Int, v : Double) -> NetsecipsGraphN {
  let result = net_sec_ips_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_graphn_sum(s : NetsecipsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_graphn_mean(s : NetsecipsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_graphn_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_graphn_scale(s : NetsecipsGraphN, f : Double) -> NetsecipsGraphN {
  let result = net_sec_ips_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_graphn_add(a : NetsecipsGraphN, b : NetsecipsGraphN) -> NetsecipsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_graphn_copy(s : NetsecipsGraphN) -> NetsecipsGraphN {
  let result = net_sec_ips_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_graphn_fill(s : NetsecipsGraphN, v : Double) -> NetsecipsGraphN {
  let result = net_sec_ips_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_graphn_min(s : NetsecipsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_graphn_max(s : NetsecipsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_graphn_to_string(s : NetsecipsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_node_make(size : Int) -> NetsecipsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_node_len(s : NetsecipsNode) -> Int { s.size }

pub fn net_sec_ips_node_get(s : NetsecipsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_node_set(s : NetsecipsNode, i : Int, v : Double) -> NetsecipsNode {
  let result = net_sec_ips_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_node_sum(s : NetsecipsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_node_mean(s : NetsecipsNode) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_node_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_node_scale(s : NetsecipsNode, f : Double) -> NetsecipsNode {
  let result = net_sec_ips_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_node_add(a : NetsecipsNode, b : NetsecipsNode) -> NetsecipsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_node_copy(s : NetsecipsNode) -> NetsecipsNode {
  let result = net_sec_ips_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_node_fill(s : NetsecipsNode, v : Double) -> NetsecipsNode {
  let result = net_sec_ips_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_node_min(s : NetsecipsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_node_max(s : NetsecipsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_node_to_string(s : NetsecipsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_edge_make(size : Int) -> NetsecipsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_edge_len(s : NetsecipsEdge) -> Int { s.size }

pub fn net_sec_ips_edge_get(s : NetsecipsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_edge_set(s : NetsecipsEdge, i : Int, v : Double) -> NetsecipsEdge {
  let result = net_sec_ips_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_edge_sum(s : NetsecipsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_edge_mean(s : NetsecipsEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_edge_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_edge_scale(s : NetsecipsEdge, f : Double) -> NetsecipsEdge {
  let result = net_sec_ips_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_edge_add(a : NetsecipsEdge, b : NetsecipsEdge) -> NetsecipsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_edge_copy(s : NetsecipsEdge) -> NetsecipsEdge {
  let result = net_sec_ips_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_edge_fill(s : NetsecipsEdge, v : Double) -> NetsecipsEdge {
  let result = net_sec_ips_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_edge_min(s : NetsecipsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_edge_max(s : NetsecipsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_edge_to_string(s : NetsecipsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_path_make(size : Int) -> NetsecipsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_path_len(s : NetsecipsPath) -> Int { s.size }

pub fn net_sec_ips_path_get(s : NetsecipsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_path_set(s : NetsecipsPath, i : Int, v : Double) -> NetsecipsPath {
  let result = net_sec_ips_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_path_sum(s : NetsecipsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_path_mean(s : NetsecipsPath) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_path_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_path_scale(s : NetsecipsPath, f : Double) -> NetsecipsPath {
  let result = net_sec_ips_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_path_add(a : NetsecipsPath, b : NetsecipsPath) -> NetsecipsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_path_copy(s : NetsecipsPath) -> NetsecipsPath {
  let result = net_sec_ips_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_path_fill(s : NetsecipsPath, v : Double) -> NetsecipsPath {
  let result = net_sec_ips_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_path_min(s : NetsecipsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_path_max(s : NetsecipsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_path_to_string(s : NetsecipsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_cluster_make(size : Int) -> NetsecipsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_cluster_len(s : NetsecipsCluster) -> Int { s.size }

pub fn net_sec_ips_cluster_get(s : NetsecipsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_cluster_set(s : NetsecipsCluster, i : Int, v : Double) -> NetsecipsCluster {
  let result = net_sec_ips_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_cluster_sum(s : NetsecipsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_cluster_mean(s : NetsecipsCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_cluster_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_cluster_scale(s : NetsecipsCluster, f : Double) -> NetsecipsCluster {
  let result = net_sec_ips_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_cluster_add(a : NetsecipsCluster, b : NetsecipsCluster) -> NetsecipsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_cluster_copy(s : NetsecipsCluster) -> NetsecipsCluster {
  let result = net_sec_ips_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_cluster_fill(s : NetsecipsCluster, v : Double) -> NetsecipsCluster {
  let result = net_sec_ips_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_cluster_min(s : NetsecipsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_cluster_max(s : NetsecipsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_cluster_to_string(s : NetsecipsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_model_make(size : Int) -> NetsecipsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_model_len(s : NetsecipsModel) -> Int { s.size }

pub fn net_sec_ips_model_get(s : NetsecipsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_model_set(s : NetsecipsModel, i : Int, v : Double) -> NetsecipsModel {
  let result = net_sec_ips_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_model_sum(s : NetsecipsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_model_mean(s : NetsecipsModel) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_model_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_model_scale(s : NetsecipsModel, f : Double) -> NetsecipsModel {
  let result = net_sec_ips_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_model_add(a : NetsecipsModel, b : NetsecipsModel) -> NetsecipsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_model_copy(s : NetsecipsModel) -> NetsecipsModel {
  let result = net_sec_ips_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_model_fill(s : NetsecipsModel, v : Double) -> NetsecipsModel {
  let result = net_sec_ips_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_model_min(s : NetsecipsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_model_max(s : NetsecipsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_model_to_string(s : NetsecipsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_layer_make(size : Int) -> NetsecipsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_layer_len(s : NetsecipsLayer) -> Int { s.size }

pub fn net_sec_ips_layer_get(s : NetsecipsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_layer_set(s : NetsecipsLayer, i : Int, v : Double) -> NetsecipsLayer {
  let result = net_sec_ips_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_layer_sum(s : NetsecipsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_layer_mean(s : NetsecipsLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_layer_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_layer_scale(s : NetsecipsLayer, f : Double) -> NetsecipsLayer {
  let result = net_sec_ips_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_layer_add(a : NetsecipsLayer, b : NetsecipsLayer) -> NetsecipsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_layer_copy(s : NetsecipsLayer) -> NetsecipsLayer {
  let result = net_sec_ips_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_layer_fill(s : NetsecipsLayer, v : Double) -> NetsecipsLayer {
  let result = net_sec_ips_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_layer_min(s : NetsecipsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_layer_max(s : NetsecipsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_layer_to_string(s : NetsecipsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_buffer_make(size : Int) -> NetsecipsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_buffer_len(s : NetsecipsBuffer) -> Int { s.size }

pub fn net_sec_ips_buffer_get(s : NetsecipsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_buffer_set(s : NetsecipsBuffer, i : Int, v : Double) -> NetsecipsBuffer {
  let result = net_sec_ips_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_buffer_sum(s : NetsecipsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_buffer_mean(s : NetsecipsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_buffer_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_buffer_scale(s : NetsecipsBuffer, f : Double) -> NetsecipsBuffer {
  let result = net_sec_ips_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_buffer_add(a : NetsecipsBuffer, b : NetsecipsBuffer) -> NetsecipsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_buffer_copy(s : NetsecipsBuffer) -> NetsecipsBuffer {
  let result = net_sec_ips_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_buffer_fill(s : NetsecipsBuffer, v : Double) -> NetsecipsBuffer {
  let result = net_sec_ips_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_buffer_min(s : NetsecipsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_buffer_max(s : NetsecipsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_buffer_to_string(s : NetsecipsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_cursor_make(size : Int) -> NetsecipsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_cursor_len(s : NetsecipsCursor) -> Int { s.size }

pub fn net_sec_ips_cursor_get(s : NetsecipsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_cursor_set(s : NetsecipsCursor, i : Int, v : Double) -> NetsecipsCursor {
  let result = net_sec_ips_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_cursor_sum(s : NetsecipsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_cursor_mean(s : NetsecipsCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_cursor_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_cursor_scale(s : NetsecipsCursor, f : Double) -> NetsecipsCursor {
  let result = net_sec_ips_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_cursor_add(a : NetsecipsCursor, b : NetsecipsCursor) -> NetsecipsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_cursor_copy(s : NetsecipsCursor) -> NetsecipsCursor {
  let result = net_sec_ips_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_cursor_fill(s : NetsecipsCursor, v : Double) -> NetsecipsCursor {
  let result = net_sec_ips_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_cursor_min(s : NetsecipsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_cursor_max(s : NetsecipsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_cursor_to_string(s : NetsecipsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_view_make(size : Int) -> NetsecipsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_view_len(s : NetsecipsView) -> Int { s.size }

pub fn net_sec_ips_view_get(s : NetsecipsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_view_set(s : NetsecipsView, i : Int, v : Double) -> NetsecipsView {
  let result = net_sec_ips_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_view_sum(s : NetsecipsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_view_mean(s : NetsecipsView) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_view_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_view_scale(s : NetsecipsView, f : Double) -> NetsecipsView {
  let result = net_sec_ips_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_view_add(a : NetsecipsView, b : NetsecipsView) -> NetsecipsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_view_copy(s : NetsecipsView) -> NetsecipsView {
  let result = net_sec_ips_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_view_fill(s : NetsecipsView, v : Double) -> NetsecipsView {
  let result = net_sec_ips_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_view_min(s : NetsecipsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_view_max(s : NetsecipsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_view_to_string(s : NetsecipsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_range_make(size : Int) -> NetsecipsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_range_len(s : NetsecipsRange) -> Int { s.size }

pub fn net_sec_ips_range_get(s : NetsecipsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_range_set(s : NetsecipsRange, i : Int, v : Double) -> NetsecipsRange {
  let result = net_sec_ips_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_range_sum(s : NetsecipsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_range_mean(s : NetsecipsRange) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_range_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_range_scale(s : NetsecipsRange, f : Double) -> NetsecipsRange {
  let result = net_sec_ips_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_range_add(a : NetsecipsRange, b : NetsecipsRange) -> NetsecipsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_range_copy(s : NetsecipsRange) -> NetsecipsRange {
  let result = net_sec_ips_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_range_fill(s : NetsecipsRange, v : Double) -> NetsecipsRange {
  let result = net_sec_ips_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_range_min(s : NetsecipsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_range_max(s : NetsecipsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_range_to_string(s : NetsecipsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecipsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ips_slice_make(size : Int) -> NetsecipsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ips_slice_len(s : NetsecipsSlice) -> Int { s.size }

pub fn net_sec_ips_slice_get(s : NetsecipsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ips_slice_set(s : NetsecipsSlice, i : Int, v : Double) -> NetsecipsSlice {
  let result = net_sec_ips_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_slice_sum(s : NetsecipsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ips_slice_mean(s : NetsecipsSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ips_slice_sum(s) / s.size.to_double() }
}

pub fn net_sec_ips_slice_scale(s : NetsecipsSlice, f : Double) -> NetsecipsSlice {
  let result = net_sec_ips_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ips_slice_add(a : NetsecipsSlice, b : NetsecipsSlice) -> NetsecipsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ips_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ips_slice_copy(s : NetsecipsSlice) -> NetsecipsSlice {
  let result = net_sec_ips_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ips_slice_fill(s : NetsecipsSlice, v : Double) -> NetsecipsSlice {
  let result = net_sec_ips_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ips_slice_min(s : NetsecipsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_slice_max(s : NetsecipsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ips_slice_to_string(s : NetsecipsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

