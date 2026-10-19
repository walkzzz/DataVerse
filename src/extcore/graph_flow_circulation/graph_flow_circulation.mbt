///===
/// extcore/graph_flow_circulation

pub(all) struct GraphflowcirculationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_circulation_make_point(x : Double, y : Double) -> GraphflowcirculationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_circulation_make_point3(x : Double, y : Double, z : Double) -> GraphflowcirculationPoint {
  { x, y, z, label: 0 }
}

pub fn graph_flow_circulation_point_x(pt : GraphflowcirculationPoint) -> Double { pt.x }

pub fn graph_flow_circulation_point_y(pt : GraphflowcirculationPoint) -> Double { pt.y }

pub fn graph_flow_circulation_point_z(pt : GraphflowcirculationPoint) -> Double { pt.z }

pub fn graph_flow_circulation_point_label(pt : GraphflowcirculationPoint) -> Int { pt.label }

pub fn graph_flow_circulation_point_dist(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  graph_flow_circulation_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_flow_circulation_point_add(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_flow_circulation_point_sub(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_flow_circulation_point_scale(pt : GraphflowcirculationPoint, s : Double) -> GraphflowcirculationPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_flow_circulation_point_dot(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_flow_circulation_point_cross(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_flow_circulation_point_norm(pt : GraphflowcirculationPoint) -> Double {
  graph_flow_circulation_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_flow_circulation_point_normalize(pt : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  let n = graph_flow_circulation_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_flow_circulation_point_scale(pt, 1.0 / n) }
}

pub fn graph_flow_circulation_point_negate(pt : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_flow_circulation_point_mid(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint) -> GraphflowcirculationPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_flow_circulation_point_lerp(a : GraphflowcirculationPoint, b : GraphflowcirculationPoint, t : Double) -> GraphflowcirculationPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_flow_circulation_point_to_string(pt : GraphflowcirculationPoint) -> String {
  "(" + graph_flow_circulation_dbl(pt.x) + ", " + graph_flow_circulation_dbl(pt.y) + ", " + graph_flow_circulation_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphflowcirculationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_circulation_make_series(vals : Array[Double], name : String) -> GraphflowcirculationSeries {
  { vals, name, meta: 0 }
}

pub fn graph_flow_circulation_series_len(s : GraphflowcirculationSeries) -> Int { s.vals.length() }

pub fn graph_flow_circulation_series_sum(s : GraphflowcirculationSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_flow_circulation_series_mean(s : GraphflowcirculationSeries) -> Double {
  let n = graph_flow_circulation_series_len(s)
  if n == 0 { 0.0 } else { graph_flow_circulation_series_sum(s) / n.to_double() }
}

pub fn graph_flow_circulation_series_min(s : GraphflowcirculationSeries) -> Double {
  let n = graph_flow_circulation_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_circulation_series_max(s : GraphflowcirculationSeries) -> Double {
  let n = graph_flow_circulation_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_circulation_series_range(s : GraphflowcirculationSeries) -> Double {
  graph_flow_circulation_series_max(s) - graph_flow_circulation_series_min(s)
}

pub fn graph_flow_circulation_series_var(s : GraphflowcirculationSeries) -> Double {
  let n = graph_flow_circulation_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_flow_circulation_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_flow_circulation_series_std(s : GraphflowcirculationSeries) -> Double { graph_flow_circulation_sqrt(graph_flow_circulation_series_var(s)) }

pub fn graph_flow_circulation_series_median(s : GraphflowcirculationSeries) -> Double {
  let n = graph_flow_circulation_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_flow_circulation_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_flow_circulation_series_scale(s : GraphflowcirculationSeries, f : Double) -> GraphflowcirculationSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_flow_circulation_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_flow_circulation_series_add(a : GraphflowcirculationSeries, b : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_flow_circulation_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_flow_circulation_series_sub(a : GraphflowcirculationSeries, b : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_flow_circulation_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_flow_circulation_series_normalize(s : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  let mn = graph_flow_circulation_series_min(s)
  let mx = graph_flow_circulation_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = graph_flow_circulation_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_flow_circulation_series_cumsum(s : GraphflowcirculationSeries) -> GraphflowcirculationSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = graph_flow_circulation_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_flow_circulation_series_to_string(s : GraphflowcirculationSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_flow_circulation_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowcirculationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_circulation_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowcirculationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_circulation_matrix_identity(n : Int) -> GraphflowcirculationMatrix {
  let m = graph_flow_circulation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_flow_circulation_matrix_get(m : GraphflowcirculationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_flow_circulation_matrix_transpose(m : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  let result = graph_flow_circulation_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_flow_circulation_matrix_add(a : GraphflowcirculationMatrix, b : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_flow_circulation_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_flow_circulation_matrix_scale(m : GraphflowcirculationMatrix, s : Double) -> GraphflowcirculationMatrix {
  let result = graph_flow_circulation_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_flow_circulation_matrix_multiply(a : GraphflowcirculationMatrix, b : GraphflowcirculationMatrix) -> GraphflowcirculationMatrix {
  if a.cols != b.rows { return graph_flow_circulation_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_flow_circulation_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_flow_circulation_matrix_trace(m : GraphflowcirculationMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_flow_circulation_matrix_det(m : GraphflowcirculationMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_flow_circulation_matrix_norm(m : GraphflowcirculationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  graph_flow_circulation_sqrt(sum)
}

pub fn graph_flow_circulation_matrix_to_string(m : GraphflowcirculationMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_flow_circulation_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphflowcirculationVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_circulation_make_vector(comps : Array[Double]) -> GraphflowcirculationVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_circulation_vector_zero(dim : Int) -> GraphflowcirculationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_flow_circulation_vector_add(a : GraphflowcirculationVector, b : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_flow_circulation_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_circulation_vector_sub(a : GraphflowcirculationVector, b : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_flow_circulation_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_circulation_vector_scale(v : GraphflowcirculationVector, s : Double) -> GraphflowcirculationVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_flow_circulation_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_flow_circulation_vector_dot(a : GraphflowcirculationVector, b : GraphflowcirculationVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_flow_circulation_vector_norm(v : GraphflowcirculationVector) -> Double { graph_flow_circulation_sqrt(graph_flow_circulation_vector_dot(v, v)) }

pub fn graph_flow_circulation_vector_normalize(v : GraphflowcirculationVector) -> GraphflowcirculationVector {
  let n = graph_flow_circulation_vector_norm(v)
  if n < 0.0000001 { v } else { graph_flow_circulation_vector_scale(v, 1.0 / n) }
}

pub fn graph_flow_circulation_vector_dist(a : GraphflowcirculationVector, b : GraphflowcirculationVector) -> Double {
  graph_flow_circulation_vector_norm(graph_flow_circulation_vector_sub(a, b))
}

pub fn graph_flow_circulation_vector_to_string(v : GraphflowcirculationVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_flow_circulation_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_circulation_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_flow_circulation_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_flow_circulation_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_flow_circulation_std(data : Array[Double]) -> Double { graph_flow_circulation_sqrt(graph_flow_circulation_var(data)) }

pub fn graph_flow_circulation_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_flow_circulation_mean(a); let mb = graph_flow_circulation_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_flow_circulation_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_flow_circulation_std(a); let sb = graph_flow_circulation_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_flow_circulation_cov(a, b) / (sa * sb) }
}

pub fn graph_flow_circulation_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_flow_circulation_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_flow_circulation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_flow_circulation_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_flow_circulation_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  graph_flow_circulation_sqrt(graph_flow_circulation_mse(pred, labels))
}

pub fn graph_flow_circulation_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + graph_flow_circulation_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_flow_circulation_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_flow_circulation_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_flow_circulation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_flow_circulation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_flow_circulation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_flow_circulation_precision(pred, labels, pos); let r = graph_flow_circulation_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_flow_circulation_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_flow_circulation_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_flow_circulation_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_flow_circulation_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_flow_circulation_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_flow_circulation_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_flow_circulation_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_flow_circulation_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_flow_circulation_fibonacci(n : Int) -> Int {
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

pub fn graph_flow_circulation_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_flow_circulation_min(data); let mx = graph_flow_circulation_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_flow_circulation_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_flow_circulation_mean(data); let sd = graph_flow_circulation_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_flow_circulation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_flow_circulation_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_flow_circulation_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_flow_circulation_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_flow_circulation_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_flow_circulation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn graph_flow_circulation_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn graph_flow_circulation_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn graph_flow_circulation_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_flow_circulation_int(x) } else { -graph_flow_circulation_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_flow_circulation_int(f * 1000000.0) } else { graph_flow_circulation_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_flow_circulation_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_flow_circulation_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GraphflowcirculationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_frame_make(size : Int) -> GraphflowcirculationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_frame_len(s : GraphflowcirculationFrame) -> Int { s.size }

pub fn graph_flow_circulation_frame_get(s : GraphflowcirculationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_frame_set(s : GraphflowcirculationFrame, i : Int, v : Double) -> GraphflowcirculationFrame {
  let result = graph_flow_circulation_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_frame_sum(s : GraphflowcirculationFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_frame_mean(s : GraphflowcirculationFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_frame_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_frame_scale(s : GraphflowcirculationFrame, f : Double) -> GraphflowcirculationFrame {
  let result = graph_flow_circulation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_frame_add(a : GraphflowcirculationFrame, b : GraphflowcirculationFrame) -> GraphflowcirculationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_frame_copy(s : GraphflowcirculationFrame) -> GraphflowcirculationFrame {
  let result = graph_flow_circulation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_frame_fill(s : GraphflowcirculationFrame, v : Double) -> GraphflowcirculationFrame {
  let result = graph_flow_circulation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_frame_min(s : GraphflowcirculationFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_frame_max(s : GraphflowcirculationFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_frame_to_string(s : GraphflowcirculationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_table_make(size : Int) -> GraphflowcirculationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_table_len(s : GraphflowcirculationTable) -> Int { s.size }

pub fn graph_flow_circulation_table_get(s : GraphflowcirculationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_table_set(s : GraphflowcirculationTable, i : Int, v : Double) -> GraphflowcirculationTable {
  let result = graph_flow_circulation_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_table_sum(s : GraphflowcirculationTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_table_mean(s : GraphflowcirculationTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_table_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_table_scale(s : GraphflowcirculationTable, f : Double) -> GraphflowcirculationTable {
  let result = graph_flow_circulation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_table_add(a : GraphflowcirculationTable, b : GraphflowcirculationTable) -> GraphflowcirculationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_table_copy(s : GraphflowcirculationTable) -> GraphflowcirculationTable {
  let result = graph_flow_circulation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_table_fill(s : GraphflowcirculationTable, v : Double) -> GraphflowcirculationTable {
  let result = graph_flow_circulation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_table_min(s : GraphflowcirculationTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_table_max(s : GraphflowcirculationTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_table_to_string(s : GraphflowcirculationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_graphn_make(size : Int) -> GraphflowcirculationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_graphn_len(s : GraphflowcirculationGraphN) -> Int { s.size }

pub fn graph_flow_circulation_graphn_get(s : GraphflowcirculationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_graphn_set(s : GraphflowcirculationGraphN, i : Int, v : Double) -> GraphflowcirculationGraphN {
  let result = graph_flow_circulation_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_graphn_sum(s : GraphflowcirculationGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_graphn_mean(s : GraphflowcirculationGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_graphn_scale(s : GraphflowcirculationGraphN, f : Double) -> GraphflowcirculationGraphN {
  let result = graph_flow_circulation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_graphn_add(a : GraphflowcirculationGraphN, b : GraphflowcirculationGraphN) -> GraphflowcirculationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_graphn_copy(s : GraphflowcirculationGraphN) -> GraphflowcirculationGraphN {
  let result = graph_flow_circulation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_graphn_fill(s : GraphflowcirculationGraphN, v : Double) -> GraphflowcirculationGraphN {
  let result = graph_flow_circulation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_graphn_min(s : GraphflowcirculationGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_graphn_max(s : GraphflowcirculationGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_graphn_to_string(s : GraphflowcirculationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_node_make(size : Int) -> GraphflowcirculationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_node_len(s : GraphflowcirculationNode) -> Int { s.size }

pub fn graph_flow_circulation_node_get(s : GraphflowcirculationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_node_set(s : GraphflowcirculationNode, i : Int, v : Double) -> GraphflowcirculationNode {
  let result = graph_flow_circulation_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_node_sum(s : GraphflowcirculationNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_node_mean(s : GraphflowcirculationNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_node_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_node_scale(s : GraphflowcirculationNode, f : Double) -> GraphflowcirculationNode {
  let result = graph_flow_circulation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_node_add(a : GraphflowcirculationNode, b : GraphflowcirculationNode) -> GraphflowcirculationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_node_copy(s : GraphflowcirculationNode) -> GraphflowcirculationNode {
  let result = graph_flow_circulation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_node_fill(s : GraphflowcirculationNode, v : Double) -> GraphflowcirculationNode {
  let result = graph_flow_circulation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_node_min(s : GraphflowcirculationNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_node_max(s : GraphflowcirculationNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_node_to_string(s : GraphflowcirculationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_edge_make(size : Int) -> GraphflowcirculationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_edge_len(s : GraphflowcirculationEdge) -> Int { s.size }

pub fn graph_flow_circulation_edge_get(s : GraphflowcirculationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_edge_set(s : GraphflowcirculationEdge, i : Int, v : Double) -> GraphflowcirculationEdge {
  let result = graph_flow_circulation_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_edge_sum(s : GraphflowcirculationEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_edge_mean(s : GraphflowcirculationEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_edge_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_edge_scale(s : GraphflowcirculationEdge, f : Double) -> GraphflowcirculationEdge {
  let result = graph_flow_circulation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_edge_add(a : GraphflowcirculationEdge, b : GraphflowcirculationEdge) -> GraphflowcirculationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_edge_copy(s : GraphflowcirculationEdge) -> GraphflowcirculationEdge {
  let result = graph_flow_circulation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_edge_fill(s : GraphflowcirculationEdge, v : Double) -> GraphflowcirculationEdge {
  let result = graph_flow_circulation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_edge_min(s : GraphflowcirculationEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_edge_max(s : GraphflowcirculationEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_edge_to_string(s : GraphflowcirculationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_path_make(size : Int) -> GraphflowcirculationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_path_len(s : GraphflowcirculationPath) -> Int { s.size }

pub fn graph_flow_circulation_path_get(s : GraphflowcirculationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_path_set(s : GraphflowcirculationPath, i : Int, v : Double) -> GraphflowcirculationPath {
  let result = graph_flow_circulation_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_path_sum(s : GraphflowcirculationPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_path_mean(s : GraphflowcirculationPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_path_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_path_scale(s : GraphflowcirculationPath, f : Double) -> GraphflowcirculationPath {
  let result = graph_flow_circulation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_path_add(a : GraphflowcirculationPath, b : GraphflowcirculationPath) -> GraphflowcirculationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_path_copy(s : GraphflowcirculationPath) -> GraphflowcirculationPath {
  let result = graph_flow_circulation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_path_fill(s : GraphflowcirculationPath, v : Double) -> GraphflowcirculationPath {
  let result = graph_flow_circulation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_path_min(s : GraphflowcirculationPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_path_max(s : GraphflowcirculationPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_path_to_string(s : GraphflowcirculationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_cluster_make(size : Int) -> GraphflowcirculationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_cluster_len(s : GraphflowcirculationCluster) -> Int { s.size }

pub fn graph_flow_circulation_cluster_get(s : GraphflowcirculationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_cluster_set(s : GraphflowcirculationCluster, i : Int, v : Double) -> GraphflowcirculationCluster {
  let result = graph_flow_circulation_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_cluster_sum(s : GraphflowcirculationCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_cluster_mean(s : GraphflowcirculationCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_cluster_scale(s : GraphflowcirculationCluster, f : Double) -> GraphflowcirculationCluster {
  let result = graph_flow_circulation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_cluster_add(a : GraphflowcirculationCluster, b : GraphflowcirculationCluster) -> GraphflowcirculationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_cluster_copy(s : GraphflowcirculationCluster) -> GraphflowcirculationCluster {
  let result = graph_flow_circulation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_cluster_fill(s : GraphflowcirculationCluster, v : Double) -> GraphflowcirculationCluster {
  let result = graph_flow_circulation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_cluster_min(s : GraphflowcirculationCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_cluster_max(s : GraphflowcirculationCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_cluster_to_string(s : GraphflowcirculationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_model_make(size : Int) -> GraphflowcirculationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_model_len(s : GraphflowcirculationModel) -> Int { s.size }

pub fn graph_flow_circulation_model_get(s : GraphflowcirculationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_model_set(s : GraphflowcirculationModel, i : Int, v : Double) -> GraphflowcirculationModel {
  let result = graph_flow_circulation_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_model_sum(s : GraphflowcirculationModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_model_mean(s : GraphflowcirculationModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_model_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_model_scale(s : GraphflowcirculationModel, f : Double) -> GraphflowcirculationModel {
  let result = graph_flow_circulation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_model_add(a : GraphflowcirculationModel, b : GraphflowcirculationModel) -> GraphflowcirculationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_model_copy(s : GraphflowcirculationModel) -> GraphflowcirculationModel {
  let result = graph_flow_circulation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_model_fill(s : GraphflowcirculationModel, v : Double) -> GraphflowcirculationModel {
  let result = graph_flow_circulation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_model_min(s : GraphflowcirculationModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_model_max(s : GraphflowcirculationModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_model_to_string(s : GraphflowcirculationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_layer_make(size : Int) -> GraphflowcirculationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_layer_len(s : GraphflowcirculationLayer) -> Int { s.size }

pub fn graph_flow_circulation_layer_get(s : GraphflowcirculationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_layer_set(s : GraphflowcirculationLayer, i : Int, v : Double) -> GraphflowcirculationLayer {
  let result = graph_flow_circulation_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_layer_sum(s : GraphflowcirculationLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_layer_mean(s : GraphflowcirculationLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_layer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_layer_scale(s : GraphflowcirculationLayer, f : Double) -> GraphflowcirculationLayer {
  let result = graph_flow_circulation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_layer_add(a : GraphflowcirculationLayer, b : GraphflowcirculationLayer) -> GraphflowcirculationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_layer_copy(s : GraphflowcirculationLayer) -> GraphflowcirculationLayer {
  let result = graph_flow_circulation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_layer_fill(s : GraphflowcirculationLayer, v : Double) -> GraphflowcirculationLayer {
  let result = graph_flow_circulation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_layer_min(s : GraphflowcirculationLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_layer_max(s : GraphflowcirculationLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_layer_to_string(s : GraphflowcirculationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_buffer_make(size : Int) -> GraphflowcirculationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_buffer_len(s : GraphflowcirculationBuffer) -> Int { s.size }

pub fn graph_flow_circulation_buffer_get(s : GraphflowcirculationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_buffer_set(s : GraphflowcirculationBuffer, i : Int, v : Double) -> GraphflowcirculationBuffer {
  let result = graph_flow_circulation_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_buffer_sum(s : GraphflowcirculationBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_buffer_mean(s : GraphflowcirculationBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_buffer_scale(s : GraphflowcirculationBuffer, f : Double) -> GraphflowcirculationBuffer {
  let result = graph_flow_circulation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_buffer_add(a : GraphflowcirculationBuffer, b : GraphflowcirculationBuffer) -> GraphflowcirculationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_buffer_copy(s : GraphflowcirculationBuffer) -> GraphflowcirculationBuffer {
  let result = graph_flow_circulation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_buffer_fill(s : GraphflowcirculationBuffer, v : Double) -> GraphflowcirculationBuffer {
  let result = graph_flow_circulation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_buffer_min(s : GraphflowcirculationBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_buffer_max(s : GraphflowcirculationBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_buffer_to_string(s : GraphflowcirculationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_cursor_make(size : Int) -> GraphflowcirculationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_cursor_len(s : GraphflowcirculationCursor) -> Int { s.size }

pub fn graph_flow_circulation_cursor_get(s : GraphflowcirculationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_cursor_set(s : GraphflowcirculationCursor, i : Int, v : Double) -> GraphflowcirculationCursor {
  let result = graph_flow_circulation_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_cursor_sum(s : GraphflowcirculationCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_cursor_mean(s : GraphflowcirculationCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_cursor_scale(s : GraphflowcirculationCursor, f : Double) -> GraphflowcirculationCursor {
  let result = graph_flow_circulation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_cursor_add(a : GraphflowcirculationCursor, b : GraphflowcirculationCursor) -> GraphflowcirculationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_cursor_copy(s : GraphflowcirculationCursor) -> GraphflowcirculationCursor {
  let result = graph_flow_circulation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_cursor_fill(s : GraphflowcirculationCursor, v : Double) -> GraphflowcirculationCursor {
  let result = graph_flow_circulation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_cursor_min(s : GraphflowcirculationCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_cursor_max(s : GraphflowcirculationCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_cursor_to_string(s : GraphflowcirculationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_view_make(size : Int) -> GraphflowcirculationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_view_len(s : GraphflowcirculationView) -> Int { s.size }

pub fn graph_flow_circulation_view_get(s : GraphflowcirculationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_view_set(s : GraphflowcirculationView, i : Int, v : Double) -> GraphflowcirculationView {
  let result = graph_flow_circulation_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_view_sum(s : GraphflowcirculationView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_view_mean(s : GraphflowcirculationView) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_view_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_view_scale(s : GraphflowcirculationView, f : Double) -> GraphflowcirculationView {
  let result = graph_flow_circulation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_view_add(a : GraphflowcirculationView, b : GraphflowcirculationView) -> GraphflowcirculationView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_view_copy(s : GraphflowcirculationView) -> GraphflowcirculationView {
  let result = graph_flow_circulation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_view_fill(s : GraphflowcirculationView, v : Double) -> GraphflowcirculationView {
  let result = graph_flow_circulation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_view_min(s : GraphflowcirculationView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_view_max(s : GraphflowcirculationView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_view_to_string(s : GraphflowcirculationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_range_make(size : Int) -> GraphflowcirculationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_range_len(s : GraphflowcirculationRange) -> Int { s.size }

pub fn graph_flow_circulation_range_get(s : GraphflowcirculationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_range_set(s : GraphflowcirculationRange, i : Int, v : Double) -> GraphflowcirculationRange {
  let result = graph_flow_circulation_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_range_sum(s : GraphflowcirculationRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_range_mean(s : GraphflowcirculationRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_range_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_range_scale(s : GraphflowcirculationRange, f : Double) -> GraphflowcirculationRange {
  let result = graph_flow_circulation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_range_add(a : GraphflowcirculationRange, b : GraphflowcirculationRange) -> GraphflowcirculationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_range_copy(s : GraphflowcirculationRange) -> GraphflowcirculationRange {
  let result = graph_flow_circulation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_range_fill(s : GraphflowcirculationRange, v : Double) -> GraphflowcirculationRange {
  let result = graph_flow_circulation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_range_min(s : GraphflowcirculationRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_range_max(s : GraphflowcirculationRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_range_to_string(s : GraphflowcirculationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowcirculationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_circulation_slice_make(size : Int) -> GraphflowcirculationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_circulation_slice_len(s : GraphflowcirculationSlice) -> Int { s.size }

pub fn graph_flow_circulation_slice_get(s : GraphflowcirculationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_circulation_slice_set(s : GraphflowcirculationSlice, i : Int, v : Double) -> GraphflowcirculationSlice {
  let result = graph_flow_circulation_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_slice_sum(s : GraphflowcirculationSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_circulation_slice_mean(s : GraphflowcirculationSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_circulation_slice_sum(s) / s.size.to_double() }
}

pub fn graph_flow_circulation_slice_scale(s : GraphflowcirculationSlice, f : Double) -> GraphflowcirculationSlice {
  let result = graph_flow_circulation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_circulation_slice_add(a : GraphflowcirculationSlice, b : GraphflowcirculationSlice) -> GraphflowcirculationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_circulation_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_circulation_slice_copy(s : GraphflowcirculationSlice) -> GraphflowcirculationSlice {
  let result = graph_flow_circulation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_circulation_slice_fill(s : GraphflowcirculationSlice, v : Double) -> GraphflowcirculationSlice {
  let result = graph_flow_circulation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_circulation_slice_min(s : GraphflowcirculationSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_slice_max(s : GraphflowcirculationSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_circulation_slice_to_string(s : GraphflowcirculationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn graph_flow_circulation_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_circulation_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

