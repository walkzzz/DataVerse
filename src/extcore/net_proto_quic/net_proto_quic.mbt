///===
/// extcore/net_proto_quic

pub(all) struct NetprotoquicPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_quic_make_point(x : Double, y : Double) -> NetprotoquicPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_quic_make_point3(x : Double, y : Double, z : Double) -> NetprotoquicPoint {
  { x, y, z, label: 0 }
}

pub fn net_proto_quic_point_x(pt : NetprotoquicPoint) -> Double { pt.x }

pub fn net_proto_quic_point_y(pt : NetprotoquicPoint) -> Double { pt.y }

pub fn net_proto_quic_point_z(pt : NetprotoquicPoint) -> Double { pt.z }

pub fn net_proto_quic_point_label(pt : NetprotoquicPoint) -> Int { pt.label }

pub fn net_proto_quic_point_dist(a : NetprotoquicPoint, b : NetprotoquicPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  net_proto_quic_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_quic_point_add(a : NetprotoquicPoint, b : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_quic_point_sub(a : NetprotoquicPoint, b : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_quic_point_scale(pt : NetprotoquicPoint, s : Double) -> NetprotoquicPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_quic_point_dot(a : NetprotoquicPoint, b : NetprotoquicPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_quic_point_cross(a : NetprotoquicPoint, b : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_quic_point_norm(pt : NetprotoquicPoint) -> Double {
  net_proto_quic_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_quic_point_normalize(pt : NetprotoquicPoint) -> NetprotoquicPoint {
  let n = net_proto_quic_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_quic_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_quic_point_negate(pt : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_quic_point_mid(a : NetprotoquicPoint, b : NetprotoquicPoint) -> NetprotoquicPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_quic_point_lerp(a : NetprotoquicPoint, b : NetprotoquicPoint, t : Double) -> NetprotoquicPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_quic_point_to_string(pt : NetprotoquicPoint) -> String {
  "(" + net_proto_quic_dbl(pt.x) + ", " + net_proto_quic_dbl(pt.y) + ", " + net_proto_quic_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetprotoquicSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_quic_make_series(vals : Array[Double], name : String) -> NetprotoquicSeries {
  { vals, name, meta: 0 }
}

pub fn net_proto_quic_series_len(s : NetprotoquicSeries) -> Int { s.vals.length() }

pub fn net_proto_quic_series_sum(s : NetprotoquicSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_proto_quic_series_mean(s : NetprotoquicSeries) -> Double {
  let n = net_proto_quic_series_len(s)
  if n == 0 { 0.0 } else { net_proto_quic_series_sum(s) / n.to_double() }
}

pub fn net_proto_quic_series_min(s : NetprotoquicSeries) -> Double {
  let n = net_proto_quic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_proto_quic_series_max(s : NetprotoquicSeries) -> Double {
  let n = net_proto_quic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_proto_quic_series_range(s : NetprotoquicSeries) -> Double {
  net_proto_quic_series_max(s) - net_proto_quic_series_min(s)
}

pub fn net_proto_quic_series_var(s : NetprotoquicSeries) -> Double {
  let n = net_proto_quic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_proto_quic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_proto_quic_series_std(s : NetprotoquicSeries) -> Double { net_proto_quic_sqrt(net_proto_quic_series_var(s)) }

pub fn net_proto_quic_series_median(s : NetprotoquicSeries) -> Double {
  let n = net_proto_quic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_proto_quic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_proto_quic_series_scale(s : NetprotoquicSeries, f : Double) -> NetprotoquicSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = net_proto_quic_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_quic_series_add(a : NetprotoquicSeries, b : NetprotoquicSeries) -> NetprotoquicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_proto_quic_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_quic_series_sub(a : NetprotoquicSeries, b : NetprotoquicSeries) -> NetprotoquicSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_proto_quic_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_quic_series_normalize(s : NetprotoquicSeries) -> NetprotoquicSeries {
  let mn = net_proto_quic_series_min(s)
  let mx = net_proto_quic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = net_proto_quic_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_quic_series_cumsum(s : NetprotoquicSeries) -> NetprotoquicSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = net_proto_quic_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_quic_series_to_string(s : NetprotoquicSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_proto_quic_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotoquicMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_quic_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotoquicMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_quic_matrix_identity(n : Int) -> NetprotoquicMatrix {
  let m = net_proto_quic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_quic_matrix_get(m : NetprotoquicMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_quic_matrix_transpose(m : NetprotoquicMatrix) -> NetprotoquicMatrix {
  let result = net_proto_quic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_quic_matrix_add(a : NetprotoquicMatrix, b : NetprotoquicMatrix) -> NetprotoquicMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_quic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_quic_matrix_scale(m : NetprotoquicMatrix, s : Double) -> NetprotoquicMatrix {
  let result = net_proto_quic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_quic_matrix_multiply(a : NetprotoquicMatrix, b : NetprotoquicMatrix) -> NetprotoquicMatrix {
  if a.cols != b.rows { return net_proto_quic_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_quic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_quic_matrix_trace(m : NetprotoquicMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_quic_matrix_det(m : NetprotoquicMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_quic_matrix_norm(m : NetprotoquicMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  net_proto_quic_sqrt(sum)
}

pub fn net_proto_quic_matrix_to_string(m : NetprotoquicMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + net_proto_quic_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NetprotoquicVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_quic_make_vector(comps : Array[Double]) -> NetprotoquicVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_quic_vector_zero(dim : Int) -> NetprotoquicVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_quic_vector_add(a : NetprotoquicVector, b : NetprotoquicVector) -> NetprotoquicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_proto_quic_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_quic_vector_sub(a : NetprotoquicVector, b : NetprotoquicVector) -> NetprotoquicVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_proto_quic_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_quic_vector_scale(v : NetprotoquicVector, s : Double) -> NetprotoquicVector {
  let mut result = []
  for i in 0..<v.dim { result = net_proto_quic_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_quic_vector_dot(a : NetprotoquicVector, b : NetprotoquicVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_quic_vector_norm(v : NetprotoquicVector) -> Double { net_proto_quic_sqrt(net_proto_quic_vector_dot(v, v)) }

pub fn net_proto_quic_vector_normalize(v : NetprotoquicVector) -> NetprotoquicVector {
  let n = net_proto_quic_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_quic_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_quic_vector_dist(a : NetprotoquicVector, b : NetprotoquicVector) -> Double {
  net_proto_quic_vector_norm(net_proto_quic_vector_sub(a, b))
}

pub fn net_proto_quic_vector_to_string(v : NetprotoquicVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_proto_quic_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_quic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_proto_quic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_proto_quic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_proto_quic_std(data : Array[Double]) -> Double { net_proto_quic_sqrt(net_proto_quic_var(data)) }

pub fn net_proto_quic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_proto_quic_mean(a); let mb = net_proto_quic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_proto_quic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_proto_quic_std(a); let sb = net_proto_quic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_proto_quic_cov(a, b) / (sa * sb) }
}

pub fn net_proto_quic_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_proto_quic_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_proto_quic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_proto_quic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_proto_quic_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  net_proto_quic_sqrt(net_proto_quic_mse(pred, labels))
}

pub fn net_proto_quic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + net_proto_quic_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_proto_quic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_proto_quic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_proto_quic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_proto_quic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_proto_quic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_proto_quic_precision(pred, labels, pos); let r = net_proto_quic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_proto_quic_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_proto_quic_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_proto_quic_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_proto_quic_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_proto_quic_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_proto_quic_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_proto_quic_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_proto_quic_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_proto_quic_fibonacci(n : Int) -> Int {
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

pub fn net_proto_quic_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_proto_quic_min(data); let mx = net_proto_quic_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_proto_quic_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_proto_quic_mean(data); let sd = net_proto_quic_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_proto_quic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_proto_quic_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_proto_quic_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_proto_quic_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_proto_quic_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_proto_quic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn net_proto_quic_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn net_proto_quic_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn net_proto_quic_dbl(x : Double) -> String {
  let i = if x >= 0.0 { net_proto_quic_int(x) } else { -net_proto_quic_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { net_proto_quic_int(f * 1000000.0) } else { net_proto_quic_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn net_proto_quic_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn net_proto_quic_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NetprotoquicFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_frame_make(size : Int) -> NetprotoquicFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_frame_len(s : NetprotoquicFrame) -> Int { s.size }

pub fn net_proto_quic_frame_get(s : NetprotoquicFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_frame_set(s : NetprotoquicFrame, i : Int, v : Double) -> NetprotoquicFrame {
  let result = net_proto_quic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_frame_sum(s : NetprotoquicFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_frame_mean(s : NetprotoquicFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_frame_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_frame_scale(s : NetprotoquicFrame, f : Double) -> NetprotoquicFrame {
  let result = net_proto_quic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_frame_add(a : NetprotoquicFrame, b : NetprotoquicFrame) -> NetprotoquicFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_frame_copy(s : NetprotoquicFrame) -> NetprotoquicFrame {
  let result = net_proto_quic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_frame_fill(s : NetprotoquicFrame, v : Double) -> NetprotoquicFrame {
  let result = net_proto_quic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_frame_min(s : NetprotoquicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_frame_max(s : NetprotoquicFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_frame_to_string(s : NetprotoquicFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_table_make(size : Int) -> NetprotoquicTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_table_len(s : NetprotoquicTable) -> Int { s.size }

pub fn net_proto_quic_table_get(s : NetprotoquicTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_table_set(s : NetprotoquicTable, i : Int, v : Double) -> NetprotoquicTable {
  let result = net_proto_quic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_table_sum(s : NetprotoquicTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_table_mean(s : NetprotoquicTable) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_table_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_table_scale(s : NetprotoquicTable, f : Double) -> NetprotoquicTable {
  let result = net_proto_quic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_table_add(a : NetprotoquicTable, b : NetprotoquicTable) -> NetprotoquicTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_table_copy(s : NetprotoquicTable) -> NetprotoquicTable {
  let result = net_proto_quic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_table_fill(s : NetprotoquicTable, v : Double) -> NetprotoquicTable {
  let result = net_proto_quic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_table_min(s : NetprotoquicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_table_max(s : NetprotoquicTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_table_to_string(s : NetprotoquicTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_graphn_make(size : Int) -> NetprotoquicGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_graphn_len(s : NetprotoquicGraphN) -> Int { s.size }

pub fn net_proto_quic_graphn_get(s : NetprotoquicGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_graphn_set(s : NetprotoquicGraphN, i : Int, v : Double) -> NetprotoquicGraphN {
  let result = net_proto_quic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_graphn_sum(s : NetprotoquicGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_graphn_mean(s : NetprotoquicGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_graphn_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_graphn_scale(s : NetprotoquicGraphN, f : Double) -> NetprotoquicGraphN {
  let result = net_proto_quic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_graphn_add(a : NetprotoquicGraphN, b : NetprotoquicGraphN) -> NetprotoquicGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_graphn_copy(s : NetprotoquicGraphN) -> NetprotoquicGraphN {
  let result = net_proto_quic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_graphn_fill(s : NetprotoquicGraphN, v : Double) -> NetprotoquicGraphN {
  let result = net_proto_quic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_graphn_min(s : NetprotoquicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_graphn_max(s : NetprotoquicGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_graphn_to_string(s : NetprotoquicGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_node_make(size : Int) -> NetprotoquicNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_node_len(s : NetprotoquicNode) -> Int { s.size }

pub fn net_proto_quic_node_get(s : NetprotoquicNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_node_set(s : NetprotoquicNode, i : Int, v : Double) -> NetprotoquicNode {
  let result = net_proto_quic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_node_sum(s : NetprotoquicNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_node_mean(s : NetprotoquicNode) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_node_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_node_scale(s : NetprotoquicNode, f : Double) -> NetprotoquicNode {
  let result = net_proto_quic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_node_add(a : NetprotoquicNode, b : NetprotoquicNode) -> NetprotoquicNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_node_copy(s : NetprotoquicNode) -> NetprotoquicNode {
  let result = net_proto_quic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_node_fill(s : NetprotoquicNode, v : Double) -> NetprotoquicNode {
  let result = net_proto_quic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_node_min(s : NetprotoquicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_node_max(s : NetprotoquicNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_node_to_string(s : NetprotoquicNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_edge_make(size : Int) -> NetprotoquicEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_edge_len(s : NetprotoquicEdge) -> Int { s.size }

pub fn net_proto_quic_edge_get(s : NetprotoquicEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_edge_set(s : NetprotoquicEdge, i : Int, v : Double) -> NetprotoquicEdge {
  let result = net_proto_quic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_edge_sum(s : NetprotoquicEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_edge_mean(s : NetprotoquicEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_edge_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_edge_scale(s : NetprotoquicEdge, f : Double) -> NetprotoquicEdge {
  let result = net_proto_quic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_edge_add(a : NetprotoquicEdge, b : NetprotoquicEdge) -> NetprotoquicEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_edge_copy(s : NetprotoquicEdge) -> NetprotoquicEdge {
  let result = net_proto_quic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_edge_fill(s : NetprotoquicEdge, v : Double) -> NetprotoquicEdge {
  let result = net_proto_quic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_edge_min(s : NetprotoquicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_edge_max(s : NetprotoquicEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_edge_to_string(s : NetprotoquicEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_path_make(size : Int) -> NetprotoquicPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_path_len(s : NetprotoquicPath) -> Int { s.size }

pub fn net_proto_quic_path_get(s : NetprotoquicPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_path_set(s : NetprotoquicPath, i : Int, v : Double) -> NetprotoquicPath {
  let result = net_proto_quic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_path_sum(s : NetprotoquicPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_path_mean(s : NetprotoquicPath) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_path_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_path_scale(s : NetprotoquicPath, f : Double) -> NetprotoquicPath {
  let result = net_proto_quic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_path_add(a : NetprotoquicPath, b : NetprotoquicPath) -> NetprotoquicPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_path_copy(s : NetprotoquicPath) -> NetprotoquicPath {
  let result = net_proto_quic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_path_fill(s : NetprotoquicPath, v : Double) -> NetprotoquicPath {
  let result = net_proto_quic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_path_min(s : NetprotoquicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_path_max(s : NetprotoquicPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_path_to_string(s : NetprotoquicPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_cluster_make(size : Int) -> NetprotoquicCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_cluster_len(s : NetprotoquicCluster) -> Int { s.size }

pub fn net_proto_quic_cluster_get(s : NetprotoquicCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_cluster_set(s : NetprotoquicCluster, i : Int, v : Double) -> NetprotoquicCluster {
  let result = net_proto_quic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_cluster_sum(s : NetprotoquicCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_cluster_mean(s : NetprotoquicCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_cluster_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_cluster_scale(s : NetprotoquicCluster, f : Double) -> NetprotoquicCluster {
  let result = net_proto_quic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_cluster_add(a : NetprotoquicCluster, b : NetprotoquicCluster) -> NetprotoquicCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_cluster_copy(s : NetprotoquicCluster) -> NetprotoquicCluster {
  let result = net_proto_quic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_cluster_fill(s : NetprotoquicCluster, v : Double) -> NetprotoquicCluster {
  let result = net_proto_quic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_cluster_min(s : NetprotoquicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_cluster_max(s : NetprotoquicCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_cluster_to_string(s : NetprotoquicCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_model_make(size : Int) -> NetprotoquicModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_model_len(s : NetprotoquicModel) -> Int { s.size }

pub fn net_proto_quic_model_get(s : NetprotoquicModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_model_set(s : NetprotoquicModel, i : Int, v : Double) -> NetprotoquicModel {
  let result = net_proto_quic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_model_sum(s : NetprotoquicModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_model_mean(s : NetprotoquicModel) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_model_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_model_scale(s : NetprotoquicModel, f : Double) -> NetprotoquicModel {
  let result = net_proto_quic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_model_add(a : NetprotoquicModel, b : NetprotoquicModel) -> NetprotoquicModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_model_copy(s : NetprotoquicModel) -> NetprotoquicModel {
  let result = net_proto_quic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_model_fill(s : NetprotoquicModel, v : Double) -> NetprotoquicModel {
  let result = net_proto_quic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_model_min(s : NetprotoquicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_model_max(s : NetprotoquicModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_model_to_string(s : NetprotoquicModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_layer_make(size : Int) -> NetprotoquicLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_layer_len(s : NetprotoquicLayer) -> Int { s.size }

pub fn net_proto_quic_layer_get(s : NetprotoquicLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_layer_set(s : NetprotoquicLayer, i : Int, v : Double) -> NetprotoquicLayer {
  let result = net_proto_quic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_layer_sum(s : NetprotoquicLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_layer_mean(s : NetprotoquicLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_layer_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_layer_scale(s : NetprotoquicLayer, f : Double) -> NetprotoquicLayer {
  let result = net_proto_quic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_layer_add(a : NetprotoquicLayer, b : NetprotoquicLayer) -> NetprotoquicLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_layer_copy(s : NetprotoquicLayer) -> NetprotoquicLayer {
  let result = net_proto_quic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_layer_fill(s : NetprotoquicLayer, v : Double) -> NetprotoquicLayer {
  let result = net_proto_quic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_layer_min(s : NetprotoquicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_layer_max(s : NetprotoquicLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_layer_to_string(s : NetprotoquicLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_buffer_make(size : Int) -> NetprotoquicBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_buffer_len(s : NetprotoquicBuffer) -> Int { s.size }

pub fn net_proto_quic_buffer_get(s : NetprotoquicBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_buffer_set(s : NetprotoquicBuffer, i : Int, v : Double) -> NetprotoquicBuffer {
  let result = net_proto_quic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_buffer_sum(s : NetprotoquicBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_buffer_mean(s : NetprotoquicBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_buffer_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_buffer_scale(s : NetprotoquicBuffer, f : Double) -> NetprotoquicBuffer {
  let result = net_proto_quic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_buffer_add(a : NetprotoquicBuffer, b : NetprotoquicBuffer) -> NetprotoquicBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_buffer_copy(s : NetprotoquicBuffer) -> NetprotoquicBuffer {
  let result = net_proto_quic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_buffer_fill(s : NetprotoquicBuffer, v : Double) -> NetprotoquicBuffer {
  let result = net_proto_quic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_buffer_min(s : NetprotoquicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_buffer_max(s : NetprotoquicBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_buffer_to_string(s : NetprotoquicBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_cursor_make(size : Int) -> NetprotoquicCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_cursor_len(s : NetprotoquicCursor) -> Int { s.size }

pub fn net_proto_quic_cursor_get(s : NetprotoquicCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_cursor_set(s : NetprotoquicCursor, i : Int, v : Double) -> NetprotoquicCursor {
  let result = net_proto_quic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_cursor_sum(s : NetprotoquicCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_cursor_mean(s : NetprotoquicCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_cursor_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_cursor_scale(s : NetprotoquicCursor, f : Double) -> NetprotoquicCursor {
  let result = net_proto_quic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_cursor_add(a : NetprotoquicCursor, b : NetprotoquicCursor) -> NetprotoquicCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_cursor_copy(s : NetprotoquicCursor) -> NetprotoquicCursor {
  let result = net_proto_quic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_cursor_fill(s : NetprotoquicCursor, v : Double) -> NetprotoquicCursor {
  let result = net_proto_quic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_cursor_min(s : NetprotoquicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_cursor_max(s : NetprotoquicCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_cursor_to_string(s : NetprotoquicCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_view_make(size : Int) -> NetprotoquicView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_view_len(s : NetprotoquicView) -> Int { s.size }

pub fn net_proto_quic_view_get(s : NetprotoquicView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_view_set(s : NetprotoquicView, i : Int, v : Double) -> NetprotoquicView {
  let result = net_proto_quic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_view_sum(s : NetprotoquicView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_view_mean(s : NetprotoquicView) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_view_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_view_scale(s : NetprotoquicView, f : Double) -> NetprotoquicView {
  let result = net_proto_quic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_view_add(a : NetprotoquicView, b : NetprotoquicView) -> NetprotoquicView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_view_copy(s : NetprotoquicView) -> NetprotoquicView {
  let result = net_proto_quic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_view_fill(s : NetprotoquicView, v : Double) -> NetprotoquicView {
  let result = net_proto_quic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_view_min(s : NetprotoquicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_view_max(s : NetprotoquicView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_view_to_string(s : NetprotoquicView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_range_make(size : Int) -> NetprotoquicRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_range_len(s : NetprotoquicRange) -> Int { s.size }

pub fn net_proto_quic_range_get(s : NetprotoquicRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_range_set(s : NetprotoquicRange, i : Int, v : Double) -> NetprotoquicRange {
  let result = net_proto_quic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_range_sum(s : NetprotoquicRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_range_mean(s : NetprotoquicRange) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_range_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_range_scale(s : NetprotoquicRange, f : Double) -> NetprotoquicRange {
  let result = net_proto_quic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_range_add(a : NetprotoquicRange, b : NetprotoquicRange) -> NetprotoquicRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_range_copy(s : NetprotoquicRange) -> NetprotoquicRange {
  let result = net_proto_quic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_range_fill(s : NetprotoquicRange, v : Double) -> NetprotoquicRange {
  let result = net_proto_quic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_range_min(s : NetprotoquicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_range_max(s : NetprotoquicRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_range_to_string(s : NetprotoquicRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotoquicSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_quic_slice_make(size : Int) -> NetprotoquicSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_quic_slice_len(s : NetprotoquicSlice) -> Int { s.size }

pub fn net_proto_quic_slice_get(s : NetprotoquicSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_quic_slice_set(s : NetprotoquicSlice, i : Int, v : Double) -> NetprotoquicSlice {
  let result = net_proto_quic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_slice_sum(s : NetprotoquicSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_quic_slice_mean(s : NetprotoquicSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_quic_slice_sum(s) / s.size.to_double() }
}

pub fn net_proto_quic_slice_scale(s : NetprotoquicSlice, f : Double) -> NetprotoquicSlice {
  let result = net_proto_quic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_quic_slice_add(a : NetprotoquicSlice, b : NetprotoquicSlice) -> NetprotoquicSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_quic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_quic_slice_copy(s : NetprotoquicSlice) -> NetprotoquicSlice {
  let result = net_proto_quic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_quic_slice_fill(s : NetprotoquicSlice, v : Double) -> NetprotoquicSlice {
  let result = net_proto_quic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_quic_slice_min(s : NetprotoquicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_slice_max(s : NetprotoquicSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_quic_slice_to_string(s : NetprotoquicSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn net_proto_quic_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_quic_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

