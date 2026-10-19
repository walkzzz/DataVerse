///===
/// extcore/net_proto_http2

pub(all) struct Netprotohttp2Point {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_http2_make_point(x : Double, y : Double) -> Netprotohttp2Point {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_http2_make_point3(x : Double, y : Double, z : Double) -> Netprotohttp2Point {
  { x, y, z, label: 0 }
}

pub fn net_proto_http2_point_x(pt : Netprotohttp2Point) -> Double { pt.x }

pub fn net_proto_http2_point_y(pt : Netprotohttp2Point) -> Double { pt.y }

pub fn net_proto_http2_point_z(pt : Netprotohttp2Point) -> Double { pt.z }

pub fn net_proto_http2_point_label(pt : Netprotohttp2Point) -> Int { pt.label }

pub fn net_proto_http2_point_dist(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  net_proto_http2_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_http2_point_add(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_http2_point_sub(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_http2_point_scale(pt : Netprotohttp2Point, s : Double) -> Netprotohttp2Point {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_http2_point_dot(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_http2_point_cross(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_http2_point_norm(pt : Netprotohttp2Point) -> Double {
  net_proto_http2_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_http2_point_normalize(pt : Netprotohttp2Point) -> Netprotohttp2Point {
  let n = net_proto_http2_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_http2_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_http2_point_negate(pt : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_http2_point_mid(a : Netprotohttp2Point, b : Netprotohttp2Point) -> Netprotohttp2Point {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_http2_point_lerp(a : Netprotohttp2Point, b : Netprotohttp2Point, t : Double) -> Netprotohttp2Point {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_http2_point_to_string(pt : Netprotohttp2Point) -> String {
  "(" + net_proto_http2_dbl(pt.x) + ", " + net_proto_http2_dbl(pt.y) + ", " + net_proto_http2_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Netprotohttp2Series {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_http2_make_series(vals : Array[Double], name : String) -> Netprotohttp2Series {
  { vals, name, meta: 0 }
}

pub fn net_proto_http2_series_len(s : Netprotohttp2Series) -> Int { s.vals.length() }

pub fn net_proto_http2_series_sum(s : Netprotohttp2Series) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_proto_http2_series_mean(s : Netprotohttp2Series) -> Double {
  let n = net_proto_http2_series_len(s)
  if n == 0 { 0.0 } else { net_proto_http2_series_sum(s) / n.to_double() }
}

pub fn net_proto_http2_series_min(s : Netprotohttp2Series) -> Double {
  let n = net_proto_http2_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_proto_http2_series_max(s : Netprotohttp2Series) -> Double {
  let n = net_proto_http2_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_proto_http2_series_range(s : Netprotohttp2Series) -> Double {
  net_proto_http2_series_max(s) - net_proto_http2_series_min(s)
}

pub fn net_proto_http2_series_var(s : Netprotohttp2Series) -> Double {
  let n = net_proto_http2_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_proto_http2_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_proto_http2_series_std(s : Netprotohttp2Series) -> Double { net_proto_http2_sqrt(net_proto_http2_series_var(s)) }

pub fn net_proto_http2_series_median(s : Netprotohttp2Series) -> Double {
  let n = net_proto_http2_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_proto_http2_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_proto_http2_series_scale(s : Netprotohttp2Series, f : Double) -> Netprotohttp2Series {
  let mut result = []
  for i in 0..<s.vals.length() { result = net_proto_http2_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_http2_series_add(a : Netprotohttp2Series, b : Netprotohttp2Series) -> Netprotohttp2Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_proto_http2_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_http2_series_sub(a : Netprotohttp2Series, b : Netprotohttp2Series) -> Netprotohttp2Series {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_proto_http2_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_http2_series_normalize(s : Netprotohttp2Series) -> Netprotohttp2Series {
  let mn = net_proto_http2_series_min(s)
  let mx = net_proto_http2_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = net_proto_http2_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_http2_series_cumsum(s : Netprotohttp2Series) -> Netprotohttp2Series {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = net_proto_http2_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_http2_series_to_string(s : Netprotohttp2Series) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_proto_http2_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Netprotohttp2Matrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_http2_make_matrix(rows : Int, cols : Int, val : Double) -> Netprotohttp2Matrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_http2_matrix_identity(n : Int) -> Netprotohttp2Matrix {
  let m = net_proto_http2_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_http2_matrix_get(m : Netprotohttp2Matrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_http2_matrix_transpose(m : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  let result = net_proto_http2_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_http2_matrix_add(a : Netprotohttp2Matrix, b : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_http2_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_http2_matrix_scale(m : Netprotohttp2Matrix, s : Double) -> Netprotohttp2Matrix {
  let result = net_proto_http2_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_http2_matrix_multiply(a : Netprotohttp2Matrix, b : Netprotohttp2Matrix) -> Netprotohttp2Matrix {
  if a.cols != b.rows { return net_proto_http2_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_http2_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_http2_matrix_trace(m : Netprotohttp2Matrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_http2_matrix_det(m : Netprotohttp2Matrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_http2_matrix_norm(m : Netprotohttp2Matrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  net_proto_http2_sqrt(sum)
}

pub fn net_proto_http2_matrix_to_string(m : Netprotohttp2Matrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + net_proto_http2_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct Netprotohttp2Vector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_http2_make_vector(comps : Array[Double]) -> Netprotohttp2Vector {
  { comps, dim: comps.length() }
}

pub fn net_proto_http2_vector_zero(dim : Int) -> Netprotohttp2Vector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_http2_vector_add(a : Netprotohttp2Vector, b : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_proto_http2_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_http2_vector_sub(a : Netprotohttp2Vector, b : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_proto_http2_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_http2_vector_scale(v : Netprotohttp2Vector, s : Double) -> Netprotohttp2Vector {
  let mut result = []
  for i in 0..<v.dim { result = net_proto_http2_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_http2_vector_dot(a : Netprotohttp2Vector, b : Netprotohttp2Vector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_http2_vector_norm(v : Netprotohttp2Vector) -> Double { net_proto_http2_sqrt(net_proto_http2_vector_dot(v, v)) }

pub fn net_proto_http2_vector_normalize(v : Netprotohttp2Vector) -> Netprotohttp2Vector {
  let n = net_proto_http2_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_http2_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_http2_vector_dist(a : Netprotohttp2Vector, b : Netprotohttp2Vector) -> Double {
  net_proto_http2_vector_norm(net_proto_http2_vector_sub(a, b))
}

pub fn net_proto_http2_vector_to_string(v : Netprotohttp2Vector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_proto_http2_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_http2_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_proto_http2_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_proto_http2_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_proto_http2_std(data : Array[Double]) -> Double { net_proto_http2_sqrt(net_proto_http2_var(data)) }

pub fn net_proto_http2_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_proto_http2_mean(a); let mb = net_proto_http2_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_proto_http2_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_proto_http2_std(a); let sb = net_proto_http2_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_proto_http2_cov(a, b) / (sa * sb) }
}

pub fn net_proto_http2_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_proto_http2_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_proto_http2_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_proto_http2_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_proto_http2_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  net_proto_http2_sqrt(net_proto_http2_mse(pred, labels))
}

pub fn net_proto_http2_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + net_proto_http2_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_proto_http2_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_proto_http2_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_proto_http2_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_proto_http2_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_proto_http2_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_proto_http2_precision(pred, labels, pos); let r = net_proto_http2_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_proto_http2_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_proto_http2_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_proto_http2_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_proto_http2_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_proto_http2_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_proto_http2_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_proto_http2_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_proto_http2_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_proto_http2_fibonacci(n : Int) -> Int {
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

pub fn net_proto_http2_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_proto_http2_min(data); let mx = net_proto_http2_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_proto_http2_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_proto_http2_mean(data); let sd = net_proto_http2_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_proto_http2_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_proto_http2_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_proto_http2_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_proto_http2_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_proto_http2_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_proto_http2_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn net_proto_http2_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn net_proto_http2_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn net_proto_http2_dbl(x : Double) -> String {
  let i = if x >= 0.0 { net_proto_http2_int(x) } else { -net_proto_http2_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { net_proto_http2_int(f * 1000000.0) } else { net_proto_http2_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn net_proto_http2_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn net_proto_http2_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct Netprotohttp2Frame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_frame_make(size : Int) -> Netprotohttp2Frame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_frame_len(s : Netprotohttp2Frame) -> Int { s.size }

pub fn net_proto_http2_frame_get(s : Netprotohttp2Frame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_frame_set(s : Netprotohttp2Frame, i : Int, v : Double) -> Netprotohttp2Frame {
  let result = net_proto_http2_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_frame_sum(s : Netprotohttp2Frame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_frame_mean(s : Netprotohttp2Frame) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_frame_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_frame_scale(s : Netprotohttp2Frame, f : Double) -> Netprotohttp2Frame {
  let result = net_proto_http2_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_frame_add(a : Netprotohttp2Frame, b : Netprotohttp2Frame) -> Netprotohttp2Frame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_frame_copy(s : Netprotohttp2Frame) -> Netprotohttp2Frame {
  let result = net_proto_http2_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_frame_fill(s : Netprotohttp2Frame, v : Double) -> Netprotohttp2Frame {
  let result = net_proto_http2_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_frame_min(s : Netprotohttp2Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_frame_max(s : Netprotohttp2Frame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_frame_to_string(s : Netprotohttp2Frame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Table {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_table_make(size : Int) -> Netprotohttp2Table {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_table_len(s : Netprotohttp2Table) -> Int { s.size }

pub fn net_proto_http2_table_get(s : Netprotohttp2Table, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_table_set(s : Netprotohttp2Table, i : Int, v : Double) -> Netprotohttp2Table {
  let result = net_proto_http2_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_table_sum(s : Netprotohttp2Table) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_table_mean(s : Netprotohttp2Table) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_table_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_table_scale(s : Netprotohttp2Table, f : Double) -> Netprotohttp2Table {
  let result = net_proto_http2_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_table_add(a : Netprotohttp2Table, b : Netprotohttp2Table) -> Netprotohttp2Table {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_table_copy(s : Netprotohttp2Table) -> Netprotohttp2Table {
  let result = net_proto_http2_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_table_fill(s : Netprotohttp2Table, v : Double) -> Netprotohttp2Table {
  let result = net_proto_http2_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_table_min(s : Netprotohttp2Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_table_max(s : Netprotohttp2Table) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_table_to_string(s : Netprotohttp2Table) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2GraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_graphn_make(size : Int) -> Netprotohttp2GraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_graphn_len(s : Netprotohttp2GraphN) -> Int { s.size }

pub fn net_proto_http2_graphn_get(s : Netprotohttp2GraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_graphn_set(s : Netprotohttp2GraphN, i : Int, v : Double) -> Netprotohttp2GraphN {
  let result = net_proto_http2_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_graphn_sum(s : Netprotohttp2GraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_graphn_mean(s : Netprotohttp2GraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_graphn_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_graphn_scale(s : Netprotohttp2GraphN, f : Double) -> Netprotohttp2GraphN {
  let result = net_proto_http2_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_graphn_add(a : Netprotohttp2GraphN, b : Netprotohttp2GraphN) -> Netprotohttp2GraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_graphn_copy(s : Netprotohttp2GraphN) -> Netprotohttp2GraphN {
  let result = net_proto_http2_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_graphn_fill(s : Netprotohttp2GraphN, v : Double) -> Netprotohttp2GraphN {
  let result = net_proto_http2_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_graphn_min(s : Netprotohttp2GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_graphn_max(s : Netprotohttp2GraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_graphn_to_string(s : Netprotohttp2GraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Node {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_node_make(size : Int) -> Netprotohttp2Node {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_node_len(s : Netprotohttp2Node) -> Int { s.size }

pub fn net_proto_http2_node_get(s : Netprotohttp2Node, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_node_set(s : Netprotohttp2Node, i : Int, v : Double) -> Netprotohttp2Node {
  let result = net_proto_http2_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_node_sum(s : Netprotohttp2Node) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_node_mean(s : Netprotohttp2Node) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_node_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_node_scale(s : Netprotohttp2Node, f : Double) -> Netprotohttp2Node {
  let result = net_proto_http2_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_node_add(a : Netprotohttp2Node, b : Netprotohttp2Node) -> Netprotohttp2Node {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_node_copy(s : Netprotohttp2Node) -> Netprotohttp2Node {
  let result = net_proto_http2_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_node_fill(s : Netprotohttp2Node, v : Double) -> Netprotohttp2Node {
  let result = net_proto_http2_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_node_min(s : Netprotohttp2Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_node_max(s : Netprotohttp2Node) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_node_to_string(s : Netprotohttp2Node) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Edge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_edge_make(size : Int) -> Netprotohttp2Edge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_edge_len(s : Netprotohttp2Edge) -> Int { s.size }

pub fn net_proto_http2_edge_get(s : Netprotohttp2Edge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_edge_set(s : Netprotohttp2Edge, i : Int, v : Double) -> Netprotohttp2Edge {
  let result = net_proto_http2_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_edge_sum(s : Netprotohttp2Edge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_edge_mean(s : Netprotohttp2Edge) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_edge_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_edge_scale(s : Netprotohttp2Edge, f : Double) -> Netprotohttp2Edge {
  let result = net_proto_http2_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_edge_add(a : Netprotohttp2Edge, b : Netprotohttp2Edge) -> Netprotohttp2Edge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_edge_copy(s : Netprotohttp2Edge) -> Netprotohttp2Edge {
  let result = net_proto_http2_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_edge_fill(s : Netprotohttp2Edge, v : Double) -> Netprotohttp2Edge {
  let result = net_proto_http2_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_edge_min(s : Netprotohttp2Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_edge_max(s : Netprotohttp2Edge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_edge_to_string(s : Netprotohttp2Edge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Path {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_path_make(size : Int) -> Netprotohttp2Path {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_path_len(s : Netprotohttp2Path) -> Int { s.size }

pub fn net_proto_http2_path_get(s : Netprotohttp2Path, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_path_set(s : Netprotohttp2Path, i : Int, v : Double) -> Netprotohttp2Path {
  let result = net_proto_http2_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_path_sum(s : Netprotohttp2Path) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_path_mean(s : Netprotohttp2Path) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_path_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_path_scale(s : Netprotohttp2Path, f : Double) -> Netprotohttp2Path {
  let result = net_proto_http2_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_path_add(a : Netprotohttp2Path, b : Netprotohttp2Path) -> Netprotohttp2Path {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_path_copy(s : Netprotohttp2Path) -> Netprotohttp2Path {
  let result = net_proto_http2_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_path_fill(s : Netprotohttp2Path, v : Double) -> Netprotohttp2Path {
  let result = net_proto_http2_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_path_min(s : Netprotohttp2Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_path_max(s : Netprotohttp2Path) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_path_to_string(s : Netprotohttp2Path) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Cluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_cluster_make(size : Int) -> Netprotohttp2Cluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_cluster_len(s : Netprotohttp2Cluster) -> Int { s.size }

pub fn net_proto_http2_cluster_get(s : Netprotohttp2Cluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_cluster_set(s : Netprotohttp2Cluster, i : Int, v : Double) -> Netprotohttp2Cluster {
  let result = net_proto_http2_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_cluster_sum(s : Netprotohttp2Cluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_cluster_mean(s : Netprotohttp2Cluster) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_cluster_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_cluster_scale(s : Netprotohttp2Cluster, f : Double) -> Netprotohttp2Cluster {
  let result = net_proto_http2_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_cluster_add(a : Netprotohttp2Cluster, b : Netprotohttp2Cluster) -> Netprotohttp2Cluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_cluster_copy(s : Netprotohttp2Cluster) -> Netprotohttp2Cluster {
  let result = net_proto_http2_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_cluster_fill(s : Netprotohttp2Cluster, v : Double) -> Netprotohttp2Cluster {
  let result = net_proto_http2_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_cluster_min(s : Netprotohttp2Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_cluster_max(s : Netprotohttp2Cluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_cluster_to_string(s : Netprotohttp2Cluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Model {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_model_make(size : Int) -> Netprotohttp2Model {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_model_len(s : Netprotohttp2Model) -> Int { s.size }

pub fn net_proto_http2_model_get(s : Netprotohttp2Model, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_model_set(s : Netprotohttp2Model, i : Int, v : Double) -> Netprotohttp2Model {
  let result = net_proto_http2_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_model_sum(s : Netprotohttp2Model) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_model_mean(s : Netprotohttp2Model) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_model_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_model_scale(s : Netprotohttp2Model, f : Double) -> Netprotohttp2Model {
  let result = net_proto_http2_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_model_add(a : Netprotohttp2Model, b : Netprotohttp2Model) -> Netprotohttp2Model {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_model_copy(s : Netprotohttp2Model) -> Netprotohttp2Model {
  let result = net_proto_http2_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_model_fill(s : Netprotohttp2Model, v : Double) -> Netprotohttp2Model {
  let result = net_proto_http2_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_model_min(s : Netprotohttp2Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_model_max(s : Netprotohttp2Model) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_model_to_string(s : Netprotohttp2Model) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Layer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_layer_make(size : Int) -> Netprotohttp2Layer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_layer_len(s : Netprotohttp2Layer) -> Int { s.size }

pub fn net_proto_http2_layer_get(s : Netprotohttp2Layer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_layer_set(s : Netprotohttp2Layer, i : Int, v : Double) -> Netprotohttp2Layer {
  let result = net_proto_http2_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_layer_sum(s : Netprotohttp2Layer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_layer_mean(s : Netprotohttp2Layer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_layer_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_layer_scale(s : Netprotohttp2Layer, f : Double) -> Netprotohttp2Layer {
  let result = net_proto_http2_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_layer_add(a : Netprotohttp2Layer, b : Netprotohttp2Layer) -> Netprotohttp2Layer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_layer_copy(s : Netprotohttp2Layer) -> Netprotohttp2Layer {
  let result = net_proto_http2_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_layer_fill(s : Netprotohttp2Layer, v : Double) -> Netprotohttp2Layer {
  let result = net_proto_http2_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_layer_min(s : Netprotohttp2Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_layer_max(s : Netprotohttp2Layer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_layer_to_string(s : Netprotohttp2Layer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Buffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_buffer_make(size : Int) -> Netprotohttp2Buffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_buffer_len(s : Netprotohttp2Buffer) -> Int { s.size }

pub fn net_proto_http2_buffer_get(s : Netprotohttp2Buffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_buffer_set(s : Netprotohttp2Buffer, i : Int, v : Double) -> Netprotohttp2Buffer {
  let result = net_proto_http2_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_buffer_sum(s : Netprotohttp2Buffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_buffer_mean(s : Netprotohttp2Buffer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_buffer_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_buffer_scale(s : Netprotohttp2Buffer, f : Double) -> Netprotohttp2Buffer {
  let result = net_proto_http2_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_buffer_add(a : Netprotohttp2Buffer, b : Netprotohttp2Buffer) -> Netprotohttp2Buffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_buffer_copy(s : Netprotohttp2Buffer) -> Netprotohttp2Buffer {
  let result = net_proto_http2_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_buffer_fill(s : Netprotohttp2Buffer, v : Double) -> Netprotohttp2Buffer {
  let result = net_proto_http2_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_buffer_min(s : Netprotohttp2Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_buffer_max(s : Netprotohttp2Buffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_buffer_to_string(s : Netprotohttp2Buffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Cursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_cursor_make(size : Int) -> Netprotohttp2Cursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_cursor_len(s : Netprotohttp2Cursor) -> Int { s.size }

pub fn net_proto_http2_cursor_get(s : Netprotohttp2Cursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_cursor_set(s : Netprotohttp2Cursor, i : Int, v : Double) -> Netprotohttp2Cursor {
  let result = net_proto_http2_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_cursor_sum(s : Netprotohttp2Cursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_cursor_mean(s : Netprotohttp2Cursor) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_cursor_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_cursor_scale(s : Netprotohttp2Cursor, f : Double) -> Netprotohttp2Cursor {
  let result = net_proto_http2_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_cursor_add(a : Netprotohttp2Cursor, b : Netprotohttp2Cursor) -> Netprotohttp2Cursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_cursor_copy(s : Netprotohttp2Cursor) -> Netprotohttp2Cursor {
  let result = net_proto_http2_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_cursor_fill(s : Netprotohttp2Cursor, v : Double) -> Netprotohttp2Cursor {
  let result = net_proto_http2_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_cursor_min(s : Netprotohttp2Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_cursor_max(s : Netprotohttp2Cursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_cursor_to_string(s : Netprotohttp2Cursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2View {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_view_make(size : Int) -> Netprotohttp2View {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_view_len(s : Netprotohttp2View) -> Int { s.size }

pub fn net_proto_http2_view_get(s : Netprotohttp2View, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_view_set(s : Netprotohttp2View, i : Int, v : Double) -> Netprotohttp2View {
  let result = net_proto_http2_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_view_sum(s : Netprotohttp2View) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_view_mean(s : Netprotohttp2View) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_view_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_view_scale(s : Netprotohttp2View, f : Double) -> Netprotohttp2View {
  let result = net_proto_http2_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_view_add(a : Netprotohttp2View, b : Netprotohttp2View) -> Netprotohttp2View {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_view_copy(s : Netprotohttp2View) -> Netprotohttp2View {
  let result = net_proto_http2_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_view_fill(s : Netprotohttp2View, v : Double) -> Netprotohttp2View {
  let result = net_proto_http2_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_view_min(s : Netprotohttp2View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_view_max(s : Netprotohttp2View) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_view_to_string(s : Netprotohttp2View) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Range {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_range_make(size : Int) -> Netprotohttp2Range {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_range_len(s : Netprotohttp2Range) -> Int { s.size }

pub fn net_proto_http2_range_get(s : Netprotohttp2Range, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_range_set(s : Netprotohttp2Range, i : Int, v : Double) -> Netprotohttp2Range {
  let result = net_proto_http2_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_range_sum(s : Netprotohttp2Range) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_range_mean(s : Netprotohttp2Range) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_range_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_range_scale(s : Netprotohttp2Range, f : Double) -> Netprotohttp2Range {
  let result = net_proto_http2_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_range_add(a : Netprotohttp2Range, b : Netprotohttp2Range) -> Netprotohttp2Range {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_range_copy(s : Netprotohttp2Range) -> Netprotohttp2Range {
  let result = net_proto_http2_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_range_fill(s : Netprotohttp2Range, v : Double) -> Netprotohttp2Range {
  let result = net_proto_http2_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_range_min(s : Netprotohttp2Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_range_max(s : Netprotohttp2Range) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_range_to_string(s : Netprotohttp2Range) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Netprotohttp2Slice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_http2_slice_make(size : Int) -> Netprotohttp2Slice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_http2_slice_len(s : Netprotohttp2Slice) -> Int { s.size }

pub fn net_proto_http2_slice_get(s : Netprotohttp2Slice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_http2_slice_set(s : Netprotohttp2Slice, i : Int, v : Double) -> Netprotohttp2Slice {
  let result = net_proto_http2_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_slice_sum(s : Netprotohttp2Slice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_http2_slice_mean(s : Netprotohttp2Slice) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_http2_slice_sum(s) / s.size.to_double() }
}

pub fn net_proto_http2_slice_scale(s : Netprotohttp2Slice, f : Double) -> Netprotohttp2Slice {
  let result = net_proto_http2_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_http2_slice_add(a : Netprotohttp2Slice, b : Netprotohttp2Slice) -> Netprotohttp2Slice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_http2_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_http2_slice_copy(s : Netprotohttp2Slice) -> Netprotohttp2Slice {
  let result = net_proto_http2_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_http2_slice_fill(s : Netprotohttp2Slice, v : Double) -> Netprotohttp2Slice {
  let result = net_proto_http2_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_http2_slice_min(s : Netprotohttp2Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_slice_max(s : Netprotohttp2Slice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_http2_slice_to_string(s : Netprotohttp2Slice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn net_proto_http2_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_http2_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

