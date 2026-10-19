///===
/// extcore/graph_flow_evacuation

pub(all) struct GraphflowevacuationPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_flow_evacuation_make_point(x : Double, y : Double) -> GraphflowevacuationPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_flow_evacuation_make_point3(x : Double, y : Double, z : Double) -> GraphflowevacuationPoint {
  { x, y, z, label: 0 }
}

pub fn graph_flow_evacuation_point_x(pt : GraphflowevacuationPoint) -> Double { pt.x }

pub fn graph_flow_evacuation_point_y(pt : GraphflowevacuationPoint) -> Double { pt.y }

pub fn graph_flow_evacuation_point_z(pt : GraphflowevacuationPoint) -> Double { pt.z }

pub fn graph_flow_evacuation_point_label(pt : GraphflowevacuationPoint) -> Int { pt.label }

pub fn graph_flow_evacuation_point_dist(a : GraphflowevacuationPoint, b : GraphflowevacuationPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  graph_flow_evacuation_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_flow_evacuation_point_add(a : GraphflowevacuationPoint, b : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_flow_evacuation_point_sub(a : GraphflowevacuationPoint, b : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_flow_evacuation_point_scale(pt : GraphflowevacuationPoint, s : Double) -> GraphflowevacuationPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_flow_evacuation_point_dot(a : GraphflowevacuationPoint, b : GraphflowevacuationPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_flow_evacuation_point_cross(a : GraphflowevacuationPoint, b : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_flow_evacuation_point_norm(pt : GraphflowevacuationPoint) -> Double {
  graph_flow_evacuation_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_flow_evacuation_point_normalize(pt : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  let n = graph_flow_evacuation_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_flow_evacuation_point_scale(pt, 1.0 / n) }
}

pub fn graph_flow_evacuation_point_negate(pt : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_flow_evacuation_point_mid(a : GraphflowevacuationPoint, b : GraphflowevacuationPoint) -> GraphflowevacuationPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_flow_evacuation_point_lerp(a : GraphflowevacuationPoint, b : GraphflowevacuationPoint, t : Double) -> GraphflowevacuationPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_flow_evacuation_point_to_string(pt : GraphflowevacuationPoint) -> String {
  "(" + graph_flow_evacuation_dbl(pt.x) + ", " + graph_flow_evacuation_dbl(pt.y) + ", " + graph_flow_evacuation_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphflowevacuationSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_flow_evacuation_make_series(vals : Array[Double], name : String) -> GraphflowevacuationSeries {
  { vals, name, meta: 0 }
}

pub fn graph_flow_evacuation_series_len(s : GraphflowevacuationSeries) -> Int { s.vals.length() }

pub fn graph_flow_evacuation_series_sum(s : GraphflowevacuationSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_flow_evacuation_series_mean(s : GraphflowevacuationSeries) -> Double {
  let n = graph_flow_evacuation_series_len(s)
  if n == 0 { 0.0 } else { graph_flow_evacuation_series_sum(s) / n.to_double() }
}

pub fn graph_flow_evacuation_series_min(s : GraphflowevacuationSeries) -> Double {
  let n = graph_flow_evacuation_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_evacuation_series_max(s : GraphflowevacuationSeries) -> Double {
  let n = graph_flow_evacuation_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_flow_evacuation_series_range(s : GraphflowevacuationSeries) -> Double {
  graph_flow_evacuation_series_max(s) - graph_flow_evacuation_series_min(s)
}

pub fn graph_flow_evacuation_series_var(s : GraphflowevacuationSeries) -> Double {
  let n = graph_flow_evacuation_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_flow_evacuation_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_flow_evacuation_series_std(s : GraphflowevacuationSeries) -> Double { graph_flow_evacuation_sqrt(graph_flow_evacuation_series_var(s)) }

pub fn graph_flow_evacuation_series_median(s : GraphflowevacuationSeries) -> Double {
  let n = graph_flow_evacuation_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_flow_evacuation_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_flow_evacuation_series_scale(s : GraphflowevacuationSeries, f : Double) -> GraphflowevacuationSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_flow_evacuation_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_flow_evacuation_series_add(a : GraphflowevacuationSeries, b : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_flow_evacuation_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_flow_evacuation_series_sub(a : GraphflowevacuationSeries, b : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_flow_evacuation_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_flow_evacuation_series_normalize(s : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  let mn = graph_flow_evacuation_series_min(s)
  let mx = graph_flow_evacuation_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = graph_flow_evacuation_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_flow_evacuation_series_cumsum(s : GraphflowevacuationSeries) -> GraphflowevacuationSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = graph_flow_evacuation_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_flow_evacuation_series_to_string(s : GraphflowevacuationSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_flow_evacuation_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphflowevacuationMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_flow_evacuation_make_matrix(rows : Int, cols : Int, val : Double) -> GraphflowevacuationMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_flow_evacuation_matrix_identity(n : Int) -> GraphflowevacuationMatrix {
  let m = graph_flow_evacuation_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_flow_evacuation_matrix_get(m : GraphflowevacuationMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_flow_evacuation_matrix_transpose(m : GraphflowevacuationMatrix) -> GraphflowevacuationMatrix {
  let result = graph_flow_evacuation_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_flow_evacuation_matrix_add(a : GraphflowevacuationMatrix, b : GraphflowevacuationMatrix) -> GraphflowevacuationMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_flow_evacuation_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_flow_evacuation_matrix_scale(m : GraphflowevacuationMatrix, s : Double) -> GraphflowevacuationMatrix {
  let result = graph_flow_evacuation_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_flow_evacuation_matrix_multiply(a : GraphflowevacuationMatrix, b : GraphflowevacuationMatrix) -> GraphflowevacuationMatrix {
  if a.cols != b.rows { return graph_flow_evacuation_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_flow_evacuation_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_flow_evacuation_matrix_trace(m : GraphflowevacuationMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_flow_evacuation_matrix_det(m : GraphflowevacuationMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_flow_evacuation_matrix_norm(m : GraphflowevacuationMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  graph_flow_evacuation_sqrt(sum)
}

pub fn graph_flow_evacuation_matrix_to_string(m : GraphflowevacuationMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_flow_evacuation_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphflowevacuationVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_flow_evacuation_make_vector(comps : Array[Double]) -> GraphflowevacuationVector {
  { comps, dim: comps.length() }
}

pub fn graph_flow_evacuation_vector_zero(dim : Int) -> GraphflowevacuationVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_flow_evacuation_vector_add(a : GraphflowevacuationVector, b : GraphflowevacuationVector) -> GraphflowevacuationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_flow_evacuation_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_evacuation_vector_sub(a : GraphflowevacuationVector, b : GraphflowevacuationVector) -> GraphflowevacuationVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_flow_evacuation_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_flow_evacuation_vector_scale(v : GraphflowevacuationVector, s : Double) -> GraphflowevacuationVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_flow_evacuation_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_flow_evacuation_vector_dot(a : GraphflowevacuationVector, b : GraphflowevacuationVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_flow_evacuation_vector_norm(v : GraphflowevacuationVector) -> Double { graph_flow_evacuation_sqrt(graph_flow_evacuation_vector_dot(v, v)) }

pub fn graph_flow_evacuation_vector_normalize(v : GraphflowevacuationVector) -> GraphflowevacuationVector {
  let n = graph_flow_evacuation_vector_norm(v)
  if n < 0.0000001 { v } else { graph_flow_evacuation_vector_scale(v, 1.0 / n) }
}

pub fn graph_flow_evacuation_vector_dist(a : GraphflowevacuationVector, b : GraphflowevacuationVector) -> Double {
  graph_flow_evacuation_vector_norm(graph_flow_evacuation_vector_sub(a, b))
}

pub fn graph_flow_evacuation_vector_to_string(v : GraphflowevacuationVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_flow_evacuation_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_flow_evacuation_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_flow_evacuation_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_flow_evacuation_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_flow_evacuation_std(data : Array[Double]) -> Double { graph_flow_evacuation_sqrt(graph_flow_evacuation_var(data)) }

pub fn graph_flow_evacuation_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_flow_evacuation_mean(a); let mb = graph_flow_evacuation_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_flow_evacuation_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_flow_evacuation_std(a); let sb = graph_flow_evacuation_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_flow_evacuation_cov(a, b) / (sa * sb) }
}

pub fn graph_flow_evacuation_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_flow_evacuation_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_flow_evacuation_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_flow_evacuation_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_flow_evacuation_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  graph_flow_evacuation_sqrt(graph_flow_evacuation_mse(pred, labels))
}

pub fn graph_flow_evacuation_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + graph_flow_evacuation_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_flow_evacuation_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_flow_evacuation_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_flow_evacuation_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_flow_evacuation_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_flow_evacuation_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_flow_evacuation_precision(pred, labels, pos); let r = graph_flow_evacuation_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_flow_evacuation_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_flow_evacuation_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_flow_evacuation_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_flow_evacuation_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_flow_evacuation_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_flow_evacuation_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_flow_evacuation_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_flow_evacuation_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_flow_evacuation_fibonacci(n : Int) -> Int {
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

pub fn graph_flow_evacuation_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_flow_evacuation_min(data); let mx = graph_flow_evacuation_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_flow_evacuation_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_flow_evacuation_mean(data); let sd = graph_flow_evacuation_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_flow_evacuation_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_flow_evacuation_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_flow_evacuation_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_flow_evacuation_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn graph_flow_evacuation_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn graph_flow_evacuation_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn graph_flow_evacuation_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_flow_evacuation_int(x) } else { -graph_flow_evacuation_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_flow_evacuation_int(f * 1000000.0) } else { graph_flow_evacuation_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_flow_evacuation_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_flow_evacuation_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GraphflowevacuationFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_frame_make(size : Int) -> GraphflowevacuationFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_frame_len(s : GraphflowevacuationFrame) -> Int { s.size }

pub fn graph_flow_evacuation_frame_get(s : GraphflowevacuationFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_frame_set(s : GraphflowevacuationFrame, i : Int, v : Double) -> GraphflowevacuationFrame {
  let result = graph_flow_evacuation_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_frame_sum(s : GraphflowevacuationFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_frame_mean(s : GraphflowevacuationFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_frame_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_frame_scale(s : GraphflowevacuationFrame, f : Double) -> GraphflowevacuationFrame {
  let result = graph_flow_evacuation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_frame_add(a : GraphflowevacuationFrame, b : GraphflowevacuationFrame) -> GraphflowevacuationFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_frame_copy(s : GraphflowevacuationFrame) -> GraphflowevacuationFrame {
  let result = graph_flow_evacuation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_frame_fill(s : GraphflowevacuationFrame, v : Double) -> GraphflowevacuationFrame {
  let result = graph_flow_evacuation_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_frame_min(s : GraphflowevacuationFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_frame_max(s : GraphflowevacuationFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_frame_to_string(s : GraphflowevacuationFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_table_make(size : Int) -> GraphflowevacuationTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_table_len(s : GraphflowevacuationTable) -> Int { s.size }

pub fn graph_flow_evacuation_table_get(s : GraphflowevacuationTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_table_set(s : GraphflowevacuationTable, i : Int, v : Double) -> GraphflowevacuationTable {
  let result = graph_flow_evacuation_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_table_sum(s : GraphflowevacuationTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_table_mean(s : GraphflowevacuationTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_table_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_table_scale(s : GraphflowevacuationTable, f : Double) -> GraphflowevacuationTable {
  let result = graph_flow_evacuation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_table_add(a : GraphflowevacuationTable, b : GraphflowevacuationTable) -> GraphflowevacuationTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_table_copy(s : GraphflowevacuationTable) -> GraphflowevacuationTable {
  let result = graph_flow_evacuation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_table_fill(s : GraphflowevacuationTable, v : Double) -> GraphflowevacuationTable {
  let result = graph_flow_evacuation_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_table_min(s : GraphflowevacuationTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_table_max(s : GraphflowevacuationTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_table_to_string(s : GraphflowevacuationTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_graphn_make(size : Int) -> GraphflowevacuationGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_graphn_len(s : GraphflowevacuationGraphN) -> Int { s.size }

pub fn graph_flow_evacuation_graphn_get(s : GraphflowevacuationGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_graphn_set(s : GraphflowevacuationGraphN, i : Int, v : Double) -> GraphflowevacuationGraphN {
  let result = graph_flow_evacuation_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_graphn_sum(s : GraphflowevacuationGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_graphn_mean(s : GraphflowevacuationGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_graphn_scale(s : GraphflowevacuationGraphN, f : Double) -> GraphflowevacuationGraphN {
  let result = graph_flow_evacuation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_graphn_add(a : GraphflowevacuationGraphN, b : GraphflowevacuationGraphN) -> GraphflowevacuationGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_graphn_copy(s : GraphflowevacuationGraphN) -> GraphflowevacuationGraphN {
  let result = graph_flow_evacuation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_graphn_fill(s : GraphflowevacuationGraphN, v : Double) -> GraphflowevacuationGraphN {
  let result = graph_flow_evacuation_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_graphn_min(s : GraphflowevacuationGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_graphn_max(s : GraphflowevacuationGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_graphn_to_string(s : GraphflowevacuationGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_node_make(size : Int) -> GraphflowevacuationNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_node_len(s : GraphflowevacuationNode) -> Int { s.size }

pub fn graph_flow_evacuation_node_get(s : GraphflowevacuationNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_node_set(s : GraphflowevacuationNode, i : Int, v : Double) -> GraphflowevacuationNode {
  let result = graph_flow_evacuation_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_node_sum(s : GraphflowevacuationNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_node_mean(s : GraphflowevacuationNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_node_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_node_scale(s : GraphflowevacuationNode, f : Double) -> GraphflowevacuationNode {
  let result = graph_flow_evacuation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_node_add(a : GraphflowevacuationNode, b : GraphflowevacuationNode) -> GraphflowevacuationNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_node_copy(s : GraphflowevacuationNode) -> GraphflowevacuationNode {
  let result = graph_flow_evacuation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_node_fill(s : GraphflowevacuationNode, v : Double) -> GraphflowevacuationNode {
  let result = graph_flow_evacuation_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_node_min(s : GraphflowevacuationNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_node_max(s : GraphflowevacuationNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_node_to_string(s : GraphflowevacuationNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_edge_make(size : Int) -> GraphflowevacuationEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_edge_len(s : GraphflowevacuationEdge) -> Int { s.size }

pub fn graph_flow_evacuation_edge_get(s : GraphflowevacuationEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_edge_set(s : GraphflowevacuationEdge, i : Int, v : Double) -> GraphflowevacuationEdge {
  let result = graph_flow_evacuation_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_edge_sum(s : GraphflowevacuationEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_edge_mean(s : GraphflowevacuationEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_edge_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_edge_scale(s : GraphflowevacuationEdge, f : Double) -> GraphflowevacuationEdge {
  let result = graph_flow_evacuation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_edge_add(a : GraphflowevacuationEdge, b : GraphflowevacuationEdge) -> GraphflowevacuationEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_edge_copy(s : GraphflowevacuationEdge) -> GraphflowevacuationEdge {
  let result = graph_flow_evacuation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_edge_fill(s : GraphflowevacuationEdge, v : Double) -> GraphflowevacuationEdge {
  let result = graph_flow_evacuation_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_edge_min(s : GraphflowevacuationEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_edge_max(s : GraphflowevacuationEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_edge_to_string(s : GraphflowevacuationEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_path_make(size : Int) -> GraphflowevacuationPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_path_len(s : GraphflowevacuationPath) -> Int { s.size }

pub fn graph_flow_evacuation_path_get(s : GraphflowevacuationPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_path_set(s : GraphflowevacuationPath, i : Int, v : Double) -> GraphflowevacuationPath {
  let result = graph_flow_evacuation_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_path_sum(s : GraphflowevacuationPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_path_mean(s : GraphflowevacuationPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_path_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_path_scale(s : GraphflowevacuationPath, f : Double) -> GraphflowevacuationPath {
  let result = graph_flow_evacuation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_path_add(a : GraphflowevacuationPath, b : GraphflowevacuationPath) -> GraphflowevacuationPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_path_copy(s : GraphflowevacuationPath) -> GraphflowevacuationPath {
  let result = graph_flow_evacuation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_path_fill(s : GraphflowevacuationPath, v : Double) -> GraphflowevacuationPath {
  let result = graph_flow_evacuation_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_path_min(s : GraphflowevacuationPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_path_max(s : GraphflowevacuationPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_path_to_string(s : GraphflowevacuationPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_cluster_make(size : Int) -> GraphflowevacuationCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_cluster_len(s : GraphflowevacuationCluster) -> Int { s.size }

pub fn graph_flow_evacuation_cluster_get(s : GraphflowevacuationCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_cluster_set(s : GraphflowevacuationCluster, i : Int, v : Double) -> GraphflowevacuationCluster {
  let result = graph_flow_evacuation_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_cluster_sum(s : GraphflowevacuationCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_cluster_mean(s : GraphflowevacuationCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_cluster_scale(s : GraphflowevacuationCluster, f : Double) -> GraphflowevacuationCluster {
  let result = graph_flow_evacuation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_cluster_add(a : GraphflowevacuationCluster, b : GraphflowevacuationCluster) -> GraphflowevacuationCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_cluster_copy(s : GraphflowevacuationCluster) -> GraphflowevacuationCluster {
  let result = graph_flow_evacuation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_cluster_fill(s : GraphflowevacuationCluster, v : Double) -> GraphflowevacuationCluster {
  let result = graph_flow_evacuation_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_cluster_min(s : GraphflowevacuationCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_cluster_max(s : GraphflowevacuationCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_cluster_to_string(s : GraphflowevacuationCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_model_make(size : Int) -> GraphflowevacuationModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_model_len(s : GraphflowevacuationModel) -> Int { s.size }

pub fn graph_flow_evacuation_model_get(s : GraphflowevacuationModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_model_set(s : GraphflowevacuationModel, i : Int, v : Double) -> GraphflowevacuationModel {
  let result = graph_flow_evacuation_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_model_sum(s : GraphflowevacuationModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_model_mean(s : GraphflowevacuationModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_model_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_model_scale(s : GraphflowevacuationModel, f : Double) -> GraphflowevacuationModel {
  let result = graph_flow_evacuation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_model_add(a : GraphflowevacuationModel, b : GraphflowevacuationModel) -> GraphflowevacuationModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_model_copy(s : GraphflowevacuationModel) -> GraphflowevacuationModel {
  let result = graph_flow_evacuation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_model_fill(s : GraphflowevacuationModel, v : Double) -> GraphflowevacuationModel {
  let result = graph_flow_evacuation_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_model_min(s : GraphflowevacuationModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_model_max(s : GraphflowevacuationModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_model_to_string(s : GraphflowevacuationModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_layer_make(size : Int) -> GraphflowevacuationLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_layer_len(s : GraphflowevacuationLayer) -> Int { s.size }

pub fn graph_flow_evacuation_layer_get(s : GraphflowevacuationLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_layer_set(s : GraphflowevacuationLayer, i : Int, v : Double) -> GraphflowevacuationLayer {
  let result = graph_flow_evacuation_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_layer_sum(s : GraphflowevacuationLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_layer_mean(s : GraphflowevacuationLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_layer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_layer_scale(s : GraphflowevacuationLayer, f : Double) -> GraphflowevacuationLayer {
  let result = graph_flow_evacuation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_layer_add(a : GraphflowevacuationLayer, b : GraphflowevacuationLayer) -> GraphflowevacuationLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_layer_copy(s : GraphflowevacuationLayer) -> GraphflowevacuationLayer {
  let result = graph_flow_evacuation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_layer_fill(s : GraphflowevacuationLayer, v : Double) -> GraphflowevacuationLayer {
  let result = graph_flow_evacuation_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_layer_min(s : GraphflowevacuationLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_layer_max(s : GraphflowevacuationLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_layer_to_string(s : GraphflowevacuationLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_buffer_make(size : Int) -> GraphflowevacuationBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_buffer_len(s : GraphflowevacuationBuffer) -> Int { s.size }

pub fn graph_flow_evacuation_buffer_get(s : GraphflowevacuationBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_buffer_set(s : GraphflowevacuationBuffer, i : Int, v : Double) -> GraphflowevacuationBuffer {
  let result = graph_flow_evacuation_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_buffer_sum(s : GraphflowevacuationBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_buffer_mean(s : GraphflowevacuationBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_buffer_scale(s : GraphflowevacuationBuffer, f : Double) -> GraphflowevacuationBuffer {
  let result = graph_flow_evacuation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_buffer_add(a : GraphflowevacuationBuffer, b : GraphflowevacuationBuffer) -> GraphflowevacuationBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_buffer_copy(s : GraphflowevacuationBuffer) -> GraphflowevacuationBuffer {
  let result = graph_flow_evacuation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_buffer_fill(s : GraphflowevacuationBuffer, v : Double) -> GraphflowevacuationBuffer {
  let result = graph_flow_evacuation_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_buffer_min(s : GraphflowevacuationBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_buffer_max(s : GraphflowevacuationBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_buffer_to_string(s : GraphflowevacuationBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_cursor_make(size : Int) -> GraphflowevacuationCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_cursor_len(s : GraphflowevacuationCursor) -> Int { s.size }

pub fn graph_flow_evacuation_cursor_get(s : GraphflowevacuationCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_cursor_set(s : GraphflowevacuationCursor, i : Int, v : Double) -> GraphflowevacuationCursor {
  let result = graph_flow_evacuation_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_cursor_sum(s : GraphflowevacuationCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_cursor_mean(s : GraphflowevacuationCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_cursor_scale(s : GraphflowevacuationCursor, f : Double) -> GraphflowevacuationCursor {
  let result = graph_flow_evacuation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_cursor_add(a : GraphflowevacuationCursor, b : GraphflowevacuationCursor) -> GraphflowevacuationCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_cursor_copy(s : GraphflowevacuationCursor) -> GraphflowevacuationCursor {
  let result = graph_flow_evacuation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_cursor_fill(s : GraphflowevacuationCursor, v : Double) -> GraphflowevacuationCursor {
  let result = graph_flow_evacuation_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_cursor_min(s : GraphflowevacuationCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_cursor_max(s : GraphflowevacuationCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_cursor_to_string(s : GraphflowevacuationCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_view_make(size : Int) -> GraphflowevacuationView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_view_len(s : GraphflowevacuationView) -> Int { s.size }

pub fn graph_flow_evacuation_view_get(s : GraphflowevacuationView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_view_set(s : GraphflowevacuationView, i : Int, v : Double) -> GraphflowevacuationView {
  let result = graph_flow_evacuation_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_view_sum(s : GraphflowevacuationView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_view_mean(s : GraphflowevacuationView) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_view_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_view_scale(s : GraphflowevacuationView, f : Double) -> GraphflowevacuationView {
  let result = graph_flow_evacuation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_view_add(a : GraphflowevacuationView, b : GraphflowevacuationView) -> GraphflowevacuationView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_view_copy(s : GraphflowevacuationView) -> GraphflowevacuationView {
  let result = graph_flow_evacuation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_view_fill(s : GraphflowevacuationView, v : Double) -> GraphflowevacuationView {
  let result = graph_flow_evacuation_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_view_min(s : GraphflowevacuationView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_view_max(s : GraphflowevacuationView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_view_to_string(s : GraphflowevacuationView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_range_make(size : Int) -> GraphflowevacuationRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_range_len(s : GraphflowevacuationRange) -> Int { s.size }

pub fn graph_flow_evacuation_range_get(s : GraphflowevacuationRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_range_set(s : GraphflowevacuationRange, i : Int, v : Double) -> GraphflowevacuationRange {
  let result = graph_flow_evacuation_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_range_sum(s : GraphflowevacuationRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_range_mean(s : GraphflowevacuationRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_range_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_range_scale(s : GraphflowevacuationRange, f : Double) -> GraphflowevacuationRange {
  let result = graph_flow_evacuation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_range_add(a : GraphflowevacuationRange, b : GraphflowevacuationRange) -> GraphflowevacuationRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_range_copy(s : GraphflowevacuationRange) -> GraphflowevacuationRange {
  let result = graph_flow_evacuation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_range_fill(s : GraphflowevacuationRange, v : Double) -> GraphflowevacuationRange {
  let result = graph_flow_evacuation_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_range_min(s : GraphflowevacuationRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_range_max(s : GraphflowevacuationRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_range_to_string(s : GraphflowevacuationRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphflowevacuationSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_flow_evacuation_slice_make(size : Int) -> GraphflowevacuationSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_flow_evacuation_slice_len(s : GraphflowevacuationSlice) -> Int { s.size }

pub fn graph_flow_evacuation_slice_get(s : GraphflowevacuationSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_flow_evacuation_slice_set(s : GraphflowevacuationSlice, i : Int, v : Double) -> GraphflowevacuationSlice {
  let result = graph_flow_evacuation_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_slice_sum(s : GraphflowevacuationSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_flow_evacuation_slice_mean(s : GraphflowevacuationSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_flow_evacuation_slice_sum(s) / s.size.to_double() }
}

pub fn graph_flow_evacuation_slice_scale(s : GraphflowevacuationSlice, f : Double) -> GraphflowevacuationSlice {
  let result = graph_flow_evacuation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_flow_evacuation_slice_add(a : GraphflowevacuationSlice, b : GraphflowevacuationSlice) -> GraphflowevacuationSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_flow_evacuation_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_flow_evacuation_slice_copy(s : GraphflowevacuationSlice) -> GraphflowevacuationSlice {
  let result = graph_flow_evacuation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_flow_evacuation_slice_fill(s : GraphflowevacuationSlice, v : Double) -> GraphflowevacuationSlice {
  let result = graph_flow_evacuation_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_flow_evacuation_slice_min(s : GraphflowevacuationSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_slice_max(s : GraphflowevacuationSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_flow_evacuation_slice_to_string(s : GraphflowevacuationSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn graph_flow_evacuation_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_flow_evacuation_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

