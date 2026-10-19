///===
/// extcore/net_flow_rate

pub(all) struct NetflowratePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_flow_rate_make_point(x : Double, y : Double) -> NetflowratePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_flow_rate_make_point3(x : Double, y : Double, z : Double) -> NetflowratePoint {
  { x, y, z, label: 0 }
}

pub fn net_flow_rate_point_x(pt : NetflowratePoint) -> Double { pt.x }

pub fn net_flow_rate_point_y(pt : NetflowratePoint) -> Double { pt.y }

pub fn net_flow_rate_point_z(pt : NetflowratePoint) -> Double { pt.z }

pub fn net_flow_rate_point_label(pt : NetflowratePoint) -> Int { pt.label }

pub fn net_flow_rate_point_dist(a : NetflowratePoint, b : NetflowratePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  net_flow_rate_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_flow_rate_point_add(a : NetflowratePoint, b : NetflowratePoint) -> NetflowratePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_flow_rate_point_sub(a : NetflowratePoint, b : NetflowratePoint) -> NetflowratePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_flow_rate_point_scale(pt : NetflowratePoint, s : Double) -> NetflowratePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_flow_rate_point_dot(a : NetflowratePoint, b : NetflowratePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_flow_rate_point_cross(a : NetflowratePoint, b : NetflowratePoint) -> NetflowratePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_flow_rate_point_norm(pt : NetflowratePoint) -> Double {
  net_flow_rate_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_flow_rate_point_normalize(pt : NetflowratePoint) -> NetflowratePoint {
  let n = net_flow_rate_point_norm(pt)
  if n < 0.0000001 { pt } else { net_flow_rate_point_scale(pt, 1.0 / n) }
}

pub fn net_flow_rate_point_negate(pt : NetflowratePoint) -> NetflowratePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_flow_rate_point_mid(a : NetflowratePoint, b : NetflowratePoint) -> NetflowratePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_flow_rate_point_lerp(a : NetflowratePoint, b : NetflowratePoint, t : Double) -> NetflowratePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_flow_rate_point_to_string(pt : NetflowratePoint) -> String {
  "(" + net_flow_rate_dbl(pt.x) + ", " + net_flow_rate_dbl(pt.y) + ", " + net_flow_rate_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetflowrateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_flow_rate_make_series(vals : Array[Double], name : String) -> NetflowrateSeries {
  { vals, name, meta: 0 }
}

pub fn net_flow_rate_series_len(s : NetflowrateSeries) -> Int { s.vals.length() }

pub fn net_flow_rate_series_sum(s : NetflowrateSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_flow_rate_series_mean(s : NetflowrateSeries) -> Double {
  let n = net_flow_rate_series_len(s)
  if n == 0 { 0.0 } else { net_flow_rate_series_sum(s) / n.to_double() }
}

pub fn net_flow_rate_series_min(s : NetflowrateSeries) -> Double {
  let n = net_flow_rate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_rate_series_max(s : NetflowrateSeries) -> Double {
  let n = net_flow_rate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_flow_rate_series_range(s : NetflowrateSeries) -> Double {
  net_flow_rate_series_max(s) - net_flow_rate_series_min(s)
}

pub fn net_flow_rate_series_var(s : NetflowrateSeries) -> Double {
  let n = net_flow_rate_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_flow_rate_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_flow_rate_series_std(s : NetflowrateSeries) -> Double { net_flow_rate_sqrt(net_flow_rate_series_var(s)) }

pub fn net_flow_rate_series_median(s : NetflowrateSeries) -> Double {
  let n = net_flow_rate_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_flow_rate_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_flow_rate_series_scale(s : NetflowrateSeries, f : Double) -> NetflowrateSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = net_flow_rate_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_flow_rate_series_add(a : NetflowrateSeries, b : NetflowrateSeries) -> NetflowrateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_flow_rate_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_flow_rate_series_sub(a : NetflowrateSeries, b : NetflowrateSeries) -> NetflowrateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_flow_rate_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_flow_rate_series_normalize(s : NetflowrateSeries) -> NetflowrateSeries {
  let mn = net_flow_rate_series_min(s)
  let mx = net_flow_rate_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = net_flow_rate_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_flow_rate_series_cumsum(s : NetflowrateSeries) -> NetflowrateSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = net_flow_rate_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_flow_rate_series_to_string(s : NetflowrateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_flow_rate_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetflowrateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_flow_rate_make_matrix(rows : Int, cols : Int, val : Double) -> NetflowrateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_flow_rate_matrix_identity(n : Int) -> NetflowrateMatrix {
  let m = net_flow_rate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_flow_rate_matrix_get(m : NetflowrateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_flow_rate_matrix_transpose(m : NetflowrateMatrix) -> NetflowrateMatrix {
  let result = net_flow_rate_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_flow_rate_matrix_add(a : NetflowrateMatrix, b : NetflowrateMatrix) -> NetflowrateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_flow_rate_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_flow_rate_matrix_scale(m : NetflowrateMatrix, s : Double) -> NetflowrateMatrix {
  let result = net_flow_rate_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_flow_rate_matrix_multiply(a : NetflowrateMatrix, b : NetflowrateMatrix) -> NetflowrateMatrix {
  if a.cols != b.rows { return net_flow_rate_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_flow_rate_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_flow_rate_matrix_trace(m : NetflowrateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_flow_rate_matrix_det(m : NetflowrateMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_flow_rate_matrix_norm(m : NetflowrateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  net_flow_rate_sqrt(sum)
}

pub fn net_flow_rate_matrix_to_string(m : NetflowrateMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + net_flow_rate_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NetflowrateVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_flow_rate_make_vector(comps : Array[Double]) -> NetflowrateVector {
  { comps, dim: comps.length() }
}

pub fn net_flow_rate_vector_zero(dim : Int) -> NetflowrateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_flow_rate_vector_add(a : NetflowrateVector, b : NetflowrateVector) -> NetflowrateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_flow_rate_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_rate_vector_sub(a : NetflowrateVector, b : NetflowrateVector) -> NetflowrateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_flow_rate_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_flow_rate_vector_scale(v : NetflowrateVector, s : Double) -> NetflowrateVector {
  let mut result = []
  for i in 0..<v.dim { result = net_flow_rate_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_flow_rate_vector_dot(a : NetflowrateVector, b : NetflowrateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_flow_rate_vector_norm(v : NetflowrateVector) -> Double { net_flow_rate_sqrt(net_flow_rate_vector_dot(v, v)) }

pub fn net_flow_rate_vector_normalize(v : NetflowrateVector) -> NetflowrateVector {
  let n = net_flow_rate_vector_norm(v)
  if n < 0.0000001 { v } else { net_flow_rate_vector_scale(v, 1.0 / n) }
}

pub fn net_flow_rate_vector_dist(a : NetflowrateVector, b : NetflowrateVector) -> Double {
  net_flow_rate_vector_norm(net_flow_rate_vector_sub(a, b))
}

pub fn net_flow_rate_vector_to_string(v : NetflowrateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_flow_rate_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_flow_rate_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_flow_rate_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_flow_rate_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_flow_rate_std(data : Array[Double]) -> Double { net_flow_rate_sqrt(net_flow_rate_var(data)) }

pub fn net_flow_rate_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_flow_rate_mean(a); let mb = net_flow_rate_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_flow_rate_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_flow_rate_std(a); let sb = net_flow_rate_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_flow_rate_cov(a, b) / (sa * sb) }
}

pub fn net_flow_rate_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_flow_rate_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_flow_rate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_flow_rate_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_flow_rate_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  net_flow_rate_sqrt(net_flow_rate_mse(pred, labels))
}

pub fn net_flow_rate_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + net_flow_rate_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_flow_rate_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_flow_rate_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_flow_rate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_flow_rate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_flow_rate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_flow_rate_precision(pred, labels, pos); let r = net_flow_rate_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_flow_rate_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_flow_rate_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_flow_rate_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_flow_rate_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_flow_rate_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_flow_rate_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_flow_rate_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_flow_rate_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_flow_rate_fibonacci(n : Int) -> Int {
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

pub fn net_flow_rate_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_flow_rate_min(data); let mx = net_flow_rate_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_flow_rate_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_flow_rate_mean(data); let sd = net_flow_rate_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_flow_rate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_flow_rate_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_flow_rate_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_flow_rate_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_flow_rate_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_flow_rate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn net_flow_rate_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn net_flow_rate_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn net_flow_rate_dbl(x : Double) -> String {
  let i = if x >= 0.0 { net_flow_rate_int(x) } else { -net_flow_rate_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { net_flow_rate_int(f * 1000000.0) } else { net_flow_rate_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn net_flow_rate_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn net_flow_rate_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NetflowrateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_frame_make(size : Int) -> NetflowrateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_frame_len(s : NetflowrateFrame) -> Int { s.size }

pub fn net_flow_rate_frame_get(s : NetflowrateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_frame_set(s : NetflowrateFrame, i : Int, v : Double) -> NetflowrateFrame {
  let result = net_flow_rate_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_frame_sum(s : NetflowrateFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_frame_mean(s : NetflowrateFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_frame_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_frame_scale(s : NetflowrateFrame, f : Double) -> NetflowrateFrame {
  let result = net_flow_rate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_frame_add(a : NetflowrateFrame, b : NetflowrateFrame) -> NetflowrateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_frame_copy(s : NetflowrateFrame) -> NetflowrateFrame {
  let result = net_flow_rate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_frame_fill(s : NetflowrateFrame, v : Double) -> NetflowrateFrame {
  let result = net_flow_rate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_frame_min(s : NetflowrateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_frame_max(s : NetflowrateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_frame_to_string(s : NetflowrateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_table_make(size : Int) -> NetflowrateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_table_len(s : NetflowrateTable) -> Int { s.size }

pub fn net_flow_rate_table_get(s : NetflowrateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_table_set(s : NetflowrateTable, i : Int, v : Double) -> NetflowrateTable {
  let result = net_flow_rate_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_table_sum(s : NetflowrateTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_table_mean(s : NetflowrateTable) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_table_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_table_scale(s : NetflowrateTable, f : Double) -> NetflowrateTable {
  let result = net_flow_rate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_table_add(a : NetflowrateTable, b : NetflowrateTable) -> NetflowrateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_table_copy(s : NetflowrateTable) -> NetflowrateTable {
  let result = net_flow_rate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_table_fill(s : NetflowrateTable, v : Double) -> NetflowrateTable {
  let result = net_flow_rate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_table_min(s : NetflowrateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_table_max(s : NetflowrateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_table_to_string(s : NetflowrateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_graphn_make(size : Int) -> NetflowrateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_graphn_len(s : NetflowrateGraphN) -> Int { s.size }

pub fn net_flow_rate_graphn_get(s : NetflowrateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_graphn_set(s : NetflowrateGraphN, i : Int, v : Double) -> NetflowrateGraphN {
  let result = net_flow_rate_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_graphn_sum(s : NetflowrateGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_graphn_mean(s : NetflowrateGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_graphn_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_graphn_scale(s : NetflowrateGraphN, f : Double) -> NetflowrateGraphN {
  let result = net_flow_rate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_graphn_add(a : NetflowrateGraphN, b : NetflowrateGraphN) -> NetflowrateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_graphn_copy(s : NetflowrateGraphN) -> NetflowrateGraphN {
  let result = net_flow_rate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_graphn_fill(s : NetflowrateGraphN, v : Double) -> NetflowrateGraphN {
  let result = net_flow_rate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_graphn_min(s : NetflowrateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_graphn_max(s : NetflowrateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_graphn_to_string(s : NetflowrateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_node_make(size : Int) -> NetflowrateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_node_len(s : NetflowrateNode) -> Int { s.size }

pub fn net_flow_rate_node_get(s : NetflowrateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_node_set(s : NetflowrateNode, i : Int, v : Double) -> NetflowrateNode {
  let result = net_flow_rate_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_node_sum(s : NetflowrateNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_node_mean(s : NetflowrateNode) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_node_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_node_scale(s : NetflowrateNode, f : Double) -> NetflowrateNode {
  let result = net_flow_rate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_node_add(a : NetflowrateNode, b : NetflowrateNode) -> NetflowrateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_node_copy(s : NetflowrateNode) -> NetflowrateNode {
  let result = net_flow_rate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_node_fill(s : NetflowrateNode, v : Double) -> NetflowrateNode {
  let result = net_flow_rate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_node_min(s : NetflowrateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_node_max(s : NetflowrateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_node_to_string(s : NetflowrateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_edge_make(size : Int) -> NetflowrateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_edge_len(s : NetflowrateEdge) -> Int { s.size }

pub fn net_flow_rate_edge_get(s : NetflowrateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_edge_set(s : NetflowrateEdge, i : Int, v : Double) -> NetflowrateEdge {
  let result = net_flow_rate_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_edge_sum(s : NetflowrateEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_edge_mean(s : NetflowrateEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_edge_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_edge_scale(s : NetflowrateEdge, f : Double) -> NetflowrateEdge {
  let result = net_flow_rate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_edge_add(a : NetflowrateEdge, b : NetflowrateEdge) -> NetflowrateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_edge_copy(s : NetflowrateEdge) -> NetflowrateEdge {
  let result = net_flow_rate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_edge_fill(s : NetflowrateEdge, v : Double) -> NetflowrateEdge {
  let result = net_flow_rate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_edge_min(s : NetflowrateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_edge_max(s : NetflowrateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_edge_to_string(s : NetflowrateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowratePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_path_make(size : Int) -> NetflowratePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_path_len(s : NetflowratePath) -> Int { s.size }

pub fn net_flow_rate_path_get(s : NetflowratePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_path_set(s : NetflowratePath, i : Int, v : Double) -> NetflowratePath {
  let result = net_flow_rate_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_path_sum(s : NetflowratePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_path_mean(s : NetflowratePath) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_path_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_path_scale(s : NetflowratePath, f : Double) -> NetflowratePath {
  let result = net_flow_rate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_path_add(a : NetflowratePath, b : NetflowratePath) -> NetflowratePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_path_copy(s : NetflowratePath) -> NetflowratePath {
  let result = net_flow_rate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_path_fill(s : NetflowratePath, v : Double) -> NetflowratePath {
  let result = net_flow_rate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_path_min(s : NetflowratePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_path_max(s : NetflowratePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_path_to_string(s : NetflowratePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_cluster_make(size : Int) -> NetflowrateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_cluster_len(s : NetflowrateCluster) -> Int { s.size }

pub fn net_flow_rate_cluster_get(s : NetflowrateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_cluster_set(s : NetflowrateCluster, i : Int, v : Double) -> NetflowrateCluster {
  let result = net_flow_rate_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_cluster_sum(s : NetflowrateCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_cluster_mean(s : NetflowrateCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_cluster_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_cluster_scale(s : NetflowrateCluster, f : Double) -> NetflowrateCluster {
  let result = net_flow_rate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_cluster_add(a : NetflowrateCluster, b : NetflowrateCluster) -> NetflowrateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_cluster_copy(s : NetflowrateCluster) -> NetflowrateCluster {
  let result = net_flow_rate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_cluster_fill(s : NetflowrateCluster, v : Double) -> NetflowrateCluster {
  let result = net_flow_rate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_cluster_min(s : NetflowrateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_cluster_max(s : NetflowrateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_cluster_to_string(s : NetflowrateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_model_make(size : Int) -> NetflowrateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_model_len(s : NetflowrateModel) -> Int { s.size }

pub fn net_flow_rate_model_get(s : NetflowrateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_model_set(s : NetflowrateModel, i : Int, v : Double) -> NetflowrateModel {
  let result = net_flow_rate_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_model_sum(s : NetflowrateModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_model_mean(s : NetflowrateModel) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_model_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_model_scale(s : NetflowrateModel, f : Double) -> NetflowrateModel {
  let result = net_flow_rate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_model_add(a : NetflowrateModel, b : NetflowrateModel) -> NetflowrateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_model_copy(s : NetflowrateModel) -> NetflowrateModel {
  let result = net_flow_rate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_model_fill(s : NetflowrateModel, v : Double) -> NetflowrateModel {
  let result = net_flow_rate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_model_min(s : NetflowrateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_model_max(s : NetflowrateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_model_to_string(s : NetflowrateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_layer_make(size : Int) -> NetflowrateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_layer_len(s : NetflowrateLayer) -> Int { s.size }

pub fn net_flow_rate_layer_get(s : NetflowrateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_layer_set(s : NetflowrateLayer, i : Int, v : Double) -> NetflowrateLayer {
  let result = net_flow_rate_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_layer_sum(s : NetflowrateLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_layer_mean(s : NetflowrateLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_layer_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_layer_scale(s : NetflowrateLayer, f : Double) -> NetflowrateLayer {
  let result = net_flow_rate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_layer_add(a : NetflowrateLayer, b : NetflowrateLayer) -> NetflowrateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_layer_copy(s : NetflowrateLayer) -> NetflowrateLayer {
  let result = net_flow_rate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_layer_fill(s : NetflowrateLayer, v : Double) -> NetflowrateLayer {
  let result = net_flow_rate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_layer_min(s : NetflowrateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_layer_max(s : NetflowrateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_layer_to_string(s : NetflowrateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_buffer_make(size : Int) -> NetflowrateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_buffer_len(s : NetflowrateBuffer) -> Int { s.size }

pub fn net_flow_rate_buffer_get(s : NetflowrateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_buffer_set(s : NetflowrateBuffer, i : Int, v : Double) -> NetflowrateBuffer {
  let result = net_flow_rate_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_buffer_sum(s : NetflowrateBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_buffer_mean(s : NetflowrateBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_buffer_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_buffer_scale(s : NetflowrateBuffer, f : Double) -> NetflowrateBuffer {
  let result = net_flow_rate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_buffer_add(a : NetflowrateBuffer, b : NetflowrateBuffer) -> NetflowrateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_buffer_copy(s : NetflowrateBuffer) -> NetflowrateBuffer {
  let result = net_flow_rate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_buffer_fill(s : NetflowrateBuffer, v : Double) -> NetflowrateBuffer {
  let result = net_flow_rate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_buffer_min(s : NetflowrateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_buffer_max(s : NetflowrateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_buffer_to_string(s : NetflowrateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_cursor_make(size : Int) -> NetflowrateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_cursor_len(s : NetflowrateCursor) -> Int { s.size }

pub fn net_flow_rate_cursor_get(s : NetflowrateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_cursor_set(s : NetflowrateCursor, i : Int, v : Double) -> NetflowrateCursor {
  let result = net_flow_rate_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_cursor_sum(s : NetflowrateCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_cursor_mean(s : NetflowrateCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_cursor_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_cursor_scale(s : NetflowrateCursor, f : Double) -> NetflowrateCursor {
  let result = net_flow_rate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_cursor_add(a : NetflowrateCursor, b : NetflowrateCursor) -> NetflowrateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_cursor_copy(s : NetflowrateCursor) -> NetflowrateCursor {
  let result = net_flow_rate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_cursor_fill(s : NetflowrateCursor, v : Double) -> NetflowrateCursor {
  let result = net_flow_rate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_cursor_min(s : NetflowrateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_cursor_max(s : NetflowrateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_cursor_to_string(s : NetflowrateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_view_make(size : Int) -> NetflowrateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_view_len(s : NetflowrateView) -> Int { s.size }

pub fn net_flow_rate_view_get(s : NetflowrateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_view_set(s : NetflowrateView, i : Int, v : Double) -> NetflowrateView {
  let result = net_flow_rate_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_view_sum(s : NetflowrateView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_view_mean(s : NetflowrateView) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_view_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_view_scale(s : NetflowrateView, f : Double) -> NetflowrateView {
  let result = net_flow_rate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_view_add(a : NetflowrateView, b : NetflowrateView) -> NetflowrateView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_view_copy(s : NetflowrateView) -> NetflowrateView {
  let result = net_flow_rate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_view_fill(s : NetflowrateView, v : Double) -> NetflowrateView {
  let result = net_flow_rate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_view_min(s : NetflowrateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_view_max(s : NetflowrateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_view_to_string(s : NetflowrateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_range_make(size : Int) -> NetflowrateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_range_len(s : NetflowrateRange) -> Int { s.size }

pub fn net_flow_rate_range_get(s : NetflowrateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_range_set(s : NetflowrateRange, i : Int, v : Double) -> NetflowrateRange {
  let result = net_flow_rate_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_range_sum(s : NetflowrateRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_range_mean(s : NetflowrateRange) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_range_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_range_scale(s : NetflowrateRange, f : Double) -> NetflowrateRange {
  let result = net_flow_rate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_range_add(a : NetflowrateRange, b : NetflowrateRange) -> NetflowrateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_range_copy(s : NetflowrateRange) -> NetflowrateRange {
  let result = net_flow_rate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_range_fill(s : NetflowrateRange, v : Double) -> NetflowrateRange {
  let result = net_flow_rate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_range_min(s : NetflowrateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_range_max(s : NetflowrateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_range_to_string(s : NetflowrateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetflowrateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_flow_rate_slice_make(size : Int) -> NetflowrateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_flow_rate_slice_len(s : NetflowrateSlice) -> Int { s.size }

pub fn net_flow_rate_slice_get(s : NetflowrateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_flow_rate_slice_set(s : NetflowrateSlice, i : Int, v : Double) -> NetflowrateSlice {
  let result = net_flow_rate_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_slice_sum(s : NetflowrateSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_flow_rate_slice_mean(s : NetflowrateSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_flow_rate_slice_sum(s) / s.size.to_double() }
}

pub fn net_flow_rate_slice_scale(s : NetflowrateSlice, f : Double) -> NetflowrateSlice {
  let result = net_flow_rate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_flow_rate_slice_add(a : NetflowrateSlice, b : NetflowrateSlice) -> NetflowrateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_flow_rate_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_flow_rate_slice_copy(s : NetflowrateSlice) -> NetflowrateSlice {
  let result = net_flow_rate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_flow_rate_slice_fill(s : NetflowrateSlice, v : Double) -> NetflowrateSlice {
  let result = net_flow_rate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_flow_rate_slice_min(s : NetflowrateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_slice_max(s : NetflowrateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_flow_rate_slice_to_string(s : NetflowrateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn net_flow_rate_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_flow_rate_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

