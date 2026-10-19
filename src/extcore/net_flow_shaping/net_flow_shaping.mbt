///===
/// extcore/net_flow_shaping

pub(all) struct NetflowshapingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_shaping_make_point(x : Double, y : Double) -> NetflowshapingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_shaping_make_point3(x : Double, y : Double, z : Double) -> NetflowshapingPoint {
  { x, y, z, label: 0 }
}

pub fn net_flow_shaping_point_x(pt : NetflowshapingPoint) -> Double { pt.x }

pub fn net_flow_shaping_point_y(pt : NetflowshapingPoint) -> Double { pt.y }

pub fn net_flow_shaping_point_z(pt : NetflowshapingPoint) -> Double { pt.z }

pub fn net_flow_shaping_point_label(pt : NetflowshapingPoint) -> Int { pt.label }

pub fn net_flow_shaping_point_dist(a : NetflowshapingPoint, b : NetflowshapingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_flow_shaping_point_add(a : NetflowshapingPoint, b : NetflowshapingPoint) -> NetflowshapingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_flow_shaping_point_sub(a : NetflowshapingPoint, b : NetflowshapingPoint) -> NetflowshapingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_flow_shaping_point_scale(pt : NetflowshapingPoint, s : Double) -> NetflowshapingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_flow_shaping_point_dot(a : NetflowshapingPoint, b : NetflowshapingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_flow_shaping_point_cross(a : NetflowshapingPoint, b : NetflowshapingPoint) -> NetflowshapingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_flow_shaping_point_norm(pt : NetflowshapingPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_flow_shaping_point_normalize(pt : NetflowshapingPoint) -> NetflowshapingPoint {
  let n = net_flow_shaping_point_norm(pt)
  if n < 0.0000001 { pt } else { net_flow_shaping_point_scale(pt, 1.0 / n) }
}

pub fn net_flow_shaping_point_negate(pt : NetflowshapingPoint) -> NetflowshapingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_flow_shaping_point_mid(a : NetflowshapingPoint, b : NetflowshapingPoint) -> NetflowshapingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_flow_shaping_point_lerp(a : NetflowshapingPoint, b : NetflowshapingPoint, t : Double) -> NetflowshapingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_flow_shaping_point_to_string(pt : NetflowshapingPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetflowshapingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_shaping_make_series(vals : Array[Double], name : String) -> NetflowshapingSeries {
  { vals, name, meta: 0 }
}

pub fn net_flow_shaping_series_len(s : NetflowshapingSeries) -> Int { s.vals.length() }

pub fn net_flow_shaping_series_sum(s : NetflowshapingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_flow_shaping_series_mean(s : NetflowshapingSeries) -> Double {
  let n = net_flow_shaping_series_len(s)
  if n == 0 { 0.0 } else { net_flow_shaping_series_sum(s) / n.to_double() }
}

pub fn net_flow_shaping_series_min(s : NetflowshapingSeries) -> Double {
  let n = net_flow_shaping_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_shaping_series_max(s : NetflowshapingSeries) -> Double {
  let n = net_flow_shaping_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_shaping_series_range(s : NetflowshapingSeries) -> Double {
  net_flow_shaping_series_max(s) - net_flow_shaping_series_min(s)
}

pub fn net_flow_shaping_series_var(s : NetflowshapingSeries) -> Double {
  let n = net_flow_shaping_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_flow_shaping_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_flow_shaping_series_std(s : NetflowshapingSeries) -> Double { @_common.sqrt(net_flow_shaping_series_var(s)) }

pub fn net_flow_shaping_series_median(s : NetflowshapingSeries) -> Double {
  let n = net_flow_shaping_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_flow_shaping_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_flow_shaping_series_scale(s : NetflowshapingSeries, f : Double) -> NetflowshapingSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_flow_shaping_series_add(a : NetflowshapingSeries, b : NetflowshapingSeries) -> NetflowshapingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_flow_shaping_series_sub(a : NetflowshapingSeries, b : NetflowshapingSeries) -> NetflowshapingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_flow_shaping_series_normalize(s : NetflowshapingSeries) -> NetflowshapingSeries {
  let mn = net_flow_shaping_series_min(s)
  let mx = net_flow_shaping_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_flow_shaping_series_cumsum(s : NetflowshapingSeries) -> NetflowshapingSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_flow_shaping_series_to_string(s : NetflowshapingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowshapingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_shaping_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowshapingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_shaping_matrix_identity(n : Int) -> NetflowshapingMatrix {
  let m = net_flow_shaping_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_flow_shaping_matrix_get(m : NetflowshapingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_flow_shaping_matrix_transpose(m : NetflowshapingMatrix) -> NetflowshapingMatrix {
  let result = net_flow_shaping_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_flow_shaping_matrix_add(a : NetflowshapingMatrix, b : NetflowshapingMatrix) -> NetflowshapingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_flow_shaping_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_flow_shaping_matrix_scale(m : NetflowshapingMatrix, s : Double) -> NetflowshapingMatrix {
  let result = net_flow_shaping_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_flow_shaping_matrix_multiply(a : NetflowshapingMatrix, b : NetflowshapingMatrix) -> NetflowshapingMatrix {
  if a.cols != b.rows { return net_flow_shaping_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_flow_shaping_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_flow_shaping_matrix_trace(m : NetflowshapingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_flow_shaping_matrix_det(m : NetflowshapingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_flow_shaping_matrix_norm(m : NetflowshapingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_flow_shaping_matrix_to_string(m : NetflowshapingMatrix) -> String {
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

pub(all) struct NetflowshapingVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_shaping_make_vector(comps : Array[Double]) -> NetflowshapingVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_shaping_vector_zero(dim : Int) -> NetflowshapingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_flow_shaping_vector_add(a : NetflowshapingVector, b : NetflowshapingVector) -> NetflowshapingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_shaping_vector_sub(a : NetflowshapingVector, b : NetflowshapingVector) -> NetflowshapingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_shaping_vector_scale(v : NetflowshapingVector, s : Double) -> NetflowshapingVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_flow_shaping_vector_dot(a : NetflowshapingVector, b : NetflowshapingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_flow_shaping_vector_norm(v : NetflowshapingVector) -> Double { @_common.sqrt(net_flow_shaping_vector_dot(v, v)) }

pub fn net_flow_shaping_vector_normalize(v : NetflowshapingVector) -> NetflowshapingVector {
  let n = net_flow_shaping_vector_norm(v)
  if n < 0.0000001 { v } else { net_flow_shaping_vector_scale(v, 1.0 / n) }
}

pub fn net_flow_shaping_vector_dist(a : NetflowshapingVector, b : NetflowshapingVector) -> Double {
  net_flow_shaping_vector_norm(net_flow_shaping_vector_sub(a, b))
}

pub fn net_flow_shaping_vector_to_string(v : NetflowshapingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_shaping_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_flow_shaping_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_flow_shaping_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_flow_shaping_std(data : Array[Double]) -> Double { @_common.sqrt(net_flow_shaping_var(data)) }

pub fn net_flow_shaping_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_flow_shaping_mean(a); let mb = net_flow_shaping_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_flow_shaping_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_flow_shaping_std(a); let sb = net_flow_shaping_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_flow_shaping_cov(a, b) / (sa * sb) }
}

pub fn net_flow_shaping_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_flow_shaping_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_flow_shaping_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_flow_shaping_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_flow_shaping_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(net_flow_shaping_mse(pred, labels))
}

pub fn net_flow_shaping_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_flow_shaping_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_flow_shaping_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_flow_shaping_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_flow_shaping_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_flow_shaping_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_flow_shaping_precision(pred, labels, pos); let r = net_flow_shaping_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_flow_shaping_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_flow_shaping_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_flow_shaping_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_flow_shaping_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_flow_shaping_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_flow_shaping_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_flow_shaping_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_flow_shaping_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_flow_shaping_fibonacci(n : Int) -> Int {
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

pub fn net_flow_shaping_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_flow_shaping_min(data); let mx = net_flow_shaping_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_flow_shaping_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_flow_shaping_mean(data); let sd = net_flow_shaping_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_flow_shaping_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_flow_shaping_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_flow_shaping_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_flow_shaping_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_flow_shaping_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_flow_shaping_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NetflowshapingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_frame_make(size : Int) -> NetflowshapingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_frame_len(s : NetflowshapingFrame) -> Int { s.size }

pub fn net_flow_shaping_frame_get(s : NetflowshapingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_frame_set(s : NetflowshapingFrame, i : Int, v : Double) -> NetflowshapingFrame {
  let result = net_flow_shaping_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_frame_sum(s : NetflowshapingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_frame_mean(s : NetflowshapingFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_frame_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_frame_scale(s : NetflowshapingFrame, f : Double) -> NetflowshapingFrame {
  let result = net_flow_shaping_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_frame_add(a : NetflowshapingFrame, b : NetflowshapingFrame) -> NetflowshapingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_frame_copy(s : NetflowshapingFrame) -> NetflowshapingFrame {
  let result = net_flow_shaping_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_frame_fill(s : NetflowshapingFrame, v : Double) -> NetflowshapingFrame {
  let result = net_flow_shaping_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_frame_min(s : NetflowshapingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_frame_max(s : NetflowshapingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_frame_to_string(s : NetflowshapingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_table_make(size : Int) -> NetflowshapingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_table_len(s : NetflowshapingTable) -> Int { s.size }

pub fn net_flow_shaping_table_get(s : NetflowshapingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_table_set(s : NetflowshapingTable, i : Int, v : Double) -> NetflowshapingTable {
  let result = net_flow_shaping_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_table_sum(s : NetflowshapingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_table_mean(s : NetflowshapingTable) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_table_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_table_scale(s : NetflowshapingTable, f : Double) -> NetflowshapingTable {
  let result = net_flow_shaping_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_table_add(a : NetflowshapingTable, b : NetflowshapingTable) -> NetflowshapingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_table_copy(s : NetflowshapingTable) -> NetflowshapingTable {
  let result = net_flow_shaping_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_table_fill(s : NetflowshapingTable, v : Double) -> NetflowshapingTable {
  let result = net_flow_shaping_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_table_min(s : NetflowshapingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_table_max(s : NetflowshapingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_table_to_string(s : NetflowshapingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_graphn_make(size : Int) -> NetflowshapingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_graphn_len(s : NetflowshapingGraphN) -> Int { s.size }

pub fn net_flow_shaping_graphn_get(s : NetflowshapingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_graphn_set(s : NetflowshapingGraphN, i : Int, v : Double) -> NetflowshapingGraphN {
  let result = net_flow_shaping_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_graphn_sum(s : NetflowshapingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_graphn_mean(s : NetflowshapingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_graphn_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_graphn_scale(s : NetflowshapingGraphN, f : Double) -> NetflowshapingGraphN {
  let result = net_flow_shaping_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_graphn_add(a : NetflowshapingGraphN, b : NetflowshapingGraphN) -> NetflowshapingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_graphn_copy(s : NetflowshapingGraphN) -> NetflowshapingGraphN {
  let result = net_flow_shaping_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_graphn_fill(s : NetflowshapingGraphN, v : Double) -> NetflowshapingGraphN {
  let result = net_flow_shaping_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_graphn_min(s : NetflowshapingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_graphn_max(s : NetflowshapingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_graphn_to_string(s : NetflowshapingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_node_make(size : Int) -> NetflowshapingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_node_len(s : NetflowshapingNode) -> Int { s.size }

pub fn net_flow_shaping_node_get(s : NetflowshapingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_node_set(s : NetflowshapingNode, i : Int, v : Double) -> NetflowshapingNode {
  let result = net_flow_shaping_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_node_sum(s : NetflowshapingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_node_mean(s : NetflowshapingNode) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_node_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_node_scale(s : NetflowshapingNode, f : Double) -> NetflowshapingNode {
  let result = net_flow_shaping_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_node_add(a : NetflowshapingNode, b : NetflowshapingNode) -> NetflowshapingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_node_copy(s : NetflowshapingNode) -> NetflowshapingNode {
  let result = net_flow_shaping_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_node_fill(s : NetflowshapingNode, v : Double) -> NetflowshapingNode {
  let result = net_flow_shaping_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_node_min(s : NetflowshapingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_node_max(s : NetflowshapingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_node_to_string(s : NetflowshapingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_edge_make(size : Int) -> NetflowshapingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_edge_len(s : NetflowshapingEdge) -> Int { s.size }

pub fn net_flow_shaping_edge_get(s : NetflowshapingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_edge_set(s : NetflowshapingEdge, i : Int, v : Double) -> NetflowshapingEdge {
  let result = net_flow_shaping_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_edge_sum(s : NetflowshapingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_edge_mean(s : NetflowshapingEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_edge_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_edge_scale(s : NetflowshapingEdge, f : Double) -> NetflowshapingEdge {
  let result = net_flow_shaping_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_edge_add(a : NetflowshapingEdge, b : NetflowshapingEdge) -> NetflowshapingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_edge_copy(s : NetflowshapingEdge) -> NetflowshapingEdge {
  let result = net_flow_shaping_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_edge_fill(s : NetflowshapingEdge, v : Double) -> NetflowshapingEdge {
  let result = net_flow_shaping_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_edge_min(s : NetflowshapingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_edge_max(s : NetflowshapingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_edge_to_string(s : NetflowshapingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_path_make(size : Int) -> NetflowshapingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_path_len(s : NetflowshapingPath) -> Int { s.size }

pub fn net_flow_shaping_path_get(s : NetflowshapingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_path_set(s : NetflowshapingPath, i : Int, v : Double) -> NetflowshapingPath {
  let result = net_flow_shaping_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_path_sum(s : NetflowshapingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_path_mean(s : NetflowshapingPath) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_path_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_path_scale(s : NetflowshapingPath, f : Double) -> NetflowshapingPath {
  let result = net_flow_shaping_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_path_add(a : NetflowshapingPath, b : NetflowshapingPath) -> NetflowshapingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_path_copy(s : NetflowshapingPath) -> NetflowshapingPath {
  let result = net_flow_shaping_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_path_fill(s : NetflowshapingPath, v : Double) -> NetflowshapingPath {
  let result = net_flow_shaping_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_path_min(s : NetflowshapingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_path_max(s : NetflowshapingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_path_to_string(s : NetflowshapingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_cluster_make(size : Int) -> NetflowshapingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_cluster_len(s : NetflowshapingCluster) -> Int { s.size }

pub fn net_flow_shaping_cluster_get(s : NetflowshapingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_cluster_set(s : NetflowshapingCluster, i : Int, v : Double) -> NetflowshapingCluster {
  let result = net_flow_shaping_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_cluster_sum(s : NetflowshapingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_cluster_mean(s : NetflowshapingCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_cluster_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_cluster_scale(s : NetflowshapingCluster, f : Double) -> NetflowshapingCluster {
  let result = net_flow_shaping_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_cluster_add(a : NetflowshapingCluster, b : NetflowshapingCluster) -> NetflowshapingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_cluster_copy(s : NetflowshapingCluster) -> NetflowshapingCluster {
  let result = net_flow_shaping_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_cluster_fill(s : NetflowshapingCluster, v : Double) -> NetflowshapingCluster {
  let result = net_flow_shaping_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_cluster_min(s : NetflowshapingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_cluster_max(s : NetflowshapingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_cluster_to_string(s : NetflowshapingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_model_make(size : Int) -> NetflowshapingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_model_len(s : NetflowshapingModel) -> Int { s.size }

pub fn net_flow_shaping_model_get(s : NetflowshapingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_model_set(s : NetflowshapingModel, i : Int, v : Double) -> NetflowshapingModel {
  let result = net_flow_shaping_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_model_sum(s : NetflowshapingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_model_mean(s : NetflowshapingModel) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_model_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_model_scale(s : NetflowshapingModel, f : Double) -> NetflowshapingModel {
  let result = net_flow_shaping_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_model_add(a : NetflowshapingModel, b : NetflowshapingModel) -> NetflowshapingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_model_copy(s : NetflowshapingModel) -> NetflowshapingModel {
  let result = net_flow_shaping_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_model_fill(s : NetflowshapingModel, v : Double) -> NetflowshapingModel {
  let result = net_flow_shaping_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_model_min(s : NetflowshapingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_model_max(s : NetflowshapingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_model_to_string(s : NetflowshapingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_layer_make(size : Int) -> NetflowshapingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_layer_len(s : NetflowshapingLayer) -> Int { s.size }

pub fn net_flow_shaping_layer_get(s : NetflowshapingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_layer_set(s : NetflowshapingLayer, i : Int, v : Double) -> NetflowshapingLayer {
  let result = net_flow_shaping_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_layer_sum(s : NetflowshapingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_layer_mean(s : NetflowshapingLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_layer_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_layer_scale(s : NetflowshapingLayer, f : Double) -> NetflowshapingLayer {
  let result = net_flow_shaping_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_layer_add(a : NetflowshapingLayer, b : NetflowshapingLayer) -> NetflowshapingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_layer_copy(s : NetflowshapingLayer) -> NetflowshapingLayer {
  let result = net_flow_shaping_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_layer_fill(s : NetflowshapingLayer, v : Double) -> NetflowshapingLayer {
  let result = net_flow_shaping_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_layer_min(s : NetflowshapingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_layer_max(s : NetflowshapingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_layer_to_string(s : NetflowshapingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_buffer_make(size : Int) -> NetflowshapingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_buffer_len(s : NetflowshapingBuffer) -> Int { s.size }

pub fn net_flow_shaping_buffer_get(s : NetflowshapingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_buffer_set(s : NetflowshapingBuffer, i : Int, v : Double) -> NetflowshapingBuffer {
  let result = net_flow_shaping_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_buffer_sum(s : NetflowshapingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_buffer_mean(s : NetflowshapingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_buffer_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_buffer_scale(s : NetflowshapingBuffer, f : Double) -> NetflowshapingBuffer {
  let result = net_flow_shaping_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_buffer_add(a : NetflowshapingBuffer, b : NetflowshapingBuffer) -> NetflowshapingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_buffer_copy(s : NetflowshapingBuffer) -> NetflowshapingBuffer {
  let result = net_flow_shaping_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_buffer_fill(s : NetflowshapingBuffer, v : Double) -> NetflowshapingBuffer {
  let result = net_flow_shaping_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_buffer_min(s : NetflowshapingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_buffer_max(s : NetflowshapingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_buffer_to_string(s : NetflowshapingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_cursor_make(size : Int) -> NetflowshapingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_cursor_len(s : NetflowshapingCursor) -> Int { s.size }

pub fn net_flow_shaping_cursor_get(s : NetflowshapingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_cursor_set(s : NetflowshapingCursor, i : Int, v : Double) -> NetflowshapingCursor {
  let result = net_flow_shaping_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_cursor_sum(s : NetflowshapingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_cursor_mean(s : NetflowshapingCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_cursor_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_cursor_scale(s : NetflowshapingCursor, f : Double) -> NetflowshapingCursor {
  let result = net_flow_shaping_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_cursor_add(a : NetflowshapingCursor, b : NetflowshapingCursor) -> NetflowshapingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_cursor_copy(s : NetflowshapingCursor) -> NetflowshapingCursor {
  let result = net_flow_shaping_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_cursor_fill(s : NetflowshapingCursor, v : Double) -> NetflowshapingCursor {
  let result = net_flow_shaping_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_cursor_min(s : NetflowshapingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_cursor_max(s : NetflowshapingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_cursor_to_string(s : NetflowshapingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_view_make(size : Int) -> NetflowshapingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_view_len(s : NetflowshapingView) -> Int { s.size }

pub fn net_flow_shaping_view_get(s : NetflowshapingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_view_set(s : NetflowshapingView, i : Int, v : Double) -> NetflowshapingView {
  let result = net_flow_shaping_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_view_sum(s : NetflowshapingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_view_mean(s : NetflowshapingView) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_view_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_view_scale(s : NetflowshapingView, f : Double) -> NetflowshapingView {
  let result = net_flow_shaping_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_view_add(a : NetflowshapingView, b : NetflowshapingView) -> NetflowshapingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_view_copy(s : NetflowshapingView) -> NetflowshapingView {
  let result = net_flow_shaping_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_view_fill(s : NetflowshapingView, v : Double) -> NetflowshapingView {
  let result = net_flow_shaping_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_view_min(s : NetflowshapingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_view_max(s : NetflowshapingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_view_to_string(s : NetflowshapingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_range_make(size : Int) -> NetflowshapingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_range_len(s : NetflowshapingRange) -> Int { s.size }

pub fn net_flow_shaping_range_get(s : NetflowshapingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_range_set(s : NetflowshapingRange, i : Int, v : Double) -> NetflowshapingRange {
  let result = net_flow_shaping_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_range_sum(s : NetflowshapingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_range_mean(s : NetflowshapingRange) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_range_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_range_scale(s : NetflowshapingRange, f : Double) -> NetflowshapingRange {
  let result = net_flow_shaping_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_range_add(a : NetflowshapingRange, b : NetflowshapingRange) -> NetflowshapingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_range_copy(s : NetflowshapingRange) -> NetflowshapingRange {
  let result = net_flow_shaping_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_range_fill(s : NetflowshapingRange, v : Double) -> NetflowshapingRange {
  let result = net_flow_shaping_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_range_min(s : NetflowshapingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_range_max(s : NetflowshapingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_range_to_string(s : NetflowshapingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowshapingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_shaping_slice_make(size : Int) -> NetflowshapingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_shaping_slice_len(s : NetflowshapingSlice) -> Int { s.size }

pub fn net_flow_shaping_slice_get(s : NetflowshapingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_shaping_slice_set(s : NetflowshapingSlice, i : Int, v : Double) -> NetflowshapingSlice {
  let result = net_flow_shaping_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_slice_sum(s : NetflowshapingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_shaping_slice_mean(s : NetflowshapingSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_shaping_slice_sum(s) / s.size.to_double() }
}

pub fn net_flow_shaping_slice_scale(s : NetflowshapingSlice, f : Double) -> NetflowshapingSlice {
  let result = net_flow_shaping_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_shaping_slice_add(a : NetflowshapingSlice, b : NetflowshapingSlice) -> NetflowshapingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_shaping_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_shaping_slice_copy(s : NetflowshapingSlice) -> NetflowshapingSlice {
  let result = net_flow_shaping_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_shaping_slice_fill(s : NetflowshapingSlice, v : Double) -> NetflowshapingSlice {
  let result = net_flow_shaping_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_shaping_slice_min(s : NetflowshapingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_slice_max(s : NetflowshapingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_shaping_slice_to_string(s : NetflowshapingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

