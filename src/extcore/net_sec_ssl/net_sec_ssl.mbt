///===
/// extcore/net_sec_ssl

pub(all) struct NetsecsslPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_sec_ssl_make_point(x : Double, y : Double) -> NetsecsslPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_sec_ssl_make_point3(x : Double, y : Double, z : Double) -> NetsecsslPoint {
  { x, y, z, label: 0 }
}

pub fn net_sec_ssl_point_x(pt : NetsecsslPoint) -> Double { pt.x }

pub fn net_sec_ssl_point_y(pt : NetsecsslPoint) -> Double { pt.y }

pub fn net_sec_ssl_point_z(pt : NetsecsslPoint) -> Double { pt.z }

pub fn net_sec_ssl_point_label(pt : NetsecsslPoint) -> Int { pt.label }

pub fn net_sec_ssl_point_dist(a : NetsecsslPoint, b : NetsecsslPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  net_sec_ssl_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_sec_ssl_point_add(a : NetsecsslPoint, b : NetsecsslPoint) -> NetsecsslPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_sec_ssl_point_sub(a : NetsecsslPoint, b : NetsecsslPoint) -> NetsecsslPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_sec_ssl_point_scale(pt : NetsecsslPoint, s : Double) -> NetsecsslPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_sec_ssl_point_dot(a : NetsecsslPoint, b : NetsecsslPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_sec_ssl_point_cross(a : NetsecsslPoint, b : NetsecsslPoint) -> NetsecsslPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_sec_ssl_point_norm(pt : NetsecsslPoint) -> Double {
  net_sec_ssl_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_sec_ssl_point_normalize(pt : NetsecsslPoint) -> NetsecsslPoint {
  let n = net_sec_ssl_point_norm(pt)
  if n < 0.0000001 { pt } else { net_sec_ssl_point_scale(pt, 1.0 / n) }
}

pub fn net_sec_ssl_point_negate(pt : NetsecsslPoint) -> NetsecsslPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_sec_ssl_point_mid(a : NetsecsslPoint, b : NetsecsslPoint) -> NetsecsslPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_sec_ssl_point_lerp(a : NetsecsslPoint, b : NetsecsslPoint, t : Double) -> NetsecsslPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_sec_ssl_point_to_string(pt : NetsecsslPoint) -> String {
  "(" + net_sec_ssl_dbl(pt.x) + ", " + net_sec_ssl_dbl(pt.y) + ", " + net_sec_ssl_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetsecsslSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_sec_ssl_make_series(vals : Array[Double], name : String) -> NetsecsslSeries {
  { vals, name, meta: 0 }
}

pub fn net_sec_ssl_series_len(s : NetsecsslSeries) -> Int { s.vals.length() }

pub fn net_sec_ssl_series_sum(s : NetsecsslSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_sec_ssl_series_mean(s : NetsecsslSeries) -> Double {
  let n = net_sec_ssl_series_len(s)
  if n == 0 { 0.0 } else { net_sec_ssl_series_sum(s) / n.to_double() }
}

pub fn net_sec_ssl_series_min(s : NetsecsslSeries) -> Double {
  let n = net_sec_ssl_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_sec_ssl_series_max(s : NetsecsslSeries) -> Double {
  let n = net_sec_ssl_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_sec_ssl_series_range(s : NetsecsslSeries) -> Double {
  net_sec_ssl_series_max(s) - net_sec_ssl_series_min(s)
}

pub fn net_sec_ssl_series_var(s : NetsecsslSeries) -> Double {
  let n = net_sec_ssl_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_sec_ssl_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_sec_ssl_series_std(s : NetsecsslSeries) -> Double { net_sec_ssl_sqrt(net_sec_ssl_series_var(s)) }

pub fn net_sec_ssl_series_median(s : NetsecsslSeries) -> Double {
  let n = net_sec_ssl_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_sec_ssl_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_sec_ssl_series_scale(s : NetsecsslSeries, f : Double) -> NetsecsslSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = net_sec_ssl_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_sec_ssl_series_add(a : NetsecsslSeries, b : NetsecsslSeries) -> NetsecsslSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_sec_ssl_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_sec_ssl_series_sub(a : NetsecsslSeries, b : NetsecsslSeries) -> NetsecsslSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_sec_ssl_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_sec_ssl_series_normalize(s : NetsecsslSeries) -> NetsecsslSeries {
  let mn = net_sec_ssl_series_min(s)
  let mx = net_sec_ssl_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = net_sec_ssl_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_sec_ssl_series_cumsum(s : NetsecsslSeries) -> NetsecsslSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = net_sec_ssl_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_sec_ssl_series_to_string(s : NetsecsslSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_sec_ssl_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetsecsslMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_sec_ssl_make_matrix(rows : Int, cols : Int, val : Double) -> NetsecsslMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_sec_ssl_matrix_identity(n : Int) -> NetsecsslMatrix {
  let m = net_sec_ssl_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_sec_ssl_matrix_get(m : NetsecsslMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_sec_ssl_matrix_transpose(m : NetsecsslMatrix) -> NetsecsslMatrix {
  let result = net_sec_ssl_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_sec_ssl_matrix_add(a : NetsecsslMatrix, b : NetsecsslMatrix) -> NetsecsslMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_sec_ssl_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_sec_ssl_matrix_scale(m : NetsecsslMatrix, s : Double) -> NetsecsslMatrix {
  let result = net_sec_ssl_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_sec_ssl_matrix_multiply(a : NetsecsslMatrix, b : NetsecsslMatrix) -> NetsecsslMatrix {
  if a.cols != b.rows { return net_sec_ssl_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_sec_ssl_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_sec_ssl_matrix_trace(m : NetsecsslMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_sec_ssl_matrix_det(m : NetsecsslMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_sec_ssl_matrix_norm(m : NetsecsslMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  net_sec_ssl_sqrt(sum)
}

pub fn net_sec_ssl_matrix_to_string(m : NetsecsslMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + net_sec_ssl_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NetsecsslVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_sec_ssl_make_vector(comps : Array[Double]) -> NetsecsslVector {
  { comps, dim: comps.length() }
}

pub fn net_sec_ssl_vector_zero(dim : Int) -> NetsecsslVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_sec_ssl_vector_add(a : NetsecsslVector, b : NetsecsslVector) -> NetsecsslVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_sec_ssl_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_ssl_vector_sub(a : NetsecsslVector, b : NetsecsslVector) -> NetsecsslVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_sec_ssl_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_sec_ssl_vector_scale(v : NetsecsslVector, s : Double) -> NetsecsslVector {
  let mut result = []
  for i in 0..<v.dim { result = net_sec_ssl_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_sec_ssl_vector_dot(a : NetsecsslVector, b : NetsecsslVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_sec_ssl_vector_norm(v : NetsecsslVector) -> Double { net_sec_ssl_sqrt(net_sec_ssl_vector_dot(v, v)) }

pub fn net_sec_ssl_vector_normalize(v : NetsecsslVector) -> NetsecsslVector {
  let n = net_sec_ssl_vector_norm(v)
  if n < 0.0000001 { v } else { net_sec_ssl_vector_scale(v, 1.0 / n) }
}

pub fn net_sec_ssl_vector_dist(a : NetsecsslVector, b : NetsecsslVector) -> Double {
  net_sec_ssl_vector_norm(net_sec_ssl_vector_sub(a, b))
}

pub fn net_sec_ssl_vector_to_string(v : NetsecsslVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_sec_ssl_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_sec_ssl_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_sec_ssl_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_sec_ssl_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_sec_ssl_std(data : Array[Double]) -> Double { net_sec_ssl_sqrt(net_sec_ssl_var(data)) }

pub fn net_sec_ssl_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_sec_ssl_mean(a); let mb = net_sec_ssl_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_sec_ssl_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_sec_ssl_std(a); let sb = net_sec_ssl_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_sec_ssl_cov(a, b) / (sa * sb) }
}

pub fn net_sec_ssl_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_sec_ssl_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_sec_ssl_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_sec_ssl_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_sec_ssl_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  net_sec_ssl_sqrt(net_sec_ssl_mse(pred, labels))
}

pub fn net_sec_ssl_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + net_sec_ssl_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_sec_ssl_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_sec_ssl_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_sec_ssl_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_sec_ssl_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_sec_ssl_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_sec_ssl_precision(pred, labels, pos); let r = net_sec_ssl_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_sec_ssl_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_sec_ssl_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_sec_ssl_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_sec_ssl_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_sec_ssl_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_sec_ssl_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_sec_ssl_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_sec_ssl_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_sec_ssl_fibonacci(n : Int) -> Int {
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

pub fn net_sec_ssl_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_sec_ssl_min(data); let mx = net_sec_ssl_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_sec_ssl_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_sec_ssl_mean(data); let sd = net_sec_ssl_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_sec_ssl_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_sec_ssl_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_sec_ssl_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_sec_ssl_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_sec_ssl_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_sec_ssl_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn net_sec_ssl_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn net_sec_ssl_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn net_sec_ssl_dbl(x : Double) -> String {
  let i = if x >= 0.0 { net_sec_ssl_int(x) } else { -net_sec_ssl_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { net_sec_ssl_int(f * 1000000.0) } else { net_sec_ssl_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn net_sec_ssl_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn net_sec_ssl_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NetsecsslFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_frame_make(size : Int) -> NetsecsslFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_frame_len(s : NetsecsslFrame) -> Int { s.size }

pub fn net_sec_ssl_frame_get(s : NetsecsslFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_frame_set(s : NetsecsslFrame, i : Int, v : Double) -> NetsecsslFrame {
  let result = net_sec_ssl_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_frame_sum(s : NetsecsslFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_frame_mean(s : NetsecsslFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_frame_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_frame_scale(s : NetsecsslFrame, f : Double) -> NetsecsslFrame {
  let result = net_sec_ssl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_frame_add(a : NetsecsslFrame, b : NetsecsslFrame) -> NetsecsslFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_frame_copy(s : NetsecsslFrame) -> NetsecsslFrame {
  let result = net_sec_ssl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_frame_fill(s : NetsecsslFrame, v : Double) -> NetsecsslFrame {
  let result = net_sec_ssl_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_frame_min(s : NetsecsslFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_frame_max(s : NetsecsslFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_frame_to_string(s : NetsecsslFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_table_make(size : Int) -> NetsecsslTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_table_len(s : NetsecsslTable) -> Int { s.size }

pub fn net_sec_ssl_table_get(s : NetsecsslTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_table_set(s : NetsecsslTable, i : Int, v : Double) -> NetsecsslTable {
  let result = net_sec_ssl_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_table_sum(s : NetsecsslTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_table_mean(s : NetsecsslTable) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_table_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_table_scale(s : NetsecsslTable, f : Double) -> NetsecsslTable {
  let result = net_sec_ssl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_table_add(a : NetsecsslTable, b : NetsecsslTable) -> NetsecsslTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_table_copy(s : NetsecsslTable) -> NetsecsslTable {
  let result = net_sec_ssl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_table_fill(s : NetsecsslTable, v : Double) -> NetsecsslTable {
  let result = net_sec_ssl_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_table_min(s : NetsecsslTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_table_max(s : NetsecsslTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_table_to_string(s : NetsecsslTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_graphn_make(size : Int) -> NetsecsslGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_graphn_len(s : NetsecsslGraphN) -> Int { s.size }

pub fn net_sec_ssl_graphn_get(s : NetsecsslGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_graphn_set(s : NetsecsslGraphN, i : Int, v : Double) -> NetsecsslGraphN {
  let result = net_sec_ssl_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_graphn_sum(s : NetsecsslGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_graphn_mean(s : NetsecsslGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_graphn_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_graphn_scale(s : NetsecsslGraphN, f : Double) -> NetsecsslGraphN {
  let result = net_sec_ssl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_graphn_add(a : NetsecsslGraphN, b : NetsecsslGraphN) -> NetsecsslGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_graphn_copy(s : NetsecsslGraphN) -> NetsecsslGraphN {
  let result = net_sec_ssl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_graphn_fill(s : NetsecsslGraphN, v : Double) -> NetsecsslGraphN {
  let result = net_sec_ssl_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_graphn_min(s : NetsecsslGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_graphn_max(s : NetsecsslGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_graphn_to_string(s : NetsecsslGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_node_make(size : Int) -> NetsecsslNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_node_len(s : NetsecsslNode) -> Int { s.size }

pub fn net_sec_ssl_node_get(s : NetsecsslNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_node_set(s : NetsecsslNode, i : Int, v : Double) -> NetsecsslNode {
  let result = net_sec_ssl_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_node_sum(s : NetsecsslNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_node_mean(s : NetsecsslNode) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_node_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_node_scale(s : NetsecsslNode, f : Double) -> NetsecsslNode {
  let result = net_sec_ssl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_node_add(a : NetsecsslNode, b : NetsecsslNode) -> NetsecsslNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_node_copy(s : NetsecsslNode) -> NetsecsslNode {
  let result = net_sec_ssl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_node_fill(s : NetsecsslNode, v : Double) -> NetsecsslNode {
  let result = net_sec_ssl_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_node_min(s : NetsecsslNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_node_max(s : NetsecsslNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_node_to_string(s : NetsecsslNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_edge_make(size : Int) -> NetsecsslEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_edge_len(s : NetsecsslEdge) -> Int { s.size }

pub fn net_sec_ssl_edge_get(s : NetsecsslEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_edge_set(s : NetsecsslEdge, i : Int, v : Double) -> NetsecsslEdge {
  let result = net_sec_ssl_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_edge_sum(s : NetsecsslEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_edge_mean(s : NetsecsslEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_edge_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_edge_scale(s : NetsecsslEdge, f : Double) -> NetsecsslEdge {
  let result = net_sec_ssl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_edge_add(a : NetsecsslEdge, b : NetsecsslEdge) -> NetsecsslEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_edge_copy(s : NetsecsslEdge) -> NetsecsslEdge {
  let result = net_sec_ssl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_edge_fill(s : NetsecsslEdge, v : Double) -> NetsecsslEdge {
  let result = net_sec_ssl_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_edge_min(s : NetsecsslEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_edge_max(s : NetsecsslEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_edge_to_string(s : NetsecsslEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_path_make(size : Int) -> NetsecsslPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_path_len(s : NetsecsslPath) -> Int { s.size }

pub fn net_sec_ssl_path_get(s : NetsecsslPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_path_set(s : NetsecsslPath, i : Int, v : Double) -> NetsecsslPath {
  let result = net_sec_ssl_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_path_sum(s : NetsecsslPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_path_mean(s : NetsecsslPath) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_path_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_path_scale(s : NetsecsslPath, f : Double) -> NetsecsslPath {
  let result = net_sec_ssl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_path_add(a : NetsecsslPath, b : NetsecsslPath) -> NetsecsslPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_path_copy(s : NetsecsslPath) -> NetsecsslPath {
  let result = net_sec_ssl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_path_fill(s : NetsecsslPath, v : Double) -> NetsecsslPath {
  let result = net_sec_ssl_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_path_min(s : NetsecsslPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_path_max(s : NetsecsslPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_path_to_string(s : NetsecsslPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_cluster_make(size : Int) -> NetsecsslCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_cluster_len(s : NetsecsslCluster) -> Int { s.size }

pub fn net_sec_ssl_cluster_get(s : NetsecsslCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_cluster_set(s : NetsecsslCluster, i : Int, v : Double) -> NetsecsslCluster {
  let result = net_sec_ssl_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_cluster_sum(s : NetsecsslCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_cluster_mean(s : NetsecsslCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_cluster_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_cluster_scale(s : NetsecsslCluster, f : Double) -> NetsecsslCluster {
  let result = net_sec_ssl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_cluster_add(a : NetsecsslCluster, b : NetsecsslCluster) -> NetsecsslCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_cluster_copy(s : NetsecsslCluster) -> NetsecsslCluster {
  let result = net_sec_ssl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_cluster_fill(s : NetsecsslCluster, v : Double) -> NetsecsslCluster {
  let result = net_sec_ssl_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_cluster_min(s : NetsecsslCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_cluster_max(s : NetsecsslCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_cluster_to_string(s : NetsecsslCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_model_make(size : Int) -> NetsecsslModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_model_len(s : NetsecsslModel) -> Int { s.size }

pub fn net_sec_ssl_model_get(s : NetsecsslModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_model_set(s : NetsecsslModel, i : Int, v : Double) -> NetsecsslModel {
  let result = net_sec_ssl_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_model_sum(s : NetsecsslModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_model_mean(s : NetsecsslModel) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_model_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_model_scale(s : NetsecsslModel, f : Double) -> NetsecsslModel {
  let result = net_sec_ssl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_model_add(a : NetsecsslModel, b : NetsecsslModel) -> NetsecsslModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_model_copy(s : NetsecsslModel) -> NetsecsslModel {
  let result = net_sec_ssl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_model_fill(s : NetsecsslModel, v : Double) -> NetsecsslModel {
  let result = net_sec_ssl_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_model_min(s : NetsecsslModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_model_max(s : NetsecsslModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_model_to_string(s : NetsecsslModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_layer_make(size : Int) -> NetsecsslLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_layer_len(s : NetsecsslLayer) -> Int { s.size }

pub fn net_sec_ssl_layer_get(s : NetsecsslLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_layer_set(s : NetsecsslLayer, i : Int, v : Double) -> NetsecsslLayer {
  let result = net_sec_ssl_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_layer_sum(s : NetsecsslLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_layer_mean(s : NetsecsslLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_layer_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_layer_scale(s : NetsecsslLayer, f : Double) -> NetsecsslLayer {
  let result = net_sec_ssl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_layer_add(a : NetsecsslLayer, b : NetsecsslLayer) -> NetsecsslLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_layer_copy(s : NetsecsslLayer) -> NetsecsslLayer {
  let result = net_sec_ssl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_layer_fill(s : NetsecsslLayer, v : Double) -> NetsecsslLayer {
  let result = net_sec_ssl_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_layer_min(s : NetsecsslLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_layer_max(s : NetsecsslLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_layer_to_string(s : NetsecsslLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_buffer_make(size : Int) -> NetsecsslBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_buffer_len(s : NetsecsslBuffer) -> Int { s.size }

pub fn net_sec_ssl_buffer_get(s : NetsecsslBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_buffer_set(s : NetsecsslBuffer, i : Int, v : Double) -> NetsecsslBuffer {
  let result = net_sec_ssl_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_buffer_sum(s : NetsecsslBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_buffer_mean(s : NetsecsslBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_buffer_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_buffer_scale(s : NetsecsslBuffer, f : Double) -> NetsecsslBuffer {
  let result = net_sec_ssl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_buffer_add(a : NetsecsslBuffer, b : NetsecsslBuffer) -> NetsecsslBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_buffer_copy(s : NetsecsslBuffer) -> NetsecsslBuffer {
  let result = net_sec_ssl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_buffer_fill(s : NetsecsslBuffer, v : Double) -> NetsecsslBuffer {
  let result = net_sec_ssl_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_buffer_min(s : NetsecsslBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_buffer_max(s : NetsecsslBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_buffer_to_string(s : NetsecsslBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_cursor_make(size : Int) -> NetsecsslCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_cursor_len(s : NetsecsslCursor) -> Int { s.size }

pub fn net_sec_ssl_cursor_get(s : NetsecsslCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_cursor_set(s : NetsecsslCursor, i : Int, v : Double) -> NetsecsslCursor {
  let result = net_sec_ssl_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_cursor_sum(s : NetsecsslCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_cursor_mean(s : NetsecsslCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_cursor_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_cursor_scale(s : NetsecsslCursor, f : Double) -> NetsecsslCursor {
  let result = net_sec_ssl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_cursor_add(a : NetsecsslCursor, b : NetsecsslCursor) -> NetsecsslCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_cursor_copy(s : NetsecsslCursor) -> NetsecsslCursor {
  let result = net_sec_ssl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_cursor_fill(s : NetsecsslCursor, v : Double) -> NetsecsslCursor {
  let result = net_sec_ssl_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_cursor_min(s : NetsecsslCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_cursor_max(s : NetsecsslCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_cursor_to_string(s : NetsecsslCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_view_make(size : Int) -> NetsecsslView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_view_len(s : NetsecsslView) -> Int { s.size }

pub fn net_sec_ssl_view_get(s : NetsecsslView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_view_set(s : NetsecsslView, i : Int, v : Double) -> NetsecsslView {
  let result = net_sec_ssl_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_view_sum(s : NetsecsslView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_view_mean(s : NetsecsslView) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_view_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_view_scale(s : NetsecsslView, f : Double) -> NetsecsslView {
  let result = net_sec_ssl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_view_add(a : NetsecsslView, b : NetsecsslView) -> NetsecsslView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_view_copy(s : NetsecsslView) -> NetsecsslView {
  let result = net_sec_ssl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_view_fill(s : NetsecsslView, v : Double) -> NetsecsslView {
  let result = net_sec_ssl_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_view_min(s : NetsecsslView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_view_max(s : NetsecsslView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_view_to_string(s : NetsecsslView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_range_make(size : Int) -> NetsecsslRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_range_len(s : NetsecsslRange) -> Int { s.size }

pub fn net_sec_ssl_range_get(s : NetsecsslRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_range_set(s : NetsecsslRange, i : Int, v : Double) -> NetsecsslRange {
  let result = net_sec_ssl_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_range_sum(s : NetsecsslRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_range_mean(s : NetsecsslRange) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_range_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_range_scale(s : NetsecsslRange, f : Double) -> NetsecsslRange {
  let result = net_sec_ssl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_range_add(a : NetsecsslRange, b : NetsecsslRange) -> NetsecsslRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_range_copy(s : NetsecsslRange) -> NetsecsslRange {
  let result = net_sec_ssl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_range_fill(s : NetsecsslRange, v : Double) -> NetsecsslRange {
  let result = net_sec_ssl_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_range_min(s : NetsecsslRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_range_max(s : NetsecsslRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_range_to_string(s : NetsecsslRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetsecsslSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_sec_ssl_slice_make(size : Int) -> NetsecsslSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_sec_ssl_slice_len(s : NetsecsslSlice) -> Int { s.size }

pub fn net_sec_ssl_slice_get(s : NetsecsslSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_sec_ssl_slice_set(s : NetsecsslSlice, i : Int, v : Double) -> NetsecsslSlice {
  let result = net_sec_ssl_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_slice_sum(s : NetsecsslSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_sec_ssl_slice_mean(s : NetsecsslSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_sec_ssl_slice_sum(s) / s.size.to_double() }
}

pub fn net_sec_ssl_slice_scale(s : NetsecsslSlice, f : Double) -> NetsecsslSlice {
  let result = net_sec_ssl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_sec_ssl_slice_add(a : NetsecsslSlice, b : NetsecsslSlice) -> NetsecsslSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_sec_ssl_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_sec_ssl_slice_copy(s : NetsecsslSlice) -> NetsecsslSlice {
  let result = net_sec_ssl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_sec_ssl_slice_fill(s : NetsecsslSlice, v : Double) -> NetsecsslSlice {
  let result = net_sec_ssl_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_sec_ssl_slice_min(s : NetsecsslSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_slice_max(s : NetsecsslSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_sec_ssl_slice_to_string(s : NetsecsslSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn net_sec_ssl_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_sec_ssl_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

