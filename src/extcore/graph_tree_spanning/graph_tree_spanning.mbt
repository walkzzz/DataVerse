///===
/// extcore/graph_tree_spanning

pub(all) struct GraphtreespanningPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_spanning_make_point(x : Double, y : Double) -> GraphtreespanningPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_spanning_make_point3(x : Double, y : Double, z : Double) -> GraphtreespanningPoint {
  { x, y, z, label: 0 }
}

pub fn graph_tree_spanning_point_x(pt : GraphtreespanningPoint) -> Double { pt.x }

pub fn graph_tree_spanning_point_y(pt : GraphtreespanningPoint) -> Double { pt.y }

pub fn graph_tree_spanning_point_z(pt : GraphtreespanningPoint) -> Double { pt.z }

pub fn graph_tree_spanning_point_label(pt : GraphtreespanningPoint) -> Int { pt.label }

pub fn graph_tree_spanning_point_dist(a : GraphtreespanningPoint, b : GraphtreespanningPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_tree_spanning_point_add(a : GraphtreespanningPoint, b : GraphtreespanningPoint) -> GraphtreespanningPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_tree_spanning_point_sub(a : GraphtreespanningPoint, b : GraphtreespanningPoint) -> GraphtreespanningPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_tree_spanning_point_scale(pt : GraphtreespanningPoint, s : Double) -> GraphtreespanningPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_tree_spanning_point_dot(a : GraphtreespanningPoint, b : GraphtreespanningPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_tree_spanning_point_cross(a : GraphtreespanningPoint, b : GraphtreespanningPoint) -> GraphtreespanningPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_tree_spanning_point_norm(pt : GraphtreespanningPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_tree_spanning_point_normalize(pt : GraphtreespanningPoint) -> GraphtreespanningPoint {
  let n = graph_tree_spanning_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_tree_spanning_point_scale(pt, 1.0 / n) }
}

pub fn graph_tree_spanning_point_negate(pt : GraphtreespanningPoint) -> GraphtreespanningPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_tree_spanning_point_mid(a : GraphtreespanningPoint, b : GraphtreespanningPoint) -> GraphtreespanningPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_tree_spanning_point_lerp(a : GraphtreespanningPoint, b : GraphtreespanningPoint, t : Double) -> GraphtreespanningPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_tree_spanning_point_to_string(pt : GraphtreespanningPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphtreespanningSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_spanning_make_series(vals : Array[Double], name : String) -> GraphtreespanningSeries {
  { vals, name, meta: 0 }
}

pub fn graph_tree_spanning_series_len(s : GraphtreespanningSeries) -> Int { s.vals.length() }

pub fn graph_tree_spanning_series_sum(s : GraphtreespanningSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_tree_spanning_series_mean(s : GraphtreespanningSeries) -> Double {
  let n = graph_tree_spanning_series_len(s)
  if n == 0 { 0.0 } else { graph_tree_spanning_series_sum(s) / n.to_double() }
}

pub fn graph_tree_spanning_series_min(s : GraphtreespanningSeries) -> Double {
  let n = graph_tree_spanning_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_tree_spanning_series_max(s : GraphtreespanningSeries) -> Double {
  let n = graph_tree_spanning_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_tree_spanning_series_range(s : GraphtreespanningSeries) -> Double {
  graph_tree_spanning_series_max(s) - graph_tree_spanning_series_min(s)
}

pub fn graph_tree_spanning_series_var(s : GraphtreespanningSeries) -> Double {
  let n = graph_tree_spanning_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_tree_spanning_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_tree_spanning_series_std(s : GraphtreespanningSeries) -> Double { @_common.sqrt(graph_tree_spanning_series_var(s)) }

pub fn graph_tree_spanning_series_median(s : GraphtreespanningSeries) -> Double {
  let n = graph_tree_spanning_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_tree_spanning_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_tree_spanning_series_scale(s : GraphtreespanningSeries, f : Double) -> GraphtreespanningSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_tree_spanning_series_add(a : GraphtreespanningSeries, b : GraphtreespanningSeries) -> GraphtreespanningSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_tree_spanning_series_sub(a : GraphtreespanningSeries, b : GraphtreespanningSeries) -> GraphtreespanningSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_tree_spanning_series_normalize(s : GraphtreespanningSeries) -> GraphtreespanningSeries {
  let mn = graph_tree_spanning_series_min(s)
  let mx = graph_tree_spanning_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_tree_spanning_series_cumsum(s : GraphtreespanningSeries) -> GraphtreespanningSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_tree_spanning_series_to_string(s : GraphtreespanningSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreespanningMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_spanning_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreespanningMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_spanning_matrix_identity(n : Int) -> GraphtreespanningMatrix {
  let m = graph_tree_spanning_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_tree_spanning_matrix_get(m : GraphtreespanningMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_tree_spanning_matrix_transpose(m : GraphtreespanningMatrix) -> GraphtreespanningMatrix {
  let result = graph_tree_spanning_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_tree_spanning_matrix_add(a : GraphtreespanningMatrix, b : GraphtreespanningMatrix) -> GraphtreespanningMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_tree_spanning_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_tree_spanning_matrix_scale(m : GraphtreespanningMatrix, s : Double) -> GraphtreespanningMatrix {
  let result = graph_tree_spanning_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_tree_spanning_matrix_multiply(a : GraphtreespanningMatrix, b : GraphtreespanningMatrix) -> GraphtreespanningMatrix {
  if a.cols != b.rows { return graph_tree_spanning_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_tree_spanning_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_tree_spanning_matrix_trace(m : GraphtreespanningMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_tree_spanning_matrix_det(m : GraphtreespanningMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_tree_spanning_matrix_norm(m : GraphtreespanningMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_tree_spanning_matrix_to_string(m : GraphtreespanningMatrix) -> String {
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

pub(all) struct GraphtreespanningVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_spanning_make_vector(comps : Array[Double]) -> GraphtreespanningVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_spanning_vector_zero(dim : Int) -> GraphtreespanningVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_tree_spanning_vector_add(a : GraphtreespanningVector, b : GraphtreespanningVector) -> GraphtreespanningVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_spanning_vector_sub(a : GraphtreespanningVector, b : GraphtreespanningVector) -> GraphtreespanningVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_spanning_vector_scale(v : GraphtreespanningVector, s : Double) -> GraphtreespanningVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_tree_spanning_vector_dot(a : GraphtreespanningVector, b : GraphtreespanningVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_tree_spanning_vector_norm(v : GraphtreespanningVector) -> Double { @_common.sqrt(graph_tree_spanning_vector_dot(v, v)) }

pub fn graph_tree_spanning_vector_normalize(v : GraphtreespanningVector) -> GraphtreespanningVector {
  let n = graph_tree_spanning_vector_norm(v)
  if n < 0.0000001 { v } else { graph_tree_spanning_vector_scale(v, 1.0 / n) }
}

pub fn graph_tree_spanning_vector_dist(a : GraphtreespanningVector, b : GraphtreespanningVector) -> Double {
  graph_tree_spanning_vector_norm(graph_tree_spanning_vector_sub(a, b))
}

pub fn graph_tree_spanning_vector_to_string(v : GraphtreespanningVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_spanning_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_tree_spanning_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_tree_spanning_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_tree_spanning_std(data : Array[Double]) -> Double { @_common.sqrt(graph_tree_spanning_var(data)) }

pub fn graph_tree_spanning_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_tree_spanning_mean(a); let mb = graph_tree_spanning_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_tree_spanning_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_tree_spanning_std(a); let sb = graph_tree_spanning_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_tree_spanning_cov(a, b) / (sa * sb) }
}

pub fn graph_tree_spanning_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_tree_spanning_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_tree_spanning_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_tree_spanning_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_tree_spanning_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(graph_tree_spanning_mse(pred, labels))
}

pub fn graph_tree_spanning_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_tree_spanning_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_tree_spanning_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_tree_spanning_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_tree_spanning_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_tree_spanning_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_tree_spanning_precision(pred, labels, pos); let r = graph_tree_spanning_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_tree_spanning_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_tree_spanning_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_tree_spanning_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_tree_spanning_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_tree_spanning_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_tree_spanning_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_tree_spanning_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_tree_spanning_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_tree_spanning_fibonacci(n : Int) -> Int {
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

pub fn graph_tree_spanning_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_tree_spanning_min(data); let mx = graph_tree_spanning_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_tree_spanning_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_tree_spanning_mean(data); let sd = graph_tree_spanning_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_tree_spanning_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_tree_spanning_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_tree_spanning_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_tree_spanning_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_tree_spanning_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_tree_spanning_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GraphtreespanningFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_frame_make(size : Int) -> GraphtreespanningFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_frame_len(s : GraphtreespanningFrame) -> Int { s.size }

pub fn graph_tree_spanning_frame_get(s : GraphtreespanningFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_frame_set(s : GraphtreespanningFrame, i : Int, v : Double) -> GraphtreespanningFrame {
  let result = graph_tree_spanning_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_frame_sum(s : GraphtreespanningFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_frame_mean(s : GraphtreespanningFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_frame_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_frame_scale(s : GraphtreespanningFrame, f : Double) -> GraphtreespanningFrame {
  let result = graph_tree_spanning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_frame_add(a : GraphtreespanningFrame, b : GraphtreespanningFrame) -> GraphtreespanningFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_frame_copy(s : GraphtreespanningFrame) -> GraphtreespanningFrame {
  let result = graph_tree_spanning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_frame_fill(s : GraphtreespanningFrame, v : Double) -> GraphtreespanningFrame {
  let result = graph_tree_spanning_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_frame_min(s : GraphtreespanningFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_frame_max(s : GraphtreespanningFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_frame_to_string(s : GraphtreespanningFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_table_make(size : Int) -> GraphtreespanningTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_table_len(s : GraphtreespanningTable) -> Int { s.size }

pub fn graph_tree_spanning_table_get(s : GraphtreespanningTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_table_set(s : GraphtreespanningTable, i : Int, v : Double) -> GraphtreespanningTable {
  let result = graph_tree_spanning_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_table_sum(s : GraphtreespanningTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_table_mean(s : GraphtreespanningTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_table_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_table_scale(s : GraphtreespanningTable, f : Double) -> GraphtreespanningTable {
  let result = graph_tree_spanning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_table_add(a : GraphtreespanningTable, b : GraphtreespanningTable) -> GraphtreespanningTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_table_copy(s : GraphtreespanningTable) -> GraphtreespanningTable {
  let result = graph_tree_spanning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_table_fill(s : GraphtreespanningTable, v : Double) -> GraphtreespanningTable {
  let result = graph_tree_spanning_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_table_min(s : GraphtreespanningTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_table_max(s : GraphtreespanningTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_table_to_string(s : GraphtreespanningTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_graphn_make(size : Int) -> GraphtreespanningGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_graphn_len(s : GraphtreespanningGraphN) -> Int { s.size }

pub fn graph_tree_spanning_graphn_get(s : GraphtreespanningGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_graphn_set(s : GraphtreespanningGraphN, i : Int, v : Double) -> GraphtreespanningGraphN {
  let result = graph_tree_spanning_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_graphn_sum(s : GraphtreespanningGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_graphn_mean(s : GraphtreespanningGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_graphn_scale(s : GraphtreespanningGraphN, f : Double) -> GraphtreespanningGraphN {
  let result = graph_tree_spanning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_graphn_add(a : GraphtreespanningGraphN, b : GraphtreespanningGraphN) -> GraphtreespanningGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_graphn_copy(s : GraphtreespanningGraphN) -> GraphtreespanningGraphN {
  let result = graph_tree_spanning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_graphn_fill(s : GraphtreespanningGraphN, v : Double) -> GraphtreespanningGraphN {
  let result = graph_tree_spanning_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_graphn_min(s : GraphtreespanningGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_graphn_max(s : GraphtreespanningGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_graphn_to_string(s : GraphtreespanningGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_node_make(size : Int) -> GraphtreespanningNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_node_len(s : GraphtreespanningNode) -> Int { s.size }

pub fn graph_tree_spanning_node_get(s : GraphtreespanningNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_node_set(s : GraphtreespanningNode, i : Int, v : Double) -> GraphtreespanningNode {
  let result = graph_tree_spanning_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_node_sum(s : GraphtreespanningNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_node_mean(s : GraphtreespanningNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_node_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_node_scale(s : GraphtreespanningNode, f : Double) -> GraphtreespanningNode {
  let result = graph_tree_spanning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_node_add(a : GraphtreespanningNode, b : GraphtreespanningNode) -> GraphtreespanningNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_node_copy(s : GraphtreespanningNode) -> GraphtreespanningNode {
  let result = graph_tree_spanning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_node_fill(s : GraphtreespanningNode, v : Double) -> GraphtreespanningNode {
  let result = graph_tree_spanning_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_node_min(s : GraphtreespanningNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_node_max(s : GraphtreespanningNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_node_to_string(s : GraphtreespanningNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_edge_make(size : Int) -> GraphtreespanningEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_edge_len(s : GraphtreespanningEdge) -> Int { s.size }

pub fn graph_tree_spanning_edge_get(s : GraphtreespanningEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_edge_set(s : GraphtreespanningEdge, i : Int, v : Double) -> GraphtreespanningEdge {
  let result = graph_tree_spanning_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_edge_sum(s : GraphtreespanningEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_edge_mean(s : GraphtreespanningEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_edge_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_edge_scale(s : GraphtreespanningEdge, f : Double) -> GraphtreespanningEdge {
  let result = graph_tree_spanning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_edge_add(a : GraphtreespanningEdge, b : GraphtreespanningEdge) -> GraphtreespanningEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_edge_copy(s : GraphtreespanningEdge) -> GraphtreespanningEdge {
  let result = graph_tree_spanning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_edge_fill(s : GraphtreespanningEdge, v : Double) -> GraphtreespanningEdge {
  let result = graph_tree_spanning_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_edge_min(s : GraphtreespanningEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_edge_max(s : GraphtreespanningEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_edge_to_string(s : GraphtreespanningEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_path_make(size : Int) -> GraphtreespanningPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_path_len(s : GraphtreespanningPath) -> Int { s.size }

pub fn graph_tree_spanning_path_get(s : GraphtreespanningPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_path_set(s : GraphtreespanningPath, i : Int, v : Double) -> GraphtreespanningPath {
  let result = graph_tree_spanning_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_path_sum(s : GraphtreespanningPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_path_mean(s : GraphtreespanningPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_path_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_path_scale(s : GraphtreespanningPath, f : Double) -> GraphtreespanningPath {
  let result = graph_tree_spanning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_path_add(a : GraphtreespanningPath, b : GraphtreespanningPath) -> GraphtreespanningPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_path_copy(s : GraphtreespanningPath) -> GraphtreespanningPath {
  let result = graph_tree_spanning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_path_fill(s : GraphtreespanningPath, v : Double) -> GraphtreespanningPath {
  let result = graph_tree_spanning_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_path_min(s : GraphtreespanningPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_path_max(s : GraphtreespanningPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_path_to_string(s : GraphtreespanningPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_cluster_make(size : Int) -> GraphtreespanningCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_cluster_len(s : GraphtreespanningCluster) -> Int { s.size }

pub fn graph_tree_spanning_cluster_get(s : GraphtreespanningCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_cluster_set(s : GraphtreespanningCluster, i : Int, v : Double) -> GraphtreespanningCluster {
  let result = graph_tree_spanning_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_cluster_sum(s : GraphtreespanningCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_cluster_mean(s : GraphtreespanningCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_cluster_scale(s : GraphtreespanningCluster, f : Double) -> GraphtreespanningCluster {
  let result = graph_tree_spanning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_cluster_add(a : GraphtreespanningCluster, b : GraphtreespanningCluster) -> GraphtreespanningCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_cluster_copy(s : GraphtreespanningCluster) -> GraphtreespanningCluster {
  let result = graph_tree_spanning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_cluster_fill(s : GraphtreespanningCluster, v : Double) -> GraphtreespanningCluster {
  let result = graph_tree_spanning_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_cluster_min(s : GraphtreespanningCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_cluster_max(s : GraphtreespanningCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_cluster_to_string(s : GraphtreespanningCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_model_make(size : Int) -> GraphtreespanningModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_model_len(s : GraphtreespanningModel) -> Int { s.size }

pub fn graph_tree_spanning_model_get(s : GraphtreespanningModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_model_set(s : GraphtreespanningModel, i : Int, v : Double) -> GraphtreespanningModel {
  let result = graph_tree_spanning_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_model_sum(s : GraphtreespanningModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_model_mean(s : GraphtreespanningModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_model_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_model_scale(s : GraphtreespanningModel, f : Double) -> GraphtreespanningModel {
  let result = graph_tree_spanning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_model_add(a : GraphtreespanningModel, b : GraphtreespanningModel) -> GraphtreespanningModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_model_copy(s : GraphtreespanningModel) -> GraphtreespanningModel {
  let result = graph_tree_spanning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_model_fill(s : GraphtreespanningModel, v : Double) -> GraphtreespanningModel {
  let result = graph_tree_spanning_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_model_min(s : GraphtreespanningModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_model_max(s : GraphtreespanningModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_model_to_string(s : GraphtreespanningModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_layer_make(size : Int) -> GraphtreespanningLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_layer_len(s : GraphtreespanningLayer) -> Int { s.size }

pub fn graph_tree_spanning_layer_get(s : GraphtreespanningLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_layer_set(s : GraphtreespanningLayer, i : Int, v : Double) -> GraphtreespanningLayer {
  let result = graph_tree_spanning_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_layer_sum(s : GraphtreespanningLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_layer_mean(s : GraphtreespanningLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_layer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_layer_scale(s : GraphtreespanningLayer, f : Double) -> GraphtreespanningLayer {
  let result = graph_tree_spanning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_layer_add(a : GraphtreespanningLayer, b : GraphtreespanningLayer) -> GraphtreespanningLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_layer_copy(s : GraphtreespanningLayer) -> GraphtreespanningLayer {
  let result = graph_tree_spanning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_layer_fill(s : GraphtreespanningLayer, v : Double) -> GraphtreespanningLayer {
  let result = graph_tree_spanning_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_layer_min(s : GraphtreespanningLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_layer_max(s : GraphtreespanningLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_layer_to_string(s : GraphtreespanningLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_buffer_make(size : Int) -> GraphtreespanningBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_buffer_len(s : GraphtreespanningBuffer) -> Int { s.size }

pub fn graph_tree_spanning_buffer_get(s : GraphtreespanningBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_buffer_set(s : GraphtreespanningBuffer, i : Int, v : Double) -> GraphtreespanningBuffer {
  let result = graph_tree_spanning_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_buffer_sum(s : GraphtreespanningBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_buffer_mean(s : GraphtreespanningBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_buffer_scale(s : GraphtreespanningBuffer, f : Double) -> GraphtreespanningBuffer {
  let result = graph_tree_spanning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_buffer_add(a : GraphtreespanningBuffer, b : GraphtreespanningBuffer) -> GraphtreespanningBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_buffer_copy(s : GraphtreespanningBuffer) -> GraphtreespanningBuffer {
  let result = graph_tree_spanning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_buffer_fill(s : GraphtreespanningBuffer, v : Double) -> GraphtreespanningBuffer {
  let result = graph_tree_spanning_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_buffer_min(s : GraphtreespanningBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_buffer_max(s : GraphtreespanningBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_buffer_to_string(s : GraphtreespanningBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_cursor_make(size : Int) -> GraphtreespanningCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_cursor_len(s : GraphtreespanningCursor) -> Int { s.size }

pub fn graph_tree_spanning_cursor_get(s : GraphtreespanningCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_cursor_set(s : GraphtreespanningCursor, i : Int, v : Double) -> GraphtreespanningCursor {
  let result = graph_tree_spanning_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_cursor_sum(s : GraphtreespanningCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_cursor_mean(s : GraphtreespanningCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_cursor_scale(s : GraphtreespanningCursor, f : Double) -> GraphtreespanningCursor {
  let result = graph_tree_spanning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_cursor_add(a : GraphtreespanningCursor, b : GraphtreespanningCursor) -> GraphtreespanningCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_cursor_copy(s : GraphtreespanningCursor) -> GraphtreespanningCursor {
  let result = graph_tree_spanning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_cursor_fill(s : GraphtreespanningCursor, v : Double) -> GraphtreespanningCursor {
  let result = graph_tree_spanning_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_cursor_min(s : GraphtreespanningCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_cursor_max(s : GraphtreespanningCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_cursor_to_string(s : GraphtreespanningCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_view_make(size : Int) -> GraphtreespanningView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_view_len(s : GraphtreespanningView) -> Int { s.size }

pub fn graph_tree_spanning_view_get(s : GraphtreespanningView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_view_set(s : GraphtreespanningView, i : Int, v : Double) -> GraphtreespanningView {
  let result = graph_tree_spanning_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_view_sum(s : GraphtreespanningView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_view_mean(s : GraphtreespanningView) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_view_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_view_scale(s : GraphtreespanningView, f : Double) -> GraphtreespanningView {
  let result = graph_tree_spanning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_view_add(a : GraphtreespanningView, b : GraphtreespanningView) -> GraphtreespanningView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_view_copy(s : GraphtreespanningView) -> GraphtreespanningView {
  let result = graph_tree_spanning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_view_fill(s : GraphtreespanningView, v : Double) -> GraphtreespanningView {
  let result = graph_tree_spanning_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_view_min(s : GraphtreespanningView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_view_max(s : GraphtreespanningView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_view_to_string(s : GraphtreespanningView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_range_make(size : Int) -> GraphtreespanningRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_range_len(s : GraphtreespanningRange) -> Int { s.size }

pub fn graph_tree_spanning_range_get(s : GraphtreespanningRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_range_set(s : GraphtreespanningRange, i : Int, v : Double) -> GraphtreespanningRange {
  let result = graph_tree_spanning_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_range_sum(s : GraphtreespanningRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_range_mean(s : GraphtreespanningRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_range_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_range_scale(s : GraphtreespanningRange, f : Double) -> GraphtreespanningRange {
  let result = graph_tree_spanning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_range_add(a : GraphtreespanningRange, b : GraphtreespanningRange) -> GraphtreespanningRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_range_copy(s : GraphtreespanningRange) -> GraphtreespanningRange {
  let result = graph_tree_spanning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_range_fill(s : GraphtreespanningRange, v : Double) -> GraphtreespanningRange {
  let result = graph_tree_spanning_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_range_min(s : GraphtreespanningRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_range_max(s : GraphtreespanningRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_range_to_string(s : GraphtreespanningRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreespanningSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_spanning_slice_make(size : Int) -> GraphtreespanningSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_spanning_slice_len(s : GraphtreespanningSlice) -> Int { s.size }

pub fn graph_tree_spanning_slice_get(s : GraphtreespanningSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_spanning_slice_set(s : GraphtreespanningSlice, i : Int, v : Double) -> GraphtreespanningSlice {
  let result = graph_tree_spanning_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_slice_sum(s : GraphtreespanningSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_spanning_slice_mean(s : GraphtreespanningSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_spanning_slice_sum(s) / s.size.to_double() }
}

pub fn graph_tree_spanning_slice_scale(s : GraphtreespanningSlice, f : Double) -> GraphtreespanningSlice {
  let result = graph_tree_spanning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_spanning_slice_add(a : GraphtreespanningSlice, b : GraphtreespanningSlice) -> GraphtreespanningSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_spanning_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_spanning_slice_copy(s : GraphtreespanningSlice) -> GraphtreespanningSlice {
  let result = graph_tree_spanning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_spanning_slice_fill(s : GraphtreespanningSlice, v : Double) -> GraphtreespanningSlice {
  let result = graph_tree_spanning_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_spanning_slice_min(s : GraphtreespanningSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_slice_max(s : GraphtreespanningSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_spanning_slice_to_string(s : GraphtreespanningSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

