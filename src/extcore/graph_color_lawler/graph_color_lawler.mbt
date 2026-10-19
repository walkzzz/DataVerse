///===
/// extcore/graph_color_lawler

pub(all) struct GraphcolorlawlerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_color_lawler_make_point(x : Double, y : Double) -> GraphcolorlawlerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_color_lawler_make_point3(x : Double, y : Double, z : Double) -> GraphcolorlawlerPoint {
  { x, y, z, label: 0 }
}

pub fn graph_color_lawler_point_x(pt : GraphcolorlawlerPoint) -> Double { pt.x }

pub fn graph_color_lawler_point_y(pt : GraphcolorlawlerPoint) -> Double { pt.y }

pub fn graph_color_lawler_point_z(pt : GraphcolorlawlerPoint) -> Double { pt.z }

pub fn graph_color_lawler_point_label(pt : GraphcolorlawlerPoint) -> Int { pt.label }

pub fn graph_color_lawler_point_dist(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  graph_color_lawler_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_color_lawler_point_add(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_color_lawler_point_sub(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_color_lawler_point_scale(pt : GraphcolorlawlerPoint, s : Double) -> GraphcolorlawlerPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_color_lawler_point_dot(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_color_lawler_point_cross(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_color_lawler_point_norm(pt : GraphcolorlawlerPoint) -> Double {
  graph_color_lawler_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_color_lawler_point_normalize(pt : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  let n = graph_color_lawler_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_color_lawler_point_scale(pt, 1.0 / n) }
}

pub fn graph_color_lawler_point_negate(pt : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_color_lawler_point_mid(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint) -> GraphcolorlawlerPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_color_lawler_point_lerp(a : GraphcolorlawlerPoint, b : GraphcolorlawlerPoint, t : Double) -> GraphcolorlawlerPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_color_lawler_point_to_string(pt : GraphcolorlawlerPoint) -> String {
  "(" + graph_color_lawler_dbl(pt.x) + ", " + graph_color_lawler_dbl(pt.y) + ", " + graph_color_lawler_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphcolorlawlerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_color_lawler_make_series(vals : Array[Double], name : String) -> GraphcolorlawlerSeries {
  { vals, name, meta: 0 }
}

pub fn graph_color_lawler_series_len(s : GraphcolorlawlerSeries) -> Int { s.vals.length() }

pub fn graph_color_lawler_series_sum(s : GraphcolorlawlerSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_color_lawler_series_mean(s : GraphcolorlawlerSeries) -> Double {
  let n = graph_color_lawler_series_len(s)
  if n == 0 { 0.0 } else { graph_color_lawler_series_sum(s) / n.to_double() }
}

pub fn graph_color_lawler_series_min(s : GraphcolorlawlerSeries) -> Double {
  let n = graph_color_lawler_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_color_lawler_series_max(s : GraphcolorlawlerSeries) -> Double {
  let n = graph_color_lawler_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_color_lawler_series_range(s : GraphcolorlawlerSeries) -> Double {
  graph_color_lawler_series_max(s) - graph_color_lawler_series_min(s)
}

pub fn graph_color_lawler_series_var(s : GraphcolorlawlerSeries) -> Double {
  let n = graph_color_lawler_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_color_lawler_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_color_lawler_series_std(s : GraphcolorlawlerSeries) -> Double { graph_color_lawler_sqrt(graph_color_lawler_series_var(s)) }

pub fn graph_color_lawler_series_median(s : GraphcolorlawlerSeries) -> Double {
  let n = graph_color_lawler_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_color_lawler_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_color_lawler_series_scale(s : GraphcolorlawlerSeries, f : Double) -> GraphcolorlawlerSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_color_lawler_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_color_lawler_series_add(a : GraphcolorlawlerSeries, b : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_color_lawler_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_color_lawler_series_sub(a : GraphcolorlawlerSeries, b : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_color_lawler_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_color_lawler_series_normalize(s : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  let mn = graph_color_lawler_series_min(s)
  let mx = graph_color_lawler_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = graph_color_lawler_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_color_lawler_series_cumsum(s : GraphcolorlawlerSeries) -> GraphcolorlawlerSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = graph_color_lawler_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_color_lawler_series_to_string(s : GraphcolorlawlerSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_color_lawler_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphcolorlawlerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_color_lawler_make_matrix(rows : Int, cols : Int, val : Double) -> GraphcolorlawlerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_color_lawler_matrix_identity(n : Int) -> GraphcolorlawlerMatrix {
  let m = graph_color_lawler_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_color_lawler_matrix_get(m : GraphcolorlawlerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_color_lawler_matrix_transpose(m : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  let result = graph_color_lawler_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_color_lawler_matrix_add(a : GraphcolorlawlerMatrix, b : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_color_lawler_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_color_lawler_matrix_scale(m : GraphcolorlawlerMatrix, s : Double) -> GraphcolorlawlerMatrix {
  let result = graph_color_lawler_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_color_lawler_matrix_multiply(a : GraphcolorlawlerMatrix, b : GraphcolorlawlerMatrix) -> GraphcolorlawlerMatrix {
  if a.cols != b.rows { return graph_color_lawler_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_color_lawler_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_color_lawler_matrix_trace(m : GraphcolorlawlerMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_color_lawler_matrix_det(m : GraphcolorlawlerMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_color_lawler_matrix_norm(m : GraphcolorlawlerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  graph_color_lawler_sqrt(sum)
}

pub fn graph_color_lawler_matrix_to_string(m : GraphcolorlawlerMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_color_lawler_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphcolorlawlerVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_color_lawler_make_vector(comps : Array[Double]) -> GraphcolorlawlerVector {
  { comps, dim: comps.length() }
}

pub fn graph_color_lawler_vector_zero(dim : Int) -> GraphcolorlawlerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_color_lawler_vector_add(a : GraphcolorlawlerVector, b : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_color_lawler_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_lawler_vector_sub(a : GraphcolorlawlerVector, b : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_color_lawler_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_color_lawler_vector_scale(v : GraphcolorlawlerVector, s : Double) -> GraphcolorlawlerVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_color_lawler_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_color_lawler_vector_dot(a : GraphcolorlawlerVector, b : GraphcolorlawlerVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_color_lawler_vector_norm(v : GraphcolorlawlerVector) -> Double { graph_color_lawler_sqrt(graph_color_lawler_vector_dot(v, v)) }

pub fn graph_color_lawler_vector_normalize(v : GraphcolorlawlerVector) -> GraphcolorlawlerVector {
  let n = graph_color_lawler_vector_norm(v)
  if n < 0.0000001 { v } else { graph_color_lawler_vector_scale(v, 1.0 / n) }
}

pub fn graph_color_lawler_vector_dist(a : GraphcolorlawlerVector, b : GraphcolorlawlerVector) -> Double {
  graph_color_lawler_vector_norm(graph_color_lawler_vector_sub(a, b))
}

pub fn graph_color_lawler_vector_to_string(v : GraphcolorlawlerVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_color_lawler_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_color_lawler_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_color_lawler_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_color_lawler_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_color_lawler_std(data : Array[Double]) -> Double { graph_color_lawler_sqrt(graph_color_lawler_var(data)) }

pub fn graph_color_lawler_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_color_lawler_mean(a); let mb = graph_color_lawler_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_color_lawler_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_color_lawler_std(a); let sb = graph_color_lawler_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_color_lawler_cov(a, b) / (sa * sb) }
}

pub fn graph_color_lawler_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_color_lawler_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_color_lawler_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_color_lawler_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_color_lawler_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  graph_color_lawler_sqrt(graph_color_lawler_mse(pred, labels))
}

pub fn graph_color_lawler_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + graph_color_lawler_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_color_lawler_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_color_lawler_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_color_lawler_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_color_lawler_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_color_lawler_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_color_lawler_precision(pred, labels, pos); let r = graph_color_lawler_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_color_lawler_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_color_lawler_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_color_lawler_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_color_lawler_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_color_lawler_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_color_lawler_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_color_lawler_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_color_lawler_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_color_lawler_fibonacci(n : Int) -> Int {
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

pub fn graph_color_lawler_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_color_lawler_min(data); let mx = graph_color_lawler_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_color_lawler_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_color_lawler_mean(data); let sd = graph_color_lawler_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_color_lawler_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_color_lawler_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_color_lawler_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_color_lawler_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_color_lawler_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_color_lawler_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn graph_color_lawler_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn graph_color_lawler_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn graph_color_lawler_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_color_lawler_int(x) } else { -graph_color_lawler_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_color_lawler_int(f * 1000000.0) } else { graph_color_lawler_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_color_lawler_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_color_lawler_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GraphcolorlawlerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_frame_make(size : Int) -> GraphcolorlawlerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_frame_len(s : GraphcolorlawlerFrame) -> Int { s.size }

pub fn graph_color_lawler_frame_get(s : GraphcolorlawlerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_frame_set(s : GraphcolorlawlerFrame, i : Int, v : Double) -> GraphcolorlawlerFrame {
  let result = graph_color_lawler_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_frame_sum(s : GraphcolorlawlerFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_frame_mean(s : GraphcolorlawlerFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_frame_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_frame_scale(s : GraphcolorlawlerFrame, f : Double) -> GraphcolorlawlerFrame {
  let result = graph_color_lawler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_frame_add(a : GraphcolorlawlerFrame, b : GraphcolorlawlerFrame) -> GraphcolorlawlerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_frame_copy(s : GraphcolorlawlerFrame) -> GraphcolorlawlerFrame {
  let result = graph_color_lawler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_frame_fill(s : GraphcolorlawlerFrame, v : Double) -> GraphcolorlawlerFrame {
  let result = graph_color_lawler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_frame_min(s : GraphcolorlawlerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_frame_max(s : GraphcolorlawlerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_frame_to_string(s : GraphcolorlawlerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_table_make(size : Int) -> GraphcolorlawlerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_table_len(s : GraphcolorlawlerTable) -> Int { s.size }

pub fn graph_color_lawler_table_get(s : GraphcolorlawlerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_table_set(s : GraphcolorlawlerTable, i : Int, v : Double) -> GraphcolorlawlerTable {
  let result = graph_color_lawler_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_table_sum(s : GraphcolorlawlerTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_table_mean(s : GraphcolorlawlerTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_table_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_table_scale(s : GraphcolorlawlerTable, f : Double) -> GraphcolorlawlerTable {
  let result = graph_color_lawler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_table_add(a : GraphcolorlawlerTable, b : GraphcolorlawlerTable) -> GraphcolorlawlerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_table_copy(s : GraphcolorlawlerTable) -> GraphcolorlawlerTable {
  let result = graph_color_lawler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_table_fill(s : GraphcolorlawlerTable, v : Double) -> GraphcolorlawlerTable {
  let result = graph_color_lawler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_table_min(s : GraphcolorlawlerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_table_max(s : GraphcolorlawlerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_table_to_string(s : GraphcolorlawlerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_graphn_make(size : Int) -> GraphcolorlawlerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_graphn_len(s : GraphcolorlawlerGraphN) -> Int { s.size }

pub fn graph_color_lawler_graphn_get(s : GraphcolorlawlerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_graphn_set(s : GraphcolorlawlerGraphN, i : Int, v : Double) -> GraphcolorlawlerGraphN {
  let result = graph_color_lawler_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_graphn_sum(s : GraphcolorlawlerGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_graphn_mean(s : GraphcolorlawlerGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_graphn_scale(s : GraphcolorlawlerGraphN, f : Double) -> GraphcolorlawlerGraphN {
  let result = graph_color_lawler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_graphn_add(a : GraphcolorlawlerGraphN, b : GraphcolorlawlerGraphN) -> GraphcolorlawlerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_graphn_copy(s : GraphcolorlawlerGraphN) -> GraphcolorlawlerGraphN {
  let result = graph_color_lawler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_graphn_fill(s : GraphcolorlawlerGraphN, v : Double) -> GraphcolorlawlerGraphN {
  let result = graph_color_lawler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_graphn_min(s : GraphcolorlawlerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_graphn_max(s : GraphcolorlawlerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_graphn_to_string(s : GraphcolorlawlerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_node_make(size : Int) -> GraphcolorlawlerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_node_len(s : GraphcolorlawlerNode) -> Int { s.size }

pub fn graph_color_lawler_node_get(s : GraphcolorlawlerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_node_set(s : GraphcolorlawlerNode, i : Int, v : Double) -> GraphcolorlawlerNode {
  let result = graph_color_lawler_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_node_sum(s : GraphcolorlawlerNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_node_mean(s : GraphcolorlawlerNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_node_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_node_scale(s : GraphcolorlawlerNode, f : Double) -> GraphcolorlawlerNode {
  let result = graph_color_lawler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_node_add(a : GraphcolorlawlerNode, b : GraphcolorlawlerNode) -> GraphcolorlawlerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_node_copy(s : GraphcolorlawlerNode) -> GraphcolorlawlerNode {
  let result = graph_color_lawler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_node_fill(s : GraphcolorlawlerNode, v : Double) -> GraphcolorlawlerNode {
  let result = graph_color_lawler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_node_min(s : GraphcolorlawlerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_node_max(s : GraphcolorlawlerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_node_to_string(s : GraphcolorlawlerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_edge_make(size : Int) -> GraphcolorlawlerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_edge_len(s : GraphcolorlawlerEdge) -> Int { s.size }

pub fn graph_color_lawler_edge_get(s : GraphcolorlawlerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_edge_set(s : GraphcolorlawlerEdge, i : Int, v : Double) -> GraphcolorlawlerEdge {
  let result = graph_color_lawler_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_edge_sum(s : GraphcolorlawlerEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_edge_mean(s : GraphcolorlawlerEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_edge_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_edge_scale(s : GraphcolorlawlerEdge, f : Double) -> GraphcolorlawlerEdge {
  let result = graph_color_lawler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_edge_add(a : GraphcolorlawlerEdge, b : GraphcolorlawlerEdge) -> GraphcolorlawlerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_edge_copy(s : GraphcolorlawlerEdge) -> GraphcolorlawlerEdge {
  let result = graph_color_lawler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_edge_fill(s : GraphcolorlawlerEdge, v : Double) -> GraphcolorlawlerEdge {
  let result = graph_color_lawler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_edge_min(s : GraphcolorlawlerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_edge_max(s : GraphcolorlawlerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_edge_to_string(s : GraphcolorlawlerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_path_make(size : Int) -> GraphcolorlawlerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_path_len(s : GraphcolorlawlerPath) -> Int { s.size }

pub fn graph_color_lawler_path_get(s : GraphcolorlawlerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_path_set(s : GraphcolorlawlerPath, i : Int, v : Double) -> GraphcolorlawlerPath {
  let result = graph_color_lawler_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_path_sum(s : GraphcolorlawlerPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_path_mean(s : GraphcolorlawlerPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_path_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_path_scale(s : GraphcolorlawlerPath, f : Double) -> GraphcolorlawlerPath {
  let result = graph_color_lawler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_path_add(a : GraphcolorlawlerPath, b : GraphcolorlawlerPath) -> GraphcolorlawlerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_path_copy(s : GraphcolorlawlerPath) -> GraphcolorlawlerPath {
  let result = graph_color_lawler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_path_fill(s : GraphcolorlawlerPath, v : Double) -> GraphcolorlawlerPath {
  let result = graph_color_lawler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_path_min(s : GraphcolorlawlerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_path_max(s : GraphcolorlawlerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_path_to_string(s : GraphcolorlawlerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_cluster_make(size : Int) -> GraphcolorlawlerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_cluster_len(s : GraphcolorlawlerCluster) -> Int { s.size }

pub fn graph_color_lawler_cluster_get(s : GraphcolorlawlerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_cluster_set(s : GraphcolorlawlerCluster, i : Int, v : Double) -> GraphcolorlawlerCluster {
  let result = graph_color_lawler_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_cluster_sum(s : GraphcolorlawlerCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_cluster_mean(s : GraphcolorlawlerCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_cluster_scale(s : GraphcolorlawlerCluster, f : Double) -> GraphcolorlawlerCluster {
  let result = graph_color_lawler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_cluster_add(a : GraphcolorlawlerCluster, b : GraphcolorlawlerCluster) -> GraphcolorlawlerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_cluster_copy(s : GraphcolorlawlerCluster) -> GraphcolorlawlerCluster {
  let result = graph_color_lawler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_cluster_fill(s : GraphcolorlawlerCluster, v : Double) -> GraphcolorlawlerCluster {
  let result = graph_color_lawler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_cluster_min(s : GraphcolorlawlerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_cluster_max(s : GraphcolorlawlerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_cluster_to_string(s : GraphcolorlawlerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_model_make(size : Int) -> GraphcolorlawlerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_model_len(s : GraphcolorlawlerModel) -> Int { s.size }

pub fn graph_color_lawler_model_get(s : GraphcolorlawlerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_model_set(s : GraphcolorlawlerModel, i : Int, v : Double) -> GraphcolorlawlerModel {
  let result = graph_color_lawler_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_model_sum(s : GraphcolorlawlerModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_model_mean(s : GraphcolorlawlerModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_model_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_model_scale(s : GraphcolorlawlerModel, f : Double) -> GraphcolorlawlerModel {
  let result = graph_color_lawler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_model_add(a : GraphcolorlawlerModel, b : GraphcolorlawlerModel) -> GraphcolorlawlerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_model_copy(s : GraphcolorlawlerModel) -> GraphcolorlawlerModel {
  let result = graph_color_lawler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_model_fill(s : GraphcolorlawlerModel, v : Double) -> GraphcolorlawlerModel {
  let result = graph_color_lawler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_model_min(s : GraphcolorlawlerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_model_max(s : GraphcolorlawlerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_model_to_string(s : GraphcolorlawlerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_layer_make(size : Int) -> GraphcolorlawlerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_layer_len(s : GraphcolorlawlerLayer) -> Int { s.size }

pub fn graph_color_lawler_layer_get(s : GraphcolorlawlerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_layer_set(s : GraphcolorlawlerLayer, i : Int, v : Double) -> GraphcolorlawlerLayer {
  let result = graph_color_lawler_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_layer_sum(s : GraphcolorlawlerLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_layer_mean(s : GraphcolorlawlerLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_layer_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_layer_scale(s : GraphcolorlawlerLayer, f : Double) -> GraphcolorlawlerLayer {
  let result = graph_color_lawler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_layer_add(a : GraphcolorlawlerLayer, b : GraphcolorlawlerLayer) -> GraphcolorlawlerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_layer_copy(s : GraphcolorlawlerLayer) -> GraphcolorlawlerLayer {
  let result = graph_color_lawler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_layer_fill(s : GraphcolorlawlerLayer, v : Double) -> GraphcolorlawlerLayer {
  let result = graph_color_lawler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_layer_min(s : GraphcolorlawlerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_layer_max(s : GraphcolorlawlerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_layer_to_string(s : GraphcolorlawlerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_buffer_make(size : Int) -> GraphcolorlawlerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_buffer_len(s : GraphcolorlawlerBuffer) -> Int { s.size }

pub fn graph_color_lawler_buffer_get(s : GraphcolorlawlerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_buffer_set(s : GraphcolorlawlerBuffer, i : Int, v : Double) -> GraphcolorlawlerBuffer {
  let result = graph_color_lawler_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_buffer_sum(s : GraphcolorlawlerBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_buffer_mean(s : GraphcolorlawlerBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_buffer_scale(s : GraphcolorlawlerBuffer, f : Double) -> GraphcolorlawlerBuffer {
  let result = graph_color_lawler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_buffer_add(a : GraphcolorlawlerBuffer, b : GraphcolorlawlerBuffer) -> GraphcolorlawlerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_buffer_copy(s : GraphcolorlawlerBuffer) -> GraphcolorlawlerBuffer {
  let result = graph_color_lawler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_buffer_fill(s : GraphcolorlawlerBuffer, v : Double) -> GraphcolorlawlerBuffer {
  let result = graph_color_lawler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_buffer_min(s : GraphcolorlawlerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_buffer_max(s : GraphcolorlawlerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_buffer_to_string(s : GraphcolorlawlerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_cursor_make(size : Int) -> GraphcolorlawlerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_cursor_len(s : GraphcolorlawlerCursor) -> Int { s.size }

pub fn graph_color_lawler_cursor_get(s : GraphcolorlawlerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_cursor_set(s : GraphcolorlawlerCursor, i : Int, v : Double) -> GraphcolorlawlerCursor {
  let result = graph_color_lawler_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_cursor_sum(s : GraphcolorlawlerCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_cursor_mean(s : GraphcolorlawlerCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_cursor_scale(s : GraphcolorlawlerCursor, f : Double) -> GraphcolorlawlerCursor {
  let result = graph_color_lawler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_cursor_add(a : GraphcolorlawlerCursor, b : GraphcolorlawlerCursor) -> GraphcolorlawlerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_cursor_copy(s : GraphcolorlawlerCursor) -> GraphcolorlawlerCursor {
  let result = graph_color_lawler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_cursor_fill(s : GraphcolorlawlerCursor, v : Double) -> GraphcolorlawlerCursor {
  let result = graph_color_lawler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_cursor_min(s : GraphcolorlawlerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_cursor_max(s : GraphcolorlawlerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_cursor_to_string(s : GraphcolorlawlerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_view_make(size : Int) -> GraphcolorlawlerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_view_len(s : GraphcolorlawlerView) -> Int { s.size }

pub fn graph_color_lawler_view_get(s : GraphcolorlawlerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_view_set(s : GraphcolorlawlerView, i : Int, v : Double) -> GraphcolorlawlerView {
  let result = graph_color_lawler_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_view_sum(s : GraphcolorlawlerView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_view_mean(s : GraphcolorlawlerView) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_view_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_view_scale(s : GraphcolorlawlerView, f : Double) -> GraphcolorlawlerView {
  let result = graph_color_lawler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_view_add(a : GraphcolorlawlerView, b : GraphcolorlawlerView) -> GraphcolorlawlerView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_view_copy(s : GraphcolorlawlerView) -> GraphcolorlawlerView {
  let result = graph_color_lawler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_view_fill(s : GraphcolorlawlerView, v : Double) -> GraphcolorlawlerView {
  let result = graph_color_lawler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_view_min(s : GraphcolorlawlerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_view_max(s : GraphcolorlawlerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_view_to_string(s : GraphcolorlawlerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_range_make(size : Int) -> GraphcolorlawlerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_range_len(s : GraphcolorlawlerRange) -> Int { s.size }

pub fn graph_color_lawler_range_get(s : GraphcolorlawlerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_range_set(s : GraphcolorlawlerRange, i : Int, v : Double) -> GraphcolorlawlerRange {
  let result = graph_color_lawler_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_range_sum(s : GraphcolorlawlerRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_range_mean(s : GraphcolorlawlerRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_range_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_range_scale(s : GraphcolorlawlerRange, f : Double) -> GraphcolorlawlerRange {
  let result = graph_color_lawler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_range_add(a : GraphcolorlawlerRange, b : GraphcolorlawlerRange) -> GraphcolorlawlerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_range_copy(s : GraphcolorlawlerRange) -> GraphcolorlawlerRange {
  let result = graph_color_lawler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_range_fill(s : GraphcolorlawlerRange, v : Double) -> GraphcolorlawlerRange {
  let result = graph_color_lawler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_range_min(s : GraphcolorlawlerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_range_max(s : GraphcolorlawlerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_range_to_string(s : GraphcolorlawlerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphcolorlawlerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_color_lawler_slice_make(size : Int) -> GraphcolorlawlerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_color_lawler_slice_len(s : GraphcolorlawlerSlice) -> Int { s.size }

pub fn graph_color_lawler_slice_get(s : GraphcolorlawlerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_color_lawler_slice_set(s : GraphcolorlawlerSlice, i : Int, v : Double) -> GraphcolorlawlerSlice {
  let result = graph_color_lawler_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_slice_sum(s : GraphcolorlawlerSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_color_lawler_slice_mean(s : GraphcolorlawlerSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_color_lawler_slice_sum(s) / s.size.to_double() }
}

pub fn graph_color_lawler_slice_scale(s : GraphcolorlawlerSlice, f : Double) -> GraphcolorlawlerSlice {
  let result = graph_color_lawler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_color_lawler_slice_add(a : GraphcolorlawlerSlice, b : GraphcolorlawlerSlice) -> GraphcolorlawlerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_color_lawler_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_color_lawler_slice_copy(s : GraphcolorlawlerSlice) -> GraphcolorlawlerSlice {
  let result = graph_color_lawler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_color_lawler_slice_fill(s : GraphcolorlawlerSlice, v : Double) -> GraphcolorlawlerSlice {
  let result = graph_color_lawler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_color_lawler_slice_min(s : GraphcolorlawlerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_slice_max(s : GraphcolorlawlerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_color_lawler_slice_to_string(s : GraphcolorlawlerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn graph_color_lawler_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_color_lawler_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

