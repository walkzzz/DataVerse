///===
/// extcore/graph_connect_strong

pub(all) struct GraphconnectstrongPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_strong_make_point(x : Double, y : Double) -> GraphconnectstrongPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_strong_make_point3(x : Double, y : Double, z : Double) -> GraphconnectstrongPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_strong_point_x(pt : GraphconnectstrongPoint) -> Double { pt.x }

pub fn graph_connect_strong_point_y(pt : GraphconnectstrongPoint) -> Double { pt.y }

pub fn graph_connect_strong_point_z(pt : GraphconnectstrongPoint) -> Double { pt.z }

pub fn graph_connect_strong_point_label(pt : GraphconnectstrongPoint) -> Int { pt.label }

pub fn graph_connect_strong_point_dist(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  graph_connect_strong_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_strong_point_add(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_strong_point_sub(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_strong_point_scale(pt : GraphconnectstrongPoint, s : Double) -> GraphconnectstrongPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_strong_point_dot(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_strong_point_cross(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_strong_point_norm(pt : GraphconnectstrongPoint) -> Double {
  graph_connect_strong_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_strong_point_normalize(pt : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  let n = graph_connect_strong_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_strong_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_strong_point_negate(pt : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_strong_point_mid(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint) -> GraphconnectstrongPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_strong_point_lerp(a : GraphconnectstrongPoint, b : GraphconnectstrongPoint, t : Double) -> GraphconnectstrongPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_strong_point_to_string(pt : GraphconnectstrongPoint) -> String {
  "(" + graph_connect_strong_dbl(pt.x) + ", " + graph_connect_strong_dbl(pt.y) + ", " + graph_connect_strong_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnectstrongSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_strong_make_series(vals : Array[Double], name : String) -> GraphconnectstrongSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_strong_series_len(s : GraphconnectstrongSeries) -> Int { s.vals.length() }

pub fn graph_connect_strong_series_sum(s : GraphconnectstrongSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_connect_strong_series_mean(s : GraphconnectstrongSeries) -> Double {
  let n = graph_connect_strong_series_len(s)
  if n == 0 { 0.0 } else { graph_connect_strong_series_sum(s) / n.to_double() }
}

pub fn graph_connect_strong_series_min(s : GraphconnectstrongSeries) -> Double {
  let n = graph_connect_strong_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_connect_strong_series_max(s : GraphconnectstrongSeries) -> Double {
  let n = graph_connect_strong_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_connect_strong_series_range(s : GraphconnectstrongSeries) -> Double {
  graph_connect_strong_series_max(s) - graph_connect_strong_series_min(s)
}

pub fn graph_connect_strong_series_var(s : GraphconnectstrongSeries) -> Double {
  let n = graph_connect_strong_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_connect_strong_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_connect_strong_series_std(s : GraphconnectstrongSeries) -> Double { graph_connect_strong_sqrt(graph_connect_strong_series_var(s)) }

pub fn graph_connect_strong_series_median(s : GraphconnectstrongSeries) -> Double {
  let n = graph_connect_strong_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_connect_strong_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_connect_strong_series_scale(s : GraphconnectstrongSeries, f : Double) -> GraphconnectstrongSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_connect_strong_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_connect_strong_series_add(a : GraphconnectstrongSeries, b : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_connect_strong_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_strong_series_sub(a : GraphconnectstrongSeries, b : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_connect_strong_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_strong_series_normalize(s : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  let mn = graph_connect_strong_series_min(s)
  let mx = graph_connect_strong_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = graph_connect_strong_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_strong_series_cumsum(s : GraphconnectstrongSeries) -> GraphconnectstrongSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = graph_connect_strong_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_strong_series_to_string(s : GraphconnectstrongSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_connect_strong_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectstrongMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_strong_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectstrongMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_strong_matrix_identity(n : Int) -> GraphconnectstrongMatrix {
  let m = graph_connect_strong_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_strong_matrix_get(m : GraphconnectstrongMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_strong_matrix_transpose(m : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  let result = graph_connect_strong_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_strong_matrix_add(a : GraphconnectstrongMatrix, b : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_strong_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_strong_matrix_scale(m : GraphconnectstrongMatrix, s : Double) -> GraphconnectstrongMatrix {
  let result = graph_connect_strong_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_strong_matrix_multiply(a : GraphconnectstrongMatrix, b : GraphconnectstrongMatrix) -> GraphconnectstrongMatrix {
  if a.cols != b.rows { return graph_connect_strong_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_strong_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_strong_matrix_trace(m : GraphconnectstrongMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_strong_matrix_det(m : GraphconnectstrongMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_strong_matrix_norm(m : GraphconnectstrongMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  graph_connect_strong_sqrt(sum)
}

pub fn graph_connect_strong_matrix_to_string(m : GraphconnectstrongMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_connect_strong_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphconnectstrongVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_strong_make_vector(comps : Array[Double]) -> GraphconnectstrongVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_strong_vector_zero(dim : Int) -> GraphconnectstrongVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_strong_vector_add(a : GraphconnectstrongVector, b : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_connect_strong_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_strong_vector_sub(a : GraphconnectstrongVector, b : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_connect_strong_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_strong_vector_scale(v : GraphconnectstrongVector, s : Double) -> GraphconnectstrongVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_connect_strong_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_connect_strong_vector_dot(a : GraphconnectstrongVector, b : GraphconnectstrongVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_strong_vector_norm(v : GraphconnectstrongVector) -> Double { graph_connect_strong_sqrt(graph_connect_strong_vector_dot(v, v)) }

pub fn graph_connect_strong_vector_normalize(v : GraphconnectstrongVector) -> GraphconnectstrongVector {
  let n = graph_connect_strong_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_strong_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_strong_vector_dist(a : GraphconnectstrongVector, b : GraphconnectstrongVector) -> Double {
  graph_connect_strong_vector_norm(graph_connect_strong_vector_sub(a, b))
}

pub fn graph_connect_strong_vector_to_string(v : GraphconnectstrongVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_connect_strong_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_strong_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_connect_strong_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_connect_strong_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_connect_strong_std(data : Array[Double]) -> Double { graph_connect_strong_sqrt(graph_connect_strong_var(data)) }

pub fn graph_connect_strong_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_connect_strong_mean(a); let mb = graph_connect_strong_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_connect_strong_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_connect_strong_std(a); let sb = graph_connect_strong_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_connect_strong_cov(a, b) / (sa * sb) }
}

pub fn graph_connect_strong_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_connect_strong_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_connect_strong_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_connect_strong_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_connect_strong_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  graph_connect_strong_sqrt(graph_connect_strong_mse(pred, labels))
}

pub fn graph_connect_strong_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + graph_connect_strong_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_connect_strong_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_connect_strong_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_connect_strong_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_connect_strong_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_connect_strong_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_connect_strong_precision(pred, labels, pos); let r = graph_connect_strong_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_connect_strong_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_connect_strong_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_connect_strong_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_connect_strong_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_connect_strong_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_connect_strong_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_connect_strong_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_connect_strong_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_connect_strong_fibonacci(n : Int) -> Int {
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

pub fn graph_connect_strong_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_connect_strong_min(data); let mx = graph_connect_strong_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_connect_strong_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_connect_strong_mean(data); let sd = graph_connect_strong_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_connect_strong_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_connect_strong_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_connect_strong_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_connect_strong_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_connect_strong_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_connect_strong_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn graph_connect_strong_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn graph_connect_strong_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn graph_connect_strong_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_connect_strong_int(x) } else { -graph_connect_strong_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_connect_strong_int(f * 1000000.0) } else { graph_connect_strong_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_connect_strong_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_connect_strong_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GraphconnectstrongFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_frame_make(size : Int) -> GraphconnectstrongFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_frame_len(s : GraphconnectstrongFrame) -> Int { s.size }

pub fn graph_connect_strong_frame_get(s : GraphconnectstrongFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_frame_set(s : GraphconnectstrongFrame, i : Int, v : Double) -> GraphconnectstrongFrame {
  let result = graph_connect_strong_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_frame_sum(s : GraphconnectstrongFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_frame_mean(s : GraphconnectstrongFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_frame_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_frame_scale(s : GraphconnectstrongFrame, f : Double) -> GraphconnectstrongFrame {
  let result = graph_connect_strong_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_frame_add(a : GraphconnectstrongFrame, b : GraphconnectstrongFrame) -> GraphconnectstrongFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_frame_copy(s : GraphconnectstrongFrame) -> GraphconnectstrongFrame {
  let result = graph_connect_strong_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_frame_fill(s : GraphconnectstrongFrame, v : Double) -> GraphconnectstrongFrame {
  let result = graph_connect_strong_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_frame_min(s : GraphconnectstrongFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_frame_max(s : GraphconnectstrongFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_frame_to_string(s : GraphconnectstrongFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_table_make(size : Int) -> GraphconnectstrongTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_table_len(s : GraphconnectstrongTable) -> Int { s.size }

pub fn graph_connect_strong_table_get(s : GraphconnectstrongTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_table_set(s : GraphconnectstrongTable, i : Int, v : Double) -> GraphconnectstrongTable {
  let result = graph_connect_strong_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_table_sum(s : GraphconnectstrongTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_table_mean(s : GraphconnectstrongTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_table_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_table_scale(s : GraphconnectstrongTable, f : Double) -> GraphconnectstrongTable {
  let result = graph_connect_strong_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_table_add(a : GraphconnectstrongTable, b : GraphconnectstrongTable) -> GraphconnectstrongTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_table_copy(s : GraphconnectstrongTable) -> GraphconnectstrongTable {
  let result = graph_connect_strong_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_table_fill(s : GraphconnectstrongTable, v : Double) -> GraphconnectstrongTable {
  let result = graph_connect_strong_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_table_min(s : GraphconnectstrongTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_table_max(s : GraphconnectstrongTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_table_to_string(s : GraphconnectstrongTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_graphn_make(size : Int) -> GraphconnectstrongGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_graphn_len(s : GraphconnectstrongGraphN) -> Int { s.size }

pub fn graph_connect_strong_graphn_get(s : GraphconnectstrongGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_graphn_set(s : GraphconnectstrongGraphN, i : Int, v : Double) -> GraphconnectstrongGraphN {
  let result = graph_connect_strong_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_graphn_sum(s : GraphconnectstrongGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_graphn_mean(s : GraphconnectstrongGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_graphn_scale(s : GraphconnectstrongGraphN, f : Double) -> GraphconnectstrongGraphN {
  let result = graph_connect_strong_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_graphn_add(a : GraphconnectstrongGraphN, b : GraphconnectstrongGraphN) -> GraphconnectstrongGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_graphn_copy(s : GraphconnectstrongGraphN) -> GraphconnectstrongGraphN {
  let result = graph_connect_strong_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_graphn_fill(s : GraphconnectstrongGraphN, v : Double) -> GraphconnectstrongGraphN {
  let result = graph_connect_strong_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_graphn_min(s : GraphconnectstrongGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_graphn_max(s : GraphconnectstrongGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_graphn_to_string(s : GraphconnectstrongGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_node_make(size : Int) -> GraphconnectstrongNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_node_len(s : GraphconnectstrongNode) -> Int { s.size }

pub fn graph_connect_strong_node_get(s : GraphconnectstrongNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_node_set(s : GraphconnectstrongNode, i : Int, v : Double) -> GraphconnectstrongNode {
  let result = graph_connect_strong_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_node_sum(s : GraphconnectstrongNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_node_mean(s : GraphconnectstrongNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_node_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_node_scale(s : GraphconnectstrongNode, f : Double) -> GraphconnectstrongNode {
  let result = graph_connect_strong_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_node_add(a : GraphconnectstrongNode, b : GraphconnectstrongNode) -> GraphconnectstrongNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_node_copy(s : GraphconnectstrongNode) -> GraphconnectstrongNode {
  let result = graph_connect_strong_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_node_fill(s : GraphconnectstrongNode, v : Double) -> GraphconnectstrongNode {
  let result = graph_connect_strong_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_node_min(s : GraphconnectstrongNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_node_max(s : GraphconnectstrongNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_node_to_string(s : GraphconnectstrongNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_edge_make(size : Int) -> GraphconnectstrongEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_edge_len(s : GraphconnectstrongEdge) -> Int { s.size }

pub fn graph_connect_strong_edge_get(s : GraphconnectstrongEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_edge_set(s : GraphconnectstrongEdge, i : Int, v : Double) -> GraphconnectstrongEdge {
  let result = graph_connect_strong_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_edge_sum(s : GraphconnectstrongEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_edge_mean(s : GraphconnectstrongEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_edge_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_edge_scale(s : GraphconnectstrongEdge, f : Double) -> GraphconnectstrongEdge {
  let result = graph_connect_strong_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_edge_add(a : GraphconnectstrongEdge, b : GraphconnectstrongEdge) -> GraphconnectstrongEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_edge_copy(s : GraphconnectstrongEdge) -> GraphconnectstrongEdge {
  let result = graph_connect_strong_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_edge_fill(s : GraphconnectstrongEdge, v : Double) -> GraphconnectstrongEdge {
  let result = graph_connect_strong_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_edge_min(s : GraphconnectstrongEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_edge_max(s : GraphconnectstrongEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_edge_to_string(s : GraphconnectstrongEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_path_make(size : Int) -> GraphconnectstrongPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_path_len(s : GraphconnectstrongPath) -> Int { s.size }

pub fn graph_connect_strong_path_get(s : GraphconnectstrongPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_path_set(s : GraphconnectstrongPath, i : Int, v : Double) -> GraphconnectstrongPath {
  let result = graph_connect_strong_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_path_sum(s : GraphconnectstrongPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_path_mean(s : GraphconnectstrongPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_path_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_path_scale(s : GraphconnectstrongPath, f : Double) -> GraphconnectstrongPath {
  let result = graph_connect_strong_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_path_add(a : GraphconnectstrongPath, b : GraphconnectstrongPath) -> GraphconnectstrongPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_path_copy(s : GraphconnectstrongPath) -> GraphconnectstrongPath {
  let result = graph_connect_strong_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_path_fill(s : GraphconnectstrongPath, v : Double) -> GraphconnectstrongPath {
  let result = graph_connect_strong_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_path_min(s : GraphconnectstrongPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_path_max(s : GraphconnectstrongPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_path_to_string(s : GraphconnectstrongPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_cluster_make(size : Int) -> GraphconnectstrongCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_cluster_len(s : GraphconnectstrongCluster) -> Int { s.size }

pub fn graph_connect_strong_cluster_get(s : GraphconnectstrongCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_cluster_set(s : GraphconnectstrongCluster, i : Int, v : Double) -> GraphconnectstrongCluster {
  let result = graph_connect_strong_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_cluster_sum(s : GraphconnectstrongCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_cluster_mean(s : GraphconnectstrongCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_cluster_scale(s : GraphconnectstrongCluster, f : Double) -> GraphconnectstrongCluster {
  let result = graph_connect_strong_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_cluster_add(a : GraphconnectstrongCluster, b : GraphconnectstrongCluster) -> GraphconnectstrongCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_cluster_copy(s : GraphconnectstrongCluster) -> GraphconnectstrongCluster {
  let result = graph_connect_strong_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_cluster_fill(s : GraphconnectstrongCluster, v : Double) -> GraphconnectstrongCluster {
  let result = graph_connect_strong_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_cluster_min(s : GraphconnectstrongCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_cluster_max(s : GraphconnectstrongCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_cluster_to_string(s : GraphconnectstrongCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_model_make(size : Int) -> GraphconnectstrongModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_model_len(s : GraphconnectstrongModel) -> Int { s.size }

pub fn graph_connect_strong_model_get(s : GraphconnectstrongModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_model_set(s : GraphconnectstrongModel, i : Int, v : Double) -> GraphconnectstrongModel {
  let result = graph_connect_strong_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_model_sum(s : GraphconnectstrongModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_model_mean(s : GraphconnectstrongModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_model_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_model_scale(s : GraphconnectstrongModel, f : Double) -> GraphconnectstrongModel {
  let result = graph_connect_strong_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_model_add(a : GraphconnectstrongModel, b : GraphconnectstrongModel) -> GraphconnectstrongModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_model_copy(s : GraphconnectstrongModel) -> GraphconnectstrongModel {
  let result = graph_connect_strong_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_model_fill(s : GraphconnectstrongModel, v : Double) -> GraphconnectstrongModel {
  let result = graph_connect_strong_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_model_min(s : GraphconnectstrongModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_model_max(s : GraphconnectstrongModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_model_to_string(s : GraphconnectstrongModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_layer_make(size : Int) -> GraphconnectstrongLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_layer_len(s : GraphconnectstrongLayer) -> Int { s.size }

pub fn graph_connect_strong_layer_get(s : GraphconnectstrongLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_layer_set(s : GraphconnectstrongLayer, i : Int, v : Double) -> GraphconnectstrongLayer {
  let result = graph_connect_strong_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_layer_sum(s : GraphconnectstrongLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_layer_mean(s : GraphconnectstrongLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_layer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_layer_scale(s : GraphconnectstrongLayer, f : Double) -> GraphconnectstrongLayer {
  let result = graph_connect_strong_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_layer_add(a : GraphconnectstrongLayer, b : GraphconnectstrongLayer) -> GraphconnectstrongLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_layer_copy(s : GraphconnectstrongLayer) -> GraphconnectstrongLayer {
  let result = graph_connect_strong_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_layer_fill(s : GraphconnectstrongLayer, v : Double) -> GraphconnectstrongLayer {
  let result = graph_connect_strong_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_layer_min(s : GraphconnectstrongLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_layer_max(s : GraphconnectstrongLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_layer_to_string(s : GraphconnectstrongLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_buffer_make(size : Int) -> GraphconnectstrongBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_buffer_len(s : GraphconnectstrongBuffer) -> Int { s.size }

pub fn graph_connect_strong_buffer_get(s : GraphconnectstrongBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_buffer_set(s : GraphconnectstrongBuffer, i : Int, v : Double) -> GraphconnectstrongBuffer {
  let result = graph_connect_strong_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_buffer_sum(s : GraphconnectstrongBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_buffer_mean(s : GraphconnectstrongBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_buffer_scale(s : GraphconnectstrongBuffer, f : Double) -> GraphconnectstrongBuffer {
  let result = graph_connect_strong_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_buffer_add(a : GraphconnectstrongBuffer, b : GraphconnectstrongBuffer) -> GraphconnectstrongBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_buffer_copy(s : GraphconnectstrongBuffer) -> GraphconnectstrongBuffer {
  let result = graph_connect_strong_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_buffer_fill(s : GraphconnectstrongBuffer, v : Double) -> GraphconnectstrongBuffer {
  let result = graph_connect_strong_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_buffer_min(s : GraphconnectstrongBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_buffer_max(s : GraphconnectstrongBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_buffer_to_string(s : GraphconnectstrongBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_cursor_make(size : Int) -> GraphconnectstrongCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_cursor_len(s : GraphconnectstrongCursor) -> Int { s.size }

pub fn graph_connect_strong_cursor_get(s : GraphconnectstrongCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_cursor_set(s : GraphconnectstrongCursor, i : Int, v : Double) -> GraphconnectstrongCursor {
  let result = graph_connect_strong_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_cursor_sum(s : GraphconnectstrongCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_cursor_mean(s : GraphconnectstrongCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_cursor_scale(s : GraphconnectstrongCursor, f : Double) -> GraphconnectstrongCursor {
  let result = graph_connect_strong_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_cursor_add(a : GraphconnectstrongCursor, b : GraphconnectstrongCursor) -> GraphconnectstrongCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_cursor_copy(s : GraphconnectstrongCursor) -> GraphconnectstrongCursor {
  let result = graph_connect_strong_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_cursor_fill(s : GraphconnectstrongCursor, v : Double) -> GraphconnectstrongCursor {
  let result = graph_connect_strong_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_cursor_min(s : GraphconnectstrongCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_cursor_max(s : GraphconnectstrongCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_cursor_to_string(s : GraphconnectstrongCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_view_make(size : Int) -> GraphconnectstrongView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_view_len(s : GraphconnectstrongView) -> Int { s.size }

pub fn graph_connect_strong_view_get(s : GraphconnectstrongView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_view_set(s : GraphconnectstrongView, i : Int, v : Double) -> GraphconnectstrongView {
  let result = graph_connect_strong_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_view_sum(s : GraphconnectstrongView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_view_mean(s : GraphconnectstrongView) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_view_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_view_scale(s : GraphconnectstrongView, f : Double) -> GraphconnectstrongView {
  let result = graph_connect_strong_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_view_add(a : GraphconnectstrongView, b : GraphconnectstrongView) -> GraphconnectstrongView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_view_copy(s : GraphconnectstrongView) -> GraphconnectstrongView {
  let result = graph_connect_strong_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_view_fill(s : GraphconnectstrongView, v : Double) -> GraphconnectstrongView {
  let result = graph_connect_strong_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_view_min(s : GraphconnectstrongView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_view_max(s : GraphconnectstrongView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_view_to_string(s : GraphconnectstrongView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_range_make(size : Int) -> GraphconnectstrongRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_range_len(s : GraphconnectstrongRange) -> Int { s.size }

pub fn graph_connect_strong_range_get(s : GraphconnectstrongRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_range_set(s : GraphconnectstrongRange, i : Int, v : Double) -> GraphconnectstrongRange {
  let result = graph_connect_strong_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_range_sum(s : GraphconnectstrongRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_range_mean(s : GraphconnectstrongRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_range_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_range_scale(s : GraphconnectstrongRange, f : Double) -> GraphconnectstrongRange {
  let result = graph_connect_strong_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_range_add(a : GraphconnectstrongRange, b : GraphconnectstrongRange) -> GraphconnectstrongRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_range_copy(s : GraphconnectstrongRange) -> GraphconnectstrongRange {
  let result = graph_connect_strong_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_range_fill(s : GraphconnectstrongRange, v : Double) -> GraphconnectstrongRange {
  let result = graph_connect_strong_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_range_min(s : GraphconnectstrongRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_range_max(s : GraphconnectstrongRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_range_to_string(s : GraphconnectstrongRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectstrongSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_strong_slice_make(size : Int) -> GraphconnectstrongSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_strong_slice_len(s : GraphconnectstrongSlice) -> Int { s.size }

pub fn graph_connect_strong_slice_get(s : GraphconnectstrongSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_strong_slice_set(s : GraphconnectstrongSlice, i : Int, v : Double) -> GraphconnectstrongSlice {
  let result = graph_connect_strong_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_slice_sum(s : GraphconnectstrongSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_strong_slice_mean(s : GraphconnectstrongSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_strong_slice_sum(s) / s.size.to_double() }
}

pub fn graph_connect_strong_slice_scale(s : GraphconnectstrongSlice, f : Double) -> GraphconnectstrongSlice {
  let result = graph_connect_strong_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_strong_slice_add(a : GraphconnectstrongSlice, b : GraphconnectstrongSlice) -> GraphconnectstrongSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_strong_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_strong_slice_copy(s : GraphconnectstrongSlice) -> GraphconnectstrongSlice {
  let result = graph_connect_strong_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_strong_slice_fill(s : GraphconnectstrongSlice, v : Double) -> GraphconnectstrongSlice {
  let result = graph_connect_strong_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_strong_slice_min(s : GraphconnectstrongSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_slice_max(s : GraphconnectstrongSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_strong_slice_to_string(s : GraphconnectstrongSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn graph_connect_strong_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_connect_strong_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

