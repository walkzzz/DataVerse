///===
/// extcore/graph_search_bidirectional

pub(all) struct GraphsearchbidirectionalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_bidirectional_make_point(x : Double, y : Double) -> GraphsearchbidirectionalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_bidirectional_make_point3(x : Double, y : Double, z : Double) -> GraphsearchbidirectionalPoint {
  { x, y, z, label: 0 }
}

pub fn graph_search_bidirectional_point_x(pt : GraphsearchbidirectionalPoint) -> Double { pt.x }

pub fn graph_search_bidirectional_point_y(pt : GraphsearchbidirectionalPoint) -> Double { pt.y }

pub fn graph_search_bidirectional_point_z(pt : GraphsearchbidirectionalPoint) -> Double { pt.z }

pub fn graph_search_bidirectional_point_label(pt : GraphsearchbidirectionalPoint) -> Int { pt.label }

pub fn graph_search_bidirectional_point_dist(a : GraphsearchbidirectionalPoint, b : GraphsearchbidirectionalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_search_bidirectional_point_add(a : GraphsearchbidirectionalPoint, b : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_search_bidirectional_point_sub(a : GraphsearchbidirectionalPoint, b : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_search_bidirectional_point_scale(pt : GraphsearchbidirectionalPoint, s : Double) -> GraphsearchbidirectionalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_search_bidirectional_point_dot(a : GraphsearchbidirectionalPoint, b : GraphsearchbidirectionalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_search_bidirectional_point_cross(a : GraphsearchbidirectionalPoint, b : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_search_bidirectional_point_norm(pt : GraphsearchbidirectionalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_search_bidirectional_point_normalize(pt : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  let n = graph_search_bidirectional_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_search_bidirectional_point_scale(pt, 1.0 / n) }
}

pub fn graph_search_bidirectional_point_negate(pt : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_search_bidirectional_point_mid(a : GraphsearchbidirectionalPoint, b : GraphsearchbidirectionalPoint) -> GraphsearchbidirectionalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_search_bidirectional_point_lerp(a : GraphsearchbidirectionalPoint, b : GraphsearchbidirectionalPoint, t : Double) -> GraphsearchbidirectionalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_search_bidirectional_point_to_string(pt : GraphsearchbidirectionalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_bidirectional_make_series(vals : Array[Double], name : String) -> GraphsearchbidirectionalSeries {
  { vals, name, meta: 0 }
}

pub fn graph_search_bidirectional_series_len(s : GraphsearchbidirectionalSeries) -> Int { s.vals.length() }

pub fn graph_search_bidirectional_series_sum(s : GraphsearchbidirectionalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_search_bidirectional_series_mean(s : GraphsearchbidirectionalSeries) -> Double {
  let n = graph_search_bidirectional_series_len(s)
  if n == 0 { 0.0 } else { graph_search_bidirectional_series_sum(s) / n.to_double() }
}

pub fn graph_search_bidirectional_series_min(s : GraphsearchbidirectionalSeries) -> Double {
  let n = graph_search_bidirectional_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_bidirectional_series_max(s : GraphsearchbidirectionalSeries) -> Double {
  let n = graph_search_bidirectional_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_bidirectional_series_range(s : GraphsearchbidirectionalSeries) -> Double {
  graph_search_bidirectional_series_max(s) - graph_search_bidirectional_series_min(s)
}

pub fn graph_search_bidirectional_series_var(s : GraphsearchbidirectionalSeries) -> Double {
  let n = graph_search_bidirectional_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_search_bidirectional_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_search_bidirectional_series_std(s : GraphsearchbidirectionalSeries) -> Double { @_common.sqrt(graph_search_bidirectional_series_var(s)) }

pub fn graph_search_bidirectional_series_median(s : GraphsearchbidirectionalSeries) -> Double {
  let n = graph_search_bidirectional_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_search_bidirectional_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_search_bidirectional_series_scale(s : GraphsearchbidirectionalSeries, f : Double) -> GraphsearchbidirectionalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_search_bidirectional_series_add(a : GraphsearchbidirectionalSeries, b : GraphsearchbidirectionalSeries) -> GraphsearchbidirectionalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_search_bidirectional_series_sub(a : GraphsearchbidirectionalSeries, b : GraphsearchbidirectionalSeries) -> GraphsearchbidirectionalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_search_bidirectional_series_normalize(s : GraphsearchbidirectionalSeries) -> GraphsearchbidirectionalSeries {
  let mn = graph_search_bidirectional_series_min(s)
  let mx = graph_search_bidirectional_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_search_bidirectional_series_cumsum(s : GraphsearchbidirectionalSeries) -> GraphsearchbidirectionalSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_search_bidirectional_series_to_string(s : GraphsearchbidirectionalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbidirectionalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_bidirectional_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchbidirectionalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_bidirectional_matrix_identity(n : Int) -> GraphsearchbidirectionalMatrix {
  let m = graph_search_bidirectional_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_search_bidirectional_matrix_get(m : GraphsearchbidirectionalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_search_bidirectional_matrix_transpose(m : GraphsearchbidirectionalMatrix) -> GraphsearchbidirectionalMatrix {
  let result = graph_search_bidirectional_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_search_bidirectional_matrix_add(a : GraphsearchbidirectionalMatrix, b : GraphsearchbidirectionalMatrix) -> GraphsearchbidirectionalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_search_bidirectional_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_search_bidirectional_matrix_scale(m : GraphsearchbidirectionalMatrix, s : Double) -> GraphsearchbidirectionalMatrix {
  let result = graph_search_bidirectional_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_search_bidirectional_matrix_multiply(a : GraphsearchbidirectionalMatrix, b : GraphsearchbidirectionalMatrix) -> GraphsearchbidirectionalMatrix {
  if a.cols != b.rows { return graph_search_bidirectional_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_search_bidirectional_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_search_bidirectional_matrix_trace(m : GraphsearchbidirectionalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_search_bidirectional_matrix_det(m : GraphsearchbidirectionalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_search_bidirectional_matrix_norm(m : GraphsearchbidirectionalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_search_bidirectional_matrix_to_string(m : GraphsearchbidirectionalMatrix) -> String {
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

pub(all) struct GraphsearchbidirectionalVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_bidirectional_make_vector(comps : Array[Double]) -> GraphsearchbidirectionalVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_bidirectional_vector_zero(dim : Int) -> GraphsearchbidirectionalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_search_bidirectional_vector_add(a : GraphsearchbidirectionalVector, b : GraphsearchbidirectionalVector) -> GraphsearchbidirectionalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_bidirectional_vector_sub(a : GraphsearchbidirectionalVector, b : GraphsearchbidirectionalVector) -> GraphsearchbidirectionalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_bidirectional_vector_scale(v : GraphsearchbidirectionalVector, s : Double) -> GraphsearchbidirectionalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_search_bidirectional_vector_dot(a : GraphsearchbidirectionalVector, b : GraphsearchbidirectionalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_search_bidirectional_vector_norm(v : GraphsearchbidirectionalVector) -> Double { @_common.sqrt(graph_search_bidirectional_vector_dot(v, v)) }

pub fn graph_search_bidirectional_vector_normalize(v : GraphsearchbidirectionalVector) -> GraphsearchbidirectionalVector {
  let n = graph_search_bidirectional_vector_norm(v)
  if n < 0.0000001 { v } else { graph_search_bidirectional_vector_scale(v, 1.0 / n) }
}

pub fn graph_search_bidirectional_vector_dist(a : GraphsearchbidirectionalVector, b : GraphsearchbidirectionalVector) -> Double {
  graph_search_bidirectional_vector_norm(graph_search_bidirectional_vector_sub(a, b))
}

pub fn graph_search_bidirectional_vector_to_string(v : GraphsearchbidirectionalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_bidirectional_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_search_bidirectional_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_search_bidirectional_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_search_bidirectional_std(data : Array[Double]) -> Double { @_common.sqrt(graph_search_bidirectional_var(data)) }

pub fn graph_search_bidirectional_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_search_bidirectional_mean(a); let mb = graph_search_bidirectional_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_search_bidirectional_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_search_bidirectional_std(a); let sb = graph_search_bidirectional_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_search_bidirectional_cov(a, b) / (sa * sb) }
}

pub fn graph_search_bidirectional_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_search_bidirectional_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_search_bidirectional_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_search_bidirectional_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_search_bidirectional_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(graph_search_bidirectional_mse(pred, labels))
}

pub fn graph_search_bidirectional_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_search_bidirectional_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_search_bidirectional_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_search_bidirectional_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_search_bidirectional_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_search_bidirectional_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_search_bidirectional_precision(pred, labels, pos); let r = graph_search_bidirectional_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_search_bidirectional_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_search_bidirectional_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_search_bidirectional_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_search_bidirectional_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_search_bidirectional_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_search_bidirectional_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_search_bidirectional_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_search_bidirectional_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_search_bidirectional_fibonacci(n : Int) -> Int {
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

pub fn graph_search_bidirectional_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_search_bidirectional_min(data); let mx = graph_search_bidirectional_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_search_bidirectional_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_search_bidirectional_mean(data); let sd = graph_search_bidirectional_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_search_bidirectional_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_search_bidirectional_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_search_bidirectional_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_search_bidirectional_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GraphsearchbidirectionalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_frame_make(size : Int) -> GraphsearchbidirectionalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_frame_len(s : GraphsearchbidirectionalFrame) -> Int { s.size }

pub fn graph_search_bidirectional_frame_get(s : GraphsearchbidirectionalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_frame_set(s : GraphsearchbidirectionalFrame, i : Int, v : Double) -> GraphsearchbidirectionalFrame {
  let result = graph_search_bidirectional_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_frame_sum(s : GraphsearchbidirectionalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_frame_mean(s : GraphsearchbidirectionalFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_frame_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_frame_scale(s : GraphsearchbidirectionalFrame, f : Double) -> GraphsearchbidirectionalFrame {
  let result = graph_search_bidirectional_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_frame_add(a : GraphsearchbidirectionalFrame, b : GraphsearchbidirectionalFrame) -> GraphsearchbidirectionalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_frame_copy(s : GraphsearchbidirectionalFrame) -> GraphsearchbidirectionalFrame {
  let result = graph_search_bidirectional_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_frame_fill(s : GraphsearchbidirectionalFrame, v : Double) -> GraphsearchbidirectionalFrame {
  let result = graph_search_bidirectional_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_frame_min(s : GraphsearchbidirectionalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_frame_max(s : GraphsearchbidirectionalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_frame_to_string(s : GraphsearchbidirectionalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_table_make(size : Int) -> GraphsearchbidirectionalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_table_len(s : GraphsearchbidirectionalTable) -> Int { s.size }

pub fn graph_search_bidirectional_table_get(s : GraphsearchbidirectionalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_table_set(s : GraphsearchbidirectionalTable, i : Int, v : Double) -> GraphsearchbidirectionalTable {
  let result = graph_search_bidirectional_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_table_sum(s : GraphsearchbidirectionalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_table_mean(s : GraphsearchbidirectionalTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_table_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_table_scale(s : GraphsearchbidirectionalTable, f : Double) -> GraphsearchbidirectionalTable {
  let result = graph_search_bidirectional_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_table_add(a : GraphsearchbidirectionalTable, b : GraphsearchbidirectionalTable) -> GraphsearchbidirectionalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_table_copy(s : GraphsearchbidirectionalTable) -> GraphsearchbidirectionalTable {
  let result = graph_search_bidirectional_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_table_fill(s : GraphsearchbidirectionalTable, v : Double) -> GraphsearchbidirectionalTable {
  let result = graph_search_bidirectional_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_table_min(s : GraphsearchbidirectionalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_table_max(s : GraphsearchbidirectionalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_table_to_string(s : GraphsearchbidirectionalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_graphn_make(size : Int) -> GraphsearchbidirectionalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_graphn_len(s : GraphsearchbidirectionalGraphN) -> Int { s.size }

pub fn graph_search_bidirectional_graphn_get(s : GraphsearchbidirectionalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_graphn_set(s : GraphsearchbidirectionalGraphN, i : Int, v : Double) -> GraphsearchbidirectionalGraphN {
  let result = graph_search_bidirectional_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_graphn_sum(s : GraphsearchbidirectionalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_graphn_mean(s : GraphsearchbidirectionalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_graphn_scale(s : GraphsearchbidirectionalGraphN, f : Double) -> GraphsearchbidirectionalGraphN {
  let result = graph_search_bidirectional_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_graphn_add(a : GraphsearchbidirectionalGraphN, b : GraphsearchbidirectionalGraphN) -> GraphsearchbidirectionalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_graphn_copy(s : GraphsearchbidirectionalGraphN) -> GraphsearchbidirectionalGraphN {
  let result = graph_search_bidirectional_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_graphn_fill(s : GraphsearchbidirectionalGraphN, v : Double) -> GraphsearchbidirectionalGraphN {
  let result = graph_search_bidirectional_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_graphn_min(s : GraphsearchbidirectionalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_graphn_max(s : GraphsearchbidirectionalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_graphn_to_string(s : GraphsearchbidirectionalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_node_make(size : Int) -> GraphsearchbidirectionalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_node_len(s : GraphsearchbidirectionalNode) -> Int { s.size }

pub fn graph_search_bidirectional_node_get(s : GraphsearchbidirectionalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_node_set(s : GraphsearchbidirectionalNode, i : Int, v : Double) -> GraphsearchbidirectionalNode {
  let result = graph_search_bidirectional_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_node_sum(s : GraphsearchbidirectionalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_node_mean(s : GraphsearchbidirectionalNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_node_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_node_scale(s : GraphsearchbidirectionalNode, f : Double) -> GraphsearchbidirectionalNode {
  let result = graph_search_bidirectional_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_node_add(a : GraphsearchbidirectionalNode, b : GraphsearchbidirectionalNode) -> GraphsearchbidirectionalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_node_copy(s : GraphsearchbidirectionalNode) -> GraphsearchbidirectionalNode {
  let result = graph_search_bidirectional_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_node_fill(s : GraphsearchbidirectionalNode, v : Double) -> GraphsearchbidirectionalNode {
  let result = graph_search_bidirectional_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_node_min(s : GraphsearchbidirectionalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_node_max(s : GraphsearchbidirectionalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_node_to_string(s : GraphsearchbidirectionalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_edge_make(size : Int) -> GraphsearchbidirectionalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_edge_len(s : GraphsearchbidirectionalEdge) -> Int { s.size }

pub fn graph_search_bidirectional_edge_get(s : GraphsearchbidirectionalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_edge_set(s : GraphsearchbidirectionalEdge, i : Int, v : Double) -> GraphsearchbidirectionalEdge {
  let result = graph_search_bidirectional_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_edge_sum(s : GraphsearchbidirectionalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_edge_mean(s : GraphsearchbidirectionalEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_edge_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_edge_scale(s : GraphsearchbidirectionalEdge, f : Double) -> GraphsearchbidirectionalEdge {
  let result = graph_search_bidirectional_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_edge_add(a : GraphsearchbidirectionalEdge, b : GraphsearchbidirectionalEdge) -> GraphsearchbidirectionalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_edge_copy(s : GraphsearchbidirectionalEdge) -> GraphsearchbidirectionalEdge {
  let result = graph_search_bidirectional_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_edge_fill(s : GraphsearchbidirectionalEdge, v : Double) -> GraphsearchbidirectionalEdge {
  let result = graph_search_bidirectional_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_edge_min(s : GraphsearchbidirectionalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_edge_max(s : GraphsearchbidirectionalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_edge_to_string(s : GraphsearchbidirectionalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_path_make(size : Int) -> GraphsearchbidirectionalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_path_len(s : GraphsearchbidirectionalPath) -> Int { s.size }

pub fn graph_search_bidirectional_path_get(s : GraphsearchbidirectionalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_path_set(s : GraphsearchbidirectionalPath, i : Int, v : Double) -> GraphsearchbidirectionalPath {
  let result = graph_search_bidirectional_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_path_sum(s : GraphsearchbidirectionalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_path_mean(s : GraphsearchbidirectionalPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_path_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_path_scale(s : GraphsearchbidirectionalPath, f : Double) -> GraphsearchbidirectionalPath {
  let result = graph_search_bidirectional_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_path_add(a : GraphsearchbidirectionalPath, b : GraphsearchbidirectionalPath) -> GraphsearchbidirectionalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_path_copy(s : GraphsearchbidirectionalPath) -> GraphsearchbidirectionalPath {
  let result = graph_search_bidirectional_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_path_fill(s : GraphsearchbidirectionalPath, v : Double) -> GraphsearchbidirectionalPath {
  let result = graph_search_bidirectional_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_path_min(s : GraphsearchbidirectionalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_path_max(s : GraphsearchbidirectionalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_path_to_string(s : GraphsearchbidirectionalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_cluster_make(size : Int) -> GraphsearchbidirectionalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_cluster_len(s : GraphsearchbidirectionalCluster) -> Int { s.size }

pub fn graph_search_bidirectional_cluster_get(s : GraphsearchbidirectionalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_cluster_set(s : GraphsearchbidirectionalCluster, i : Int, v : Double) -> GraphsearchbidirectionalCluster {
  let result = graph_search_bidirectional_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_cluster_sum(s : GraphsearchbidirectionalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_cluster_mean(s : GraphsearchbidirectionalCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_cluster_scale(s : GraphsearchbidirectionalCluster, f : Double) -> GraphsearchbidirectionalCluster {
  let result = graph_search_bidirectional_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_cluster_add(a : GraphsearchbidirectionalCluster, b : GraphsearchbidirectionalCluster) -> GraphsearchbidirectionalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_cluster_copy(s : GraphsearchbidirectionalCluster) -> GraphsearchbidirectionalCluster {
  let result = graph_search_bidirectional_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_cluster_fill(s : GraphsearchbidirectionalCluster, v : Double) -> GraphsearchbidirectionalCluster {
  let result = graph_search_bidirectional_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_cluster_min(s : GraphsearchbidirectionalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_cluster_max(s : GraphsearchbidirectionalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_cluster_to_string(s : GraphsearchbidirectionalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_model_make(size : Int) -> GraphsearchbidirectionalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_model_len(s : GraphsearchbidirectionalModel) -> Int { s.size }

pub fn graph_search_bidirectional_model_get(s : GraphsearchbidirectionalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_model_set(s : GraphsearchbidirectionalModel, i : Int, v : Double) -> GraphsearchbidirectionalModel {
  let result = graph_search_bidirectional_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_model_sum(s : GraphsearchbidirectionalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_model_mean(s : GraphsearchbidirectionalModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_model_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_model_scale(s : GraphsearchbidirectionalModel, f : Double) -> GraphsearchbidirectionalModel {
  let result = graph_search_bidirectional_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_model_add(a : GraphsearchbidirectionalModel, b : GraphsearchbidirectionalModel) -> GraphsearchbidirectionalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_model_copy(s : GraphsearchbidirectionalModel) -> GraphsearchbidirectionalModel {
  let result = graph_search_bidirectional_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_model_fill(s : GraphsearchbidirectionalModel, v : Double) -> GraphsearchbidirectionalModel {
  let result = graph_search_bidirectional_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_model_min(s : GraphsearchbidirectionalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_model_max(s : GraphsearchbidirectionalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_model_to_string(s : GraphsearchbidirectionalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_layer_make(size : Int) -> GraphsearchbidirectionalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_layer_len(s : GraphsearchbidirectionalLayer) -> Int { s.size }

pub fn graph_search_bidirectional_layer_get(s : GraphsearchbidirectionalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_layer_set(s : GraphsearchbidirectionalLayer, i : Int, v : Double) -> GraphsearchbidirectionalLayer {
  let result = graph_search_bidirectional_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_layer_sum(s : GraphsearchbidirectionalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_layer_mean(s : GraphsearchbidirectionalLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_layer_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_layer_scale(s : GraphsearchbidirectionalLayer, f : Double) -> GraphsearchbidirectionalLayer {
  let result = graph_search_bidirectional_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_layer_add(a : GraphsearchbidirectionalLayer, b : GraphsearchbidirectionalLayer) -> GraphsearchbidirectionalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_layer_copy(s : GraphsearchbidirectionalLayer) -> GraphsearchbidirectionalLayer {
  let result = graph_search_bidirectional_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_layer_fill(s : GraphsearchbidirectionalLayer, v : Double) -> GraphsearchbidirectionalLayer {
  let result = graph_search_bidirectional_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_layer_min(s : GraphsearchbidirectionalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_layer_max(s : GraphsearchbidirectionalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_layer_to_string(s : GraphsearchbidirectionalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_buffer_make(size : Int) -> GraphsearchbidirectionalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_buffer_len(s : GraphsearchbidirectionalBuffer) -> Int { s.size }

pub fn graph_search_bidirectional_buffer_get(s : GraphsearchbidirectionalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_buffer_set(s : GraphsearchbidirectionalBuffer, i : Int, v : Double) -> GraphsearchbidirectionalBuffer {
  let result = graph_search_bidirectional_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_buffer_sum(s : GraphsearchbidirectionalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_buffer_mean(s : GraphsearchbidirectionalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_buffer_scale(s : GraphsearchbidirectionalBuffer, f : Double) -> GraphsearchbidirectionalBuffer {
  let result = graph_search_bidirectional_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_buffer_add(a : GraphsearchbidirectionalBuffer, b : GraphsearchbidirectionalBuffer) -> GraphsearchbidirectionalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_buffer_copy(s : GraphsearchbidirectionalBuffer) -> GraphsearchbidirectionalBuffer {
  let result = graph_search_bidirectional_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_buffer_fill(s : GraphsearchbidirectionalBuffer, v : Double) -> GraphsearchbidirectionalBuffer {
  let result = graph_search_bidirectional_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_buffer_min(s : GraphsearchbidirectionalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_buffer_max(s : GraphsearchbidirectionalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_buffer_to_string(s : GraphsearchbidirectionalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_cursor_make(size : Int) -> GraphsearchbidirectionalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_cursor_len(s : GraphsearchbidirectionalCursor) -> Int { s.size }

pub fn graph_search_bidirectional_cursor_get(s : GraphsearchbidirectionalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_cursor_set(s : GraphsearchbidirectionalCursor, i : Int, v : Double) -> GraphsearchbidirectionalCursor {
  let result = graph_search_bidirectional_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_cursor_sum(s : GraphsearchbidirectionalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_cursor_mean(s : GraphsearchbidirectionalCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_cursor_scale(s : GraphsearchbidirectionalCursor, f : Double) -> GraphsearchbidirectionalCursor {
  let result = graph_search_bidirectional_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_cursor_add(a : GraphsearchbidirectionalCursor, b : GraphsearchbidirectionalCursor) -> GraphsearchbidirectionalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_cursor_copy(s : GraphsearchbidirectionalCursor) -> GraphsearchbidirectionalCursor {
  let result = graph_search_bidirectional_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_cursor_fill(s : GraphsearchbidirectionalCursor, v : Double) -> GraphsearchbidirectionalCursor {
  let result = graph_search_bidirectional_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_cursor_min(s : GraphsearchbidirectionalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_cursor_max(s : GraphsearchbidirectionalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_cursor_to_string(s : GraphsearchbidirectionalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_view_make(size : Int) -> GraphsearchbidirectionalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_view_len(s : GraphsearchbidirectionalView) -> Int { s.size }

pub fn graph_search_bidirectional_view_get(s : GraphsearchbidirectionalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_view_set(s : GraphsearchbidirectionalView, i : Int, v : Double) -> GraphsearchbidirectionalView {
  let result = graph_search_bidirectional_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_view_sum(s : GraphsearchbidirectionalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_view_mean(s : GraphsearchbidirectionalView) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_view_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_view_scale(s : GraphsearchbidirectionalView, f : Double) -> GraphsearchbidirectionalView {
  let result = graph_search_bidirectional_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_view_add(a : GraphsearchbidirectionalView, b : GraphsearchbidirectionalView) -> GraphsearchbidirectionalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_view_copy(s : GraphsearchbidirectionalView) -> GraphsearchbidirectionalView {
  let result = graph_search_bidirectional_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_view_fill(s : GraphsearchbidirectionalView, v : Double) -> GraphsearchbidirectionalView {
  let result = graph_search_bidirectional_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_view_min(s : GraphsearchbidirectionalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_view_max(s : GraphsearchbidirectionalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_view_to_string(s : GraphsearchbidirectionalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_range_make(size : Int) -> GraphsearchbidirectionalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_range_len(s : GraphsearchbidirectionalRange) -> Int { s.size }

pub fn graph_search_bidirectional_range_get(s : GraphsearchbidirectionalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_range_set(s : GraphsearchbidirectionalRange, i : Int, v : Double) -> GraphsearchbidirectionalRange {
  let result = graph_search_bidirectional_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_range_sum(s : GraphsearchbidirectionalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_range_mean(s : GraphsearchbidirectionalRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_range_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_range_scale(s : GraphsearchbidirectionalRange, f : Double) -> GraphsearchbidirectionalRange {
  let result = graph_search_bidirectional_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_range_add(a : GraphsearchbidirectionalRange, b : GraphsearchbidirectionalRange) -> GraphsearchbidirectionalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_range_copy(s : GraphsearchbidirectionalRange) -> GraphsearchbidirectionalRange {
  let result = graph_search_bidirectional_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_range_fill(s : GraphsearchbidirectionalRange, v : Double) -> GraphsearchbidirectionalRange {
  let result = graph_search_bidirectional_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_range_min(s : GraphsearchbidirectionalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_range_max(s : GraphsearchbidirectionalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_range_to_string(s : GraphsearchbidirectionalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbidirectionalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bidirectional_slice_make(size : Int) -> GraphsearchbidirectionalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bidirectional_slice_len(s : GraphsearchbidirectionalSlice) -> Int { s.size }

pub fn graph_search_bidirectional_slice_get(s : GraphsearchbidirectionalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bidirectional_slice_set(s : GraphsearchbidirectionalSlice, i : Int, v : Double) -> GraphsearchbidirectionalSlice {
  let result = graph_search_bidirectional_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_slice_sum(s : GraphsearchbidirectionalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bidirectional_slice_mean(s : GraphsearchbidirectionalSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bidirectional_slice_sum(s) / s.size.to_double() }
}

pub fn graph_search_bidirectional_slice_scale(s : GraphsearchbidirectionalSlice, f : Double) -> GraphsearchbidirectionalSlice {
  let result = graph_search_bidirectional_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bidirectional_slice_add(a : GraphsearchbidirectionalSlice, b : GraphsearchbidirectionalSlice) -> GraphsearchbidirectionalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bidirectional_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bidirectional_slice_copy(s : GraphsearchbidirectionalSlice) -> GraphsearchbidirectionalSlice {
  let result = graph_search_bidirectional_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bidirectional_slice_fill(s : GraphsearchbidirectionalSlice, v : Double) -> GraphsearchbidirectionalSlice {
  let result = graph_search_bidirectional_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bidirectional_slice_min(s : GraphsearchbidirectionalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_slice_max(s : GraphsearchbidirectionalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bidirectional_slice_to_string(s : GraphsearchbidirectionalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

