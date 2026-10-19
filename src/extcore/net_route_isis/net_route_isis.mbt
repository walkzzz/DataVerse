///===
/// extcore/net_route_isis

pub(all) struct NetrouteisisPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_route_isis_make_point(x : Double, y : Double) -> NetrouteisisPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_route_isis_make_point3(x : Double, y : Double, z : Double) -> NetrouteisisPoint {
  { x, y, z, label: 0 }
}

pub fn net_route_isis_point_x(pt : NetrouteisisPoint) -> Double { pt.x }

pub fn net_route_isis_point_y(pt : NetrouteisisPoint) -> Double { pt.y }

pub fn net_route_isis_point_z(pt : NetrouteisisPoint) -> Double { pt.z }

pub fn net_route_isis_point_label(pt : NetrouteisisPoint) -> Int { pt.label }

pub fn net_route_isis_point_dist(a : NetrouteisisPoint, b : NetrouteisisPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  net_route_isis_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_route_isis_point_add(a : NetrouteisisPoint, b : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_route_isis_point_sub(a : NetrouteisisPoint, b : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_route_isis_point_scale(pt : NetrouteisisPoint, s : Double) -> NetrouteisisPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_route_isis_point_dot(a : NetrouteisisPoint, b : NetrouteisisPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_route_isis_point_cross(a : NetrouteisisPoint, b : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_route_isis_point_norm(pt : NetrouteisisPoint) -> Double {
  net_route_isis_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_route_isis_point_normalize(pt : NetrouteisisPoint) -> NetrouteisisPoint {
  let n = net_route_isis_point_norm(pt)
  if n < 0.0000001 { pt } else { net_route_isis_point_scale(pt, 1.0 / n) }
}

pub fn net_route_isis_point_negate(pt : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_route_isis_point_mid(a : NetrouteisisPoint, b : NetrouteisisPoint) -> NetrouteisisPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_route_isis_point_lerp(a : NetrouteisisPoint, b : NetrouteisisPoint, t : Double) -> NetrouteisisPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_route_isis_point_to_string(pt : NetrouteisisPoint) -> String {
  "(" + net_route_isis_dbl(pt.x) + ", " + net_route_isis_dbl(pt.y) + ", " + net_route_isis_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetrouteisisSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_route_isis_make_series(vals : Array[Double], name : String) -> NetrouteisisSeries {
  { vals, name, meta: 0 }
}

pub fn net_route_isis_series_len(s : NetrouteisisSeries) -> Int { s.vals.length() }

pub fn net_route_isis_series_sum(s : NetrouteisisSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_route_isis_series_mean(s : NetrouteisisSeries) -> Double {
  let n = net_route_isis_series_len(s)
  if n == 0 { 0.0 } else { net_route_isis_series_sum(s) / n.to_double() }
}

pub fn net_route_isis_series_min(s : NetrouteisisSeries) -> Double {
  let n = net_route_isis_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_route_isis_series_max(s : NetrouteisisSeries) -> Double {
  let n = net_route_isis_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_route_isis_series_range(s : NetrouteisisSeries) -> Double {
  net_route_isis_series_max(s) - net_route_isis_series_min(s)
}

pub fn net_route_isis_series_var(s : NetrouteisisSeries) -> Double {
  let n = net_route_isis_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_route_isis_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_route_isis_series_std(s : NetrouteisisSeries) -> Double { net_route_isis_sqrt(net_route_isis_series_var(s)) }

pub fn net_route_isis_series_median(s : NetrouteisisSeries) -> Double {
  let n = net_route_isis_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_route_isis_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_route_isis_series_scale(s : NetrouteisisSeries, f : Double) -> NetrouteisisSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = net_route_isis_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_route_isis_series_add(a : NetrouteisisSeries, b : NetrouteisisSeries) -> NetrouteisisSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_route_isis_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_route_isis_series_sub(a : NetrouteisisSeries, b : NetrouteisisSeries) -> NetrouteisisSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_route_isis_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_route_isis_series_normalize(s : NetrouteisisSeries) -> NetrouteisisSeries {
  let mn = net_route_isis_series_min(s)
  let mx = net_route_isis_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = net_route_isis_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_route_isis_series_cumsum(s : NetrouteisisSeries) -> NetrouteisisSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = net_route_isis_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_route_isis_series_to_string(s : NetrouteisisSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_route_isis_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetrouteisisMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_route_isis_make_matrix(rows : Int, cols : Int, val : Double) -> NetrouteisisMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_route_isis_matrix_identity(n : Int) -> NetrouteisisMatrix {
  let m = net_route_isis_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_route_isis_matrix_get(m : NetrouteisisMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_route_isis_matrix_transpose(m : NetrouteisisMatrix) -> NetrouteisisMatrix {
  let result = net_route_isis_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_route_isis_matrix_add(a : NetrouteisisMatrix, b : NetrouteisisMatrix) -> NetrouteisisMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_route_isis_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_route_isis_matrix_scale(m : NetrouteisisMatrix, s : Double) -> NetrouteisisMatrix {
  let result = net_route_isis_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_route_isis_matrix_multiply(a : NetrouteisisMatrix, b : NetrouteisisMatrix) -> NetrouteisisMatrix {
  if a.cols != b.rows { return net_route_isis_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_route_isis_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_route_isis_matrix_trace(m : NetrouteisisMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_route_isis_matrix_det(m : NetrouteisisMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_route_isis_matrix_norm(m : NetrouteisisMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  net_route_isis_sqrt(sum)
}

pub fn net_route_isis_matrix_to_string(m : NetrouteisisMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + net_route_isis_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NetrouteisisVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_route_isis_make_vector(comps : Array[Double]) -> NetrouteisisVector {
  { comps, dim: comps.length() }
}

pub fn net_route_isis_vector_zero(dim : Int) -> NetrouteisisVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_route_isis_vector_add(a : NetrouteisisVector, b : NetrouteisisVector) -> NetrouteisisVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_route_isis_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_isis_vector_sub(a : NetrouteisisVector, b : NetrouteisisVector) -> NetrouteisisVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_route_isis_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_route_isis_vector_scale(v : NetrouteisisVector, s : Double) -> NetrouteisisVector {
  let mut result = []
  for i in 0..<v.dim { result = net_route_isis_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_route_isis_vector_dot(a : NetrouteisisVector, b : NetrouteisisVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_route_isis_vector_norm(v : NetrouteisisVector) -> Double { net_route_isis_sqrt(net_route_isis_vector_dot(v, v)) }

pub fn net_route_isis_vector_normalize(v : NetrouteisisVector) -> NetrouteisisVector {
  let n = net_route_isis_vector_norm(v)
  if n < 0.0000001 { v } else { net_route_isis_vector_scale(v, 1.0 / n) }
}

pub fn net_route_isis_vector_dist(a : NetrouteisisVector, b : NetrouteisisVector) -> Double {
  net_route_isis_vector_norm(net_route_isis_vector_sub(a, b))
}

pub fn net_route_isis_vector_to_string(v : NetrouteisisVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_route_isis_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_route_isis_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_route_isis_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_route_isis_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_route_isis_std(data : Array[Double]) -> Double { net_route_isis_sqrt(net_route_isis_var(data)) }

pub fn net_route_isis_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_route_isis_mean(a); let mb = net_route_isis_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_route_isis_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_route_isis_std(a); let sb = net_route_isis_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_route_isis_cov(a, b) / (sa * sb) }
}

pub fn net_route_isis_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_route_isis_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_route_isis_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_route_isis_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_route_isis_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  net_route_isis_sqrt(net_route_isis_mse(pred, labels))
}

pub fn net_route_isis_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + net_route_isis_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_route_isis_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_route_isis_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_route_isis_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_route_isis_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_route_isis_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_route_isis_precision(pred, labels, pos); let r = net_route_isis_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_route_isis_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_route_isis_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_route_isis_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_route_isis_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_route_isis_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_route_isis_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_route_isis_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_route_isis_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_route_isis_fibonacci(n : Int) -> Int {
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

pub fn net_route_isis_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_route_isis_min(data); let mx = net_route_isis_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_route_isis_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_route_isis_mean(data); let sd = net_route_isis_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_route_isis_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_route_isis_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_route_isis_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_route_isis_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_route_isis_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_route_isis_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn net_route_isis_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn net_route_isis_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn net_route_isis_dbl(x : Double) -> String {
  let i = if x >= 0.0 { net_route_isis_int(x) } else { -net_route_isis_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { net_route_isis_int(f * 1000000.0) } else { net_route_isis_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn net_route_isis_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn net_route_isis_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NetrouteisisFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_frame_make(size : Int) -> NetrouteisisFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_frame_len(s : NetrouteisisFrame) -> Int { s.size }

pub fn net_route_isis_frame_get(s : NetrouteisisFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_frame_set(s : NetrouteisisFrame, i : Int, v : Double) -> NetrouteisisFrame {
  let result = net_route_isis_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_frame_sum(s : NetrouteisisFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_frame_mean(s : NetrouteisisFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_frame_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_frame_scale(s : NetrouteisisFrame, f : Double) -> NetrouteisisFrame {
  let result = net_route_isis_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_frame_add(a : NetrouteisisFrame, b : NetrouteisisFrame) -> NetrouteisisFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_frame_copy(s : NetrouteisisFrame) -> NetrouteisisFrame {
  let result = net_route_isis_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_frame_fill(s : NetrouteisisFrame, v : Double) -> NetrouteisisFrame {
  let result = net_route_isis_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_frame_min(s : NetrouteisisFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_frame_max(s : NetrouteisisFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_frame_to_string(s : NetrouteisisFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_table_make(size : Int) -> NetrouteisisTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_table_len(s : NetrouteisisTable) -> Int { s.size }

pub fn net_route_isis_table_get(s : NetrouteisisTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_table_set(s : NetrouteisisTable, i : Int, v : Double) -> NetrouteisisTable {
  let result = net_route_isis_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_table_sum(s : NetrouteisisTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_table_mean(s : NetrouteisisTable) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_table_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_table_scale(s : NetrouteisisTable, f : Double) -> NetrouteisisTable {
  let result = net_route_isis_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_table_add(a : NetrouteisisTable, b : NetrouteisisTable) -> NetrouteisisTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_table_copy(s : NetrouteisisTable) -> NetrouteisisTable {
  let result = net_route_isis_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_table_fill(s : NetrouteisisTable, v : Double) -> NetrouteisisTable {
  let result = net_route_isis_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_table_min(s : NetrouteisisTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_table_max(s : NetrouteisisTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_table_to_string(s : NetrouteisisTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_graphn_make(size : Int) -> NetrouteisisGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_graphn_len(s : NetrouteisisGraphN) -> Int { s.size }

pub fn net_route_isis_graphn_get(s : NetrouteisisGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_graphn_set(s : NetrouteisisGraphN, i : Int, v : Double) -> NetrouteisisGraphN {
  let result = net_route_isis_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_graphn_sum(s : NetrouteisisGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_graphn_mean(s : NetrouteisisGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_graphn_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_graphn_scale(s : NetrouteisisGraphN, f : Double) -> NetrouteisisGraphN {
  let result = net_route_isis_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_graphn_add(a : NetrouteisisGraphN, b : NetrouteisisGraphN) -> NetrouteisisGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_graphn_copy(s : NetrouteisisGraphN) -> NetrouteisisGraphN {
  let result = net_route_isis_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_graphn_fill(s : NetrouteisisGraphN, v : Double) -> NetrouteisisGraphN {
  let result = net_route_isis_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_graphn_min(s : NetrouteisisGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_graphn_max(s : NetrouteisisGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_graphn_to_string(s : NetrouteisisGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_node_make(size : Int) -> NetrouteisisNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_node_len(s : NetrouteisisNode) -> Int { s.size }

pub fn net_route_isis_node_get(s : NetrouteisisNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_node_set(s : NetrouteisisNode, i : Int, v : Double) -> NetrouteisisNode {
  let result = net_route_isis_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_node_sum(s : NetrouteisisNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_node_mean(s : NetrouteisisNode) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_node_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_node_scale(s : NetrouteisisNode, f : Double) -> NetrouteisisNode {
  let result = net_route_isis_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_node_add(a : NetrouteisisNode, b : NetrouteisisNode) -> NetrouteisisNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_node_copy(s : NetrouteisisNode) -> NetrouteisisNode {
  let result = net_route_isis_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_node_fill(s : NetrouteisisNode, v : Double) -> NetrouteisisNode {
  let result = net_route_isis_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_node_min(s : NetrouteisisNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_node_max(s : NetrouteisisNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_node_to_string(s : NetrouteisisNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_edge_make(size : Int) -> NetrouteisisEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_edge_len(s : NetrouteisisEdge) -> Int { s.size }

pub fn net_route_isis_edge_get(s : NetrouteisisEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_edge_set(s : NetrouteisisEdge, i : Int, v : Double) -> NetrouteisisEdge {
  let result = net_route_isis_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_edge_sum(s : NetrouteisisEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_edge_mean(s : NetrouteisisEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_edge_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_edge_scale(s : NetrouteisisEdge, f : Double) -> NetrouteisisEdge {
  let result = net_route_isis_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_edge_add(a : NetrouteisisEdge, b : NetrouteisisEdge) -> NetrouteisisEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_edge_copy(s : NetrouteisisEdge) -> NetrouteisisEdge {
  let result = net_route_isis_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_edge_fill(s : NetrouteisisEdge, v : Double) -> NetrouteisisEdge {
  let result = net_route_isis_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_edge_min(s : NetrouteisisEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_edge_max(s : NetrouteisisEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_edge_to_string(s : NetrouteisisEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_path_make(size : Int) -> NetrouteisisPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_path_len(s : NetrouteisisPath) -> Int { s.size }

pub fn net_route_isis_path_get(s : NetrouteisisPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_path_set(s : NetrouteisisPath, i : Int, v : Double) -> NetrouteisisPath {
  let result = net_route_isis_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_path_sum(s : NetrouteisisPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_path_mean(s : NetrouteisisPath) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_path_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_path_scale(s : NetrouteisisPath, f : Double) -> NetrouteisisPath {
  let result = net_route_isis_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_path_add(a : NetrouteisisPath, b : NetrouteisisPath) -> NetrouteisisPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_path_copy(s : NetrouteisisPath) -> NetrouteisisPath {
  let result = net_route_isis_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_path_fill(s : NetrouteisisPath, v : Double) -> NetrouteisisPath {
  let result = net_route_isis_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_path_min(s : NetrouteisisPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_path_max(s : NetrouteisisPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_path_to_string(s : NetrouteisisPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_cluster_make(size : Int) -> NetrouteisisCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_cluster_len(s : NetrouteisisCluster) -> Int { s.size }

pub fn net_route_isis_cluster_get(s : NetrouteisisCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_cluster_set(s : NetrouteisisCluster, i : Int, v : Double) -> NetrouteisisCluster {
  let result = net_route_isis_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_cluster_sum(s : NetrouteisisCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_cluster_mean(s : NetrouteisisCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_cluster_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_cluster_scale(s : NetrouteisisCluster, f : Double) -> NetrouteisisCluster {
  let result = net_route_isis_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_cluster_add(a : NetrouteisisCluster, b : NetrouteisisCluster) -> NetrouteisisCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_cluster_copy(s : NetrouteisisCluster) -> NetrouteisisCluster {
  let result = net_route_isis_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_cluster_fill(s : NetrouteisisCluster, v : Double) -> NetrouteisisCluster {
  let result = net_route_isis_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_cluster_min(s : NetrouteisisCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_cluster_max(s : NetrouteisisCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_cluster_to_string(s : NetrouteisisCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_model_make(size : Int) -> NetrouteisisModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_model_len(s : NetrouteisisModel) -> Int { s.size }

pub fn net_route_isis_model_get(s : NetrouteisisModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_model_set(s : NetrouteisisModel, i : Int, v : Double) -> NetrouteisisModel {
  let result = net_route_isis_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_model_sum(s : NetrouteisisModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_model_mean(s : NetrouteisisModel) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_model_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_model_scale(s : NetrouteisisModel, f : Double) -> NetrouteisisModel {
  let result = net_route_isis_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_model_add(a : NetrouteisisModel, b : NetrouteisisModel) -> NetrouteisisModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_model_copy(s : NetrouteisisModel) -> NetrouteisisModel {
  let result = net_route_isis_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_model_fill(s : NetrouteisisModel, v : Double) -> NetrouteisisModel {
  let result = net_route_isis_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_model_min(s : NetrouteisisModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_model_max(s : NetrouteisisModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_model_to_string(s : NetrouteisisModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_layer_make(size : Int) -> NetrouteisisLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_layer_len(s : NetrouteisisLayer) -> Int { s.size }

pub fn net_route_isis_layer_get(s : NetrouteisisLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_layer_set(s : NetrouteisisLayer, i : Int, v : Double) -> NetrouteisisLayer {
  let result = net_route_isis_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_layer_sum(s : NetrouteisisLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_layer_mean(s : NetrouteisisLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_layer_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_layer_scale(s : NetrouteisisLayer, f : Double) -> NetrouteisisLayer {
  let result = net_route_isis_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_layer_add(a : NetrouteisisLayer, b : NetrouteisisLayer) -> NetrouteisisLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_layer_copy(s : NetrouteisisLayer) -> NetrouteisisLayer {
  let result = net_route_isis_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_layer_fill(s : NetrouteisisLayer, v : Double) -> NetrouteisisLayer {
  let result = net_route_isis_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_layer_min(s : NetrouteisisLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_layer_max(s : NetrouteisisLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_layer_to_string(s : NetrouteisisLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_buffer_make(size : Int) -> NetrouteisisBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_buffer_len(s : NetrouteisisBuffer) -> Int { s.size }

pub fn net_route_isis_buffer_get(s : NetrouteisisBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_buffer_set(s : NetrouteisisBuffer, i : Int, v : Double) -> NetrouteisisBuffer {
  let result = net_route_isis_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_buffer_sum(s : NetrouteisisBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_buffer_mean(s : NetrouteisisBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_buffer_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_buffer_scale(s : NetrouteisisBuffer, f : Double) -> NetrouteisisBuffer {
  let result = net_route_isis_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_buffer_add(a : NetrouteisisBuffer, b : NetrouteisisBuffer) -> NetrouteisisBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_buffer_copy(s : NetrouteisisBuffer) -> NetrouteisisBuffer {
  let result = net_route_isis_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_buffer_fill(s : NetrouteisisBuffer, v : Double) -> NetrouteisisBuffer {
  let result = net_route_isis_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_buffer_min(s : NetrouteisisBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_buffer_max(s : NetrouteisisBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_buffer_to_string(s : NetrouteisisBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_cursor_make(size : Int) -> NetrouteisisCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_cursor_len(s : NetrouteisisCursor) -> Int { s.size }

pub fn net_route_isis_cursor_get(s : NetrouteisisCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_cursor_set(s : NetrouteisisCursor, i : Int, v : Double) -> NetrouteisisCursor {
  let result = net_route_isis_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_cursor_sum(s : NetrouteisisCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_cursor_mean(s : NetrouteisisCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_cursor_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_cursor_scale(s : NetrouteisisCursor, f : Double) -> NetrouteisisCursor {
  let result = net_route_isis_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_cursor_add(a : NetrouteisisCursor, b : NetrouteisisCursor) -> NetrouteisisCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_cursor_copy(s : NetrouteisisCursor) -> NetrouteisisCursor {
  let result = net_route_isis_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_cursor_fill(s : NetrouteisisCursor, v : Double) -> NetrouteisisCursor {
  let result = net_route_isis_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_cursor_min(s : NetrouteisisCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_cursor_max(s : NetrouteisisCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_cursor_to_string(s : NetrouteisisCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_view_make(size : Int) -> NetrouteisisView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_view_len(s : NetrouteisisView) -> Int { s.size }

pub fn net_route_isis_view_get(s : NetrouteisisView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_view_set(s : NetrouteisisView, i : Int, v : Double) -> NetrouteisisView {
  let result = net_route_isis_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_view_sum(s : NetrouteisisView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_view_mean(s : NetrouteisisView) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_view_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_view_scale(s : NetrouteisisView, f : Double) -> NetrouteisisView {
  let result = net_route_isis_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_view_add(a : NetrouteisisView, b : NetrouteisisView) -> NetrouteisisView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_view_copy(s : NetrouteisisView) -> NetrouteisisView {
  let result = net_route_isis_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_view_fill(s : NetrouteisisView, v : Double) -> NetrouteisisView {
  let result = net_route_isis_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_view_min(s : NetrouteisisView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_view_max(s : NetrouteisisView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_view_to_string(s : NetrouteisisView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_range_make(size : Int) -> NetrouteisisRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_range_len(s : NetrouteisisRange) -> Int { s.size }

pub fn net_route_isis_range_get(s : NetrouteisisRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_range_set(s : NetrouteisisRange, i : Int, v : Double) -> NetrouteisisRange {
  let result = net_route_isis_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_range_sum(s : NetrouteisisRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_range_mean(s : NetrouteisisRange) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_range_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_range_scale(s : NetrouteisisRange, f : Double) -> NetrouteisisRange {
  let result = net_route_isis_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_range_add(a : NetrouteisisRange, b : NetrouteisisRange) -> NetrouteisisRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_range_copy(s : NetrouteisisRange) -> NetrouteisisRange {
  let result = net_route_isis_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_range_fill(s : NetrouteisisRange, v : Double) -> NetrouteisisRange {
  let result = net_route_isis_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_range_min(s : NetrouteisisRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_range_max(s : NetrouteisisRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_range_to_string(s : NetrouteisisRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetrouteisisSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_route_isis_slice_make(size : Int) -> NetrouteisisSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_route_isis_slice_len(s : NetrouteisisSlice) -> Int { s.size }

pub fn net_route_isis_slice_get(s : NetrouteisisSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_route_isis_slice_set(s : NetrouteisisSlice, i : Int, v : Double) -> NetrouteisisSlice {
  let result = net_route_isis_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_slice_sum(s : NetrouteisisSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_route_isis_slice_mean(s : NetrouteisisSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_route_isis_slice_sum(s) / s.size.to_double() }
}

pub fn net_route_isis_slice_scale(s : NetrouteisisSlice, f : Double) -> NetrouteisisSlice {
  let result = net_route_isis_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_route_isis_slice_add(a : NetrouteisisSlice, b : NetrouteisisSlice) -> NetrouteisisSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_route_isis_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_route_isis_slice_copy(s : NetrouteisisSlice) -> NetrouteisisSlice {
  let result = net_route_isis_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_route_isis_slice_fill(s : NetrouteisisSlice, v : Double) -> NetrouteisisSlice {
  let result = net_route_isis_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_route_isis_slice_min(s : NetrouteisisSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_slice_max(s : NetrouteisisSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_route_isis_slice_to_string(s : NetrouteisisSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn net_route_isis_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_route_isis_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

