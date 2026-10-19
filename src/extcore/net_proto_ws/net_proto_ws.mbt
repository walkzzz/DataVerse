///===
/// extcore/net_proto_ws

pub(all) struct NetprotowsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn net_proto_ws_make_point(x : Double, y : Double) -> NetprotowsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn net_proto_ws_make_point3(x : Double, y : Double, z : Double) -> NetprotowsPoint {
  { x, y, z, label: 0 }
}

pub fn net_proto_ws_point_x(pt : NetprotowsPoint) -> Double { pt.x }

pub fn net_proto_ws_point_y(pt : NetprotowsPoint) -> Double { pt.y }

pub fn net_proto_ws_point_z(pt : NetprotowsPoint) -> Double { pt.z }

pub fn net_proto_ws_point_label(pt : NetprotowsPoint) -> Int { pt.label }

pub fn net_proto_ws_point_dist(a : NetprotowsPoint, b : NetprotowsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  net_proto_ws_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn net_proto_ws_point_add(a : NetprotowsPoint, b : NetprotowsPoint) -> NetprotowsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn net_proto_ws_point_sub(a : NetprotowsPoint, b : NetprotowsPoint) -> NetprotowsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn net_proto_ws_point_scale(pt : NetprotowsPoint, s : Double) -> NetprotowsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn net_proto_ws_point_dot(a : NetprotowsPoint, b : NetprotowsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn net_proto_ws_point_cross(a : NetprotowsPoint, b : NetprotowsPoint) -> NetprotowsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn net_proto_ws_point_norm(pt : NetprotowsPoint) -> Double {
  net_proto_ws_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn net_proto_ws_point_normalize(pt : NetprotowsPoint) -> NetprotowsPoint {
  let n = net_proto_ws_point_norm(pt)
  if n < 0.0000001 { pt } else { net_proto_ws_point_scale(pt, 1.0 / n) }
}

pub fn net_proto_ws_point_negate(pt : NetprotowsPoint) -> NetprotowsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn net_proto_ws_point_mid(a : NetprotowsPoint, b : NetprotowsPoint) -> NetprotowsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn net_proto_ws_point_lerp(a : NetprotowsPoint, b : NetprotowsPoint, t : Double) -> NetprotowsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn net_proto_ws_point_to_string(pt : NetprotowsPoint) -> String {
  "(" + net_proto_ws_dbl(pt.x) + ", " + net_proto_ws_dbl(pt.y) + ", " + net_proto_ws_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NetprotowsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn net_proto_ws_make_series(vals : Array[Double], name : String) -> NetprotowsSeries {
  { vals, name, meta: 0 }
}

pub fn net_proto_ws_series_len(s : NetprotowsSeries) -> Int { s.vals.length() }

pub fn net_proto_ws_series_sum(s : NetprotowsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn net_proto_ws_series_mean(s : NetprotowsSeries) -> Double {
  let n = net_proto_ws_series_len(s)
  if n == 0 { 0.0 } else { net_proto_ws_series_sum(s) / n.to_double() }
}

pub fn net_proto_ws_series_min(s : NetprotowsSeries) -> Double {
  let n = net_proto_ws_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn net_proto_ws_series_max(s : NetprotowsSeries) -> Double {
  let n = net_proto_ws_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn net_proto_ws_series_range(s : NetprotowsSeries) -> Double {
  net_proto_ws_series_max(s) - net_proto_ws_series_min(s)
}

pub fn net_proto_ws_series_var(s : NetprotowsSeries) -> Double {
  let n = net_proto_ws_series_len(s)
  if n == 0 { 0.0 } else {
    let m = net_proto_ws_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn net_proto_ws_series_std(s : NetprotowsSeries) -> Double { net_proto_ws_sqrt(net_proto_ws_series_var(s)) }

pub fn net_proto_ws_series_median(s : NetprotowsSeries) -> Double {
  let n = net_proto_ws_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = net_proto_ws_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_proto_ws_series_scale(s : NetprotowsSeries, f : Double) -> NetprotowsSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = net_proto_ws_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn net_proto_ws_series_add(a : NetprotowsSeries, b : NetprotowsSeries) -> NetprotowsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_proto_ws_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn net_proto_ws_series_sub(a : NetprotowsSeries, b : NetprotowsSeries) -> NetprotowsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = net_proto_ws_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn net_proto_ws_series_normalize(s : NetprotowsSeries) -> NetprotowsSeries {
  let mn = net_proto_ws_series_min(s)
  let mx = net_proto_ws_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = net_proto_ws_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn net_proto_ws_series_cumsum(s : NetprotowsSeries) -> NetprotowsSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = net_proto_ws_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn net_proto_ws_series_to_string(s : NetprotowsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_proto_ws_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NetprotowsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn net_proto_ws_make_matrix(rows : Int, cols : Int, val : Double) -> NetprotowsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn net_proto_ws_matrix_identity(n : Int) -> NetprotowsMatrix {
  let m = net_proto_ws_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn net_proto_ws_matrix_get(m : NetprotowsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn net_proto_ws_matrix_transpose(m : NetprotowsMatrix) -> NetprotowsMatrix {
  let result = net_proto_ws_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn net_proto_ws_matrix_add(a : NetprotowsMatrix, b : NetprotowsMatrix) -> NetprotowsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = net_proto_ws_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn net_proto_ws_matrix_scale(m : NetprotowsMatrix, s : Double) -> NetprotowsMatrix {
  let result = net_proto_ws_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn net_proto_ws_matrix_multiply(a : NetprotowsMatrix, b : NetprotowsMatrix) -> NetprotowsMatrix {
  if a.cols != b.rows { return net_proto_ws_make_matrix(a.rows, b.cols, 0.0) }
  let result = net_proto_ws_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn net_proto_ws_matrix_trace(m : NetprotowsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn net_proto_ws_matrix_det(m : NetprotowsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn net_proto_ws_matrix_norm(m : NetprotowsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  net_proto_ws_sqrt(sum)
}

pub fn net_proto_ws_matrix_to_string(m : NetprotowsMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + net_proto_ws_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct NetprotowsVector {
  comps : Array[Double]
  dim : Int
}

pub fn net_proto_ws_make_vector(comps : Array[Double]) -> NetprotowsVector {
  { comps, dim: comps.length() }
}

pub fn net_proto_ws_vector_zero(dim : Int) -> NetprotowsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn net_proto_ws_vector_add(a : NetprotowsVector, b : NetprotowsVector) -> NetprotowsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_proto_ws_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_ws_vector_sub(a : NetprotowsVector, b : NetprotowsVector) -> NetprotowsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = net_proto_ws_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn net_proto_ws_vector_scale(v : NetprotowsVector, s : Double) -> NetprotowsVector {
  let mut result = []
  for i in 0..<v.dim { result = net_proto_ws_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn net_proto_ws_vector_dot(a : NetprotowsVector, b : NetprotowsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn net_proto_ws_vector_norm(v : NetprotowsVector) -> Double { net_proto_ws_sqrt(net_proto_ws_vector_dot(v, v)) }

pub fn net_proto_ws_vector_normalize(v : NetprotowsVector) -> NetprotowsVector {
  let n = net_proto_ws_vector_norm(v)
  if n < 0.0000001 { v } else { net_proto_ws_vector_scale(v, 1.0 / n) }
}

pub fn net_proto_ws_vector_dist(a : NetprotowsVector, b : NetprotowsVector) -> Double {
  net_proto_ws_vector_norm(net_proto_ws_vector_sub(a, b))
}

pub fn net_proto_ws_vector_to_string(v : NetprotowsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + net_proto_ws_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn net_proto_ws_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn net_proto_ws_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = net_proto_ws_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_proto_ws_std(data : Array[Double]) -> Double { net_proto_ws_sqrt(net_proto_ws_var(data)) }

pub fn net_proto_ws_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = net_proto_ws_mean(a); let mb = net_proto_ws_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn net_proto_ws_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = net_proto_ws_std(a); let sb = net_proto_ws_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { net_proto_ws_cov(a, b) / (sa * sb) }
}

pub fn net_proto_ws_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = net_proto_ws_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn net_proto_ws_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn net_proto_ws_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn net_proto_ws_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  net_proto_ws_sqrt(net_proto_ws_mse(pred, labels))
}

pub fn net_proto_ws_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + net_proto_ws_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn net_proto_ws_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = net_proto_ws_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn net_proto_ws_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn net_proto_ws_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn net_proto_ws_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = net_proto_ws_precision(pred, labels, pos); let r = net_proto_ws_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn net_proto_ws_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn net_proto_ws_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = net_proto_ws_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn net_proto_ws_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn net_proto_ws_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn net_proto_ws_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = net_proto_ws_gcd(a, b)
    (a / g) * b
  }
}

pub fn net_proto_ws_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn net_proto_ws_fibonacci(n : Int) -> Int {
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

pub fn net_proto_ws_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = net_proto_ws_min(data); let mx = net_proto_ws_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn net_proto_ws_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = net_proto_ws_mean(data); let sd = net_proto_ws_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn net_proto_ws_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn net_proto_ws_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn net_proto_ws_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn net_proto_ws_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn net_proto_ws_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn net_proto_ws_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn net_proto_ws_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn net_proto_ws_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn net_proto_ws_dbl(x : Double) -> String {
  let i = if x >= 0.0 { net_proto_ws_int(x) } else { -net_proto_ws_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { net_proto_ws_int(f * 1000000.0) } else { net_proto_ws_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn net_proto_ws_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn net_proto_ws_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct NetprotowsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_frame_make(size : Int) -> NetprotowsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_frame_len(s : NetprotowsFrame) -> Int { s.size }

pub fn net_proto_ws_frame_get(s : NetprotowsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_frame_set(s : NetprotowsFrame, i : Int, v : Double) -> NetprotowsFrame {
  let result = net_proto_ws_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_frame_sum(s : NetprotowsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_frame_mean(s : NetprotowsFrame) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_frame_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_frame_scale(s : NetprotowsFrame, f : Double) -> NetprotowsFrame {
  let result = net_proto_ws_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_frame_add(a : NetprotowsFrame, b : NetprotowsFrame) -> NetprotowsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_frame_copy(s : NetprotowsFrame) -> NetprotowsFrame {
  let result = net_proto_ws_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_frame_fill(s : NetprotowsFrame, v : Double) -> NetprotowsFrame {
  let result = net_proto_ws_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_frame_min(s : NetprotowsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_frame_max(s : NetprotowsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_frame_to_string(s : NetprotowsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_table_make(size : Int) -> NetprotowsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_table_len(s : NetprotowsTable) -> Int { s.size }

pub fn net_proto_ws_table_get(s : NetprotowsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_table_set(s : NetprotowsTable, i : Int, v : Double) -> NetprotowsTable {
  let result = net_proto_ws_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_table_sum(s : NetprotowsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_table_mean(s : NetprotowsTable) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_table_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_table_scale(s : NetprotowsTable, f : Double) -> NetprotowsTable {
  let result = net_proto_ws_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_table_add(a : NetprotowsTable, b : NetprotowsTable) -> NetprotowsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_table_copy(s : NetprotowsTable) -> NetprotowsTable {
  let result = net_proto_ws_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_table_fill(s : NetprotowsTable, v : Double) -> NetprotowsTable {
  let result = net_proto_ws_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_table_min(s : NetprotowsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_table_max(s : NetprotowsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_table_to_string(s : NetprotowsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_graphn_make(size : Int) -> NetprotowsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_graphn_len(s : NetprotowsGraphN) -> Int { s.size }

pub fn net_proto_ws_graphn_get(s : NetprotowsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_graphn_set(s : NetprotowsGraphN, i : Int, v : Double) -> NetprotowsGraphN {
  let result = net_proto_ws_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_graphn_sum(s : NetprotowsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_graphn_mean(s : NetprotowsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_graphn_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_graphn_scale(s : NetprotowsGraphN, f : Double) -> NetprotowsGraphN {
  let result = net_proto_ws_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_graphn_add(a : NetprotowsGraphN, b : NetprotowsGraphN) -> NetprotowsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_graphn_copy(s : NetprotowsGraphN) -> NetprotowsGraphN {
  let result = net_proto_ws_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_graphn_fill(s : NetprotowsGraphN, v : Double) -> NetprotowsGraphN {
  let result = net_proto_ws_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_graphn_min(s : NetprotowsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_graphn_max(s : NetprotowsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_graphn_to_string(s : NetprotowsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_node_make(size : Int) -> NetprotowsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_node_len(s : NetprotowsNode) -> Int { s.size }

pub fn net_proto_ws_node_get(s : NetprotowsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_node_set(s : NetprotowsNode, i : Int, v : Double) -> NetprotowsNode {
  let result = net_proto_ws_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_node_sum(s : NetprotowsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_node_mean(s : NetprotowsNode) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_node_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_node_scale(s : NetprotowsNode, f : Double) -> NetprotowsNode {
  let result = net_proto_ws_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_node_add(a : NetprotowsNode, b : NetprotowsNode) -> NetprotowsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_node_copy(s : NetprotowsNode) -> NetprotowsNode {
  let result = net_proto_ws_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_node_fill(s : NetprotowsNode, v : Double) -> NetprotowsNode {
  let result = net_proto_ws_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_node_min(s : NetprotowsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_node_max(s : NetprotowsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_node_to_string(s : NetprotowsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_edge_make(size : Int) -> NetprotowsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_edge_len(s : NetprotowsEdge) -> Int { s.size }

pub fn net_proto_ws_edge_get(s : NetprotowsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_edge_set(s : NetprotowsEdge, i : Int, v : Double) -> NetprotowsEdge {
  let result = net_proto_ws_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_edge_sum(s : NetprotowsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_edge_mean(s : NetprotowsEdge) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_edge_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_edge_scale(s : NetprotowsEdge, f : Double) -> NetprotowsEdge {
  let result = net_proto_ws_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_edge_add(a : NetprotowsEdge, b : NetprotowsEdge) -> NetprotowsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_edge_copy(s : NetprotowsEdge) -> NetprotowsEdge {
  let result = net_proto_ws_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_edge_fill(s : NetprotowsEdge, v : Double) -> NetprotowsEdge {
  let result = net_proto_ws_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_edge_min(s : NetprotowsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_edge_max(s : NetprotowsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_edge_to_string(s : NetprotowsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_path_make(size : Int) -> NetprotowsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_path_len(s : NetprotowsPath) -> Int { s.size }

pub fn net_proto_ws_path_get(s : NetprotowsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_path_set(s : NetprotowsPath, i : Int, v : Double) -> NetprotowsPath {
  let result = net_proto_ws_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_path_sum(s : NetprotowsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_path_mean(s : NetprotowsPath) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_path_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_path_scale(s : NetprotowsPath, f : Double) -> NetprotowsPath {
  let result = net_proto_ws_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_path_add(a : NetprotowsPath, b : NetprotowsPath) -> NetprotowsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_path_copy(s : NetprotowsPath) -> NetprotowsPath {
  let result = net_proto_ws_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_path_fill(s : NetprotowsPath, v : Double) -> NetprotowsPath {
  let result = net_proto_ws_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_path_min(s : NetprotowsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_path_max(s : NetprotowsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_path_to_string(s : NetprotowsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_cluster_make(size : Int) -> NetprotowsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_cluster_len(s : NetprotowsCluster) -> Int { s.size }

pub fn net_proto_ws_cluster_get(s : NetprotowsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_cluster_set(s : NetprotowsCluster, i : Int, v : Double) -> NetprotowsCluster {
  let result = net_proto_ws_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_cluster_sum(s : NetprotowsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_cluster_mean(s : NetprotowsCluster) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_cluster_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_cluster_scale(s : NetprotowsCluster, f : Double) -> NetprotowsCluster {
  let result = net_proto_ws_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_cluster_add(a : NetprotowsCluster, b : NetprotowsCluster) -> NetprotowsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_cluster_copy(s : NetprotowsCluster) -> NetprotowsCluster {
  let result = net_proto_ws_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_cluster_fill(s : NetprotowsCluster, v : Double) -> NetprotowsCluster {
  let result = net_proto_ws_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_cluster_min(s : NetprotowsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_cluster_max(s : NetprotowsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_cluster_to_string(s : NetprotowsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_model_make(size : Int) -> NetprotowsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_model_len(s : NetprotowsModel) -> Int { s.size }

pub fn net_proto_ws_model_get(s : NetprotowsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_model_set(s : NetprotowsModel, i : Int, v : Double) -> NetprotowsModel {
  let result = net_proto_ws_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_model_sum(s : NetprotowsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_model_mean(s : NetprotowsModel) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_model_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_model_scale(s : NetprotowsModel, f : Double) -> NetprotowsModel {
  let result = net_proto_ws_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_model_add(a : NetprotowsModel, b : NetprotowsModel) -> NetprotowsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_model_copy(s : NetprotowsModel) -> NetprotowsModel {
  let result = net_proto_ws_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_model_fill(s : NetprotowsModel, v : Double) -> NetprotowsModel {
  let result = net_proto_ws_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_model_min(s : NetprotowsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_model_max(s : NetprotowsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_model_to_string(s : NetprotowsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_layer_make(size : Int) -> NetprotowsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_layer_len(s : NetprotowsLayer) -> Int { s.size }

pub fn net_proto_ws_layer_get(s : NetprotowsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_layer_set(s : NetprotowsLayer, i : Int, v : Double) -> NetprotowsLayer {
  let result = net_proto_ws_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_layer_sum(s : NetprotowsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_layer_mean(s : NetprotowsLayer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_layer_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_layer_scale(s : NetprotowsLayer, f : Double) -> NetprotowsLayer {
  let result = net_proto_ws_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_layer_add(a : NetprotowsLayer, b : NetprotowsLayer) -> NetprotowsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_layer_copy(s : NetprotowsLayer) -> NetprotowsLayer {
  let result = net_proto_ws_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_layer_fill(s : NetprotowsLayer, v : Double) -> NetprotowsLayer {
  let result = net_proto_ws_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_layer_min(s : NetprotowsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_layer_max(s : NetprotowsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_layer_to_string(s : NetprotowsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_buffer_make(size : Int) -> NetprotowsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_buffer_len(s : NetprotowsBuffer) -> Int { s.size }

pub fn net_proto_ws_buffer_get(s : NetprotowsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_buffer_set(s : NetprotowsBuffer, i : Int, v : Double) -> NetprotowsBuffer {
  let result = net_proto_ws_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_buffer_sum(s : NetprotowsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_buffer_mean(s : NetprotowsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_buffer_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_buffer_scale(s : NetprotowsBuffer, f : Double) -> NetprotowsBuffer {
  let result = net_proto_ws_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_buffer_add(a : NetprotowsBuffer, b : NetprotowsBuffer) -> NetprotowsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_buffer_copy(s : NetprotowsBuffer) -> NetprotowsBuffer {
  let result = net_proto_ws_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_buffer_fill(s : NetprotowsBuffer, v : Double) -> NetprotowsBuffer {
  let result = net_proto_ws_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_buffer_min(s : NetprotowsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_buffer_max(s : NetprotowsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_buffer_to_string(s : NetprotowsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_cursor_make(size : Int) -> NetprotowsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_cursor_len(s : NetprotowsCursor) -> Int { s.size }

pub fn net_proto_ws_cursor_get(s : NetprotowsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_cursor_set(s : NetprotowsCursor, i : Int, v : Double) -> NetprotowsCursor {
  let result = net_proto_ws_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_cursor_sum(s : NetprotowsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_cursor_mean(s : NetprotowsCursor) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_cursor_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_cursor_scale(s : NetprotowsCursor, f : Double) -> NetprotowsCursor {
  let result = net_proto_ws_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_cursor_add(a : NetprotowsCursor, b : NetprotowsCursor) -> NetprotowsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_cursor_copy(s : NetprotowsCursor) -> NetprotowsCursor {
  let result = net_proto_ws_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_cursor_fill(s : NetprotowsCursor, v : Double) -> NetprotowsCursor {
  let result = net_proto_ws_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_cursor_min(s : NetprotowsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_cursor_max(s : NetprotowsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_cursor_to_string(s : NetprotowsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_view_make(size : Int) -> NetprotowsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_view_len(s : NetprotowsView) -> Int { s.size }

pub fn net_proto_ws_view_get(s : NetprotowsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_view_set(s : NetprotowsView, i : Int, v : Double) -> NetprotowsView {
  let result = net_proto_ws_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_view_sum(s : NetprotowsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_view_mean(s : NetprotowsView) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_view_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_view_scale(s : NetprotowsView, f : Double) -> NetprotowsView {
  let result = net_proto_ws_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_view_add(a : NetprotowsView, b : NetprotowsView) -> NetprotowsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_view_copy(s : NetprotowsView) -> NetprotowsView {
  let result = net_proto_ws_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_view_fill(s : NetprotowsView, v : Double) -> NetprotowsView {
  let result = net_proto_ws_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_view_min(s : NetprotowsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_view_max(s : NetprotowsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_view_to_string(s : NetprotowsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_range_make(size : Int) -> NetprotowsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_range_len(s : NetprotowsRange) -> Int { s.size }

pub fn net_proto_ws_range_get(s : NetprotowsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_range_set(s : NetprotowsRange, i : Int, v : Double) -> NetprotowsRange {
  let result = net_proto_ws_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_range_sum(s : NetprotowsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_range_mean(s : NetprotowsRange) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_range_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_range_scale(s : NetprotowsRange, f : Double) -> NetprotowsRange {
  let result = net_proto_ws_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_range_add(a : NetprotowsRange, b : NetprotowsRange) -> NetprotowsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_range_copy(s : NetprotowsRange) -> NetprotowsRange {
  let result = net_proto_ws_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_range_fill(s : NetprotowsRange, v : Double) -> NetprotowsRange {
  let result = net_proto_ws_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_range_min(s : NetprotowsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_range_max(s : NetprotowsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_range_to_string(s : NetprotowsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NetprotowsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn net_proto_ws_slice_make(size : Int) -> NetprotowsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn net_proto_ws_slice_len(s : NetprotowsSlice) -> Int { s.size }

pub fn net_proto_ws_slice_get(s : NetprotowsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn net_proto_ws_slice_set(s : NetprotowsSlice, i : Int, v : Double) -> NetprotowsSlice {
  let result = net_proto_ws_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_slice_sum(s : NetprotowsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn net_proto_ws_slice_mean(s : NetprotowsSlice) -> Double {
  if s.size == 0 { 0.0 } else { net_proto_ws_slice_sum(s) / s.size.to_double() }
}

pub fn net_proto_ws_slice_scale(s : NetprotowsSlice, f : Double) -> NetprotowsSlice {
  let result = net_proto_ws_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn net_proto_ws_slice_add(a : NetprotowsSlice, b : NetprotowsSlice) -> NetprotowsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = net_proto_ws_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn net_proto_ws_slice_copy(s : NetprotowsSlice) -> NetprotowsSlice {
  let result = net_proto_ws_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn net_proto_ws_slice_fill(s : NetprotowsSlice, v : Double) -> NetprotowsSlice {
  let result = net_proto_ws_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn net_proto_ws_slice_min(s : NetprotowsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_slice_max(s : NetprotowsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn net_proto_ws_slice_to_string(s : NetprotowsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn net_proto_ws_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn net_proto_ws_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

