///===
/// extcore/graph_tree_encoding

pub(all) struct GraphtreeencodingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_tree_encoding_make_point(x : Double, y : Double) -> GraphtreeencodingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_tree_encoding_make_point3(x : Double, y : Double, z : Double) -> GraphtreeencodingPoint {
  { x, y, z, label: 0 }
}

pub fn graph_tree_encoding_point_x(pt : GraphtreeencodingPoint) -> Double { pt.x }

pub fn graph_tree_encoding_point_y(pt : GraphtreeencodingPoint) -> Double { pt.y }

pub fn graph_tree_encoding_point_z(pt : GraphtreeencodingPoint) -> Double { pt.z }

pub fn graph_tree_encoding_point_label(pt : GraphtreeencodingPoint) -> Int { pt.label }

pub fn graph_tree_encoding_point_dist(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  graph_tree_encoding_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_tree_encoding_point_add(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_tree_encoding_point_sub(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_tree_encoding_point_scale(pt : GraphtreeencodingPoint, s : Double) -> GraphtreeencodingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_tree_encoding_point_dot(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_tree_encoding_point_cross(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_tree_encoding_point_norm(pt : GraphtreeencodingPoint) -> Double {
  graph_tree_encoding_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_tree_encoding_point_normalize(pt : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  let n = graph_tree_encoding_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_tree_encoding_point_scale(pt, 1.0 / n) }
}

pub fn graph_tree_encoding_point_negate(pt : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_tree_encoding_point_mid(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint) -> GraphtreeencodingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_tree_encoding_point_lerp(a : GraphtreeencodingPoint, b : GraphtreeencodingPoint, t : Double) -> GraphtreeencodingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_tree_encoding_point_to_string(pt : GraphtreeencodingPoint) -> String {
  "(" + graph_tree_encoding_dbl(pt.x) + ", " + graph_tree_encoding_dbl(pt.y) + ", " + graph_tree_encoding_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphtreeencodingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_tree_encoding_make_series(vals : Array[Double], name : String) -> GraphtreeencodingSeries {
  { vals, name, meta: 0 }
}

pub fn graph_tree_encoding_series_len(s : GraphtreeencodingSeries) -> Int { s.vals.length() }

pub fn graph_tree_encoding_series_sum(s : GraphtreeencodingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_tree_encoding_series_mean(s : GraphtreeencodingSeries) -> Double {
  let n = graph_tree_encoding_series_len(s)
  if n == 0 { 0.0 } else { graph_tree_encoding_series_sum(s) / n.to_double() }
}

pub fn graph_tree_encoding_series_min(s : GraphtreeencodingSeries) -> Double {
  let n = graph_tree_encoding_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_tree_encoding_series_max(s : GraphtreeencodingSeries) -> Double {
  let n = graph_tree_encoding_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_tree_encoding_series_range(s : GraphtreeencodingSeries) -> Double {
  graph_tree_encoding_series_max(s) - graph_tree_encoding_series_min(s)
}

pub fn graph_tree_encoding_series_var(s : GraphtreeencodingSeries) -> Double {
  let n = graph_tree_encoding_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_tree_encoding_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_tree_encoding_series_std(s : GraphtreeencodingSeries) -> Double { graph_tree_encoding_sqrt(graph_tree_encoding_series_var(s)) }

pub fn graph_tree_encoding_series_median(s : GraphtreeencodingSeries) -> Double {
  let n = graph_tree_encoding_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_tree_encoding_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_tree_encoding_series_scale(s : GraphtreeencodingSeries, f : Double) -> GraphtreeencodingSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_tree_encoding_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_tree_encoding_series_add(a : GraphtreeencodingSeries, b : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_tree_encoding_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_tree_encoding_series_sub(a : GraphtreeencodingSeries, b : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_tree_encoding_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_tree_encoding_series_normalize(s : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  let mn = graph_tree_encoding_series_min(s)
  let mx = graph_tree_encoding_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = graph_tree_encoding_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_tree_encoding_series_cumsum(s : GraphtreeencodingSeries) -> GraphtreeencodingSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = graph_tree_encoding_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_tree_encoding_series_to_string(s : GraphtreeencodingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_tree_encoding_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphtreeencodingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_tree_encoding_make_matrix(rows : Int, cols : Int, val : Double) -> GraphtreeencodingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_tree_encoding_matrix_identity(n : Int) -> GraphtreeencodingMatrix {
  let m = graph_tree_encoding_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_tree_encoding_matrix_get(m : GraphtreeencodingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_tree_encoding_matrix_transpose(m : GraphtreeencodingMatrix) -> GraphtreeencodingMatrix {
  let result = graph_tree_encoding_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_tree_encoding_matrix_add(a : GraphtreeencodingMatrix, b : GraphtreeencodingMatrix) -> GraphtreeencodingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_tree_encoding_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_tree_encoding_matrix_scale(m : GraphtreeencodingMatrix, s : Double) -> GraphtreeencodingMatrix {
  let result = graph_tree_encoding_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_tree_encoding_matrix_multiply(a : GraphtreeencodingMatrix, b : GraphtreeencodingMatrix) -> GraphtreeencodingMatrix {
  if a.cols != b.rows { return graph_tree_encoding_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_tree_encoding_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_tree_encoding_matrix_trace(m : GraphtreeencodingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_tree_encoding_matrix_det(m : GraphtreeencodingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_tree_encoding_matrix_norm(m : GraphtreeencodingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  graph_tree_encoding_sqrt(sum)
}

pub fn graph_tree_encoding_matrix_to_string(m : GraphtreeencodingMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_tree_encoding_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphtreeencodingVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_tree_encoding_make_vector(comps : Array[Double]) -> GraphtreeencodingVector {
  { comps, dim: comps.length() }
}

pub fn graph_tree_encoding_vector_zero(dim : Int) -> GraphtreeencodingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_tree_encoding_vector_add(a : GraphtreeencodingVector, b : GraphtreeencodingVector) -> GraphtreeencodingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_tree_encoding_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_encoding_vector_sub(a : GraphtreeencodingVector, b : GraphtreeencodingVector) -> GraphtreeencodingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_tree_encoding_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_tree_encoding_vector_scale(v : GraphtreeencodingVector, s : Double) -> GraphtreeencodingVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_tree_encoding_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_tree_encoding_vector_dot(a : GraphtreeencodingVector, b : GraphtreeencodingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_tree_encoding_vector_norm(v : GraphtreeencodingVector) -> Double { graph_tree_encoding_sqrt(graph_tree_encoding_vector_dot(v, v)) }

pub fn graph_tree_encoding_vector_normalize(v : GraphtreeencodingVector) -> GraphtreeencodingVector {
  let n = graph_tree_encoding_vector_norm(v)
  if n < 0.0000001 { v } else { graph_tree_encoding_vector_scale(v, 1.0 / n) }
}

pub fn graph_tree_encoding_vector_dist(a : GraphtreeencodingVector, b : GraphtreeencodingVector) -> Double {
  graph_tree_encoding_vector_norm(graph_tree_encoding_vector_sub(a, b))
}

pub fn graph_tree_encoding_vector_to_string(v : GraphtreeencodingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_tree_encoding_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_tree_encoding_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_tree_encoding_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_tree_encoding_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_tree_encoding_std(data : Array[Double]) -> Double { graph_tree_encoding_sqrt(graph_tree_encoding_var(data)) }

pub fn graph_tree_encoding_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_tree_encoding_mean(a); let mb = graph_tree_encoding_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_tree_encoding_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_tree_encoding_std(a); let sb = graph_tree_encoding_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_tree_encoding_cov(a, b) / (sa * sb) }
}

pub fn graph_tree_encoding_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_tree_encoding_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_tree_encoding_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_tree_encoding_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_tree_encoding_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  graph_tree_encoding_sqrt(graph_tree_encoding_mse(pred, labels))
}

pub fn graph_tree_encoding_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + graph_tree_encoding_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_tree_encoding_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_tree_encoding_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_tree_encoding_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_tree_encoding_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_tree_encoding_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_tree_encoding_precision(pred, labels, pos); let r = graph_tree_encoding_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_tree_encoding_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_tree_encoding_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_tree_encoding_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_tree_encoding_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_tree_encoding_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_tree_encoding_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_tree_encoding_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_tree_encoding_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_tree_encoding_fibonacci(n : Int) -> Int {
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

pub fn graph_tree_encoding_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_tree_encoding_min(data); let mx = graph_tree_encoding_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_tree_encoding_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_tree_encoding_mean(data); let sd = graph_tree_encoding_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_tree_encoding_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_tree_encoding_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_tree_encoding_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_tree_encoding_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_tree_encoding_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_tree_encoding_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn graph_tree_encoding_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn graph_tree_encoding_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn graph_tree_encoding_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_tree_encoding_int(x) } else { -graph_tree_encoding_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_tree_encoding_int(f * 1000000.0) } else { graph_tree_encoding_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_tree_encoding_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_tree_encoding_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GraphtreeencodingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_frame_make(size : Int) -> GraphtreeencodingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_frame_len(s : GraphtreeencodingFrame) -> Int { s.size }

pub fn graph_tree_encoding_frame_get(s : GraphtreeencodingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_frame_set(s : GraphtreeencodingFrame, i : Int, v : Double) -> GraphtreeencodingFrame {
  let result = graph_tree_encoding_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_frame_sum(s : GraphtreeencodingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_frame_mean(s : GraphtreeencodingFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_frame_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_frame_scale(s : GraphtreeencodingFrame, f : Double) -> GraphtreeencodingFrame {
  let result = graph_tree_encoding_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_frame_add(a : GraphtreeencodingFrame, b : GraphtreeencodingFrame) -> GraphtreeencodingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_frame_copy(s : GraphtreeencodingFrame) -> GraphtreeencodingFrame {
  let result = graph_tree_encoding_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_frame_fill(s : GraphtreeencodingFrame, v : Double) -> GraphtreeencodingFrame {
  let result = graph_tree_encoding_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_frame_min(s : GraphtreeencodingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_frame_max(s : GraphtreeencodingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_frame_to_string(s : GraphtreeencodingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_table_make(size : Int) -> GraphtreeencodingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_table_len(s : GraphtreeencodingTable) -> Int { s.size }

pub fn graph_tree_encoding_table_get(s : GraphtreeencodingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_table_set(s : GraphtreeencodingTable, i : Int, v : Double) -> GraphtreeencodingTable {
  let result = graph_tree_encoding_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_table_sum(s : GraphtreeencodingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_table_mean(s : GraphtreeencodingTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_table_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_table_scale(s : GraphtreeencodingTable, f : Double) -> GraphtreeencodingTable {
  let result = graph_tree_encoding_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_table_add(a : GraphtreeencodingTable, b : GraphtreeencodingTable) -> GraphtreeencodingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_table_copy(s : GraphtreeencodingTable) -> GraphtreeencodingTable {
  let result = graph_tree_encoding_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_table_fill(s : GraphtreeencodingTable, v : Double) -> GraphtreeencodingTable {
  let result = graph_tree_encoding_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_table_min(s : GraphtreeencodingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_table_max(s : GraphtreeencodingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_table_to_string(s : GraphtreeencodingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_graphn_make(size : Int) -> GraphtreeencodingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_graphn_len(s : GraphtreeencodingGraphN) -> Int { s.size }

pub fn graph_tree_encoding_graphn_get(s : GraphtreeencodingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_graphn_set(s : GraphtreeencodingGraphN, i : Int, v : Double) -> GraphtreeencodingGraphN {
  let result = graph_tree_encoding_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_graphn_sum(s : GraphtreeencodingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_graphn_mean(s : GraphtreeencodingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_graphn_scale(s : GraphtreeencodingGraphN, f : Double) -> GraphtreeencodingGraphN {
  let result = graph_tree_encoding_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_graphn_add(a : GraphtreeencodingGraphN, b : GraphtreeencodingGraphN) -> GraphtreeencodingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_graphn_copy(s : GraphtreeencodingGraphN) -> GraphtreeencodingGraphN {
  let result = graph_tree_encoding_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_graphn_fill(s : GraphtreeencodingGraphN, v : Double) -> GraphtreeencodingGraphN {
  let result = graph_tree_encoding_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_graphn_min(s : GraphtreeencodingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_graphn_max(s : GraphtreeencodingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_graphn_to_string(s : GraphtreeencodingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_node_make(size : Int) -> GraphtreeencodingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_node_len(s : GraphtreeencodingNode) -> Int { s.size }

pub fn graph_tree_encoding_node_get(s : GraphtreeencodingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_node_set(s : GraphtreeencodingNode, i : Int, v : Double) -> GraphtreeencodingNode {
  let result = graph_tree_encoding_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_node_sum(s : GraphtreeencodingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_node_mean(s : GraphtreeencodingNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_node_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_node_scale(s : GraphtreeencodingNode, f : Double) -> GraphtreeencodingNode {
  let result = graph_tree_encoding_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_node_add(a : GraphtreeencodingNode, b : GraphtreeencodingNode) -> GraphtreeencodingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_node_copy(s : GraphtreeencodingNode) -> GraphtreeencodingNode {
  let result = graph_tree_encoding_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_node_fill(s : GraphtreeencodingNode, v : Double) -> GraphtreeencodingNode {
  let result = graph_tree_encoding_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_node_min(s : GraphtreeencodingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_node_max(s : GraphtreeencodingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_node_to_string(s : GraphtreeencodingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_edge_make(size : Int) -> GraphtreeencodingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_edge_len(s : GraphtreeencodingEdge) -> Int { s.size }

pub fn graph_tree_encoding_edge_get(s : GraphtreeencodingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_edge_set(s : GraphtreeencodingEdge, i : Int, v : Double) -> GraphtreeencodingEdge {
  let result = graph_tree_encoding_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_edge_sum(s : GraphtreeencodingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_edge_mean(s : GraphtreeencodingEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_edge_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_edge_scale(s : GraphtreeencodingEdge, f : Double) -> GraphtreeencodingEdge {
  let result = graph_tree_encoding_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_edge_add(a : GraphtreeencodingEdge, b : GraphtreeencodingEdge) -> GraphtreeencodingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_edge_copy(s : GraphtreeencodingEdge) -> GraphtreeencodingEdge {
  let result = graph_tree_encoding_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_edge_fill(s : GraphtreeencodingEdge, v : Double) -> GraphtreeencodingEdge {
  let result = graph_tree_encoding_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_edge_min(s : GraphtreeencodingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_edge_max(s : GraphtreeencodingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_edge_to_string(s : GraphtreeencodingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_path_make(size : Int) -> GraphtreeencodingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_path_len(s : GraphtreeencodingPath) -> Int { s.size }

pub fn graph_tree_encoding_path_get(s : GraphtreeencodingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_path_set(s : GraphtreeencodingPath, i : Int, v : Double) -> GraphtreeencodingPath {
  let result = graph_tree_encoding_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_path_sum(s : GraphtreeencodingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_path_mean(s : GraphtreeencodingPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_path_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_path_scale(s : GraphtreeencodingPath, f : Double) -> GraphtreeencodingPath {
  let result = graph_tree_encoding_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_path_add(a : GraphtreeencodingPath, b : GraphtreeencodingPath) -> GraphtreeencodingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_path_copy(s : GraphtreeencodingPath) -> GraphtreeencodingPath {
  let result = graph_tree_encoding_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_path_fill(s : GraphtreeencodingPath, v : Double) -> GraphtreeencodingPath {
  let result = graph_tree_encoding_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_path_min(s : GraphtreeencodingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_path_max(s : GraphtreeencodingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_path_to_string(s : GraphtreeencodingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_cluster_make(size : Int) -> GraphtreeencodingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_cluster_len(s : GraphtreeencodingCluster) -> Int { s.size }

pub fn graph_tree_encoding_cluster_get(s : GraphtreeencodingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_cluster_set(s : GraphtreeencodingCluster, i : Int, v : Double) -> GraphtreeencodingCluster {
  let result = graph_tree_encoding_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_cluster_sum(s : GraphtreeencodingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_cluster_mean(s : GraphtreeencodingCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_cluster_scale(s : GraphtreeencodingCluster, f : Double) -> GraphtreeencodingCluster {
  let result = graph_tree_encoding_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_cluster_add(a : GraphtreeencodingCluster, b : GraphtreeencodingCluster) -> GraphtreeencodingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_cluster_copy(s : GraphtreeencodingCluster) -> GraphtreeencodingCluster {
  let result = graph_tree_encoding_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_cluster_fill(s : GraphtreeencodingCluster, v : Double) -> GraphtreeencodingCluster {
  let result = graph_tree_encoding_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_cluster_min(s : GraphtreeencodingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_cluster_max(s : GraphtreeencodingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_cluster_to_string(s : GraphtreeencodingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_model_make(size : Int) -> GraphtreeencodingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_model_len(s : GraphtreeencodingModel) -> Int { s.size }

pub fn graph_tree_encoding_model_get(s : GraphtreeencodingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_model_set(s : GraphtreeencodingModel, i : Int, v : Double) -> GraphtreeencodingModel {
  let result = graph_tree_encoding_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_model_sum(s : GraphtreeencodingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_model_mean(s : GraphtreeencodingModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_model_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_model_scale(s : GraphtreeencodingModel, f : Double) -> GraphtreeencodingModel {
  let result = graph_tree_encoding_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_model_add(a : GraphtreeencodingModel, b : GraphtreeencodingModel) -> GraphtreeencodingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_model_copy(s : GraphtreeencodingModel) -> GraphtreeencodingModel {
  let result = graph_tree_encoding_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_model_fill(s : GraphtreeencodingModel, v : Double) -> GraphtreeencodingModel {
  let result = graph_tree_encoding_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_model_min(s : GraphtreeencodingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_model_max(s : GraphtreeencodingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_model_to_string(s : GraphtreeencodingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_layer_make(size : Int) -> GraphtreeencodingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_layer_len(s : GraphtreeencodingLayer) -> Int { s.size }

pub fn graph_tree_encoding_layer_get(s : GraphtreeencodingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_layer_set(s : GraphtreeencodingLayer, i : Int, v : Double) -> GraphtreeencodingLayer {
  let result = graph_tree_encoding_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_layer_sum(s : GraphtreeencodingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_layer_mean(s : GraphtreeencodingLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_layer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_layer_scale(s : GraphtreeencodingLayer, f : Double) -> GraphtreeencodingLayer {
  let result = graph_tree_encoding_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_layer_add(a : GraphtreeencodingLayer, b : GraphtreeencodingLayer) -> GraphtreeencodingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_layer_copy(s : GraphtreeencodingLayer) -> GraphtreeencodingLayer {
  let result = graph_tree_encoding_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_layer_fill(s : GraphtreeencodingLayer, v : Double) -> GraphtreeencodingLayer {
  let result = graph_tree_encoding_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_layer_min(s : GraphtreeencodingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_layer_max(s : GraphtreeencodingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_layer_to_string(s : GraphtreeencodingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_buffer_make(size : Int) -> GraphtreeencodingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_buffer_len(s : GraphtreeencodingBuffer) -> Int { s.size }

pub fn graph_tree_encoding_buffer_get(s : GraphtreeencodingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_buffer_set(s : GraphtreeencodingBuffer, i : Int, v : Double) -> GraphtreeencodingBuffer {
  let result = graph_tree_encoding_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_buffer_sum(s : GraphtreeencodingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_buffer_mean(s : GraphtreeencodingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_buffer_scale(s : GraphtreeencodingBuffer, f : Double) -> GraphtreeencodingBuffer {
  let result = graph_tree_encoding_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_buffer_add(a : GraphtreeencodingBuffer, b : GraphtreeencodingBuffer) -> GraphtreeencodingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_buffer_copy(s : GraphtreeencodingBuffer) -> GraphtreeencodingBuffer {
  let result = graph_tree_encoding_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_buffer_fill(s : GraphtreeencodingBuffer, v : Double) -> GraphtreeencodingBuffer {
  let result = graph_tree_encoding_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_buffer_min(s : GraphtreeencodingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_buffer_max(s : GraphtreeencodingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_buffer_to_string(s : GraphtreeencodingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_cursor_make(size : Int) -> GraphtreeencodingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_cursor_len(s : GraphtreeencodingCursor) -> Int { s.size }

pub fn graph_tree_encoding_cursor_get(s : GraphtreeencodingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_cursor_set(s : GraphtreeencodingCursor, i : Int, v : Double) -> GraphtreeencodingCursor {
  let result = graph_tree_encoding_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_cursor_sum(s : GraphtreeencodingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_cursor_mean(s : GraphtreeencodingCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_cursor_scale(s : GraphtreeencodingCursor, f : Double) -> GraphtreeencodingCursor {
  let result = graph_tree_encoding_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_cursor_add(a : GraphtreeencodingCursor, b : GraphtreeencodingCursor) -> GraphtreeencodingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_cursor_copy(s : GraphtreeencodingCursor) -> GraphtreeencodingCursor {
  let result = graph_tree_encoding_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_cursor_fill(s : GraphtreeencodingCursor, v : Double) -> GraphtreeencodingCursor {
  let result = graph_tree_encoding_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_cursor_min(s : GraphtreeencodingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_cursor_max(s : GraphtreeencodingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_cursor_to_string(s : GraphtreeencodingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_view_make(size : Int) -> GraphtreeencodingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_view_len(s : GraphtreeencodingView) -> Int { s.size }

pub fn graph_tree_encoding_view_get(s : GraphtreeencodingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_view_set(s : GraphtreeencodingView, i : Int, v : Double) -> GraphtreeencodingView {
  let result = graph_tree_encoding_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_view_sum(s : GraphtreeencodingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_view_mean(s : GraphtreeencodingView) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_view_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_view_scale(s : GraphtreeencodingView, f : Double) -> GraphtreeencodingView {
  let result = graph_tree_encoding_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_view_add(a : GraphtreeencodingView, b : GraphtreeencodingView) -> GraphtreeencodingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_view_copy(s : GraphtreeencodingView) -> GraphtreeencodingView {
  let result = graph_tree_encoding_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_view_fill(s : GraphtreeencodingView, v : Double) -> GraphtreeencodingView {
  let result = graph_tree_encoding_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_view_min(s : GraphtreeencodingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_view_max(s : GraphtreeencodingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_view_to_string(s : GraphtreeencodingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_range_make(size : Int) -> GraphtreeencodingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_range_len(s : GraphtreeencodingRange) -> Int { s.size }

pub fn graph_tree_encoding_range_get(s : GraphtreeencodingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_range_set(s : GraphtreeencodingRange, i : Int, v : Double) -> GraphtreeencodingRange {
  let result = graph_tree_encoding_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_range_sum(s : GraphtreeencodingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_range_mean(s : GraphtreeencodingRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_range_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_range_scale(s : GraphtreeencodingRange, f : Double) -> GraphtreeencodingRange {
  let result = graph_tree_encoding_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_range_add(a : GraphtreeencodingRange, b : GraphtreeencodingRange) -> GraphtreeencodingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_range_copy(s : GraphtreeencodingRange) -> GraphtreeencodingRange {
  let result = graph_tree_encoding_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_range_fill(s : GraphtreeencodingRange, v : Double) -> GraphtreeencodingRange {
  let result = graph_tree_encoding_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_range_min(s : GraphtreeencodingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_range_max(s : GraphtreeencodingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_range_to_string(s : GraphtreeencodingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphtreeencodingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_tree_encoding_slice_make(size : Int) -> GraphtreeencodingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_tree_encoding_slice_len(s : GraphtreeencodingSlice) -> Int { s.size }

pub fn graph_tree_encoding_slice_get(s : GraphtreeencodingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_tree_encoding_slice_set(s : GraphtreeencodingSlice, i : Int, v : Double) -> GraphtreeencodingSlice {
  let result = graph_tree_encoding_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_slice_sum(s : GraphtreeencodingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_tree_encoding_slice_mean(s : GraphtreeencodingSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_tree_encoding_slice_sum(s) / s.size.to_double() }
}

pub fn graph_tree_encoding_slice_scale(s : GraphtreeencodingSlice, f : Double) -> GraphtreeencodingSlice {
  let result = graph_tree_encoding_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_tree_encoding_slice_add(a : GraphtreeencodingSlice, b : GraphtreeencodingSlice) -> GraphtreeencodingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_tree_encoding_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_tree_encoding_slice_copy(s : GraphtreeencodingSlice) -> GraphtreeencodingSlice {
  let result = graph_tree_encoding_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_tree_encoding_slice_fill(s : GraphtreeencodingSlice, v : Double) -> GraphtreeencodingSlice {
  let result = graph_tree_encoding_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_tree_encoding_slice_min(s : GraphtreeencodingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_slice_max(s : GraphtreeencodingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_tree_encoding_slice_to_string(s : GraphtreeencodingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn graph_tree_encoding_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_tree_encoding_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

