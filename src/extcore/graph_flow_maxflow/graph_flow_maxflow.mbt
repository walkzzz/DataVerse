///===
/// extcore/graph_flow_maxflow

pub(all) struct GraphflowmaxflowPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_maxflow_make_point(x : Double, y : Double) -> GraphflowmaxflowPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_maxflow_make_point3(x : Double, y : Double, z : Double) -> GraphflowmaxflowPoint {
  { x, y, z, label: 0 }
}

pub fn graph_flow_maxflow_point_x(pt : GraphflowmaxflowPoint) -> Double { pt.x }

pub fn graph_flow_maxflow_point_y(pt : GraphflowmaxflowPoint) -> Double { pt.y }

pub fn graph_flow_maxflow_point_z(pt : GraphflowmaxflowPoint) -> Double { pt.z }

pub fn graph_flow_maxflow_point_label(pt : GraphflowmaxflowPoint) -> Int { pt.label }

pub fn graph_flow_maxflow_point_dist(a : GraphflowmaxflowPoint, b : GraphflowmaxflowPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  graph_flow_maxflow_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_flow_maxflow_point_add(a : GraphflowmaxflowPoint, b : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_flow_maxflow_point_sub(a : GraphflowmaxflowPoint, b : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_flow_maxflow_point_scale(pt : GraphflowmaxflowPoint, s : Double) -> GraphflowmaxflowPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_flow_maxflow_point_dot(a : GraphflowmaxflowPoint, b : GraphflowmaxflowPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_flow_maxflow_point_cross(a : GraphflowmaxflowPoint, b : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_flow_maxflow_point_norm(pt : GraphflowmaxflowPoint) -> Double {
  graph_flow_maxflow_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_flow_maxflow_point_normalize(pt : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  let n = graph_flow_maxflow_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_flow_maxflow_point_scale(pt, 1.0 / n) }
}

pub fn graph_flow_maxflow_point_negate(pt : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_flow_maxflow_point_mid(a : GraphflowmaxflowPoint, b : GraphflowmaxflowPoint) -> GraphflowmaxflowPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_flow_maxflow_point_lerp(a : GraphflowmaxflowPoint, b : GraphflowmaxflowPoint, t : Double) -> GraphflowmaxflowPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_flow_maxflow_point_to_string(pt : GraphflowmaxflowPoint) -> String {
  "(" + graph_flow_maxflow_dbl(pt.x) + ", " + graph_flow_maxflow_dbl(pt.y) + ", " + graph_flow_maxflow_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphflowmaxflowSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_maxflow_make_series(vals : Array[Double], name : String) -> GraphflowmaxflowSeries {
  { vals, name, meta: 0 }
}

pub fn graph_flow_maxflow_series_len(s : GraphflowmaxflowSeries) -> Int { s.vals.length() }

pub fn graph_flow_maxflow_series_sum(s : GraphflowmaxflowSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_flow_maxflow_series_mean(s : GraphflowmaxflowSeries) -> Double {
  let n = graph_flow_maxflow_series_len(s)
  if n == 0 { 0.0 } else { graph_flow_maxflow_series_sum(s) / n.to_double() }
}

pub fn graph_flow_maxflow_series_min(s : GraphflowmaxflowSeries) -> Double {
  let n = graph_flow_maxflow_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_maxflow_series_max(s : GraphflowmaxflowSeries) -> Double {
  let n = graph_flow_maxflow_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_maxflow_series_range(s : GraphflowmaxflowSeries) -> Double {
  graph_flow_maxflow_series_max(s) - graph_flow_maxflow_series_min(s)
}

pub fn graph_flow_maxflow_series_var(s : GraphflowmaxflowSeries) -> Double {
  let n = graph_flow_maxflow_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_flow_maxflow_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_flow_maxflow_series_std(s : GraphflowmaxflowSeries) -> Double { graph_flow_maxflow_sqrt(graph_flow_maxflow_series_var(s)) }

pub fn graph_flow_maxflow_series_median(s : GraphflowmaxflowSeries) -> Double {
  let n = graph_flow_maxflow_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_flow_maxflow_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_flow_maxflow_series_scale(s : GraphflowmaxflowSeries, f : Double) -> GraphflowmaxflowSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_flow_maxflow_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_flow_maxflow_series_add(a : GraphflowmaxflowSeries, b : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_flow_maxflow_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_flow_maxflow_series_sub(a : GraphflowmaxflowSeries, b : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_flow_maxflow_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_flow_maxflow_series_normalize(s : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  let mn = graph_flow_maxflow_series_min(s)
  let mx = graph_flow_maxflow_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = graph_flow_maxflow_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_flow_maxflow_series_cumsum(s : GraphflowmaxflowSeries) -> GraphflowmaxflowSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = graph_flow_maxflow_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_flow_maxflow_series_to_string(s : GraphflowmaxflowSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_flow_maxflow_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowmaxflowMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_maxflow_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowmaxflowMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_maxflow_matrix_identity(n : Int) -> GraphflowmaxflowMatrix {
  let m = graph_flow_maxflow_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_flow_maxflow_matrix_get(m : GraphflowmaxflowMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_flow_maxflow_matrix_transpose(m : GraphflowmaxflowMatrix) -> GraphflowmaxflowMatrix {
  let result = graph_flow_maxflow_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_flow_maxflow_matrix_add(a : GraphflowmaxflowMatrix, b : GraphflowmaxflowMatrix) -> GraphflowmaxflowMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_flow_maxflow_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_flow_maxflow_matrix_scale(m : GraphflowmaxflowMatrix, s : Double) -> GraphflowmaxflowMatrix {
  let result = graph_flow_maxflow_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_flow_maxflow_matrix_multiply(a : GraphflowmaxflowMatrix, b : GraphflowmaxflowMatrix) -> GraphflowmaxflowMatrix {
  if a.cols != b.rows { return graph_flow_maxflow_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_flow_maxflow_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_flow_maxflow_matrix_trace(m : GraphflowmaxflowMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_flow_maxflow_matrix_det(m : GraphflowmaxflowMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_flow_maxflow_matrix_norm(m : GraphflowmaxflowMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  graph_flow_maxflow_sqrt(sum)
}

pub fn graph_flow_maxflow_matrix_to_string(m : GraphflowmaxflowMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_flow_maxflow_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphflowmaxflowVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_maxflow_make_vector(comps : Array[Double]) -> GraphflowmaxflowVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_maxflow_vector_zero(dim : Int) -> GraphflowmaxflowVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_flow_maxflow_vector_add(a : GraphflowmaxflowVector, b : GraphflowmaxflowVector) -> GraphflowmaxflowVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_flow_maxflow_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_maxflow_vector_sub(a : GraphflowmaxflowVector, b : GraphflowmaxflowVector) -> GraphflowmaxflowVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_flow_maxflow_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_maxflow_vector_scale(v : GraphflowmaxflowVector, s : Double) -> GraphflowmaxflowVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_flow_maxflow_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_flow_maxflow_vector_dot(a : GraphflowmaxflowVector, b : GraphflowmaxflowVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_flow_maxflow_vector_norm(v : GraphflowmaxflowVector) -> Double { graph_flow_maxflow_sqrt(graph_flow_maxflow_vector_dot(v, v)) }

pub fn graph_flow_maxflow_vector_normalize(v : GraphflowmaxflowVector) -> GraphflowmaxflowVector {
  let n = graph_flow_maxflow_vector_norm(v)
  if n < 0.0000001 { v } else { graph_flow_maxflow_vector_scale(v, 1.0 / n) }
}

pub fn graph_flow_maxflow_vector_dist(a : GraphflowmaxflowVector, b : GraphflowmaxflowVector) -> Double {
  graph_flow_maxflow_vector_norm(graph_flow_maxflow_vector_sub(a, b))
}

pub fn graph_flow_maxflow_vector_to_string(v : GraphflowmaxflowVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_flow_maxflow_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_maxflow_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_flow_maxflow_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_flow_maxflow_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_flow_maxflow_std(data : Array[Double]) -> Double { graph_flow_maxflow_sqrt(graph_flow_maxflow_var(data)) }

pub fn graph_flow_maxflow_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_flow_maxflow_mean(a); let mb = graph_flow_maxflow_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_flow_maxflow_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_flow_maxflow_std(a); let sb = graph_flow_maxflow_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_flow_maxflow_cov(a, b) / (sa * sb) }
}

pub fn graph_flow_maxflow_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_flow_maxflow_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_flow_maxflow_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_flow_maxflow_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_flow_maxflow_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  graph_flow_maxflow_sqrt(graph_flow_maxflow_mse(pred, labels))
}

pub fn graph_flow_maxflow_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + graph_flow_maxflow_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_flow_maxflow_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_flow_maxflow_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_flow_maxflow_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_flow_maxflow_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_flow_maxflow_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_flow_maxflow_precision(pred, labels, pos); let r = graph_flow_maxflow_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_flow_maxflow_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_flow_maxflow_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_flow_maxflow_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_flow_maxflow_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_flow_maxflow_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_flow_maxflow_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_flow_maxflow_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_flow_maxflow_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_flow_maxflow_fibonacci(n : Int) -> Int {
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

pub fn graph_flow_maxflow_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_flow_maxflow_min(data); let mx = graph_flow_maxflow_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_flow_maxflow_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_flow_maxflow_mean(data); let sd = graph_flow_maxflow_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_flow_maxflow_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_flow_maxflow_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_flow_maxflow_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_flow_maxflow_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn graph_flow_maxflow_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn graph_flow_maxflow_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn graph_flow_maxflow_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_flow_maxflow_int(x) } else { -graph_flow_maxflow_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_flow_maxflow_int(f * 1000000.0) } else { graph_flow_maxflow_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_flow_maxflow_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_flow_maxflow_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GraphflowmaxflowFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_frame_make(size : Int) -> GraphflowmaxflowFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_frame_len(s : GraphflowmaxflowFrame) -> Int { s.size }

pub fn graph_flow_maxflow_frame_get(s : GraphflowmaxflowFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_frame_set(s : GraphflowmaxflowFrame, i : Int, v : Double) -> GraphflowmaxflowFrame {
  let result = graph_flow_maxflow_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_frame_sum(s : GraphflowmaxflowFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_frame_mean(s : GraphflowmaxflowFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_frame_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_frame_scale(s : GraphflowmaxflowFrame, f : Double) -> GraphflowmaxflowFrame {
  let result = graph_flow_maxflow_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_frame_add(a : GraphflowmaxflowFrame, b : GraphflowmaxflowFrame) -> GraphflowmaxflowFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_frame_copy(s : GraphflowmaxflowFrame) -> GraphflowmaxflowFrame {
  let result = graph_flow_maxflow_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_frame_fill(s : GraphflowmaxflowFrame, v : Double) -> GraphflowmaxflowFrame {
  let result = graph_flow_maxflow_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_frame_min(s : GraphflowmaxflowFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_frame_max(s : GraphflowmaxflowFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_frame_to_string(s : GraphflowmaxflowFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_table_make(size : Int) -> GraphflowmaxflowTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_table_len(s : GraphflowmaxflowTable) -> Int { s.size }

pub fn graph_flow_maxflow_table_get(s : GraphflowmaxflowTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_table_set(s : GraphflowmaxflowTable, i : Int, v : Double) -> GraphflowmaxflowTable {
  let result = graph_flow_maxflow_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_table_sum(s : GraphflowmaxflowTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_table_mean(s : GraphflowmaxflowTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_table_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_table_scale(s : GraphflowmaxflowTable, f : Double) -> GraphflowmaxflowTable {
  let result = graph_flow_maxflow_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_table_add(a : GraphflowmaxflowTable, b : GraphflowmaxflowTable) -> GraphflowmaxflowTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_table_copy(s : GraphflowmaxflowTable) -> GraphflowmaxflowTable {
  let result = graph_flow_maxflow_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_table_fill(s : GraphflowmaxflowTable, v : Double) -> GraphflowmaxflowTable {
  let result = graph_flow_maxflow_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_table_min(s : GraphflowmaxflowTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_table_max(s : GraphflowmaxflowTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_table_to_string(s : GraphflowmaxflowTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_graphn_make(size : Int) -> GraphflowmaxflowGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_graphn_len(s : GraphflowmaxflowGraphN) -> Int { s.size }

pub fn graph_flow_maxflow_graphn_get(s : GraphflowmaxflowGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_graphn_set(s : GraphflowmaxflowGraphN, i : Int, v : Double) -> GraphflowmaxflowGraphN {
  let result = graph_flow_maxflow_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_graphn_sum(s : GraphflowmaxflowGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_graphn_mean(s : GraphflowmaxflowGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_graphn_scale(s : GraphflowmaxflowGraphN, f : Double) -> GraphflowmaxflowGraphN {
  let result = graph_flow_maxflow_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_graphn_add(a : GraphflowmaxflowGraphN, b : GraphflowmaxflowGraphN) -> GraphflowmaxflowGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_graphn_copy(s : GraphflowmaxflowGraphN) -> GraphflowmaxflowGraphN {
  let result = graph_flow_maxflow_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_graphn_fill(s : GraphflowmaxflowGraphN, v : Double) -> GraphflowmaxflowGraphN {
  let result = graph_flow_maxflow_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_graphn_min(s : GraphflowmaxflowGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_graphn_max(s : GraphflowmaxflowGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_graphn_to_string(s : GraphflowmaxflowGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_node_make(size : Int) -> GraphflowmaxflowNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_node_len(s : GraphflowmaxflowNode) -> Int { s.size }

pub fn graph_flow_maxflow_node_get(s : GraphflowmaxflowNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_node_set(s : GraphflowmaxflowNode, i : Int, v : Double) -> GraphflowmaxflowNode {
  let result = graph_flow_maxflow_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_node_sum(s : GraphflowmaxflowNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_node_mean(s : GraphflowmaxflowNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_node_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_node_scale(s : GraphflowmaxflowNode, f : Double) -> GraphflowmaxflowNode {
  let result = graph_flow_maxflow_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_node_add(a : GraphflowmaxflowNode, b : GraphflowmaxflowNode) -> GraphflowmaxflowNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_node_copy(s : GraphflowmaxflowNode) -> GraphflowmaxflowNode {
  let result = graph_flow_maxflow_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_node_fill(s : GraphflowmaxflowNode, v : Double) -> GraphflowmaxflowNode {
  let result = graph_flow_maxflow_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_node_min(s : GraphflowmaxflowNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_node_max(s : GraphflowmaxflowNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_node_to_string(s : GraphflowmaxflowNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_edge_make(size : Int) -> GraphflowmaxflowEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_edge_len(s : GraphflowmaxflowEdge) -> Int { s.size }

pub fn graph_flow_maxflow_edge_get(s : GraphflowmaxflowEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_edge_set(s : GraphflowmaxflowEdge, i : Int, v : Double) -> GraphflowmaxflowEdge {
  let result = graph_flow_maxflow_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_edge_sum(s : GraphflowmaxflowEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_edge_mean(s : GraphflowmaxflowEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_edge_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_edge_scale(s : GraphflowmaxflowEdge, f : Double) -> GraphflowmaxflowEdge {
  let result = graph_flow_maxflow_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_edge_add(a : GraphflowmaxflowEdge, b : GraphflowmaxflowEdge) -> GraphflowmaxflowEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_edge_copy(s : GraphflowmaxflowEdge) -> GraphflowmaxflowEdge {
  let result = graph_flow_maxflow_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_edge_fill(s : GraphflowmaxflowEdge, v : Double) -> GraphflowmaxflowEdge {
  let result = graph_flow_maxflow_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_edge_min(s : GraphflowmaxflowEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_edge_max(s : GraphflowmaxflowEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_edge_to_string(s : GraphflowmaxflowEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_path_make(size : Int) -> GraphflowmaxflowPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_path_len(s : GraphflowmaxflowPath) -> Int { s.size }

pub fn graph_flow_maxflow_path_get(s : GraphflowmaxflowPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_path_set(s : GraphflowmaxflowPath, i : Int, v : Double) -> GraphflowmaxflowPath {
  let result = graph_flow_maxflow_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_path_sum(s : GraphflowmaxflowPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_path_mean(s : GraphflowmaxflowPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_path_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_path_scale(s : GraphflowmaxflowPath, f : Double) -> GraphflowmaxflowPath {
  let result = graph_flow_maxflow_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_path_add(a : GraphflowmaxflowPath, b : GraphflowmaxflowPath) -> GraphflowmaxflowPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_path_copy(s : GraphflowmaxflowPath) -> GraphflowmaxflowPath {
  let result = graph_flow_maxflow_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_path_fill(s : GraphflowmaxflowPath, v : Double) -> GraphflowmaxflowPath {
  let result = graph_flow_maxflow_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_path_min(s : GraphflowmaxflowPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_path_max(s : GraphflowmaxflowPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_path_to_string(s : GraphflowmaxflowPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_cluster_make(size : Int) -> GraphflowmaxflowCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_cluster_len(s : GraphflowmaxflowCluster) -> Int { s.size }

pub fn graph_flow_maxflow_cluster_get(s : GraphflowmaxflowCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_cluster_set(s : GraphflowmaxflowCluster, i : Int, v : Double) -> GraphflowmaxflowCluster {
  let result = graph_flow_maxflow_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_cluster_sum(s : GraphflowmaxflowCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_cluster_mean(s : GraphflowmaxflowCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_cluster_scale(s : GraphflowmaxflowCluster, f : Double) -> GraphflowmaxflowCluster {
  let result = graph_flow_maxflow_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_cluster_add(a : GraphflowmaxflowCluster, b : GraphflowmaxflowCluster) -> GraphflowmaxflowCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_cluster_copy(s : GraphflowmaxflowCluster) -> GraphflowmaxflowCluster {
  let result = graph_flow_maxflow_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_cluster_fill(s : GraphflowmaxflowCluster, v : Double) -> GraphflowmaxflowCluster {
  let result = graph_flow_maxflow_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_cluster_min(s : GraphflowmaxflowCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_cluster_max(s : GraphflowmaxflowCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_cluster_to_string(s : GraphflowmaxflowCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_model_make(size : Int) -> GraphflowmaxflowModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_model_len(s : GraphflowmaxflowModel) -> Int { s.size }

pub fn graph_flow_maxflow_model_get(s : GraphflowmaxflowModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_model_set(s : GraphflowmaxflowModel, i : Int, v : Double) -> GraphflowmaxflowModel {
  let result = graph_flow_maxflow_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_model_sum(s : GraphflowmaxflowModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_model_mean(s : GraphflowmaxflowModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_model_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_model_scale(s : GraphflowmaxflowModel, f : Double) -> GraphflowmaxflowModel {
  let result = graph_flow_maxflow_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_model_add(a : GraphflowmaxflowModel, b : GraphflowmaxflowModel) -> GraphflowmaxflowModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_model_copy(s : GraphflowmaxflowModel) -> GraphflowmaxflowModel {
  let result = graph_flow_maxflow_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_model_fill(s : GraphflowmaxflowModel, v : Double) -> GraphflowmaxflowModel {
  let result = graph_flow_maxflow_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_model_min(s : GraphflowmaxflowModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_model_max(s : GraphflowmaxflowModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_model_to_string(s : GraphflowmaxflowModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_layer_make(size : Int) -> GraphflowmaxflowLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_layer_len(s : GraphflowmaxflowLayer) -> Int { s.size }

pub fn graph_flow_maxflow_layer_get(s : GraphflowmaxflowLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_layer_set(s : GraphflowmaxflowLayer, i : Int, v : Double) -> GraphflowmaxflowLayer {
  let result = graph_flow_maxflow_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_layer_sum(s : GraphflowmaxflowLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_layer_mean(s : GraphflowmaxflowLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_layer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_layer_scale(s : GraphflowmaxflowLayer, f : Double) -> GraphflowmaxflowLayer {
  let result = graph_flow_maxflow_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_layer_add(a : GraphflowmaxflowLayer, b : GraphflowmaxflowLayer) -> GraphflowmaxflowLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_layer_copy(s : GraphflowmaxflowLayer) -> GraphflowmaxflowLayer {
  let result = graph_flow_maxflow_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_layer_fill(s : GraphflowmaxflowLayer, v : Double) -> GraphflowmaxflowLayer {
  let result = graph_flow_maxflow_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_layer_min(s : GraphflowmaxflowLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_layer_max(s : GraphflowmaxflowLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_layer_to_string(s : GraphflowmaxflowLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_buffer_make(size : Int) -> GraphflowmaxflowBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_buffer_len(s : GraphflowmaxflowBuffer) -> Int { s.size }

pub fn graph_flow_maxflow_buffer_get(s : GraphflowmaxflowBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_buffer_set(s : GraphflowmaxflowBuffer, i : Int, v : Double) -> GraphflowmaxflowBuffer {
  let result = graph_flow_maxflow_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_buffer_sum(s : GraphflowmaxflowBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_buffer_mean(s : GraphflowmaxflowBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_buffer_scale(s : GraphflowmaxflowBuffer, f : Double) -> GraphflowmaxflowBuffer {
  let result = graph_flow_maxflow_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_buffer_add(a : GraphflowmaxflowBuffer, b : GraphflowmaxflowBuffer) -> GraphflowmaxflowBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_buffer_copy(s : GraphflowmaxflowBuffer) -> GraphflowmaxflowBuffer {
  let result = graph_flow_maxflow_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_buffer_fill(s : GraphflowmaxflowBuffer, v : Double) -> GraphflowmaxflowBuffer {
  let result = graph_flow_maxflow_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_buffer_min(s : GraphflowmaxflowBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_buffer_max(s : GraphflowmaxflowBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_buffer_to_string(s : GraphflowmaxflowBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_cursor_make(size : Int) -> GraphflowmaxflowCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_cursor_len(s : GraphflowmaxflowCursor) -> Int { s.size }

pub fn graph_flow_maxflow_cursor_get(s : GraphflowmaxflowCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_cursor_set(s : GraphflowmaxflowCursor, i : Int, v : Double) -> GraphflowmaxflowCursor {
  let result = graph_flow_maxflow_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_cursor_sum(s : GraphflowmaxflowCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_cursor_mean(s : GraphflowmaxflowCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_cursor_scale(s : GraphflowmaxflowCursor, f : Double) -> GraphflowmaxflowCursor {
  let result = graph_flow_maxflow_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_cursor_add(a : GraphflowmaxflowCursor, b : GraphflowmaxflowCursor) -> GraphflowmaxflowCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_cursor_copy(s : GraphflowmaxflowCursor) -> GraphflowmaxflowCursor {
  let result = graph_flow_maxflow_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_cursor_fill(s : GraphflowmaxflowCursor, v : Double) -> GraphflowmaxflowCursor {
  let result = graph_flow_maxflow_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_cursor_min(s : GraphflowmaxflowCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_cursor_max(s : GraphflowmaxflowCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_cursor_to_string(s : GraphflowmaxflowCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_view_make(size : Int) -> GraphflowmaxflowView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_view_len(s : GraphflowmaxflowView) -> Int { s.size }

pub fn graph_flow_maxflow_view_get(s : GraphflowmaxflowView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_view_set(s : GraphflowmaxflowView, i : Int, v : Double) -> GraphflowmaxflowView {
  let result = graph_flow_maxflow_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_view_sum(s : GraphflowmaxflowView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_view_mean(s : GraphflowmaxflowView) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_view_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_view_scale(s : GraphflowmaxflowView, f : Double) -> GraphflowmaxflowView {
  let result = graph_flow_maxflow_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_view_add(a : GraphflowmaxflowView, b : GraphflowmaxflowView) -> GraphflowmaxflowView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_view_copy(s : GraphflowmaxflowView) -> GraphflowmaxflowView {
  let result = graph_flow_maxflow_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_view_fill(s : GraphflowmaxflowView, v : Double) -> GraphflowmaxflowView {
  let result = graph_flow_maxflow_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_view_min(s : GraphflowmaxflowView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_view_max(s : GraphflowmaxflowView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_view_to_string(s : GraphflowmaxflowView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_range_make(size : Int) -> GraphflowmaxflowRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_range_len(s : GraphflowmaxflowRange) -> Int { s.size }

pub fn graph_flow_maxflow_range_get(s : GraphflowmaxflowRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_range_set(s : GraphflowmaxflowRange, i : Int, v : Double) -> GraphflowmaxflowRange {
  let result = graph_flow_maxflow_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_range_sum(s : GraphflowmaxflowRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_range_mean(s : GraphflowmaxflowRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_range_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_range_scale(s : GraphflowmaxflowRange, f : Double) -> GraphflowmaxflowRange {
  let result = graph_flow_maxflow_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_range_add(a : GraphflowmaxflowRange, b : GraphflowmaxflowRange) -> GraphflowmaxflowRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_range_copy(s : GraphflowmaxflowRange) -> GraphflowmaxflowRange {
  let result = graph_flow_maxflow_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_range_fill(s : GraphflowmaxflowRange, v : Double) -> GraphflowmaxflowRange {
  let result = graph_flow_maxflow_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_range_min(s : GraphflowmaxflowRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_range_max(s : GraphflowmaxflowRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_range_to_string(s : GraphflowmaxflowRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowmaxflowSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_maxflow_slice_make(size : Int) -> GraphflowmaxflowSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_maxflow_slice_len(s : GraphflowmaxflowSlice) -> Int { s.size }

pub fn graph_flow_maxflow_slice_get(s : GraphflowmaxflowSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_maxflow_slice_set(s : GraphflowmaxflowSlice, i : Int, v : Double) -> GraphflowmaxflowSlice {
  let result = graph_flow_maxflow_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_slice_sum(s : GraphflowmaxflowSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_maxflow_slice_mean(s : GraphflowmaxflowSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_maxflow_slice_sum(s) / s.size.to_double() }
}

pub fn graph_flow_maxflow_slice_scale(s : GraphflowmaxflowSlice, f : Double) -> GraphflowmaxflowSlice {
  let result = graph_flow_maxflow_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_maxflow_slice_add(a : GraphflowmaxflowSlice, b : GraphflowmaxflowSlice) -> GraphflowmaxflowSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_maxflow_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_maxflow_slice_copy(s : GraphflowmaxflowSlice) -> GraphflowmaxflowSlice {
  let result = graph_flow_maxflow_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_maxflow_slice_fill(s : GraphflowmaxflowSlice, v : Double) -> GraphflowmaxflowSlice {
  let result = graph_flow_maxflow_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_maxflow_slice_min(s : GraphflowmaxflowSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_slice_max(s : GraphflowmaxflowSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_maxflow_slice_to_string(s : GraphflowmaxflowSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn graph_flow_maxflow_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_maxflow_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

