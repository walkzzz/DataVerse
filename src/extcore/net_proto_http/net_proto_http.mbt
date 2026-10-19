///===
/// extcore/net_proto_http

pub(all) struct NetprotohttpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_http_make_point(x : Double, y : Double) -> NetprotohttpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_http_make_point3(x : Double, y : Double, z : Double) -> NetprotohttpPoint {
  { x, y, z, label: 0 }
}

pub fn net_proto_http_point_x(pt : NetprotohttpPoint) -> Double { pt.x }

pub fn net_proto_http_point_y(pt : NetprotohttpPoint) -> Double { pt.y }

pub fn net_proto_http_point_z(pt : NetprotohttpPoint) -> Double { pt.z }

pub fn net_proto_http_point_label(pt : NetprotohttpPoint) -> Int { pt.label }

pub fn net_proto_http_point_dist(a : NetprotohttpPoint, b : NetprotohttpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  net_proto_http_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_http_point_add(a : NetprotohttpPoint, b : NetprotohttpPoint) -> NetprotohttpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_http_point_sub(a : NetprotohttpPoint, b : NetprotohttpPoint) -> NetprotohttpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_http_point_scale(pt : NetprotohttpPoint, s : Double) -> NetprotohttpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_http_point_dot(a : NetprotohttpPoint, b : NetprotohttpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_http_point_cross(a : NetprotohttpPoint, b : NetprotohttpPoint) -> NetprotohttpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_http_point_norm(pt : NetprotohttpPoint) -> Double {
  net_proto_http_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_http_point_normalize(pt : NetprotohttpPoint) -> NetprotohttpPoint {
  let n = net_proto_http_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_http_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_http_point_negate(pt : NetprotohttpPoint) -> NetprotohttpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_http_point_mid(a : NetprotohttpPoint, b : NetprotohttpPoint) -> NetprotohttpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_http_point_lerp(a : NetprotohttpPoint, b : NetprotohttpPoint, t : Double) -> NetprotohttpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_http_point_to_string(pt : NetprotohttpPoint) -> String {
  "(" + net_proto_http_dbl(pt.x) + ", " + net_proto_http_dbl(pt.y) + ", " + net_proto_http_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetprotohttpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_http_make_series(vals : Array[Double], name : String) -> NetprotohttpSeries {
  { vals, name, meta: 0 }
}

pub fn net_proto_http_series_len(s : NetprotohttpSeries) -> Int { s.vals.length() }

pub fn net_proto_http_series_sum(s : NetprotohttpSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_proto_http_series_mean(s : NetprotohttpSeries) -> Double {
  let n = net_proto_http_series_len(s)
  if n == 0 { 0.0 } else { net_proto_http_series_sum(s) / n.to_double() }
}

pub fn net_proto_http_series_min(s : NetprotohttpSeries) -> Double {
  let n = net_proto_http_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_proto_http_series_max(s : NetprotohttpSeries) -> Double {
  let n = net_proto_http_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_proto_http_series_range(s : NetprotohttpSeries) -> Double {
  net_proto_http_series_max(s) - net_proto_http_series_min(s)
}

pub fn net_proto_http_series_var(s : NetprotohttpSeries) -> Double {
  let n = net_proto_http_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_proto_http_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_proto_http_series_std(s : NetprotohttpSeries) -> Double { net_proto_http_sqrt(net_proto_http_series_var(s)) }

pub fn net_proto_http_series_median(s : NetprotohttpSeries) -> Double {
  let n = net_proto_http_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_proto_http_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_proto_http_series_scale(s : NetprotohttpSeries, f : Double) -> NetprotohttpSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = net_proto_http_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_http_series_add(a : NetprotohttpSeries, b : NetprotohttpSeries) -> NetprotohttpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_proto_http_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_http_series_sub(a : NetprotohttpSeries, b : NetprotohttpSeries) -> NetprotohttpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_proto_http_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_http_series_normalize(s : NetprotohttpSeries) -> NetprotohttpSeries {
  let mn = net_proto_http_series_min(s)
  let mx = net_proto_http_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = net_proto_http_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_http_series_cumsum(s : NetprotohttpSeries) -> NetprotohttpSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = net_proto_http_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_http_series_to_string(s : NetprotohttpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_proto_http_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotohttpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_http_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotohttpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_http_matrix_identity(n : Int) -> NetprotohttpMatrix {
  let m = net_proto_http_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_http_matrix_get(m : NetprotohttpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_http_matrix_transpose(m : NetprotohttpMatrix) -> NetprotohttpMatrix {
  let result = net_proto_http_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_http_matrix_add(a : NetprotohttpMatrix, b : NetprotohttpMatrix) -> NetprotohttpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_http_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_http_matrix_scale(m : NetprotohttpMatrix, s : Double) -> NetprotohttpMatrix {
  let result = net_proto_http_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_http_matrix_multiply(a : NetprotohttpMatrix, b : NetprotohttpMatrix) -> NetprotohttpMatrix {
  if a.cols != b.rows { return net_proto_http_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_http_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_http_matrix_trace(m : NetprotohttpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_http_matrix_det(m : NetprotohttpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_http_matrix_norm(m : NetprotohttpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  net_proto_http_sqrt(sum)
}

pub fn net_proto_http_matrix_to_string(m : NetprotohttpMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + net_proto_http_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NetprotohttpVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_http_make_vector(comps : Array[Double]) -> NetprotohttpVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_http_vector_zero(dim : Int) -> NetprotohttpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_http_vector_add(a : NetprotohttpVector, b : NetprotohttpVector) -> NetprotohttpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_proto_http_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_http_vector_sub(a : NetprotohttpVector, b : NetprotohttpVector) -> NetprotohttpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_proto_http_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_http_vector_scale(v : NetprotohttpVector, s : Double) -> NetprotohttpVector {
  let mut result = []
  for i in 0..<v.dim { result = net_proto_http_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_http_vector_dot(a : NetprotohttpVector, b : NetprotohttpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_http_vector_norm(v : NetprotohttpVector) -> Double { net_proto_http_sqrt(net_proto_http_vector_dot(v, v)) }

pub fn net_proto_http_vector_normalize(v : NetprotohttpVector) -> NetprotohttpVector {
  let n = net_proto_http_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_http_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_http_vector_dist(a : NetprotohttpVector, b : NetprotohttpVector) -> Double {
  net_proto_http_vector_norm(net_proto_http_vector_sub(a, b))
}

pub fn net_proto_http_vector_to_string(v : NetprotohttpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_proto_http_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_http_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_proto_http_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_proto_http_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_proto_http_std(data : Array[Double]) -> Double { net_proto_http_sqrt(net_proto_http_var(data)) }

pub fn net_proto_http_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_proto_http_mean(a); let mb = net_proto_http_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_proto_http_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_proto_http_std(a); let sb = net_proto_http_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_proto_http_cov(a, b) / (sa * sb) }
}

pub fn net_proto_http_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_proto_http_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_proto_http_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_proto_http_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_proto_http_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  net_proto_http_sqrt(net_proto_http_mse(pred, labels))
}

pub fn net_proto_http_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + net_proto_http_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_proto_http_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_proto_http_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_proto_http_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_proto_http_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_proto_http_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_proto_http_precision(pred, labels, pos); let r = net_proto_http_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_proto_http_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_proto_http_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_proto_http_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_proto_http_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_proto_http_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_proto_http_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_proto_http_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_proto_http_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_proto_http_fibonacci(n : Int) -> Int {
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

pub fn net_proto_http_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_proto_http_min(data); let mx = net_proto_http_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_proto_http_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_proto_http_mean(data); let sd = net_proto_http_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_proto_http_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_proto_http_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_proto_http_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_proto_http_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_proto_http_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_proto_http_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn net_proto_http_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn net_proto_http_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn net_proto_http_dbl(x : Double) -> String {
  let i = if x >= 0.0 { net_proto_http_int(x) } else { -net_proto_http_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { net_proto_http_int(f * 1000000.0) } else { net_proto_http_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn net_proto_http_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn net_proto_http_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NetprotohttpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_frame_make(size : Int) -> NetprotohttpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_frame_len(s : NetprotohttpFrame) -> Int { s.size }

pub fn net_proto_http_frame_get(s : NetprotohttpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_frame_set(s : NetprotohttpFrame, i : Int, v : Double) -> NetprotohttpFrame {
  let result = net_proto_http_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_frame_sum(s : NetprotohttpFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_frame_mean(s : NetprotohttpFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_frame_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_frame_scale(s : NetprotohttpFrame, f : Double) -> NetprotohttpFrame {
  let result = net_proto_http_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_frame_add(a : NetprotohttpFrame, b : NetprotohttpFrame) -> NetprotohttpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_frame_copy(s : NetprotohttpFrame) -> NetprotohttpFrame {
  let result = net_proto_http_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_frame_fill(s : NetprotohttpFrame, v : Double) -> NetprotohttpFrame {
  let result = net_proto_http_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_frame_min(s : NetprotohttpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_frame_max(s : NetprotohttpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_frame_to_string(s : NetprotohttpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_table_make(size : Int) -> NetprotohttpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_table_len(s : NetprotohttpTable) -> Int { s.size }

pub fn net_proto_http_table_get(s : NetprotohttpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_table_set(s : NetprotohttpTable, i : Int, v : Double) -> NetprotohttpTable {
  let result = net_proto_http_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_table_sum(s : NetprotohttpTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_table_mean(s : NetprotohttpTable) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_table_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_table_scale(s : NetprotohttpTable, f : Double) -> NetprotohttpTable {
  let result = net_proto_http_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_table_add(a : NetprotohttpTable, b : NetprotohttpTable) -> NetprotohttpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_table_copy(s : NetprotohttpTable) -> NetprotohttpTable {
  let result = net_proto_http_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_table_fill(s : NetprotohttpTable, v : Double) -> NetprotohttpTable {
  let result = net_proto_http_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_table_min(s : NetprotohttpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_table_max(s : NetprotohttpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_table_to_string(s : NetprotohttpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_graphn_make(size : Int) -> NetprotohttpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_graphn_len(s : NetprotohttpGraphN) -> Int { s.size }

pub fn net_proto_http_graphn_get(s : NetprotohttpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_graphn_set(s : NetprotohttpGraphN, i : Int, v : Double) -> NetprotohttpGraphN {
  let result = net_proto_http_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_graphn_sum(s : NetprotohttpGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_graphn_mean(s : NetprotohttpGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_graphn_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_graphn_scale(s : NetprotohttpGraphN, f : Double) -> NetprotohttpGraphN {
  let result = net_proto_http_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_graphn_add(a : NetprotohttpGraphN, b : NetprotohttpGraphN) -> NetprotohttpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_graphn_copy(s : NetprotohttpGraphN) -> NetprotohttpGraphN {
  let result = net_proto_http_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_graphn_fill(s : NetprotohttpGraphN, v : Double) -> NetprotohttpGraphN {
  let result = net_proto_http_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_graphn_min(s : NetprotohttpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_graphn_max(s : NetprotohttpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_graphn_to_string(s : NetprotohttpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_node_make(size : Int) -> NetprotohttpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_node_len(s : NetprotohttpNode) -> Int { s.size }

pub fn net_proto_http_node_get(s : NetprotohttpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_node_set(s : NetprotohttpNode, i : Int, v : Double) -> NetprotohttpNode {
  let result = net_proto_http_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_node_sum(s : NetprotohttpNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_node_mean(s : NetprotohttpNode) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_node_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_node_scale(s : NetprotohttpNode, f : Double) -> NetprotohttpNode {
  let result = net_proto_http_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_node_add(a : NetprotohttpNode, b : NetprotohttpNode) -> NetprotohttpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_node_copy(s : NetprotohttpNode) -> NetprotohttpNode {
  let result = net_proto_http_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_node_fill(s : NetprotohttpNode, v : Double) -> NetprotohttpNode {
  let result = net_proto_http_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_node_min(s : NetprotohttpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_node_max(s : NetprotohttpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_node_to_string(s : NetprotohttpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_edge_make(size : Int) -> NetprotohttpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_edge_len(s : NetprotohttpEdge) -> Int { s.size }

pub fn net_proto_http_edge_get(s : NetprotohttpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_edge_set(s : NetprotohttpEdge, i : Int, v : Double) -> NetprotohttpEdge {
  let result = net_proto_http_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_edge_sum(s : NetprotohttpEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_edge_mean(s : NetprotohttpEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_edge_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_edge_scale(s : NetprotohttpEdge, f : Double) -> NetprotohttpEdge {
  let result = net_proto_http_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_edge_add(a : NetprotohttpEdge, b : NetprotohttpEdge) -> NetprotohttpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_edge_copy(s : NetprotohttpEdge) -> NetprotohttpEdge {
  let result = net_proto_http_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_edge_fill(s : NetprotohttpEdge, v : Double) -> NetprotohttpEdge {
  let result = net_proto_http_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_edge_min(s : NetprotohttpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_edge_max(s : NetprotohttpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_edge_to_string(s : NetprotohttpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_path_make(size : Int) -> NetprotohttpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_path_len(s : NetprotohttpPath) -> Int { s.size }

pub fn net_proto_http_path_get(s : NetprotohttpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_path_set(s : NetprotohttpPath, i : Int, v : Double) -> NetprotohttpPath {
  let result = net_proto_http_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_path_sum(s : NetprotohttpPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_path_mean(s : NetprotohttpPath) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_path_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_path_scale(s : NetprotohttpPath, f : Double) -> NetprotohttpPath {
  let result = net_proto_http_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_path_add(a : NetprotohttpPath, b : NetprotohttpPath) -> NetprotohttpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_path_copy(s : NetprotohttpPath) -> NetprotohttpPath {
  let result = net_proto_http_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_path_fill(s : NetprotohttpPath, v : Double) -> NetprotohttpPath {
  let result = net_proto_http_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_path_min(s : NetprotohttpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_path_max(s : NetprotohttpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_path_to_string(s : NetprotohttpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_cluster_make(size : Int) -> NetprotohttpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_cluster_len(s : NetprotohttpCluster) -> Int { s.size }

pub fn net_proto_http_cluster_get(s : NetprotohttpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_cluster_set(s : NetprotohttpCluster, i : Int, v : Double) -> NetprotohttpCluster {
  let result = net_proto_http_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_cluster_sum(s : NetprotohttpCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_cluster_mean(s : NetprotohttpCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_cluster_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_cluster_scale(s : NetprotohttpCluster, f : Double) -> NetprotohttpCluster {
  let result = net_proto_http_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_cluster_add(a : NetprotohttpCluster, b : NetprotohttpCluster) -> NetprotohttpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_cluster_copy(s : NetprotohttpCluster) -> NetprotohttpCluster {
  let result = net_proto_http_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_cluster_fill(s : NetprotohttpCluster, v : Double) -> NetprotohttpCluster {
  let result = net_proto_http_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_cluster_min(s : NetprotohttpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_cluster_max(s : NetprotohttpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_cluster_to_string(s : NetprotohttpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_model_make(size : Int) -> NetprotohttpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_model_len(s : NetprotohttpModel) -> Int { s.size }

pub fn net_proto_http_model_get(s : NetprotohttpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_model_set(s : NetprotohttpModel, i : Int, v : Double) -> NetprotohttpModel {
  let result = net_proto_http_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_model_sum(s : NetprotohttpModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_model_mean(s : NetprotohttpModel) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_model_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_model_scale(s : NetprotohttpModel, f : Double) -> NetprotohttpModel {
  let result = net_proto_http_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_model_add(a : NetprotohttpModel, b : NetprotohttpModel) -> NetprotohttpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_model_copy(s : NetprotohttpModel) -> NetprotohttpModel {
  let result = net_proto_http_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_model_fill(s : NetprotohttpModel, v : Double) -> NetprotohttpModel {
  let result = net_proto_http_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_model_min(s : NetprotohttpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_model_max(s : NetprotohttpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_model_to_string(s : NetprotohttpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_layer_make(size : Int) -> NetprotohttpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_layer_len(s : NetprotohttpLayer) -> Int { s.size }

pub fn net_proto_http_layer_get(s : NetprotohttpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_layer_set(s : NetprotohttpLayer, i : Int, v : Double) -> NetprotohttpLayer {
  let result = net_proto_http_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_layer_sum(s : NetprotohttpLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_layer_mean(s : NetprotohttpLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_layer_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_layer_scale(s : NetprotohttpLayer, f : Double) -> NetprotohttpLayer {
  let result = net_proto_http_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_layer_add(a : NetprotohttpLayer, b : NetprotohttpLayer) -> NetprotohttpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_layer_copy(s : NetprotohttpLayer) -> NetprotohttpLayer {
  let result = net_proto_http_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_layer_fill(s : NetprotohttpLayer, v : Double) -> NetprotohttpLayer {
  let result = net_proto_http_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_layer_min(s : NetprotohttpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_layer_max(s : NetprotohttpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_layer_to_string(s : NetprotohttpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_buffer_make(size : Int) -> NetprotohttpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_buffer_len(s : NetprotohttpBuffer) -> Int { s.size }

pub fn net_proto_http_buffer_get(s : NetprotohttpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_buffer_set(s : NetprotohttpBuffer, i : Int, v : Double) -> NetprotohttpBuffer {
  let result = net_proto_http_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_buffer_sum(s : NetprotohttpBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_buffer_mean(s : NetprotohttpBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_buffer_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_buffer_scale(s : NetprotohttpBuffer, f : Double) -> NetprotohttpBuffer {
  let result = net_proto_http_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_buffer_add(a : NetprotohttpBuffer, b : NetprotohttpBuffer) -> NetprotohttpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_buffer_copy(s : NetprotohttpBuffer) -> NetprotohttpBuffer {
  let result = net_proto_http_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_buffer_fill(s : NetprotohttpBuffer, v : Double) -> NetprotohttpBuffer {
  let result = net_proto_http_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_buffer_min(s : NetprotohttpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_buffer_max(s : NetprotohttpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_buffer_to_string(s : NetprotohttpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_cursor_make(size : Int) -> NetprotohttpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_cursor_len(s : NetprotohttpCursor) -> Int { s.size }

pub fn net_proto_http_cursor_get(s : NetprotohttpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_cursor_set(s : NetprotohttpCursor, i : Int, v : Double) -> NetprotohttpCursor {
  let result = net_proto_http_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_cursor_sum(s : NetprotohttpCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_cursor_mean(s : NetprotohttpCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_cursor_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_cursor_scale(s : NetprotohttpCursor, f : Double) -> NetprotohttpCursor {
  let result = net_proto_http_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_cursor_add(a : NetprotohttpCursor, b : NetprotohttpCursor) -> NetprotohttpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_cursor_copy(s : NetprotohttpCursor) -> NetprotohttpCursor {
  let result = net_proto_http_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_cursor_fill(s : NetprotohttpCursor, v : Double) -> NetprotohttpCursor {
  let result = net_proto_http_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_cursor_min(s : NetprotohttpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_cursor_max(s : NetprotohttpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_cursor_to_string(s : NetprotohttpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_view_make(size : Int) -> NetprotohttpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_view_len(s : NetprotohttpView) -> Int { s.size }

pub fn net_proto_http_view_get(s : NetprotohttpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_view_set(s : NetprotohttpView, i : Int, v : Double) -> NetprotohttpView {
  let result = net_proto_http_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_view_sum(s : NetprotohttpView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_view_mean(s : NetprotohttpView) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_view_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_view_scale(s : NetprotohttpView, f : Double) -> NetprotohttpView {
  let result = net_proto_http_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_view_add(a : NetprotohttpView, b : NetprotohttpView) -> NetprotohttpView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_view_copy(s : NetprotohttpView) -> NetprotohttpView {
  let result = net_proto_http_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_view_fill(s : NetprotohttpView, v : Double) -> NetprotohttpView {
  let result = net_proto_http_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_view_min(s : NetprotohttpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_view_max(s : NetprotohttpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_view_to_string(s : NetprotohttpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_range_make(size : Int) -> NetprotohttpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_range_len(s : NetprotohttpRange) -> Int { s.size }

pub fn net_proto_http_range_get(s : NetprotohttpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_range_set(s : NetprotohttpRange, i : Int, v : Double) -> NetprotohttpRange {
  let result = net_proto_http_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_range_sum(s : NetprotohttpRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_range_mean(s : NetprotohttpRange) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_range_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_range_scale(s : NetprotohttpRange, f : Double) -> NetprotohttpRange {
  let result = net_proto_http_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_range_add(a : NetprotohttpRange, b : NetprotohttpRange) -> NetprotohttpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_range_copy(s : NetprotohttpRange) -> NetprotohttpRange {
  let result = net_proto_http_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_range_fill(s : NetprotohttpRange, v : Double) -> NetprotohttpRange {
  let result = net_proto_http_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_range_min(s : NetprotohttpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_range_max(s : NetprotohttpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_range_to_string(s : NetprotohttpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotohttpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http_slice_make(size : Int) -> NetprotohttpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http_slice_len(s : NetprotohttpSlice) -> Int { s.size }

pub fn net_proto_http_slice_get(s : NetprotohttpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http_slice_set(s : NetprotohttpSlice, i : Int, v : Double) -> NetprotohttpSlice {
  let result = net_proto_http_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_slice_sum(s : NetprotohttpSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http_slice_mean(s : NetprotohttpSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http_slice_sum(s) / s.size.to_double() }
}

pub fn net_proto_http_slice_scale(s : NetprotohttpSlice, f : Double) -> NetprotohttpSlice {
  let result = net_proto_http_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http_slice_add(a : NetprotohttpSlice, b : NetprotohttpSlice) -> NetprotohttpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http_slice_copy(s : NetprotohttpSlice) -> NetprotohttpSlice {
  let result = net_proto_http_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http_slice_fill(s : NetprotohttpSlice, v : Double) -> NetprotohttpSlice {
  let result = net_proto_http_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http_slice_min(s : NetprotohttpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_slice_max(s : NetprotohttpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http_slice_to_string(s : NetprotohttpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn net_proto_http_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

