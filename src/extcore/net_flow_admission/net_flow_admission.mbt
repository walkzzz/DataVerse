///===
/// extcore/net_flow_admission

pub(all) struct NetflowadmissionPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_admission_make_point(x : Double, y : Double) -> NetflowadmissionPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_admission_make_point3(x : Double, y : Double, z : Double) -> NetflowadmissionPoint {
  { x, y, z, label: 0 }
}

pub fn net_flow_admission_point_x(pt : NetflowadmissionPoint) -> Double { pt.x }

pub fn net_flow_admission_point_y(pt : NetflowadmissionPoint) -> Double { pt.y }

pub fn net_flow_admission_point_z(pt : NetflowadmissionPoint) -> Double { pt.z }

pub fn net_flow_admission_point_label(pt : NetflowadmissionPoint) -> Int { pt.label }

pub fn net_flow_admission_point_dist(a : NetflowadmissionPoint, b : NetflowadmissionPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_flow_admission_point_add(a : NetflowadmissionPoint, b : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_flow_admission_point_sub(a : NetflowadmissionPoint, b : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_flow_admission_point_scale(pt : NetflowadmissionPoint, s : Double) -> NetflowadmissionPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_flow_admission_point_dot(a : NetflowadmissionPoint, b : NetflowadmissionPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_flow_admission_point_cross(a : NetflowadmissionPoint, b : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_flow_admission_point_norm(pt : NetflowadmissionPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_flow_admission_point_normalize(pt : NetflowadmissionPoint) -> NetflowadmissionPoint {
  let n = net_flow_admission_point_norm(pt)
  if n < 0.0000001 { pt } else { net_flow_admission_point_scale(pt, 1.0 / n) }
}

pub fn net_flow_admission_point_negate(pt : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_flow_admission_point_mid(a : NetflowadmissionPoint, b : NetflowadmissionPoint) -> NetflowadmissionPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_flow_admission_point_lerp(a : NetflowadmissionPoint, b : NetflowadmissionPoint, t : Double) -> NetflowadmissionPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_flow_admission_point_to_string(pt : NetflowadmissionPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetflowadmissionSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_admission_make_series(vals : Array[Double], name : String) -> NetflowadmissionSeries {
  { vals, name, meta: 0 }
}

pub fn net_flow_admission_series_len(s : NetflowadmissionSeries) -> Int { s.vals.length() }

pub fn net_flow_admission_series_sum(s : NetflowadmissionSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_flow_admission_series_mean(s : NetflowadmissionSeries) -> Double {
  let n = net_flow_admission_series_len(s)
  if n == 0 { 0.0 } else { net_flow_admission_series_sum(s) / n.to_double() }
}

pub fn net_flow_admission_series_min(s : NetflowadmissionSeries) -> Double {
  let n = net_flow_admission_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_admission_series_max(s : NetflowadmissionSeries) -> Double {
  let n = net_flow_admission_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_admission_series_range(s : NetflowadmissionSeries) -> Double {
  net_flow_admission_series_max(s) - net_flow_admission_series_min(s)
}

pub fn net_flow_admission_series_var(s : NetflowadmissionSeries) -> Double {
  let n = net_flow_admission_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_flow_admission_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_flow_admission_series_std(s : NetflowadmissionSeries) -> Double { @_common.sqrt(net_flow_admission_series_var(s)) }

pub fn net_flow_admission_series_median(s : NetflowadmissionSeries) -> Double {
  let n = net_flow_admission_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_flow_admission_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_flow_admission_series_scale(s : NetflowadmissionSeries, f : Double) -> NetflowadmissionSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_flow_admission_series_add(a : NetflowadmissionSeries, b : NetflowadmissionSeries) -> NetflowadmissionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_flow_admission_series_sub(a : NetflowadmissionSeries, b : NetflowadmissionSeries) -> NetflowadmissionSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_flow_admission_series_normalize(s : NetflowadmissionSeries) -> NetflowadmissionSeries {
  let mn = net_flow_admission_series_min(s)
  let mx = net_flow_admission_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_flow_admission_series_cumsum(s : NetflowadmissionSeries) -> NetflowadmissionSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_flow_admission_series_to_string(s : NetflowadmissionSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowadmissionMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_admission_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowadmissionMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_admission_matrix_identity(n : Int) -> NetflowadmissionMatrix {
  let m = net_flow_admission_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_flow_admission_matrix_get(m : NetflowadmissionMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_flow_admission_matrix_transpose(m : NetflowadmissionMatrix) -> NetflowadmissionMatrix {
  let result = net_flow_admission_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_flow_admission_matrix_add(a : NetflowadmissionMatrix, b : NetflowadmissionMatrix) -> NetflowadmissionMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_flow_admission_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_flow_admission_matrix_scale(m : NetflowadmissionMatrix, s : Double) -> NetflowadmissionMatrix {
  let result = net_flow_admission_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_flow_admission_matrix_multiply(a : NetflowadmissionMatrix, b : NetflowadmissionMatrix) -> NetflowadmissionMatrix {
  if a.cols != b.rows { return net_flow_admission_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_flow_admission_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_flow_admission_matrix_trace(m : NetflowadmissionMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_flow_admission_matrix_det(m : NetflowadmissionMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_flow_admission_matrix_norm(m : NetflowadmissionMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_flow_admission_matrix_to_string(m : NetflowadmissionMatrix) -> String {
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

pub(all) struct NetflowadmissionVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_admission_make_vector(comps : Array[Double]) -> NetflowadmissionVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_admission_vector_zero(dim : Int) -> NetflowadmissionVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_flow_admission_vector_add(a : NetflowadmissionVector, b : NetflowadmissionVector) -> NetflowadmissionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_admission_vector_sub(a : NetflowadmissionVector, b : NetflowadmissionVector) -> NetflowadmissionVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_admission_vector_scale(v : NetflowadmissionVector, s : Double) -> NetflowadmissionVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_flow_admission_vector_dot(a : NetflowadmissionVector, b : NetflowadmissionVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_flow_admission_vector_norm(v : NetflowadmissionVector) -> Double { @_common.sqrt(net_flow_admission_vector_dot(v, v)) }

pub fn net_flow_admission_vector_normalize(v : NetflowadmissionVector) -> NetflowadmissionVector {
  let n = net_flow_admission_vector_norm(v)
  if n < 0.0000001 { v } else { net_flow_admission_vector_scale(v, 1.0 / n) }
}

pub fn net_flow_admission_vector_dist(a : NetflowadmissionVector, b : NetflowadmissionVector) -> Double {
  net_flow_admission_vector_norm(net_flow_admission_vector_sub(a, b))
}

pub fn net_flow_admission_vector_to_string(v : NetflowadmissionVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_admission_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_flow_admission_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_flow_admission_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_flow_admission_std(data : Array[Double]) -> Double { @_common.sqrt(net_flow_admission_var(data)) }

pub fn net_flow_admission_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_flow_admission_mean(a); let mb = net_flow_admission_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_flow_admission_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_flow_admission_std(a); let sb = net_flow_admission_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_flow_admission_cov(a, b) / (sa * sb) }
}

pub fn net_flow_admission_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_flow_admission_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_flow_admission_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_flow_admission_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_flow_admission_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(net_flow_admission_mse(pred, labels))
}

pub fn net_flow_admission_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_flow_admission_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_flow_admission_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_flow_admission_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_flow_admission_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_flow_admission_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_flow_admission_precision(pred, labels, pos); let r = net_flow_admission_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_flow_admission_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_flow_admission_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_flow_admission_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_flow_admission_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_flow_admission_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_flow_admission_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_flow_admission_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_flow_admission_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_flow_admission_fibonacci(n : Int) -> Int {
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

pub fn net_flow_admission_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_flow_admission_min(data); let mx = net_flow_admission_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_flow_admission_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_flow_admission_mean(data); let sd = net_flow_admission_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_flow_admission_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_flow_admission_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_flow_admission_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_flow_admission_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_flow_admission_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_flow_admission_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NetflowadmissionFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_frame_make(size : Int) -> NetflowadmissionFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_frame_len(s : NetflowadmissionFrame) -> Int { s.size }

pub fn net_flow_admission_frame_get(s : NetflowadmissionFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_frame_set(s : NetflowadmissionFrame, i : Int, v : Double) -> NetflowadmissionFrame {
  let result = net_flow_admission_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_frame_sum(s : NetflowadmissionFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_frame_mean(s : NetflowadmissionFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_frame_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_frame_scale(s : NetflowadmissionFrame, f : Double) -> NetflowadmissionFrame {
  let result = net_flow_admission_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_frame_add(a : NetflowadmissionFrame, b : NetflowadmissionFrame) -> NetflowadmissionFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_frame_copy(s : NetflowadmissionFrame) -> NetflowadmissionFrame {
  let result = net_flow_admission_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_frame_fill(s : NetflowadmissionFrame, v : Double) -> NetflowadmissionFrame {
  let result = net_flow_admission_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_frame_min(s : NetflowadmissionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_frame_max(s : NetflowadmissionFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_frame_to_string(s : NetflowadmissionFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_table_make(size : Int) -> NetflowadmissionTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_table_len(s : NetflowadmissionTable) -> Int { s.size }

pub fn net_flow_admission_table_get(s : NetflowadmissionTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_table_set(s : NetflowadmissionTable, i : Int, v : Double) -> NetflowadmissionTable {
  let result = net_flow_admission_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_table_sum(s : NetflowadmissionTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_table_mean(s : NetflowadmissionTable) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_table_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_table_scale(s : NetflowadmissionTable, f : Double) -> NetflowadmissionTable {
  let result = net_flow_admission_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_table_add(a : NetflowadmissionTable, b : NetflowadmissionTable) -> NetflowadmissionTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_table_copy(s : NetflowadmissionTable) -> NetflowadmissionTable {
  let result = net_flow_admission_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_table_fill(s : NetflowadmissionTable, v : Double) -> NetflowadmissionTable {
  let result = net_flow_admission_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_table_min(s : NetflowadmissionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_table_max(s : NetflowadmissionTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_table_to_string(s : NetflowadmissionTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_graphn_make(size : Int) -> NetflowadmissionGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_graphn_len(s : NetflowadmissionGraphN) -> Int { s.size }

pub fn net_flow_admission_graphn_get(s : NetflowadmissionGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_graphn_set(s : NetflowadmissionGraphN, i : Int, v : Double) -> NetflowadmissionGraphN {
  let result = net_flow_admission_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_graphn_sum(s : NetflowadmissionGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_graphn_mean(s : NetflowadmissionGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_graphn_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_graphn_scale(s : NetflowadmissionGraphN, f : Double) -> NetflowadmissionGraphN {
  let result = net_flow_admission_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_graphn_add(a : NetflowadmissionGraphN, b : NetflowadmissionGraphN) -> NetflowadmissionGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_graphn_copy(s : NetflowadmissionGraphN) -> NetflowadmissionGraphN {
  let result = net_flow_admission_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_graphn_fill(s : NetflowadmissionGraphN, v : Double) -> NetflowadmissionGraphN {
  let result = net_flow_admission_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_graphn_min(s : NetflowadmissionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_graphn_max(s : NetflowadmissionGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_graphn_to_string(s : NetflowadmissionGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_node_make(size : Int) -> NetflowadmissionNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_node_len(s : NetflowadmissionNode) -> Int { s.size }

pub fn net_flow_admission_node_get(s : NetflowadmissionNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_node_set(s : NetflowadmissionNode, i : Int, v : Double) -> NetflowadmissionNode {
  let result = net_flow_admission_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_node_sum(s : NetflowadmissionNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_node_mean(s : NetflowadmissionNode) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_node_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_node_scale(s : NetflowadmissionNode, f : Double) -> NetflowadmissionNode {
  let result = net_flow_admission_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_node_add(a : NetflowadmissionNode, b : NetflowadmissionNode) -> NetflowadmissionNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_node_copy(s : NetflowadmissionNode) -> NetflowadmissionNode {
  let result = net_flow_admission_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_node_fill(s : NetflowadmissionNode, v : Double) -> NetflowadmissionNode {
  let result = net_flow_admission_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_node_min(s : NetflowadmissionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_node_max(s : NetflowadmissionNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_node_to_string(s : NetflowadmissionNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_edge_make(size : Int) -> NetflowadmissionEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_edge_len(s : NetflowadmissionEdge) -> Int { s.size }

pub fn net_flow_admission_edge_get(s : NetflowadmissionEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_edge_set(s : NetflowadmissionEdge, i : Int, v : Double) -> NetflowadmissionEdge {
  let result = net_flow_admission_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_edge_sum(s : NetflowadmissionEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_edge_mean(s : NetflowadmissionEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_edge_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_edge_scale(s : NetflowadmissionEdge, f : Double) -> NetflowadmissionEdge {
  let result = net_flow_admission_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_edge_add(a : NetflowadmissionEdge, b : NetflowadmissionEdge) -> NetflowadmissionEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_edge_copy(s : NetflowadmissionEdge) -> NetflowadmissionEdge {
  let result = net_flow_admission_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_edge_fill(s : NetflowadmissionEdge, v : Double) -> NetflowadmissionEdge {
  let result = net_flow_admission_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_edge_min(s : NetflowadmissionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_edge_max(s : NetflowadmissionEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_edge_to_string(s : NetflowadmissionEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_path_make(size : Int) -> NetflowadmissionPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_path_len(s : NetflowadmissionPath) -> Int { s.size }

pub fn net_flow_admission_path_get(s : NetflowadmissionPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_path_set(s : NetflowadmissionPath, i : Int, v : Double) -> NetflowadmissionPath {
  let result = net_flow_admission_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_path_sum(s : NetflowadmissionPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_path_mean(s : NetflowadmissionPath) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_path_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_path_scale(s : NetflowadmissionPath, f : Double) -> NetflowadmissionPath {
  let result = net_flow_admission_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_path_add(a : NetflowadmissionPath, b : NetflowadmissionPath) -> NetflowadmissionPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_path_copy(s : NetflowadmissionPath) -> NetflowadmissionPath {
  let result = net_flow_admission_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_path_fill(s : NetflowadmissionPath, v : Double) -> NetflowadmissionPath {
  let result = net_flow_admission_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_path_min(s : NetflowadmissionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_path_max(s : NetflowadmissionPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_path_to_string(s : NetflowadmissionPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_cluster_make(size : Int) -> NetflowadmissionCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_cluster_len(s : NetflowadmissionCluster) -> Int { s.size }

pub fn net_flow_admission_cluster_get(s : NetflowadmissionCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_cluster_set(s : NetflowadmissionCluster, i : Int, v : Double) -> NetflowadmissionCluster {
  let result = net_flow_admission_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_cluster_sum(s : NetflowadmissionCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_cluster_mean(s : NetflowadmissionCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_cluster_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_cluster_scale(s : NetflowadmissionCluster, f : Double) -> NetflowadmissionCluster {
  let result = net_flow_admission_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_cluster_add(a : NetflowadmissionCluster, b : NetflowadmissionCluster) -> NetflowadmissionCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_cluster_copy(s : NetflowadmissionCluster) -> NetflowadmissionCluster {
  let result = net_flow_admission_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_cluster_fill(s : NetflowadmissionCluster, v : Double) -> NetflowadmissionCluster {
  let result = net_flow_admission_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_cluster_min(s : NetflowadmissionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_cluster_max(s : NetflowadmissionCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_cluster_to_string(s : NetflowadmissionCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_model_make(size : Int) -> NetflowadmissionModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_model_len(s : NetflowadmissionModel) -> Int { s.size }

pub fn net_flow_admission_model_get(s : NetflowadmissionModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_model_set(s : NetflowadmissionModel, i : Int, v : Double) -> NetflowadmissionModel {
  let result = net_flow_admission_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_model_sum(s : NetflowadmissionModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_model_mean(s : NetflowadmissionModel) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_model_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_model_scale(s : NetflowadmissionModel, f : Double) -> NetflowadmissionModel {
  let result = net_flow_admission_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_model_add(a : NetflowadmissionModel, b : NetflowadmissionModel) -> NetflowadmissionModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_model_copy(s : NetflowadmissionModel) -> NetflowadmissionModel {
  let result = net_flow_admission_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_model_fill(s : NetflowadmissionModel, v : Double) -> NetflowadmissionModel {
  let result = net_flow_admission_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_model_min(s : NetflowadmissionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_model_max(s : NetflowadmissionModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_model_to_string(s : NetflowadmissionModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_layer_make(size : Int) -> NetflowadmissionLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_layer_len(s : NetflowadmissionLayer) -> Int { s.size }

pub fn net_flow_admission_layer_get(s : NetflowadmissionLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_layer_set(s : NetflowadmissionLayer, i : Int, v : Double) -> NetflowadmissionLayer {
  let result = net_flow_admission_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_layer_sum(s : NetflowadmissionLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_layer_mean(s : NetflowadmissionLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_layer_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_layer_scale(s : NetflowadmissionLayer, f : Double) -> NetflowadmissionLayer {
  let result = net_flow_admission_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_layer_add(a : NetflowadmissionLayer, b : NetflowadmissionLayer) -> NetflowadmissionLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_layer_copy(s : NetflowadmissionLayer) -> NetflowadmissionLayer {
  let result = net_flow_admission_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_layer_fill(s : NetflowadmissionLayer, v : Double) -> NetflowadmissionLayer {
  let result = net_flow_admission_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_layer_min(s : NetflowadmissionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_layer_max(s : NetflowadmissionLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_layer_to_string(s : NetflowadmissionLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_buffer_make(size : Int) -> NetflowadmissionBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_buffer_len(s : NetflowadmissionBuffer) -> Int { s.size }

pub fn net_flow_admission_buffer_get(s : NetflowadmissionBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_buffer_set(s : NetflowadmissionBuffer, i : Int, v : Double) -> NetflowadmissionBuffer {
  let result = net_flow_admission_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_buffer_sum(s : NetflowadmissionBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_buffer_mean(s : NetflowadmissionBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_buffer_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_buffer_scale(s : NetflowadmissionBuffer, f : Double) -> NetflowadmissionBuffer {
  let result = net_flow_admission_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_buffer_add(a : NetflowadmissionBuffer, b : NetflowadmissionBuffer) -> NetflowadmissionBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_buffer_copy(s : NetflowadmissionBuffer) -> NetflowadmissionBuffer {
  let result = net_flow_admission_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_buffer_fill(s : NetflowadmissionBuffer, v : Double) -> NetflowadmissionBuffer {
  let result = net_flow_admission_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_buffer_min(s : NetflowadmissionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_buffer_max(s : NetflowadmissionBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_buffer_to_string(s : NetflowadmissionBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_cursor_make(size : Int) -> NetflowadmissionCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_cursor_len(s : NetflowadmissionCursor) -> Int { s.size }

pub fn net_flow_admission_cursor_get(s : NetflowadmissionCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_cursor_set(s : NetflowadmissionCursor, i : Int, v : Double) -> NetflowadmissionCursor {
  let result = net_flow_admission_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_cursor_sum(s : NetflowadmissionCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_cursor_mean(s : NetflowadmissionCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_cursor_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_cursor_scale(s : NetflowadmissionCursor, f : Double) -> NetflowadmissionCursor {
  let result = net_flow_admission_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_cursor_add(a : NetflowadmissionCursor, b : NetflowadmissionCursor) -> NetflowadmissionCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_cursor_copy(s : NetflowadmissionCursor) -> NetflowadmissionCursor {
  let result = net_flow_admission_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_cursor_fill(s : NetflowadmissionCursor, v : Double) -> NetflowadmissionCursor {
  let result = net_flow_admission_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_cursor_min(s : NetflowadmissionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_cursor_max(s : NetflowadmissionCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_cursor_to_string(s : NetflowadmissionCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_view_make(size : Int) -> NetflowadmissionView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_view_len(s : NetflowadmissionView) -> Int { s.size }

pub fn net_flow_admission_view_get(s : NetflowadmissionView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_view_set(s : NetflowadmissionView, i : Int, v : Double) -> NetflowadmissionView {
  let result = net_flow_admission_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_view_sum(s : NetflowadmissionView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_view_mean(s : NetflowadmissionView) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_view_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_view_scale(s : NetflowadmissionView, f : Double) -> NetflowadmissionView {
  let result = net_flow_admission_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_view_add(a : NetflowadmissionView, b : NetflowadmissionView) -> NetflowadmissionView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_view_copy(s : NetflowadmissionView) -> NetflowadmissionView {
  let result = net_flow_admission_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_view_fill(s : NetflowadmissionView, v : Double) -> NetflowadmissionView {
  let result = net_flow_admission_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_view_min(s : NetflowadmissionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_view_max(s : NetflowadmissionView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_view_to_string(s : NetflowadmissionView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_range_make(size : Int) -> NetflowadmissionRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_range_len(s : NetflowadmissionRange) -> Int { s.size }

pub fn net_flow_admission_range_get(s : NetflowadmissionRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_range_set(s : NetflowadmissionRange, i : Int, v : Double) -> NetflowadmissionRange {
  let result = net_flow_admission_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_range_sum(s : NetflowadmissionRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_range_mean(s : NetflowadmissionRange) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_range_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_range_scale(s : NetflowadmissionRange, f : Double) -> NetflowadmissionRange {
  let result = net_flow_admission_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_range_add(a : NetflowadmissionRange, b : NetflowadmissionRange) -> NetflowadmissionRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_range_copy(s : NetflowadmissionRange) -> NetflowadmissionRange {
  let result = net_flow_admission_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_range_fill(s : NetflowadmissionRange, v : Double) -> NetflowadmissionRange {
  let result = net_flow_admission_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_range_min(s : NetflowadmissionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_range_max(s : NetflowadmissionRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_range_to_string(s : NetflowadmissionRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowadmissionSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_admission_slice_make(size : Int) -> NetflowadmissionSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_admission_slice_len(s : NetflowadmissionSlice) -> Int { s.size }

pub fn net_flow_admission_slice_get(s : NetflowadmissionSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_admission_slice_set(s : NetflowadmissionSlice, i : Int, v : Double) -> NetflowadmissionSlice {
  let result = net_flow_admission_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_slice_sum(s : NetflowadmissionSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_admission_slice_mean(s : NetflowadmissionSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_admission_slice_sum(s) / s.size.to_double() }
}

pub fn net_flow_admission_slice_scale(s : NetflowadmissionSlice, f : Double) -> NetflowadmissionSlice {
  let result = net_flow_admission_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_admission_slice_add(a : NetflowadmissionSlice, b : NetflowadmissionSlice) -> NetflowadmissionSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_admission_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_admission_slice_copy(s : NetflowadmissionSlice) -> NetflowadmissionSlice {
  let result = net_flow_admission_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_admission_slice_fill(s : NetflowadmissionSlice, v : Double) -> NetflowadmissionSlice {
  let result = net_flow_admission_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_admission_slice_min(s : NetflowadmissionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_slice_max(s : NetflowadmissionSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_admission_slice_to_string(s : NetflowadmissionSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

