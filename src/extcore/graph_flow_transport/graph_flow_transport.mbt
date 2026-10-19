///===
/// extcore/graph_flow_transport

pub(all) struct GraphflowtransportPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_transport_make_point(x : Double, y : Double) -> GraphflowtransportPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_transport_make_point3(x : Double, y : Double, z : Double) -> GraphflowtransportPoint {
  { x, y, z, label: 0 }
}

pub fn graph_flow_transport_point_x(pt : GraphflowtransportPoint) -> Double { pt.x }

pub fn graph_flow_transport_point_y(pt : GraphflowtransportPoint) -> Double { pt.y }

pub fn graph_flow_transport_point_z(pt : GraphflowtransportPoint) -> Double { pt.z }

pub fn graph_flow_transport_point_label(pt : GraphflowtransportPoint) -> Int { pt.label }

pub fn graph_flow_transport_point_dist(a : GraphflowtransportPoint, b : GraphflowtransportPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_flow_transport_point_add(a : GraphflowtransportPoint, b : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_flow_transport_point_sub(a : GraphflowtransportPoint, b : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_flow_transport_point_scale(pt : GraphflowtransportPoint, s : Double) -> GraphflowtransportPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_flow_transport_point_dot(a : GraphflowtransportPoint, b : GraphflowtransportPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_flow_transport_point_cross(a : GraphflowtransportPoint, b : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_flow_transport_point_norm(pt : GraphflowtransportPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_flow_transport_point_normalize(pt : GraphflowtransportPoint) -> GraphflowtransportPoint {
  let n = graph_flow_transport_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_flow_transport_point_scale(pt, 1.0 / n) }
}

pub fn graph_flow_transport_point_negate(pt : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_flow_transport_point_mid(a : GraphflowtransportPoint, b : GraphflowtransportPoint) -> GraphflowtransportPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_flow_transport_point_lerp(a : GraphflowtransportPoint, b : GraphflowtransportPoint, t : Double) -> GraphflowtransportPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_flow_transport_point_to_string(pt : GraphflowtransportPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphflowtransportSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_transport_make_series(vals : Array[Double], name : String) -> GraphflowtransportSeries {
  { vals, name, meta: 0 }
}

pub fn graph_flow_transport_series_len(s : GraphflowtransportSeries) -> Int { s.vals.length() }

pub fn graph_flow_transport_series_sum(s : GraphflowtransportSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_flow_transport_series_mean(s : GraphflowtransportSeries) -> Double {
  let n = graph_flow_transport_series_len(s)
  if n == 0 { 0.0 } else { graph_flow_transport_series_sum(s) / n.to_double() }
}

pub fn graph_flow_transport_series_min(s : GraphflowtransportSeries) -> Double {
  let n = graph_flow_transport_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_transport_series_max(s : GraphflowtransportSeries) -> Double {
  let n = graph_flow_transport_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_transport_series_range(s : GraphflowtransportSeries) -> Double {
  graph_flow_transport_series_max(s) - graph_flow_transport_series_min(s)
}

pub fn graph_flow_transport_series_var(s : GraphflowtransportSeries) -> Double {
  let n = graph_flow_transport_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_flow_transport_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_flow_transport_series_std(s : GraphflowtransportSeries) -> Double { @_common.sqrt(graph_flow_transport_series_var(s)) }

pub fn graph_flow_transport_series_median(s : GraphflowtransportSeries) -> Double {
  let n = graph_flow_transport_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_flow_transport_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_flow_transport_series_scale(s : GraphflowtransportSeries, f : Double) -> GraphflowtransportSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_flow_transport_series_add(a : GraphflowtransportSeries, b : GraphflowtransportSeries) -> GraphflowtransportSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_flow_transport_series_sub(a : GraphflowtransportSeries, b : GraphflowtransportSeries) -> GraphflowtransportSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_flow_transport_series_normalize(s : GraphflowtransportSeries) -> GraphflowtransportSeries {
  let mn = graph_flow_transport_series_min(s)
  let mx = graph_flow_transport_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_flow_transport_series_cumsum(s : GraphflowtransportSeries) -> GraphflowtransportSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_flow_transport_series_to_string(s : GraphflowtransportSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowtransportMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_transport_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowtransportMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_transport_matrix_identity(n : Int) -> GraphflowtransportMatrix {
  let m = graph_flow_transport_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_flow_transport_matrix_get(m : GraphflowtransportMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_flow_transport_matrix_transpose(m : GraphflowtransportMatrix) -> GraphflowtransportMatrix {
  let result = graph_flow_transport_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_flow_transport_matrix_add(a : GraphflowtransportMatrix, b : GraphflowtransportMatrix) -> GraphflowtransportMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_flow_transport_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_flow_transport_matrix_scale(m : GraphflowtransportMatrix, s : Double) -> GraphflowtransportMatrix {
  let result = graph_flow_transport_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_flow_transport_matrix_multiply(a : GraphflowtransportMatrix, b : GraphflowtransportMatrix) -> GraphflowtransportMatrix {
  if a.cols != b.rows { return graph_flow_transport_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_flow_transport_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_flow_transport_matrix_trace(m : GraphflowtransportMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_flow_transport_matrix_det(m : GraphflowtransportMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_flow_transport_matrix_norm(m : GraphflowtransportMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_flow_transport_matrix_to_string(m : GraphflowtransportMatrix) -> String {
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

pub(all) struct GraphflowtransportVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_transport_make_vector(comps : Array[Double]) -> GraphflowtransportVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_transport_vector_zero(dim : Int) -> GraphflowtransportVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_flow_transport_vector_add(a : GraphflowtransportVector, b : GraphflowtransportVector) -> GraphflowtransportVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_transport_vector_sub(a : GraphflowtransportVector, b : GraphflowtransportVector) -> GraphflowtransportVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_transport_vector_scale(v : GraphflowtransportVector, s : Double) -> GraphflowtransportVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_flow_transport_vector_dot(a : GraphflowtransportVector, b : GraphflowtransportVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_flow_transport_vector_norm(v : GraphflowtransportVector) -> Double { @_common.sqrt(graph_flow_transport_vector_dot(v, v)) }

pub fn graph_flow_transport_vector_normalize(v : GraphflowtransportVector) -> GraphflowtransportVector {
  let n = graph_flow_transport_vector_norm(v)
  if n < 0.0000001 { v } else { graph_flow_transport_vector_scale(v, 1.0 / n) }
}

pub fn graph_flow_transport_vector_dist(a : GraphflowtransportVector, b : GraphflowtransportVector) -> Double {
  graph_flow_transport_vector_norm(graph_flow_transport_vector_sub(a, b))
}

pub fn graph_flow_transport_vector_to_string(v : GraphflowtransportVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_transport_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_flow_transport_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_flow_transport_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_flow_transport_std(data : Array[Double]) -> Double { @_common.sqrt(graph_flow_transport_var(data)) }

pub fn graph_flow_transport_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_flow_transport_mean(a); let mb = graph_flow_transport_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_flow_transport_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_flow_transport_std(a); let sb = graph_flow_transport_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_flow_transport_cov(a, b) / (sa * sb) }
}

pub fn graph_flow_transport_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_flow_transport_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_flow_transport_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_flow_transport_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_flow_transport_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(graph_flow_transport_mse(pred, labels))
}

pub fn graph_flow_transport_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_flow_transport_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_flow_transport_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_flow_transport_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_flow_transport_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_flow_transport_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_flow_transport_precision(pred, labels, pos); let r = graph_flow_transport_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_flow_transport_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_flow_transport_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_flow_transport_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_flow_transport_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_flow_transport_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_flow_transport_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_flow_transport_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_flow_transport_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_flow_transport_fibonacci(n : Int) -> Int {
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

pub fn graph_flow_transport_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_flow_transport_min(data); let mx = graph_flow_transport_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_flow_transport_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_flow_transport_mean(data); let sd = graph_flow_transport_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_flow_transport_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_flow_transport_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_flow_transport_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_flow_transport_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_flow_transport_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_flow_transport_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GraphflowtransportFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_frame_make(size : Int) -> GraphflowtransportFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_frame_len(s : GraphflowtransportFrame) -> Int { s.size }

pub fn graph_flow_transport_frame_get(s : GraphflowtransportFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_frame_set(s : GraphflowtransportFrame, i : Int, v : Double) -> GraphflowtransportFrame {
  let result = graph_flow_transport_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_frame_sum(s : GraphflowtransportFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_frame_mean(s : GraphflowtransportFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_frame_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_frame_scale(s : GraphflowtransportFrame, f : Double) -> GraphflowtransportFrame {
  let result = graph_flow_transport_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_frame_add(a : GraphflowtransportFrame, b : GraphflowtransportFrame) -> GraphflowtransportFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_frame_copy(s : GraphflowtransportFrame) -> GraphflowtransportFrame {
  let result = graph_flow_transport_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_frame_fill(s : GraphflowtransportFrame, v : Double) -> GraphflowtransportFrame {
  let result = graph_flow_transport_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_frame_min(s : GraphflowtransportFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_frame_max(s : GraphflowtransportFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_frame_to_string(s : GraphflowtransportFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_table_make(size : Int) -> GraphflowtransportTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_table_len(s : GraphflowtransportTable) -> Int { s.size }

pub fn graph_flow_transport_table_get(s : GraphflowtransportTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_table_set(s : GraphflowtransportTable, i : Int, v : Double) -> GraphflowtransportTable {
  let result = graph_flow_transport_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_table_sum(s : GraphflowtransportTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_table_mean(s : GraphflowtransportTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_table_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_table_scale(s : GraphflowtransportTable, f : Double) -> GraphflowtransportTable {
  let result = graph_flow_transport_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_table_add(a : GraphflowtransportTable, b : GraphflowtransportTable) -> GraphflowtransportTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_table_copy(s : GraphflowtransportTable) -> GraphflowtransportTable {
  let result = graph_flow_transport_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_table_fill(s : GraphflowtransportTable, v : Double) -> GraphflowtransportTable {
  let result = graph_flow_transport_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_table_min(s : GraphflowtransportTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_table_max(s : GraphflowtransportTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_table_to_string(s : GraphflowtransportTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_graphn_make(size : Int) -> GraphflowtransportGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_graphn_len(s : GraphflowtransportGraphN) -> Int { s.size }

pub fn graph_flow_transport_graphn_get(s : GraphflowtransportGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_graphn_set(s : GraphflowtransportGraphN, i : Int, v : Double) -> GraphflowtransportGraphN {
  let result = graph_flow_transport_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_graphn_sum(s : GraphflowtransportGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_graphn_mean(s : GraphflowtransportGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_graphn_scale(s : GraphflowtransportGraphN, f : Double) -> GraphflowtransportGraphN {
  let result = graph_flow_transport_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_graphn_add(a : GraphflowtransportGraphN, b : GraphflowtransportGraphN) -> GraphflowtransportGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_graphn_copy(s : GraphflowtransportGraphN) -> GraphflowtransportGraphN {
  let result = graph_flow_transport_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_graphn_fill(s : GraphflowtransportGraphN, v : Double) -> GraphflowtransportGraphN {
  let result = graph_flow_transport_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_graphn_min(s : GraphflowtransportGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_graphn_max(s : GraphflowtransportGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_graphn_to_string(s : GraphflowtransportGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_node_make(size : Int) -> GraphflowtransportNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_node_len(s : GraphflowtransportNode) -> Int { s.size }

pub fn graph_flow_transport_node_get(s : GraphflowtransportNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_node_set(s : GraphflowtransportNode, i : Int, v : Double) -> GraphflowtransportNode {
  let result = graph_flow_transport_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_node_sum(s : GraphflowtransportNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_node_mean(s : GraphflowtransportNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_node_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_node_scale(s : GraphflowtransportNode, f : Double) -> GraphflowtransportNode {
  let result = graph_flow_transport_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_node_add(a : GraphflowtransportNode, b : GraphflowtransportNode) -> GraphflowtransportNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_node_copy(s : GraphflowtransportNode) -> GraphflowtransportNode {
  let result = graph_flow_transport_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_node_fill(s : GraphflowtransportNode, v : Double) -> GraphflowtransportNode {
  let result = graph_flow_transport_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_node_min(s : GraphflowtransportNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_node_max(s : GraphflowtransportNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_node_to_string(s : GraphflowtransportNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_edge_make(size : Int) -> GraphflowtransportEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_edge_len(s : GraphflowtransportEdge) -> Int { s.size }

pub fn graph_flow_transport_edge_get(s : GraphflowtransportEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_edge_set(s : GraphflowtransportEdge, i : Int, v : Double) -> GraphflowtransportEdge {
  let result = graph_flow_transport_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_edge_sum(s : GraphflowtransportEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_edge_mean(s : GraphflowtransportEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_edge_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_edge_scale(s : GraphflowtransportEdge, f : Double) -> GraphflowtransportEdge {
  let result = graph_flow_transport_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_edge_add(a : GraphflowtransportEdge, b : GraphflowtransportEdge) -> GraphflowtransportEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_edge_copy(s : GraphflowtransportEdge) -> GraphflowtransportEdge {
  let result = graph_flow_transport_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_edge_fill(s : GraphflowtransportEdge, v : Double) -> GraphflowtransportEdge {
  let result = graph_flow_transport_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_edge_min(s : GraphflowtransportEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_edge_max(s : GraphflowtransportEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_edge_to_string(s : GraphflowtransportEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_path_make(size : Int) -> GraphflowtransportPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_path_len(s : GraphflowtransportPath) -> Int { s.size }

pub fn graph_flow_transport_path_get(s : GraphflowtransportPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_path_set(s : GraphflowtransportPath, i : Int, v : Double) -> GraphflowtransportPath {
  let result = graph_flow_transport_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_path_sum(s : GraphflowtransportPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_path_mean(s : GraphflowtransportPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_path_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_path_scale(s : GraphflowtransportPath, f : Double) -> GraphflowtransportPath {
  let result = graph_flow_transport_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_path_add(a : GraphflowtransportPath, b : GraphflowtransportPath) -> GraphflowtransportPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_path_copy(s : GraphflowtransportPath) -> GraphflowtransportPath {
  let result = graph_flow_transport_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_path_fill(s : GraphflowtransportPath, v : Double) -> GraphflowtransportPath {
  let result = graph_flow_transport_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_path_min(s : GraphflowtransportPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_path_max(s : GraphflowtransportPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_path_to_string(s : GraphflowtransportPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_cluster_make(size : Int) -> GraphflowtransportCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_cluster_len(s : GraphflowtransportCluster) -> Int { s.size }

pub fn graph_flow_transport_cluster_get(s : GraphflowtransportCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_cluster_set(s : GraphflowtransportCluster, i : Int, v : Double) -> GraphflowtransportCluster {
  let result = graph_flow_transport_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_cluster_sum(s : GraphflowtransportCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_cluster_mean(s : GraphflowtransportCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_cluster_scale(s : GraphflowtransportCluster, f : Double) -> GraphflowtransportCluster {
  let result = graph_flow_transport_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_cluster_add(a : GraphflowtransportCluster, b : GraphflowtransportCluster) -> GraphflowtransportCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_cluster_copy(s : GraphflowtransportCluster) -> GraphflowtransportCluster {
  let result = graph_flow_transport_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_cluster_fill(s : GraphflowtransportCluster, v : Double) -> GraphflowtransportCluster {
  let result = graph_flow_transport_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_cluster_min(s : GraphflowtransportCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_cluster_max(s : GraphflowtransportCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_cluster_to_string(s : GraphflowtransportCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_model_make(size : Int) -> GraphflowtransportModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_model_len(s : GraphflowtransportModel) -> Int { s.size }

pub fn graph_flow_transport_model_get(s : GraphflowtransportModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_model_set(s : GraphflowtransportModel, i : Int, v : Double) -> GraphflowtransportModel {
  let result = graph_flow_transport_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_model_sum(s : GraphflowtransportModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_model_mean(s : GraphflowtransportModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_model_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_model_scale(s : GraphflowtransportModel, f : Double) -> GraphflowtransportModel {
  let result = graph_flow_transport_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_model_add(a : GraphflowtransportModel, b : GraphflowtransportModel) -> GraphflowtransportModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_model_copy(s : GraphflowtransportModel) -> GraphflowtransportModel {
  let result = graph_flow_transport_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_model_fill(s : GraphflowtransportModel, v : Double) -> GraphflowtransportModel {
  let result = graph_flow_transport_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_model_min(s : GraphflowtransportModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_model_max(s : GraphflowtransportModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_model_to_string(s : GraphflowtransportModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_layer_make(size : Int) -> GraphflowtransportLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_layer_len(s : GraphflowtransportLayer) -> Int { s.size }

pub fn graph_flow_transport_layer_get(s : GraphflowtransportLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_layer_set(s : GraphflowtransportLayer, i : Int, v : Double) -> GraphflowtransportLayer {
  let result = graph_flow_transport_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_layer_sum(s : GraphflowtransportLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_layer_mean(s : GraphflowtransportLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_layer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_layer_scale(s : GraphflowtransportLayer, f : Double) -> GraphflowtransportLayer {
  let result = graph_flow_transport_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_layer_add(a : GraphflowtransportLayer, b : GraphflowtransportLayer) -> GraphflowtransportLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_layer_copy(s : GraphflowtransportLayer) -> GraphflowtransportLayer {
  let result = graph_flow_transport_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_layer_fill(s : GraphflowtransportLayer, v : Double) -> GraphflowtransportLayer {
  let result = graph_flow_transport_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_layer_min(s : GraphflowtransportLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_layer_max(s : GraphflowtransportLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_layer_to_string(s : GraphflowtransportLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_buffer_make(size : Int) -> GraphflowtransportBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_buffer_len(s : GraphflowtransportBuffer) -> Int { s.size }

pub fn graph_flow_transport_buffer_get(s : GraphflowtransportBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_buffer_set(s : GraphflowtransportBuffer, i : Int, v : Double) -> GraphflowtransportBuffer {
  let result = graph_flow_transport_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_buffer_sum(s : GraphflowtransportBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_buffer_mean(s : GraphflowtransportBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_buffer_scale(s : GraphflowtransportBuffer, f : Double) -> GraphflowtransportBuffer {
  let result = graph_flow_transport_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_buffer_add(a : GraphflowtransportBuffer, b : GraphflowtransportBuffer) -> GraphflowtransportBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_buffer_copy(s : GraphflowtransportBuffer) -> GraphflowtransportBuffer {
  let result = graph_flow_transport_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_buffer_fill(s : GraphflowtransportBuffer, v : Double) -> GraphflowtransportBuffer {
  let result = graph_flow_transport_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_buffer_min(s : GraphflowtransportBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_buffer_max(s : GraphflowtransportBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_buffer_to_string(s : GraphflowtransportBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_cursor_make(size : Int) -> GraphflowtransportCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_cursor_len(s : GraphflowtransportCursor) -> Int { s.size }

pub fn graph_flow_transport_cursor_get(s : GraphflowtransportCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_cursor_set(s : GraphflowtransportCursor, i : Int, v : Double) -> GraphflowtransportCursor {
  let result = graph_flow_transport_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_cursor_sum(s : GraphflowtransportCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_cursor_mean(s : GraphflowtransportCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_cursor_scale(s : GraphflowtransportCursor, f : Double) -> GraphflowtransportCursor {
  let result = graph_flow_transport_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_cursor_add(a : GraphflowtransportCursor, b : GraphflowtransportCursor) -> GraphflowtransportCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_cursor_copy(s : GraphflowtransportCursor) -> GraphflowtransportCursor {
  let result = graph_flow_transport_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_cursor_fill(s : GraphflowtransportCursor, v : Double) -> GraphflowtransportCursor {
  let result = graph_flow_transport_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_cursor_min(s : GraphflowtransportCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_cursor_max(s : GraphflowtransportCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_cursor_to_string(s : GraphflowtransportCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_view_make(size : Int) -> GraphflowtransportView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_view_len(s : GraphflowtransportView) -> Int { s.size }

pub fn graph_flow_transport_view_get(s : GraphflowtransportView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_view_set(s : GraphflowtransportView, i : Int, v : Double) -> GraphflowtransportView {
  let result = graph_flow_transport_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_view_sum(s : GraphflowtransportView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_view_mean(s : GraphflowtransportView) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_view_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_view_scale(s : GraphflowtransportView, f : Double) -> GraphflowtransportView {
  let result = graph_flow_transport_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_view_add(a : GraphflowtransportView, b : GraphflowtransportView) -> GraphflowtransportView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_view_copy(s : GraphflowtransportView) -> GraphflowtransportView {
  let result = graph_flow_transport_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_view_fill(s : GraphflowtransportView, v : Double) -> GraphflowtransportView {
  let result = graph_flow_transport_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_view_min(s : GraphflowtransportView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_view_max(s : GraphflowtransportView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_view_to_string(s : GraphflowtransportView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_range_make(size : Int) -> GraphflowtransportRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_range_len(s : GraphflowtransportRange) -> Int { s.size }

pub fn graph_flow_transport_range_get(s : GraphflowtransportRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_range_set(s : GraphflowtransportRange, i : Int, v : Double) -> GraphflowtransportRange {
  let result = graph_flow_transport_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_range_sum(s : GraphflowtransportRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_range_mean(s : GraphflowtransportRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_range_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_range_scale(s : GraphflowtransportRange, f : Double) -> GraphflowtransportRange {
  let result = graph_flow_transport_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_range_add(a : GraphflowtransportRange, b : GraphflowtransportRange) -> GraphflowtransportRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_range_copy(s : GraphflowtransportRange) -> GraphflowtransportRange {
  let result = graph_flow_transport_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_range_fill(s : GraphflowtransportRange, v : Double) -> GraphflowtransportRange {
  let result = graph_flow_transport_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_range_min(s : GraphflowtransportRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_range_max(s : GraphflowtransportRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_range_to_string(s : GraphflowtransportRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowtransportSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_transport_slice_make(size : Int) -> GraphflowtransportSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_transport_slice_len(s : GraphflowtransportSlice) -> Int { s.size }

pub fn graph_flow_transport_slice_get(s : GraphflowtransportSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_transport_slice_set(s : GraphflowtransportSlice, i : Int, v : Double) -> GraphflowtransportSlice {
  let result = graph_flow_transport_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_slice_sum(s : GraphflowtransportSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_transport_slice_mean(s : GraphflowtransportSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_transport_slice_sum(s) / s.size.to_double() }
}

pub fn graph_flow_transport_slice_scale(s : GraphflowtransportSlice, f : Double) -> GraphflowtransportSlice {
  let result = graph_flow_transport_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_transport_slice_add(a : GraphflowtransportSlice, b : GraphflowtransportSlice) -> GraphflowtransportSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_transport_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_transport_slice_copy(s : GraphflowtransportSlice) -> GraphflowtransportSlice {
  let result = graph_flow_transport_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_transport_slice_fill(s : GraphflowtransportSlice, v : Double) -> GraphflowtransportSlice {
  let result = graph_flow_transport_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_transport_slice_min(s : GraphflowtransportSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_slice_max(s : GraphflowtransportSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_transport_slice_to_string(s : GraphflowtransportSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

