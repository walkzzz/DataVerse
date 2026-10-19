///===
/// extcore/graph_tree_arborescence

pub(all) struct GraphtreearborescencePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_arborescence_make_point(x : Double, y : Double) -> GraphtreearborescencePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_arborescence_make_point3(x : Double, y : Double, z : Double) -> GraphtreearborescencePoint {
  { x, y, z, label: 0 }
}

pub fn graph_tree_arborescence_point_x(pt : GraphtreearborescencePoint) -> Double { pt.x }

pub fn graph_tree_arborescence_point_y(pt : GraphtreearborescencePoint) -> Double { pt.y }

pub fn graph_tree_arborescence_point_z(pt : GraphtreearborescencePoint) -> Double { pt.z }

pub fn graph_tree_arborescence_point_label(pt : GraphtreearborescencePoint) -> Int { pt.label }

pub fn graph_tree_arborescence_point_dist(a : GraphtreearborescencePoint, b : GraphtreearborescencePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_tree_arborescence_point_add(a : GraphtreearborescencePoint, b : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_tree_arborescence_point_sub(a : GraphtreearborescencePoint, b : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_tree_arborescence_point_scale(pt : GraphtreearborescencePoint, s : Double) -> GraphtreearborescencePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_tree_arborescence_point_dot(a : GraphtreearborescencePoint, b : GraphtreearborescencePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_tree_arborescence_point_cross(a : GraphtreearborescencePoint, b : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_tree_arborescence_point_norm(pt : GraphtreearborescencePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_tree_arborescence_point_normalize(pt : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  let n = graph_tree_arborescence_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_tree_arborescence_point_scale(pt, 1.0 / n) }
}

pub fn graph_tree_arborescence_point_negate(pt : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_tree_arborescence_point_mid(a : GraphtreearborescencePoint, b : GraphtreearborescencePoint) -> GraphtreearborescencePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_tree_arborescence_point_lerp(a : GraphtreearborescencePoint, b : GraphtreearborescencePoint, t : Double) -> GraphtreearborescencePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_tree_arborescence_point_to_string(pt : GraphtreearborescencePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphtreearborescenceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_arborescence_make_series(vals : Array[Double], name : String) -> GraphtreearborescenceSeries {
  { vals, name, meta: 0 }
}

pub fn graph_tree_arborescence_series_len(s : GraphtreearborescenceSeries) -> Int { s.vals.length() }

pub fn graph_tree_arborescence_series_sum(s : GraphtreearborescenceSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_tree_arborescence_series_mean(s : GraphtreearborescenceSeries) -> Double {
  let n = graph_tree_arborescence_series_len(s)
  if n == 0 { 0.0 } else { graph_tree_arborescence_series_sum(s) / n.to_double() }
}

pub fn graph_tree_arborescence_series_min(s : GraphtreearborescenceSeries) -> Double {
  let n = graph_tree_arborescence_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_tree_arborescence_series_max(s : GraphtreearborescenceSeries) -> Double {
  let n = graph_tree_arborescence_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_tree_arborescence_series_range(s : GraphtreearborescenceSeries) -> Double {
  graph_tree_arborescence_series_max(s) - graph_tree_arborescence_series_min(s)
}

pub fn graph_tree_arborescence_series_var(s : GraphtreearborescenceSeries) -> Double {
  let n = graph_tree_arborescence_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_tree_arborescence_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_tree_arborescence_series_std(s : GraphtreearborescenceSeries) -> Double { @_common.sqrt(graph_tree_arborescence_series_var(s)) }

pub fn graph_tree_arborescence_series_median(s : GraphtreearborescenceSeries) -> Double {
  let n = graph_tree_arborescence_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_tree_arborescence_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_tree_arborescence_series_scale(s : GraphtreearborescenceSeries, f : Double) -> GraphtreearborescenceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_tree_arborescence_series_add(a : GraphtreearborescenceSeries, b : GraphtreearborescenceSeries) -> GraphtreearborescenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_tree_arborescence_series_sub(a : GraphtreearborescenceSeries, b : GraphtreearborescenceSeries) -> GraphtreearborescenceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_tree_arborescence_series_normalize(s : GraphtreearborescenceSeries) -> GraphtreearborescenceSeries {
  let mn = graph_tree_arborescence_series_min(s)
  let mx = graph_tree_arborescence_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_tree_arborescence_series_cumsum(s : GraphtreearborescenceSeries) -> GraphtreearborescenceSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_tree_arborescence_series_to_string(s : GraphtreearborescenceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreearborescenceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_arborescence_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreearborescenceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_arborescence_matrix_identity(n : Int) -> GraphtreearborescenceMatrix {
  let m = graph_tree_arborescence_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_tree_arborescence_matrix_get(m : GraphtreearborescenceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_tree_arborescence_matrix_transpose(m : GraphtreearborescenceMatrix) -> GraphtreearborescenceMatrix {
  let result = graph_tree_arborescence_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_tree_arborescence_matrix_add(a : GraphtreearborescenceMatrix, b : GraphtreearborescenceMatrix) -> GraphtreearborescenceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_tree_arborescence_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_tree_arborescence_matrix_scale(m : GraphtreearborescenceMatrix, s : Double) -> GraphtreearborescenceMatrix {
  let result = graph_tree_arborescence_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_tree_arborescence_matrix_multiply(a : GraphtreearborescenceMatrix, b : GraphtreearborescenceMatrix) -> GraphtreearborescenceMatrix {
  if a.cols != b.rows { return graph_tree_arborescence_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_tree_arborescence_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_tree_arborescence_matrix_trace(m : GraphtreearborescenceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_tree_arborescence_matrix_det(m : GraphtreearborescenceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_tree_arborescence_matrix_norm(m : GraphtreearborescenceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_tree_arborescence_matrix_to_string(m : GraphtreearborescenceMatrix) -> String {
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

pub(all) struct GraphtreearborescenceVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_arborescence_make_vector(comps : Array[Double]) -> GraphtreearborescenceVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_arborescence_vector_zero(dim : Int) -> GraphtreearborescenceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_tree_arborescence_vector_add(a : GraphtreearborescenceVector, b : GraphtreearborescenceVector) -> GraphtreearborescenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_arborescence_vector_sub(a : GraphtreearborescenceVector, b : GraphtreearborescenceVector) -> GraphtreearborescenceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_arborescence_vector_scale(v : GraphtreearborescenceVector, s : Double) -> GraphtreearborescenceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_tree_arborescence_vector_dot(a : GraphtreearborescenceVector, b : GraphtreearborescenceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_tree_arborescence_vector_norm(v : GraphtreearborescenceVector) -> Double { @_common.sqrt(graph_tree_arborescence_vector_dot(v, v)) }

pub fn graph_tree_arborescence_vector_normalize(v : GraphtreearborescenceVector) -> GraphtreearborescenceVector {
  let n = graph_tree_arborescence_vector_norm(v)
  if n < 0.0000001 { v } else { graph_tree_arborescence_vector_scale(v, 1.0 / n) }
}

pub fn graph_tree_arborescence_vector_dist(a : GraphtreearborescenceVector, b : GraphtreearborescenceVector) -> Double {
  graph_tree_arborescence_vector_norm(graph_tree_arborescence_vector_sub(a, b))
}

pub fn graph_tree_arborescence_vector_to_string(v : GraphtreearborescenceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_arborescence_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_tree_arborescence_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_tree_arborescence_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_tree_arborescence_std(data : Array[Double]) -> Double { @_common.sqrt(graph_tree_arborescence_var(data)) }

pub fn graph_tree_arborescence_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_tree_arborescence_mean(a); let mb = graph_tree_arborescence_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_tree_arborescence_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_tree_arborescence_std(a); let sb = graph_tree_arborescence_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_tree_arborescence_cov(a, b) / (sa * sb) }
}

pub fn graph_tree_arborescence_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_tree_arborescence_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_tree_arborescence_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_tree_arborescence_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_tree_arborescence_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(graph_tree_arborescence_mse(pred, labels))
}

pub fn graph_tree_arborescence_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_tree_arborescence_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_tree_arborescence_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_tree_arborescence_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_tree_arborescence_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_tree_arborescence_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_tree_arborescence_precision(pred, labels, pos); let r = graph_tree_arborescence_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_tree_arborescence_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_tree_arborescence_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_tree_arborescence_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_tree_arborescence_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_tree_arborescence_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_tree_arborescence_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_tree_arborescence_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_tree_arborescence_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_tree_arborescence_fibonacci(n : Int) -> Int {
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

pub fn graph_tree_arborescence_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_tree_arborescence_min(data); let mx = graph_tree_arborescence_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_tree_arborescence_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_tree_arborescence_mean(data); let sd = graph_tree_arborescence_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_tree_arborescence_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_tree_arborescence_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_tree_arborescence_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_tree_arborescence_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GraphtreearborescenceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_frame_make(size : Int) -> GraphtreearborescenceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_frame_len(s : GraphtreearborescenceFrame) -> Int { s.size }

pub fn graph_tree_arborescence_frame_get(s : GraphtreearborescenceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_frame_set(s : GraphtreearborescenceFrame, i : Int, v : Double) -> GraphtreearborescenceFrame {
  let result = graph_tree_arborescence_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_frame_sum(s : GraphtreearborescenceFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_frame_mean(s : GraphtreearborescenceFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_frame_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_frame_scale(s : GraphtreearborescenceFrame, f : Double) -> GraphtreearborescenceFrame {
  let result = graph_tree_arborescence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_frame_add(a : GraphtreearborescenceFrame, b : GraphtreearborescenceFrame) -> GraphtreearborescenceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_frame_copy(s : GraphtreearborescenceFrame) -> GraphtreearborescenceFrame {
  let result = graph_tree_arborescence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_frame_fill(s : GraphtreearborescenceFrame, v : Double) -> GraphtreearborescenceFrame {
  let result = graph_tree_arborescence_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_frame_min(s : GraphtreearborescenceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_frame_max(s : GraphtreearborescenceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_frame_to_string(s : GraphtreearborescenceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_table_make(size : Int) -> GraphtreearborescenceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_table_len(s : GraphtreearborescenceTable) -> Int { s.size }

pub fn graph_tree_arborescence_table_get(s : GraphtreearborescenceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_table_set(s : GraphtreearborescenceTable, i : Int, v : Double) -> GraphtreearborescenceTable {
  let result = graph_tree_arborescence_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_table_sum(s : GraphtreearborescenceTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_table_mean(s : GraphtreearborescenceTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_table_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_table_scale(s : GraphtreearborescenceTable, f : Double) -> GraphtreearborescenceTable {
  let result = graph_tree_arborescence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_table_add(a : GraphtreearborescenceTable, b : GraphtreearborescenceTable) -> GraphtreearborescenceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_table_copy(s : GraphtreearborescenceTable) -> GraphtreearborescenceTable {
  let result = graph_tree_arborescence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_table_fill(s : GraphtreearborescenceTable, v : Double) -> GraphtreearborescenceTable {
  let result = graph_tree_arborescence_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_table_min(s : GraphtreearborescenceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_table_max(s : GraphtreearborescenceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_table_to_string(s : GraphtreearborescenceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_graphn_make(size : Int) -> GraphtreearborescenceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_graphn_len(s : GraphtreearborescenceGraphN) -> Int { s.size }

pub fn graph_tree_arborescence_graphn_get(s : GraphtreearborescenceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_graphn_set(s : GraphtreearborescenceGraphN, i : Int, v : Double) -> GraphtreearborescenceGraphN {
  let result = graph_tree_arborescence_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_graphn_sum(s : GraphtreearborescenceGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_graphn_mean(s : GraphtreearborescenceGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_graphn_scale(s : GraphtreearborescenceGraphN, f : Double) -> GraphtreearborescenceGraphN {
  let result = graph_tree_arborescence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_graphn_add(a : GraphtreearborescenceGraphN, b : GraphtreearborescenceGraphN) -> GraphtreearborescenceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_graphn_copy(s : GraphtreearborescenceGraphN) -> GraphtreearborescenceGraphN {
  let result = graph_tree_arborescence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_graphn_fill(s : GraphtreearborescenceGraphN, v : Double) -> GraphtreearborescenceGraphN {
  let result = graph_tree_arborescence_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_graphn_min(s : GraphtreearborescenceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_graphn_max(s : GraphtreearborescenceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_graphn_to_string(s : GraphtreearborescenceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_node_make(size : Int) -> GraphtreearborescenceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_node_len(s : GraphtreearborescenceNode) -> Int { s.size }

pub fn graph_tree_arborescence_node_get(s : GraphtreearborescenceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_node_set(s : GraphtreearborescenceNode, i : Int, v : Double) -> GraphtreearborescenceNode {
  let result = graph_tree_arborescence_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_node_sum(s : GraphtreearborescenceNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_node_mean(s : GraphtreearborescenceNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_node_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_node_scale(s : GraphtreearborescenceNode, f : Double) -> GraphtreearborescenceNode {
  let result = graph_tree_arborescence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_node_add(a : GraphtreearborescenceNode, b : GraphtreearborescenceNode) -> GraphtreearborescenceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_node_copy(s : GraphtreearborescenceNode) -> GraphtreearborescenceNode {
  let result = graph_tree_arborescence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_node_fill(s : GraphtreearborescenceNode, v : Double) -> GraphtreearborescenceNode {
  let result = graph_tree_arborescence_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_node_min(s : GraphtreearborescenceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_node_max(s : GraphtreearborescenceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_node_to_string(s : GraphtreearborescenceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_edge_make(size : Int) -> GraphtreearborescenceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_edge_len(s : GraphtreearborescenceEdge) -> Int { s.size }

pub fn graph_tree_arborescence_edge_get(s : GraphtreearborescenceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_edge_set(s : GraphtreearborescenceEdge, i : Int, v : Double) -> GraphtreearborescenceEdge {
  let result = graph_tree_arborescence_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_edge_sum(s : GraphtreearborescenceEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_edge_mean(s : GraphtreearborescenceEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_edge_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_edge_scale(s : GraphtreearborescenceEdge, f : Double) -> GraphtreearborescenceEdge {
  let result = graph_tree_arborescence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_edge_add(a : GraphtreearborescenceEdge, b : GraphtreearborescenceEdge) -> GraphtreearborescenceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_edge_copy(s : GraphtreearborescenceEdge) -> GraphtreearborescenceEdge {
  let result = graph_tree_arborescence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_edge_fill(s : GraphtreearborescenceEdge, v : Double) -> GraphtreearborescenceEdge {
  let result = graph_tree_arborescence_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_edge_min(s : GraphtreearborescenceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_edge_max(s : GraphtreearborescenceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_edge_to_string(s : GraphtreearborescenceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescencePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_path_make(size : Int) -> GraphtreearborescencePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_path_len(s : GraphtreearborescencePath) -> Int { s.size }

pub fn graph_tree_arborescence_path_get(s : GraphtreearborescencePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_path_set(s : GraphtreearborescencePath, i : Int, v : Double) -> GraphtreearborescencePath {
  let result = graph_tree_arborescence_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_path_sum(s : GraphtreearborescencePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_path_mean(s : GraphtreearborescencePath) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_path_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_path_scale(s : GraphtreearborescencePath, f : Double) -> GraphtreearborescencePath {
  let result = graph_tree_arborescence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_path_add(a : GraphtreearborescencePath, b : GraphtreearborescencePath) -> GraphtreearborescencePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_path_copy(s : GraphtreearborescencePath) -> GraphtreearborescencePath {
  let result = graph_tree_arborescence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_path_fill(s : GraphtreearborescencePath, v : Double) -> GraphtreearborescencePath {
  let result = graph_tree_arborescence_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_path_min(s : GraphtreearborescencePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_path_max(s : GraphtreearborescencePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_path_to_string(s : GraphtreearborescencePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_cluster_make(size : Int) -> GraphtreearborescenceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_cluster_len(s : GraphtreearborescenceCluster) -> Int { s.size }

pub fn graph_tree_arborescence_cluster_get(s : GraphtreearborescenceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_cluster_set(s : GraphtreearborescenceCluster, i : Int, v : Double) -> GraphtreearborescenceCluster {
  let result = graph_tree_arborescence_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_cluster_sum(s : GraphtreearborescenceCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_cluster_mean(s : GraphtreearborescenceCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_cluster_scale(s : GraphtreearborescenceCluster, f : Double) -> GraphtreearborescenceCluster {
  let result = graph_tree_arborescence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_cluster_add(a : GraphtreearborescenceCluster, b : GraphtreearborescenceCluster) -> GraphtreearborescenceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_cluster_copy(s : GraphtreearborescenceCluster) -> GraphtreearborescenceCluster {
  let result = graph_tree_arborescence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_cluster_fill(s : GraphtreearborescenceCluster, v : Double) -> GraphtreearborescenceCluster {
  let result = graph_tree_arborescence_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_cluster_min(s : GraphtreearborescenceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_cluster_max(s : GraphtreearborescenceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_cluster_to_string(s : GraphtreearborescenceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_model_make(size : Int) -> GraphtreearborescenceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_model_len(s : GraphtreearborescenceModel) -> Int { s.size }

pub fn graph_tree_arborescence_model_get(s : GraphtreearborescenceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_model_set(s : GraphtreearborescenceModel, i : Int, v : Double) -> GraphtreearborescenceModel {
  let result = graph_tree_arborescence_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_model_sum(s : GraphtreearborescenceModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_model_mean(s : GraphtreearborescenceModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_model_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_model_scale(s : GraphtreearborescenceModel, f : Double) -> GraphtreearborescenceModel {
  let result = graph_tree_arborescence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_model_add(a : GraphtreearborescenceModel, b : GraphtreearborescenceModel) -> GraphtreearborescenceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_model_copy(s : GraphtreearborescenceModel) -> GraphtreearborescenceModel {
  let result = graph_tree_arborescence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_model_fill(s : GraphtreearborescenceModel, v : Double) -> GraphtreearborescenceModel {
  let result = graph_tree_arborescence_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_model_min(s : GraphtreearborescenceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_model_max(s : GraphtreearborescenceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_model_to_string(s : GraphtreearborescenceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_layer_make(size : Int) -> GraphtreearborescenceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_layer_len(s : GraphtreearborescenceLayer) -> Int { s.size }

pub fn graph_tree_arborescence_layer_get(s : GraphtreearborescenceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_layer_set(s : GraphtreearborescenceLayer, i : Int, v : Double) -> GraphtreearborescenceLayer {
  let result = graph_tree_arborescence_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_layer_sum(s : GraphtreearborescenceLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_layer_mean(s : GraphtreearborescenceLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_layer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_layer_scale(s : GraphtreearborescenceLayer, f : Double) -> GraphtreearborescenceLayer {
  let result = graph_tree_arborescence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_layer_add(a : GraphtreearborescenceLayer, b : GraphtreearborescenceLayer) -> GraphtreearborescenceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_layer_copy(s : GraphtreearborescenceLayer) -> GraphtreearborescenceLayer {
  let result = graph_tree_arborescence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_layer_fill(s : GraphtreearborescenceLayer, v : Double) -> GraphtreearborescenceLayer {
  let result = graph_tree_arborescence_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_layer_min(s : GraphtreearborescenceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_layer_max(s : GraphtreearborescenceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_layer_to_string(s : GraphtreearborescenceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_buffer_make(size : Int) -> GraphtreearborescenceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_buffer_len(s : GraphtreearborescenceBuffer) -> Int { s.size }

pub fn graph_tree_arborescence_buffer_get(s : GraphtreearborescenceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_buffer_set(s : GraphtreearborescenceBuffer, i : Int, v : Double) -> GraphtreearborescenceBuffer {
  let result = graph_tree_arborescence_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_buffer_sum(s : GraphtreearborescenceBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_buffer_mean(s : GraphtreearborescenceBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_buffer_scale(s : GraphtreearborescenceBuffer, f : Double) -> GraphtreearborescenceBuffer {
  let result = graph_tree_arborescence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_buffer_add(a : GraphtreearborescenceBuffer, b : GraphtreearborescenceBuffer) -> GraphtreearborescenceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_buffer_copy(s : GraphtreearborescenceBuffer) -> GraphtreearborescenceBuffer {
  let result = graph_tree_arborescence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_buffer_fill(s : GraphtreearborescenceBuffer, v : Double) -> GraphtreearborescenceBuffer {
  let result = graph_tree_arborescence_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_buffer_min(s : GraphtreearborescenceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_buffer_max(s : GraphtreearborescenceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_buffer_to_string(s : GraphtreearborescenceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_cursor_make(size : Int) -> GraphtreearborescenceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_cursor_len(s : GraphtreearborescenceCursor) -> Int { s.size }

pub fn graph_tree_arborescence_cursor_get(s : GraphtreearborescenceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_cursor_set(s : GraphtreearborescenceCursor, i : Int, v : Double) -> GraphtreearborescenceCursor {
  let result = graph_tree_arborescence_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_cursor_sum(s : GraphtreearborescenceCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_cursor_mean(s : GraphtreearborescenceCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_cursor_scale(s : GraphtreearborescenceCursor, f : Double) -> GraphtreearborescenceCursor {
  let result = graph_tree_arborescence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_cursor_add(a : GraphtreearborescenceCursor, b : GraphtreearborescenceCursor) -> GraphtreearborescenceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_cursor_copy(s : GraphtreearborescenceCursor) -> GraphtreearborescenceCursor {
  let result = graph_tree_arborescence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_cursor_fill(s : GraphtreearborescenceCursor, v : Double) -> GraphtreearborescenceCursor {
  let result = graph_tree_arborescence_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_cursor_min(s : GraphtreearborescenceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_cursor_max(s : GraphtreearborescenceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_cursor_to_string(s : GraphtreearborescenceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_view_make(size : Int) -> GraphtreearborescenceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_view_len(s : GraphtreearborescenceView) -> Int { s.size }

pub fn graph_tree_arborescence_view_get(s : GraphtreearborescenceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_view_set(s : GraphtreearborescenceView, i : Int, v : Double) -> GraphtreearborescenceView {
  let result = graph_tree_arborescence_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_view_sum(s : GraphtreearborescenceView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_view_mean(s : GraphtreearborescenceView) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_view_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_view_scale(s : GraphtreearborescenceView, f : Double) -> GraphtreearborescenceView {
  let result = graph_tree_arborescence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_view_add(a : GraphtreearborescenceView, b : GraphtreearborescenceView) -> GraphtreearborescenceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_view_copy(s : GraphtreearborescenceView) -> GraphtreearborescenceView {
  let result = graph_tree_arborescence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_view_fill(s : GraphtreearborescenceView, v : Double) -> GraphtreearborescenceView {
  let result = graph_tree_arborescence_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_view_min(s : GraphtreearborescenceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_view_max(s : GraphtreearborescenceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_view_to_string(s : GraphtreearborescenceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_range_make(size : Int) -> GraphtreearborescenceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_range_len(s : GraphtreearborescenceRange) -> Int { s.size }

pub fn graph_tree_arborescence_range_get(s : GraphtreearborescenceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_range_set(s : GraphtreearborescenceRange, i : Int, v : Double) -> GraphtreearborescenceRange {
  let result = graph_tree_arborescence_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_range_sum(s : GraphtreearborescenceRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_range_mean(s : GraphtreearborescenceRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_range_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_range_scale(s : GraphtreearborescenceRange, f : Double) -> GraphtreearborescenceRange {
  let result = graph_tree_arborescence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_range_add(a : GraphtreearborescenceRange, b : GraphtreearborescenceRange) -> GraphtreearborescenceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_range_copy(s : GraphtreearborescenceRange) -> GraphtreearborescenceRange {
  let result = graph_tree_arborescence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_range_fill(s : GraphtreearborescenceRange, v : Double) -> GraphtreearborescenceRange {
  let result = graph_tree_arborescence_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_range_min(s : GraphtreearborescenceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_range_max(s : GraphtreearborescenceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_range_to_string(s : GraphtreearborescenceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreearborescenceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_arborescence_slice_make(size : Int) -> GraphtreearborescenceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_arborescence_slice_len(s : GraphtreearborescenceSlice) -> Int { s.size }

pub fn graph_tree_arborescence_slice_get(s : GraphtreearborescenceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_arborescence_slice_set(s : GraphtreearborescenceSlice, i : Int, v : Double) -> GraphtreearborescenceSlice {
  let result = graph_tree_arborescence_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_slice_sum(s : GraphtreearborescenceSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_arborescence_slice_mean(s : GraphtreearborescenceSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_arborescence_slice_sum(s) / s.size.to_double() }
}

pub fn graph_tree_arborescence_slice_scale(s : GraphtreearborescenceSlice, f : Double) -> GraphtreearborescenceSlice {
  let result = graph_tree_arborescence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_arborescence_slice_add(a : GraphtreearborescenceSlice, b : GraphtreearborescenceSlice) -> GraphtreearborescenceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_arborescence_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_arborescence_slice_copy(s : GraphtreearborescenceSlice) -> GraphtreearborescenceSlice {
  let result = graph_tree_arborescence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_arborescence_slice_fill(s : GraphtreearborescenceSlice, v : Double) -> GraphtreearborescenceSlice {
  let result = graph_tree_arborescence_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_arborescence_slice_min(s : GraphtreearborescenceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_slice_max(s : GraphtreearborescenceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_arborescence_slice_to_string(s : GraphtreearborescenceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

