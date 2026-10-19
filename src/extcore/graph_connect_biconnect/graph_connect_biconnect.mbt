///===
/// extcore/graph_connect_biconnect

pub(all) struct GraphconnectbiconnectPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_biconnect_make_point(x : Double, y : Double) -> GraphconnectbiconnectPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_biconnect_make_point3(x : Double, y : Double, z : Double) -> GraphconnectbiconnectPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_biconnect_point_x(pt : GraphconnectbiconnectPoint) -> Double { pt.x }

pub fn graph_connect_biconnect_point_y(pt : GraphconnectbiconnectPoint) -> Double { pt.y }

pub fn graph_connect_biconnect_point_z(pt : GraphconnectbiconnectPoint) -> Double { pt.z }

pub fn graph_connect_biconnect_point_label(pt : GraphconnectbiconnectPoint) -> Int { pt.label }

pub fn graph_connect_biconnect_point_dist(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  graph_connect_biconnect_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_biconnect_point_add(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_biconnect_point_sub(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_biconnect_point_scale(pt : GraphconnectbiconnectPoint, s : Double) -> GraphconnectbiconnectPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_biconnect_point_dot(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_biconnect_point_cross(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_biconnect_point_norm(pt : GraphconnectbiconnectPoint) -> Double {
  graph_connect_biconnect_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_biconnect_point_normalize(pt : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  let n = graph_connect_biconnect_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_biconnect_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_biconnect_point_negate(pt : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_biconnect_point_mid(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint) -> GraphconnectbiconnectPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_biconnect_point_lerp(a : GraphconnectbiconnectPoint, b : GraphconnectbiconnectPoint, t : Double) -> GraphconnectbiconnectPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_biconnect_point_to_string(pt : GraphconnectbiconnectPoint) -> String {
  "(" + graph_connect_biconnect_dbl(pt.x) + ", " + graph_connect_biconnect_dbl(pt.y) + ", " + graph_connect_biconnect_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_biconnect_make_series(vals : Array[Double], name : String) -> GraphconnectbiconnectSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_biconnect_series_len(s : GraphconnectbiconnectSeries) -> Int { s.vals.length() }

pub fn graph_connect_biconnect_series_sum(s : GraphconnectbiconnectSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_connect_biconnect_series_mean(s : GraphconnectbiconnectSeries) -> Double {
  let n = graph_connect_biconnect_series_len(s)
  if n == 0 { 0.0 } else { graph_connect_biconnect_series_sum(s) / n.to_double() }
}

pub fn graph_connect_biconnect_series_min(s : GraphconnectbiconnectSeries) -> Double {
  let n = graph_connect_biconnect_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_connect_biconnect_series_max(s : GraphconnectbiconnectSeries) -> Double {
  let n = graph_connect_biconnect_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_connect_biconnect_series_range(s : GraphconnectbiconnectSeries) -> Double {
  graph_connect_biconnect_series_max(s) - graph_connect_biconnect_series_min(s)
}

pub fn graph_connect_biconnect_series_var(s : GraphconnectbiconnectSeries) -> Double {
  let n = graph_connect_biconnect_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_connect_biconnect_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_connect_biconnect_series_std(s : GraphconnectbiconnectSeries) -> Double { graph_connect_biconnect_sqrt(graph_connect_biconnect_series_var(s)) }

pub fn graph_connect_biconnect_series_median(s : GraphconnectbiconnectSeries) -> Double {
  let n = graph_connect_biconnect_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_connect_biconnect_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_connect_biconnect_series_scale(s : GraphconnectbiconnectSeries, f : Double) -> GraphconnectbiconnectSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_connect_biconnect_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_connect_biconnect_series_add(a : GraphconnectbiconnectSeries, b : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_connect_biconnect_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_biconnect_series_sub(a : GraphconnectbiconnectSeries, b : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_connect_biconnect_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_biconnect_series_normalize(s : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  let mn = graph_connect_biconnect_series_min(s)
  let mx = graph_connect_biconnect_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = graph_connect_biconnect_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_biconnect_series_cumsum(s : GraphconnectbiconnectSeries) -> GraphconnectbiconnectSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = graph_connect_biconnect_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_biconnect_series_to_string(s : GraphconnectbiconnectSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_connect_biconnect_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectbiconnectMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_biconnect_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectbiconnectMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_biconnect_matrix_identity(n : Int) -> GraphconnectbiconnectMatrix {
  let m = graph_connect_biconnect_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_biconnect_matrix_get(m : GraphconnectbiconnectMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_biconnect_matrix_transpose(m : GraphconnectbiconnectMatrix) -> GraphconnectbiconnectMatrix {
  let result = graph_connect_biconnect_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_biconnect_matrix_add(a : GraphconnectbiconnectMatrix, b : GraphconnectbiconnectMatrix) -> GraphconnectbiconnectMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_biconnect_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_biconnect_matrix_scale(m : GraphconnectbiconnectMatrix, s : Double) -> GraphconnectbiconnectMatrix {
  let result = graph_connect_biconnect_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_biconnect_matrix_multiply(a : GraphconnectbiconnectMatrix, b : GraphconnectbiconnectMatrix) -> GraphconnectbiconnectMatrix {
  if a.cols != b.rows { return graph_connect_biconnect_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_biconnect_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_biconnect_matrix_trace(m : GraphconnectbiconnectMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_biconnect_matrix_det(m : GraphconnectbiconnectMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_biconnect_matrix_norm(m : GraphconnectbiconnectMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  graph_connect_biconnect_sqrt(sum)
}

pub fn graph_connect_biconnect_matrix_to_string(m : GraphconnectbiconnectMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_connect_biconnect_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphconnectbiconnectVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_biconnect_make_vector(comps : Array[Double]) -> GraphconnectbiconnectVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_biconnect_vector_zero(dim : Int) -> GraphconnectbiconnectVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_biconnect_vector_add(a : GraphconnectbiconnectVector, b : GraphconnectbiconnectVector) -> GraphconnectbiconnectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_connect_biconnect_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_biconnect_vector_sub(a : GraphconnectbiconnectVector, b : GraphconnectbiconnectVector) -> GraphconnectbiconnectVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_connect_biconnect_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_biconnect_vector_scale(v : GraphconnectbiconnectVector, s : Double) -> GraphconnectbiconnectVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_connect_biconnect_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_connect_biconnect_vector_dot(a : GraphconnectbiconnectVector, b : GraphconnectbiconnectVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_biconnect_vector_norm(v : GraphconnectbiconnectVector) -> Double { graph_connect_biconnect_sqrt(graph_connect_biconnect_vector_dot(v, v)) }

pub fn graph_connect_biconnect_vector_normalize(v : GraphconnectbiconnectVector) -> GraphconnectbiconnectVector {
  let n = graph_connect_biconnect_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_biconnect_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_biconnect_vector_dist(a : GraphconnectbiconnectVector, b : GraphconnectbiconnectVector) -> Double {
  graph_connect_biconnect_vector_norm(graph_connect_biconnect_vector_sub(a, b))
}

pub fn graph_connect_biconnect_vector_to_string(v : GraphconnectbiconnectVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_connect_biconnect_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_biconnect_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_connect_biconnect_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_connect_biconnect_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_connect_biconnect_std(data : Array[Double]) -> Double { graph_connect_biconnect_sqrt(graph_connect_biconnect_var(data)) }

pub fn graph_connect_biconnect_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_connect_biconnect_mean(a); let mb = graph_connect_biconnect_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_connect_biconnect_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_connect_biconnect_std(a); let sb = graph_connect_biconnect_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_connect_biconnect_cov(a, b) / (sa * sb) }
}

pub fn graph_connect_biconnect_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_connect_biconnect_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_connect_biconnect_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_connect_biconnect_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_connect_biconnect_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  graph_connect_biconnect_sqrt(graph_connect_biconnect_mse(pred, labels))
}

pub fn graph_connect_biconnect_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + graph_connect_biconnect_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_connect_biconnect_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_connect_biconnect_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_connect_biconnect_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_connect_biconnect_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_connect_biconnect_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_connect_biconnect_precision(pred, labels, pos); let r = graph_connect_biconnect_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_connect_biconnect_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_connect_biconnect_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_connect_biconnect_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_connect_biconnect_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_connect_biconnect_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_connect_biconnect_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_connect_biconnect_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_connect_biconnect_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_connect_biconnect_fibonacci(n : Int) -> Int {
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

pub fn graph_connect_biconnect_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_connect_biconnect_min(data); let mx = graph_connect_biconnect_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_connect_biconnect_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_connect_biconnect_mean(data); let sd = graph_connect_biconnect_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_connect_biconnect_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_connect_biconnect_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_connect_biconnect_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_connect_biconnect_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn graph_connect_biconnect_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn graph_connect_biconnect_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn graph_connect_biconnect_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_connect_biconnect_int(x) } else { -graph_connect_biconnect_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_connect_biconnect_int(f * 1000000.0) } else { graph_connect_biconnect_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_connect_biconnect_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_connect_biconnect_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GraphconnectbiconnectFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_frame_make(size : Int) -> GraphconnectbiconnectFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_frame_len(s : GraphconnectbiconnectFrame) -> Int { s.size }

pub fn graph_connect_biconnect_frame_get(s : GraphconnectbiconnectFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_frame_set(s : GraphconnectbiconnectFrame, i : Int, v : Double) -> GraphconnectbiconnectFrame {
  let result = graph_connect_biconnect_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_frame_sum(s : GraphconnectbiconnectFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_frame_mean(s : GraphconnectbiconnectFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_frame_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_frame_scale(s : GraphconnectbiconnectFrame, f : Double) -> GraphconnectbiconnectFrame {
  let result = graph_connect_biconnect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_frame_add(a : GraphconnectbiconnectFrame, b : GraphconnectbiconnectFrame) -> GraphconnectbiconnectFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_frame_copy(s : GraphconnectbiconnectFrame) -> GraphconnectbiconnectFrame {
  let result = graph_connect_biconnect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_frame_fill(s : GraphconnectbiconnectFrame, v : Double) -> GraphconnectbiconnectFrame {
  let result = graph_connect_biconnect_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_frame_min(s : GraphconnectbiconnectFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_frame_max(s : GraphconnectbiconnectFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_frame_to_string(s : GraphconnectbiconnectFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_table_make(size : Int) -> GraphconnectbiconnectTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_table_len(s : GraphconnectbiconnectTable) -> Int { s.size }

pub fn graph_connect_biconnect_table_get(s : GraphconnectbiconnectTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_table_set(s : GraphconnectbiconnectTable, i : Int, v : Double) -> GraphconnectbiconnectTable {
  let result = graph_connect_biconnect_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_table_sum(s : GraphconnectbiconnectTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_table_mean(s : GraphconnectbiconnectTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_table_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_table_scale(s : GraphconnectbiconnectTable, f : Double) -> GraphconnectbiconnectTable {
  let result = graph_connect_biconnect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_table_add(a : GraphconnectbiconnectTable, b : GraphconnectbiconnectTable) -> GraphconnectbiconnectTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_table_copy(s : GraphconnectbiconnectTable) -> GraphconnectbiconnectTable {
  let result = graph_connect_biconnect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_table_fill(s : GraphconnectbiconnectTable, v : Double) -> GraphconnectbiconnectTable {
  let result = graph_connect_biconnect_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_table_min(s : GraphconnectbiconnectTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_table_max(s : GraphconnectbiconnectTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_table_to_string(s : GraphconnectbiconnectTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_graphn_make(size : Int) -> GraphconnectbiconnectGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_graphn_len(s : GraphconnectbiconnectGraphN) -> Int { s.size }

pub fn graph_connect_biconnect_graphn_get(s : GraphconnectbiconnectGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_graphn_set(s : GraphconnectbiconnectGraphN, i : Int, v : Double) -> GraphconnectbiconnectGraphN {
  let result = graph_connect_biconnect_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_graphn_sum(s : GraphconnectbiconnectGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_graphn_mean(s : GraphconnectbiconnectGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_graphn_scale(s : GraphconnectbiconnectGraphN, f : Double) -> GraphconnectbiconnectGraphN {
  let result = graph_connect_biconnect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_graphn_add(a : GraphconnectbiconnectGraphN, b : GraphconnectbiconnectGraphN) -> GraphconnectbiconnectGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_graphn_copy(s : GraphconnectbiconnectGraphN) -> GraphconnectbiconnectGraphN {
  let result = graph_connect_biconnect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_graphn_fill(s : GraphconnectbiconnectGraphN, v : Double) -> GraphconnectbiconnectGraphN {
  let result = graph_connect_biconnect_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_graphn_min(s : GraphconnectbiconnectGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_graphn_max(s : GraphconnectbiconnectGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_graphn_to_string(s : GraphconnectbiconnectGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_node_make(size : Int) -> GraphconnectbiconnectNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_node_len(s : GraphconnectbiconnectNode) -> Int { s.size }

pub fn graph_connect_biconnect_node_get(s : GraphconnectbiconnectNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_node_set(s : GraphconnectbiconnectNode, i : Int, v : Double) -> GraphconnectbiconnectNode {
  let result = graph_connect_biconnect_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_node_sum(s : GraphconnectbiconnectNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_node_mean(s : GraphconnectbiconnectNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_node_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_node_scale(s : GraphconnectbiconnectNode, f : Double) -> GraphconnectbiconnectNode {
  let result = graph_connect_biconnect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_node_add(a : GraphconnectbiconnectNode, b : GraphconnectbiconnectNode) -> GraphconnectbiconnectNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_node_copy(s : GraphconnectbiconnectNode) -> GraphconnectbiconnectNode {
  let result = graph_connect_biconnect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_node_fill(s : GraphconnectbiconnectNode, v : Double) -> GraphconnectbiconnectNode {
  let result = graph_connect_biconnect_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_node_min(s : GraphconnectbiconnectNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_node_max(s : GraphconnectbiconnectNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_node_to_string(s : GraphconnectbiconnectNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_edge_make(size : Int) -> GraphconnectbiconnectEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_edge_len(s : GraphconnectbiconnectEdge) -> Int { s.size }

pub fn graph_connect_biconnect_edge_get(s : GraphconnectbiconnectEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_edge_set(s : GraphconnectbiconnectEdge, i : Int, v : Double) -> GraphconnectbiconnectEdge {
  let result = graph_connect_biconnect_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_edge_sum(s : GraphconnectbiconnectEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_edge_mean(s : GraphconnectbiconnectEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_edge_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_edge_scale(s : GraphconnectbiconnectEdge, f : Double) -> GraphconnectbiconnectEdge {
  let result = graph_connect_biconnect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_edge_add(a : GraphconnectbiconnectEdge, b : GraphconnectbiconnectEdge) -> GraphconnectbiconnectEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_edge_copy(s : GraphconnectbiconnectEdge) -> GraphconnectbiconnectEdge {
  let result = graph_connect_biconnect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_edge_fill(s : GraphconnectbiconnectEdge, v : Double) -> GraphconnectbiconnectEdge {
  let result = graph_connect_biconnect_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_edge_min(s : GraphconnectbiconnectEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_edge_max(s : GraphconnectbiconnectEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_edge_to_string(s : GraphconnectbiconnectEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_path_make(size : Int) -> GraphconnectbiconnectPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_path_len(s : GraphconnectbiconnectPath) -> Int { s.size }

pub fn graph_connect_biconnect_path_get(s : GraphconnectbiconnectPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_path_set(s : GraphconnectbiconnectPath, i : Int, v : Double) -> GraphconnectbiconnectPath {
  let result = graph_connect_biconnect_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_path_sum(s : GraphconnectbiconnectPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_path_mean(s : GraphconnectbiconnectPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_path_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_path_scale(s : GraphconnectbiconnectPath, f : Double) -> GraphconnectbiconnectPath {
  let result = graph_connect_biconnect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_path_add(a : GraphconnectbiconnectPath, b : GraphconnectbiconnectPath) -> GraphconnectbiconnectPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_path_copy(s : GraphconnectbiconnectPath) -> GraphconnectbiconnectPath {
  let result = graph_connect_biconnect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_path_fill(s : GraphconnectbiconnectPath, v : Double) -> GraphconnectbiconnectPath {
  let result = graph_connect_biconnect_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_path_min(s : GraphconnectbiconnectPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_path_max(s : GraphconnectbiconnectPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_path_to_string(s : GraphconnectbiconnectPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_cluster_make(size : Int) -> GraphconnectbiconnectCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_cluster_len(s : GraphconnectbiconnectCluster) -> Int { s.size }

pub fn graph_connect_biconnect_cluster_get(s : GraphconnectbiconnectCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_cluster_set(s : GraphconnectbiconnectCluster, i : Int, v : Double) -> GraphconnectbiconnectCluster {
  let result = graph_connect_biconnect_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_cluster_sum(s : GraphconnectbiconnectCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_cluster_mean(s : GraphconnectbiconnectCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_cluster_scale(s : GraphconnectbiconnectCluster, f : Double) -> GraphconnectbiconnectCluster {
  let result = graph_connect_biconnect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_cluster_add(a : GraphconnectbiconnectCluster, b : GraphconnectbiconnectCluster) -> GraphconnectbiconnectCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_cluster_copy(s : GraphconnectbiconnectCluster) -> GraphconnectbiconnectCluster {
  let result = graph_connect_biconnect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_cluster_fill(s : GraphconnectbiconnectCluster, v : Double) -> GraphconnectbiconnectCluster {
  let result = graph_connect_biconnect_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_cluster_min(s : GraphconnectbiconnectCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_cluster_max(s : GraphconnectbiconnectCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_cluster_to_string(s : GraphconnectbiconnectCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_model_make(size : Int) -> GraphconnectbiconnectModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_model_len(s : GraphconnectbiconnectModel) -> Int { s.size }

pub fn graph_connect_biconnect_model_get(s : GraphconnectbiconnectModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_model_set(s : GraphconnectbiconnectModel, i : Int, v : Double) -> GraphconnectbiconnectModel {
  let result = graph_connect_biconnect_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_model_sum(s : GraphconnectbiconnectModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_model_mean(s : GraphconnectbiconnectModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_model_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_model_scale(s : GraphconnectbiconnectModel, f : Double) -> GraphconnectbiconnectModel {
  let result = graph_connect_biconnect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_model_add(a : GraphconnectbiconnectModel, b : GraphconnectbiconnectModel) -> GraphconnectbiconnectModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_model_copy(s : GraphconnectbiconnectModel) -> GraphconnectbiconnectModel {
  let result = graph_connect_biconnect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_model_fill(s : GraphconnectbiconnectModel, v : Double) -> GraphconnectbiconnectModel {
  let result = graph_connect_biconnect_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_model_min(s : GraphconnectbiconnectModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_model_max(s : GraphconnectbiconnectModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_model_to_string(s : GraphconnectbiconnectModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_layer_make(size : Int) -> GraphconnectbiconnectLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_layer_len(s : GraphconnectbiconnectLayer) -> Int { s.size }

pub fn graph_connect_biconnect_layer_get(s : GraphconnectbiconnectLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_layer_set(s : GraphconnectbiconnectLayer, i : Int, v : Double) -> GraphconnectbiconnectLayer {
  let result = graph_connect_biconnect_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_layer_sum(s : GraphconnectbiconnectLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_layer_mean(s : GraphconnectbiconnectLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_layer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_layer_scale(s : GraphconnectbiconnectLayer, f : Double) -> GraphconnectbiconnectLayer {
  let result = graph_connect_biconnect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_layer_add(a : GraphconnectbiconnectLayer, b : GraphconnectbiconnectLayer) -> GraphconnectbiconnectLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_layer_copy(s : GraphconnectbiconnectLayer) -> GraphconnectbiconnectLayer {
  let result = graph_connect_biconnect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_layer_fill(s : GraphconnectbiconnectLayer, v : Double) -> GraphconnectbiconnectLayer {
  let result = graph_connect_biconnect_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_layer_min(s : GraphconnectbiconnectLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_layer_max(s : GraphconnectbiconnectLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_layer_to_string(s : GraphconnectbiconnectLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_buffer_make(size : Int) -> GraphconnectbiconnectBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_buffer_len(s : GraphconnectbiconnectBuffer) -> Int { s.size }

pub fn graph_connect_biconnect_buffer_get(s : GraphconnectbiconnectBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_buffer_set(s : GraphconnectbiconnectBuffer, i : Int, v : Double) -> GraphconnectbiconnectBuffer {
  let result = graph_connect_biconnect_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_buffer_sum(s : GraphconnectbiconnectBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_buffer_mean(s : GraphconnectbiconnectBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_buffer_scale(s : GraphconnectbiconnectBuffer, f : Double) -> GraphconnectbiconnectBuffer {
  let result = graph_connect_biconnect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_buffer_add(a : GraphconnectbiconnectBuffer, b : GraphconnectbiconnectBuffer) -> GraphconnectbiconnectBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_buffer_copy(s : GraphconnectbiconnectBuffer) -> GraphconnectbiconnectBuffer {
  let result = graph_connect_biconnect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_buffer_fill(s : GraphconnectbiconnectBuffer, v : Double) -> GraphconnectbiconnectBuffer {
  let result = graph_connect_biconnect_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_buffer_min(s : GraphconnectbiconnectBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_buffer_max(s : GraphconnectbiconnectBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_buffer_to_string(s : GraphconnectbiconnectBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_cursor_make(size : Int) -> GraphconnectbiconnectCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_cursor_len(s : GraphconnectbiconnectCursor) -> Int { s.size }

pub fn graph_connect_biconnect_cursor_get(s : GraphconnectbiconnectCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_cursor_set(s : GraphconnectbiconnectCursor, i : Int, v : Double) -> GraphconnectbiconnectCursor {
  let result = graph_connect_biconnect_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_cursor_sum(s : GraphconnectbiconnectCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_cursor_mean(s : GraphconnectbiconnectCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_cursor_scale(s : GraphconnectbiconnectCursor, f : Double) -> GraphconnectbiconnectCursor {
  let result = graph_connect_biconnect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_cursor_add(a : GraphconnectbiconnectCursor, b : GraphconnectbiconnectCursor) -> GraphconnectbiconnectCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_cursor_copy(s : GraphconnectbiconnectCursor) -> GraphconnectbiconnectCursor {
  let result = graph_connect_biconnect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_cursor_fill(s : GraphconnectbiconnectCursor, v : Double) -> GraphconnectbiconnectCursor {
  let result = graph_connect_biconnect_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_cursor_min(s : GraphconnectbiconnectCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_cursor_max(s : GraphconnectbiconnectCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_cursor_to_string(s : GraphconnectbiconnectCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_view_make(size : Int) -> GraphconnectbiconnectView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_view_len(s : GraphconnectbiconnectView) -> Int { s.size }

pub fn graph_connect_biconnect_view_get(s : GraphconnectbiconnectView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_view_set(s : GraphconnectbiconnectView, i : Int, v : Double) -> GraphconnectbiconnectView {
  let result = graph_connect_biconnect_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_view_sum(s : GraphconnectbiconnectView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_view_mean(s : GraphconnectbiconnectView) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_view_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_view_scale(s : GraphconnectbiconnectView, f : Double) -> GraphconnectbiconnectView {
  let result = graph_connect_biconnect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_view_add(a : GraphconnectbiconnectView, b : GraphconnectbiconnectView) -> GraphconnectbiconnectView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_view_copy(s : GraphconnectbiconnectView) -> GraphconnectbiconnectView {
  let result = graph_connect_biconnect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_view_fill(s : GraphconnectbiconnectView, v : Double) -> GraphconnectbiconnectView {
  let result = graph_connect_biconnect_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_view_min(s : GraphconnectbiconnectView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_view_max(s : GraphconnectbiconnectView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_view_to_string(s : GraphconnectbiconnectView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_range_make(size : Int) -> GraphconnectbiconnectRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_range_len(s : GraphconnectbiconnectRange) -> Int { s.size }

pub fn graph_connect_biconnect_range_get(s : GraphconnectbiconnectRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_range_set(s : GraphconnectbiconnectRange, i : Int, v : Double) -> GraphconnectbiconnectRange {
  let result = graph_connect_biconnect_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_range_sum(s : GraphconnectbiconnectRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_range_mean(s : GraphconnectbiconnectRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_range_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_range_scale(s : GraphconnectbiconnectRange, f : Double) -> GraphconnectbiconnectRange {
  let result = graph_connect_biconnect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_range_add(a : GraphconnectbiconnectRange, b : GraphconnectbiconnectRange) -> GraphconnectbiconnectRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_range_copy(s : GraphconnectbiconnectRange) -> GraphconnectbiconnectRange {
  let result = graph_connect_biconnect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_range_fill(s : GraphconnectbiconnectRange, v : Double) -> GraphconnectbiconnectRange {
  let result = graph_connect_biconnect_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_range_min(s : GraphconnectbiconnectRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_range_max(s : GraphconnectbiconnectRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_range_to_string(s : GraphconnectbiconnectRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectbiconnectSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_biconnect_slice_make(size : Int) -> GraphconnectbiconnectSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_biconnect_slice_len(s : GraphconnectbiconnectSlice) -> Int { s.size }

pub fn graph_connect_biconnect_slice_get(s : GraphconnectbiconnectSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_biconnect_slice_set(s : GraphconnectbiconnectSlice, i : Int, v : Double) -> GraphconnectbiconnectSlice {
  let result = graph_connect_biconnect_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_slice_sum(s : GraphconnectbiconnectSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_biconnect_slice_mean(s : GraphconnectbiconnectSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_biconnect_slice_sum(s) / s.size.to_double() }
}

pub fn graph_connect_biconnect_slice_scale(s : GraphconnectbiconnectSlice, f : Double) -> GraphconnectbiconnectSlice {
  let result = graph_connect_biconnect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_biconnect_slice_add(a : GraphconnectbiconnectSlice, b : GraphconnectbiconnectSlice) -> GraphconnectbiconnectSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_biconnect_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_biconnect_slice_copy(s : GraphconnectbiconnectSlice) -> GraphconnectbiconnectSlice {
  let result = graph_connect_biconnect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_biconnect_slice_fill(s : GraphconnectbiconnectSlice, v : Double) -> GraphconnectbiconnectSlice {
  let result = graph_connect_biconnect_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_biconnect_slice_min(s : GraphconnectbiconnectSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_slice_max(s : GraphconnectbiconnectSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_biconnect_slice_to_string(s : GraphconnectbiconnectSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn graph_connect_biconnect_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_biconnect_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

