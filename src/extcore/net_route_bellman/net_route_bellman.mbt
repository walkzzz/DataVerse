///===
/// extcore/net_route_bellman

pub(all) struct NetroutebellmanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_bellman_make_point(x : Double, y : Double) -> NetroutebellmanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_bellman_make_point3(x : Double, y : Double, z : Double) -> NetroutebellmanPoint {
  { x, y, z, label: 0 }
}

pub fn net_route_bellman_point_x(pt : NetroutebellmanPoint) -> Double { pt.x }

pub fn net_route_bellman_point_y(pt : NetroutebellmanPoint) -> Double { pt.y }

pub fn net_route_bellman_point_z(pt : NetroutebellmanPoint) -> Double { pt.z }

pub fn net_route_bellman_point_label(pt : NetroutebellmanPoint) -> Int { pt.label }

pub fn net_route_bellman_point_dist(a : NetroutebellmanPoint, b : NetroutebellmanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_route_bellman_point_add(a : NetroutebellmanPoint, b : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_route_bellman_point_sub(a : NetroutebellmanPoint, b : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_route_bellman_point_scale(pt : NetroutebellmanPoint, s : Double) -> NetroutebellmanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_route_bellman_point_dot(a : NetroutebellmanPoint, b : NetroutebellmanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_route_bellman_point_cross(a : NetroutebellmanPoint, b : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_route_bellman_point_norm(pt : NetroutebellmanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_route_bellman_point_normalize(pt : NetroutebellmanPoint) -> NetroutebellmanPoint {
  let n = net_route_bellman_point_norm(pt)
  if n < 0.0000001 { pt } else { net_route_bellman_point_scale(pt, 1.0 / n) }
}

pub fn net_route_bellman_point_negate(pt : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_route_bellman_point_mid(a : NetroutebellmanPoint, b : NetroutebellmanPoint) -> NetroutebellmanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_route_bellman_point_lerp(a : NetroutebellmanPoint, b : NetroutebellmanPoint, t : Double) -> NetroutebellmanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_route_bellman_point_to_string(pt : NetroutebellmanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetroutebellmanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_bellman_make_series(vals : Array[Double], name : String) -> NetroutebellmanSeries {
  { vals, name, meta: 0 }
}

pub fn net_route_bellman_series_len(s : NetroutebellmanSeries) -> Int { s.vals.length() }

pub fn net_route_bellman_series_sum(s : NetroutebellmanSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_route_bellman_series_mean(s : NetroutebellmanSeries) -> Double {
  let n = net_route_bellman_series_len(s)
  if n == 0 { 0.0 } else { net_route_bellman_series_sum(s) / n.to_double() }
}

pub fn net_route_bellman_series_min(s : NetroutebellmanSeries) -> Double {
  let n = net_route_bellman_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_route_bellman_series_max(s : NetroutebellmanSeries) -> Double {
  let n = net_route_bellman_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_route_bellman_series_range(s : NetroutebellmanSeries) -> Double {
  net_route_bellman_series_max(s) - net_route_bellman_series_min(s)
}

pub fn net_route_bellman_series_var(s : NetroutebellmanSeries) -> Double {
  let n = net_route_bellman_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_route_bellman_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_route_bellman_series_std(s : NetroutebellmanSeries) -> Double { @_common.sqrt(net_route_bellman_series_var(s)) }

pub fn net_route_bellman_series_median(s : NetroutebellmanSeries) -> Double {
  let n = net_route_bellman_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_route_bellman_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_route_bellman_series_scale(s : NetroutebellmanSeries, f : Double) -> NetroutebellmanSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_route_bellman_series_add(a : NetroutebellmanSeries, b : NetroutebellmanSeries) -> NetroutebellmanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_route_bellman_series_sub(a : NetroutebellmanSeries, b : NetroutebellmanSeries) -> NetroutebellmanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_route_bellman_series_normalize(s : NetroutebellmanSeries) -> NetroutebellmanSeries {
  let mn = net_route_bellman_series_min(s)
  let mx = net_route_bellman_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_route_bellman_series_cumsum(s : NetroutebellmanSeries) -> NetroutebellmanSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_route_bellman_series_to_string(s : NetroutebellmanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetroutebellmanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_bellman_make_matrix(rows : Int, cols : Int, val : Double) -> NetroutebellmanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_bellman_matrix_identity(n : Int) -> NetroutebellmanMatrix {
  let m = net_route_bellman_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_route_bellman_matrix_get(m : NetroutebellmanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_route_bellman_matrix_transpose(m : NetroutebellmanMatrix) -> NetroutebellmanMatrix {
  let result = net_route_bellman_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_route_bellman_matrix_add(a : NetroutebellmanMatrix, b : NetroutebellmanMatrix) -> NetroutebellmanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_route_bellman_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_route_bellman_matrix_scale(m : NetroutebellmanMatrix, s : Double) -> NetroutebellmanMatrix {
  let result = net_route_bellman_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_route_bellman_matrix_multiply(a : NetroutebellmanMatrix, b : NetroutebellmanMatrix) -> NetroutebellmanMatrix {
  if a.cols != b.rows { return net_route_bellman_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_route_bellman_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_route_bellman_matrix_trace(m : NetroutebellmanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_route_bellman_matrix_det(m : NetroutebellmanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_route_bellman_matrix_norm(m : NetroutebellmanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn net_route_bellman_matrix_to_string(m : NetroutebellmanMatrix) -> String {
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

pub(all) struct NetroutebellmanVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_bellman_make_vector(comps : Array[Double]) -> NetroutebellmanVector {
  { comps, dim: comps.length() }
}

pub fn net_route_bellman_vector_zero(dim : Int) -> NetroutebellmanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_route_bellman_vector_add(a : NetroutebellmanVector, b : NetroutebellmanVector) -> NetroutebellmanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_bellman_vector_sub(a : NetroutebellmanVector, b : NetroutebellmanVector) -> NetroutebellmanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_bellman_vector_scale(v : NetroutebellmanVector, s : Double) -> NetroutebellmanVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_route_bellman_vector_dot(a : NetroutebellmanVector, b : NetroutebellmanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_route_bellman_vector_norm(v : NetroutebellmanVector) -> Double { @_common.sqrt(net_route_bellman_vector_dot(v, v)) }

pub fn net_route_bellman_vector_normalize(v : NetroutebellmanVector) -> NetroutebellmanVector {
  let n = net_route_bellman_vector_norm(v)
  if n < 0.0000001 { v } else { net_route_bellman_vector_scale(v, 1.0 / n) }
}

pub fn net_route_bellman_vector_dist(a : NetroutebellmanVector, b : NetroutebellmanVector) -> Double {
  net_route_bellman_vector_norm(net_route_bellman_vector_sub(a, b))
}

pub fn net_route_bellman_vector_to_string(v : NetroutebellmanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_bellman_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_route_bellman_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_route_bellman_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_route_bellman_std(data : Array[Double]) -> Double { @_common.sqrt(net_route_bellman_var(data)) }

pub fn net_route_bellman_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_route_bellman_mean(a); let mb = net_route_bellman_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_route_bellman_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_route_bellman_std(a); let sb = net_route_bellman_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_route_bellman_cov(a, b) / (sa * sb) }
}

pub fn net_route_bellman_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_route_bellman_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_route_bellman_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_route_bellman_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_route_bellman_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(net_route_bellman_mse(pred, labels))
}

pub fn net_route_bellman_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_route_bellman_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_route_bellman_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_route_bellman_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_route_bellman_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_route_bellman_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_route_bellman_precision(pred, labels, pos); let r = net_route_bellman_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_route_bellman_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_route_bellman_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_route_bellman_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_route_bellman_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_route_bellman_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_route_bellman_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_route_bellman_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_route_bellman_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_route_bellman_fibonacci(n : Int) -> Int {
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

pub fn net_route_bellman_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_route_bellman_min(data); let mx = net_route_bellman_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_route_bellman_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_route_bellman_mean(data); let sd = net_route_bellman_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_route_bellman_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_route_bellman_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_route_bellman_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_route_bellman_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_route_bellman_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_route_bellman_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NetroutebellmanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_frame_make(size : Int) -> NetroutebellmanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_frame_len(s : NetroutebellmanFrame) -> Int { s.size }

pub fn net_route_bellman_frame_get(s : NetroutebellmanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_frame_set(s : NetroutebellmanFrame, i : Int, v : Double) -> NetroutebellmanFrame {
  let result = net_route_bellman_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_frame_sum(s : NetroutebellmanFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_frame_mean(s : NetroutebellmanFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_frame_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_frame_scale(s : NetroutebellmanFrame, f : Double) -> NetroutebellmanFrame {
  let result = net_route_bellman_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_frame_add(a : NetroutebellmanFrame, b : NetroutebellmanFrame) -> NetroutebellmanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_frame_copy(s : NetroutebellmanFrame) -> NetroutebellmanFrame {
  let result = net_route_bellman_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_frame_fill(s : NetroutebellmanFrame, v : Double) -> NetroutebellmanFrame {
  let result = net_route_bellman_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_frame_min(s : NetroutebellmanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_frame_max(s : NetroutebellmanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_frame_to_string(s : NetroutebellmanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_table_make(size : Int) -> NetroutebellmanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_table_len(s : NetroutebellmanTable) -> Int { s.size }

pub fn net_route_bellman_table_get(s : NetroutebellmanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_table_set(s : NetroutebellmanTable, i : Int, v : Double) -> NetroutebellmanTable {
  let result = net_route_bellman_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_table_sum(s : NetroutebellmanTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_table_mean(s : NetroutebellmanTable) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_table_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_table_scale(s : NetroutebellmanTable, f : Double) -> NetroutebellmanTable {
  let result = net_route_bellman_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_table_add(a : NetroutebellmanTable, b : NetroutebellmanTable) -> NetroutebellmanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_table_copy(s : NetroutebellmanTable) -> NetroutebellmanTable {
  let result = net_route_bellman_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_table_fill(s : NetroutebellmanTable, v : Double) -> NetroutebellmanTable {
  let result = net_route_bellman_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_table_min(s : NetroutebellmanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_table_max(s : NetroutebellmanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_table_to_string(s : NetroutebellmanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_graphn_make(size : Int) -> NetroutebellmanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_graphn_len(s : NetroutebellmanGraphN) -> Int { s.size }

pub fn net_route_bellman_graphn_get(s : NetroutebellmanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_graphn_set(s : NetroutebellmanGraphN, i : Int, v : Double) -> NetroutebellmanGraphN {
  let result = net_route_bellman_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_graphn_sum(s : NetroutebellmanGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_graphn_mean(s : NetroutebellmanGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_graphn_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_graphn_scale(s : NetroutebellmanGraphN, f : Double) -> NetroutebellmanGraphN {
  let result = net_route_bellman_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_graphn_add(a : NetroutebellmanGraphN, b : NetroutebellmanGraphN) -> NetroutebellmanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_graphn_copy(s : NetroutebellmanGraphN) -> NetroutebellmanGraphN {
  let result = net_route_bellman_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_graphn_fill(s : NetroutebellmanGraphN, v : Double) -> NetroutebellmanGraphN {
  let result = net_route_bellman_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_graphn_min(s : NetroutebellmanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_graphn_max(s : NetroutebellmanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_graphn_to_string(s : NetroutebellmanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_node_make(size : Int) -> NetroutebellmanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_node_len(s : NetroutebellmanNode) -> Int { s.size }

pub fn net_route_bellman_node_get(s : NetroutebellmanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_node_set(s : NetroutebellmanNode, i : Int, v : Double) -> NetroutebellmanNode {
  let result = net_route_bellman_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_node_sum(s : NetroutebellmanNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_node_mean(s : NetroutebellmanNode) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_node_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_node_scale(s : NetroutebellmanNode, f : Double) -> NetroutebellmanNode {
  let result = net_route_bellman_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_node_add(a : NetroutebellmanNode, b : NetroutebellmanNode) -> NetroutebellmanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_node_copy(s : NetroutebellmanNode) -> NetroutebellmanNode {
  let result = net_route_bellman_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_node_fill(s : NetroutebellmanNode, v : Double) -> NetroutebellmanNode {
  let result = net_route_bellman_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_node_min(s : NetroutebellmanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_node_max(s : NetroutebellmanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_node_to_string(s : NetroutebellmanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_edge_make(size : Int) -> NetroutebellmanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_edge_len(s : NetroutebellmanEdge) -> Int { s.size }

pub fn net_route_bellman_edge_get(s : NetroutebellmanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_edge_set(s : NetroutebellmanEdge, i : Int, v : Double) -> NetroutebellmanEdge {
  let result = net_route_bellman_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_edge_sum(s : NetroutebellmanEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_edge_mean(s : NetroutebellmanEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_edge_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_edge_scale(s : NetroutebellmanEdge, f : Double) -> NetroutebellmanEdge {
  let result = net_route_bellman_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_edge_add(a : NetroutebellmanEdge, b : NetroutebellmanEdge) -> NetroutebellmanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_edge_copy(s : NetroutebellmanEdge) -> NetroutebellmanEdge {
  let result = net_route_bellman_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_edge_fill(s : NetroutebellmanEdge, v : Double) -> NetroutebellmanEdge {
  let result = net_route_bellman_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_edge_min(s : NetroutebellmanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_edge_max(s : NetroutebellmanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_edge_to_string(s : NetroutebellmanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_path_make(size : Int) -> NetroutebellmanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_path_len(s : NetroutebellmanPath) -> Int { s.size }

pub fn net_route_bellman_path_get(s : NetroutebellmanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_path_set(s : NetroutebellmanPath, i : Int, v : Double) -> NetroutebellmanPath {
  let result = net_route_bellman_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_path_sum(s : NetroutebellmanPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_path_mean(s : NetroutebellmanPath) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_path_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_path_scale(s : NetroutebellmanPath, f : Double) -> NetroutebellmanPath {
  let result = net_route_bellman_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_path_add(a : NetroutebellmanPath, b : NetroutebellmanPath) -> NetroutebellmanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_path_copy(s : NetroutebellmanPath) -> NetroutebellmanPath {
  let result = net_route_bellman_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_path_fill(s : NetroutebellmanPath, v : Double) -> NetroutebellmanPath {
  let result = net_route_bellman_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_path_min(s : NetroutebellmanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_path_max(s : NetroutebellmanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_path_to_string(s : NetroutebellmanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_cluster_make(size : Int) -> NetroutebellmanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_cluster_len(s : NetroutebellmanCluster) -> Int { s.size }

pub fn net_route_bellman_cluster_get(s : NetroutebellmanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_cluster_set(s : NetroutebellmanCluster, i : Int, v : Double) -> NetroutebellmanCluster {
  let result = net_route_bellman_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_cluster_sum(s : NetroutebellmanCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_cluster_mean(s : NetroutebellmanCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_cluster_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_cluster_scale(s : NetroutebellmanCluster, f : Double) -> NetroutebellmanCluster {
  let result = net_route_bellman_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_cluster_add(a : NetroutebellmanCluster, b : NetroutebellmanCluster) -> NetroutebellmanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_cluster_copy(s : NetroutebellmanCluster) -> NetroutebellmanCluster {
  let result = net_route_bellman_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_cluster_fill(s : NetroutebellmanCluster, v : Double) -> NetroutebellmanCluster {
  let result = net_route_bellman_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_cluster_min(s : NetroutebellmanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_cluster_max(s : NetroutebellmanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_cluster_to_string(s : NetroutebellmanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_model_make(size : Int) -> NetroutebellmanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_model_len(s : NetroutebellmanModel) -> Int { s.size }

pub fn net_route_bellman_model_get(s : NetroutebellmanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_model_set(s : NetroutebellmanModel, i : Int, v : Double) -> NetroutebellmanModel {
  let result = net_route_bellman_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_model_sum(s : NetroutebellmanModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_model_mean(s : NetroutebellmanModel) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_model_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_model_scale(s : NetroutebellmanModel, f : Double) -> NetroutebellmanModel {
  let result = net_route_bellman_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_model_add(a : NetroutebellmanModel, b : NetroutebellmanModel) -> NetroutebellmanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_model_copy(s : NetroutebellmanModel) -> NetroutebellmanModel {
  let result = net_route_bellman_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_model_fill(s : NetroutebellmanModel, v : Double) -> NetroutebellmanModel {
  let result = net_route_bellman_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_model_min(s : NetroutebellmanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_model_max(s : NetroutebellmanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_model_to_string(s : NetroutebellmanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_layer_make(size : Int) -> NetroutebellmanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_layer_len(s : NetroutebellmanLayer) -> Int { s.size }

pub fn net_route_bellman_layer_get(s : NetroutebellmanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_layer_set(s : NetroutebellmanLayer, i : Int, v : Double) -> NetroutebellmanLayer {
  let result = net_route_bellman_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_layer_sum(s : NetroutebellmanLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_layer_mean(s : NetroutebellmanLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_layer_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_layer_scale(s : NetroutebellmanLayer, f : Double) -> NetroutebellmanLayer {
  let result = net_route_bellman_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_layer_add(a : NetroutebellmanLayer, b : NetroutebellmanLayer) -> NetroutebellmanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_layer_copy(s : NetroutebellmanLayer) -> NetroutebellmanLayer {
  let result = net_route_bellman_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_layer_fill(s : NetroutebellmanLayer, v : Double) -> NetroutebellmanLayer {
  let result = net_route_bellman_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_layer_min(s : NetroutebellmanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_layer_max(s : NetroutebellmanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_layer_to_string(s : NetroutebellmanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_buffer_make(size : Int) -> NetroutebellmanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_buffer_len(s : NetroutebellmanBuffer) -> Int { s.size }

pub fn net_route_bellman_buffer_get(s : NetroutebellmanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_buffer_set(s : NetroutebellmanBuffer, i : Int, v : Double) -> NetroutebellmanBuffer {
  let result = net_route_bellman_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_buffer_sum(s : NetroutebellmanBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_buffer_mean(s : NetroutebellmanBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_buffer_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_buffer_scale(s : NetroutebellmanBuffer, f : Double) -> NetroutebellmanBuffer {
  let result = net_route_bellman_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_buffer_add(a : NetroutebellmanBuffer, b : NetroutebellmanBuffer) -> NetroutebellmanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_buffer_copy(s : NetroutebellmanBuffer) -> NetroutebellmanBuffer {
  let result = net_route_bellman_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_buffer_fill(s : NetroutebellmanBuffer, v : Double) -> NetroutebellmanBuffer {
  let result = net_route_bellman_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_buffer_min(s : NetroutebellmanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_buffer_max(s : NetroutebellmanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_buffer_to_string(s : NetroutebellmanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_cursor_make(size : Int) -> NetroutebellmanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_cursor_len(s : NetroutebellmanCursor) -> Int { s.size }

pub fn net_route_bellman_cursor_get(s : NetroutebellmanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_cursor_set(s : NetroutebellmanCursor, i : Int, v : Double) -> NetroutebellmanCursor {
  let result = net_route_bellman_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_cursor_sum(s : NetroutebellmanCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_cursor_mean(s : NetroutebellmanCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_cursor_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_cursor_scale(s : NetroutebellmanCursor, f : Double) -> NetroutebellmanCursor {
  let result = net_route_bellman_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_cursor_add(a : NetroutebellmanCursor, b : NetroutebellmanCursor) -> NetroutebellmanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_cursor_copy(s : NetroutebellmanCursor) -> NetroutebellmanCursor {
  let result = net_route_bellman_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_cursor_fill(s : NetroutebellmanCursor, v : Double) -> NetroutebellmanCursor {
  let result = net_route_bellman_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_cursor_min(s : NetroutebellmanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_cursor_max(s : NetroutebellmanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_cursor_to_string(s : NetroutebellmanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_view_make(size : Int) -> NetroutebellmanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_view_len(s : NetroutebellmanView) -> Int { s.size }

pub fn net_route_bellman_view_get(s : NetroutebellmanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_view_set(s : NetroutebellmanView, i : Int, v : Double) -> NetroutebellmanView {
  let result = net_route_bellman_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_view_sum(s : NetroutebellmanView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_view_mean(s : NetroutebellmanView) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_view_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_view_scale(s : NetroutebellmanView, f : Double) -> NetroutebellmanView {
  let result = net_route_bellman_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_view_add(a : NetroutebellmanView, b : NetroutebellmanView) -> NetroutebellmanView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_view_copy(s : NetroutebellmanView) -> NetroutebellmanView {
  let result = net_route_bellman_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_view_fill(s : NetroutebellmanView, v : Double) -> NetroutebellmanView {
  let result = net_route_bellman_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_view_min(s : NetroutebellmanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_view_max(s : NetroutebellmanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_view_to_string(s : NetroutebellmanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_range_make(size : Int) -> NetroutebellmanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_range_len(s : NetroutebellmanRange) -> Int { s.size }

pub fn net_route_bellman_range_get(s : NetroutebellmanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_range_set(s : NetroutebellmanRange, i : Int, v : Double) -> NetroutebellmanRange {
  let result = net_route_bellman_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_range_sum(s : NetroutebellmanRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_range_mean(s : NetroutebellmanRange) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_range_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_range_scale(s : NetroutebellmanRange, f : Double) -> NetroutebellmanRange {
  let result = net_route_bellman_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_range_add(a : NetroutebellmanRange, b : NetroutebellmanRange) -> NetroutebellmanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_range_copy(s : NetroutebellmanRange) -> NetroutebellmanRange {
  let result = net_route_bellman_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_range_fill(s : NetroutebellmanRange, v : Double) -> NetroutebellmanRange {
  let result = net_route_bellman_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_range_min(s : NetroutebellmanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_range_max(s : NetroutebellmanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_range_to_string(s : NetroutebellmanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetroutebellmanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_bellman_slice_make(size : Int) -> NetroutebellmanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_bellman_slice_len(s : NetroutebellmanSlice) -> Int { s.size }

pub fn net_route_bellman_slice_get(s : NetroutebellmanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_bellman_slice_set(s : NetroutebellmanSlice, i : Int, v : Double) -> NetroutebellmanSlice {
  let result = net_route_bellman_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_slice_sum(s : NetroutebellmanSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_bellman_slice_mean(s : NetroutebellmanSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_route_bellman_slice_sum(s) / s.size.to_double() }
}

pub fn net_route_bellman_slice_scale(s : NetroutebellmanSlice, f : Double) -> NetroutebellmanSlice {
  let result = net_route_bellman_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_bellman_slice_add(a : NetroutebellmanSlice, b : NetroutebellmanSlice) -> NetroutebellmanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_bellman_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_bellman_slice_copy(s : NetroutebellmanSlice) -> NetroutebellmanSlice {
  let result = net_route_bellman_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_bellman_slice_fill(s : NetroutebellmanSlice, v : Double) -> NetroutebellmanSlice {
  let result = net_route_bellman_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_bellman_slice_min(s : NetroutebellmanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_slice_max(s : NetroutebellmanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_bellman_slice_to_string(s : NetroutebellmanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

