///===
/// extcore/graph_search_iddfs

pub(all) struct GraphsearchiddfsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_iddfs_make_point(x : Double, y : Double) -> GraphsearchiddfsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_iddfs_make_point3(x : Double, y : Double, z : Double) -> GraphsearchiddfsPoint {
  { x, y, z, label: 0 }
}

pub fn graph_search_iddfs_point_x(pt : GraphsearchiddfsPoint) -> Double { pt.x }

pub fn graph_search_iddfs_point_y(pt : GraphsearchiddfsPoint) -> Double { pt.y }

pub fn graph_search_iddfs_point_z(pt : GraphsearchiddfsPoint) -> Double { pt.z }

pub fn graph_search_iddfs_point_label(pt : GraphsearchiddfsPoint) -> Int { pt.label }

pub fn graph_search_iddfs_point_dist(a : GraphsearchiddfsPoint, b : GraphsearchiddfsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  graph_search_iddfs_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_search_iddfs_point_add(a : GraphsearchiddfsPoint, b : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_search_iddfs_point_sub(a : GraphsearchiddfsPoint, b : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_search_iddfs_point_scale(pt : GraphsearchiddfsPoint, s : Double) -> GraphsearchiddfsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_search_iddfs_point_dot(a : GraphsearchiddfsPoint, b : GraphsearchiddfsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_search_iddfs_point_cross(a : GraphsearchiddfsPoint, b : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_search_iddfs_point_norm(pt : GraphsearchiddfsPoint) -> Double {
  graph_search_iddfs_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_search_iddfs_point_normalize(pt : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  let n = graph_search_iddfs_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_search_iddfs_point_scale(pt, 1.0 / n) }
}

pub fn graph_search_iddfs_point_negate(pt : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_search_iddfs_point_mid(a : GraphsearchiddfsPoint, b : GraphsearchiddfsPoint) -> GraphsearchiddfsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_search_iddfs_point_lerp(a : GraphsearchiddfsPoint, b : GraphsearchiddfsPoint, t : Double) -> GraphsearchiddfsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_search_iddfs_point_to_string(pt : GraphsearchiddfsPoint) -> String {
  "(" + graph_search_iddfs_dbl(pt.x) + ", " + graph_search_iddfs_dbl(pt.y) + ", " + graph_search_iddfs_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphsearchiddfsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_iddfs_make_series(vals : Array[Double], name : String) -> GraphsearchiddfsSeries {
  { vals, name, meta: 0 }
}

pub fn graph_search_iddfs_series_len(s : GraphsearchiddfsSeries) -> Int { s.vals.length() }

pub fn graph_search_iddfs_series_sum(s : GraphsearchiddfsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_search_iddfs_series_mean(s : GraphsearchiddfsSeries) -> Double {
  let n = graph_search_iddfs_series_len(s)
  if n == 0 { 0.0 } else { graph_search_iddfs_series_sum(s) / n.to_double() }
}

pub fn graph_search_iddfs_series_min(s : GraphsearchiddfsSeries) -> Double {
  let n = graph_search_iddfs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_iddfs_series_max(s : GraphsearchiddfsSeries) -> Double {
  let n = graph_search_iddfs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_iddfs_series_range(s : GraphsearchiddfsSeries) -> Double {
  graph_search_iddfs_series_max(s) - graph_search_iddfs_series_min(s)
}

pub fn graph_search_iddfs_series_var(s : GraphsearchiddfsSeries) -> Double {
  let n = graph_search_iddfs_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_search_iddfs_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_search_iddfs_series_std(s : GraphsearchiddfsSeries) -> Double { graph_search_iddfs_sqrt(graph_search_iddfs_series_var(s)) }

pub fn graph_search_iddfs_series_median(s : GraphsearchiddfsSeries) -> Double {
  let n = graph_search_iddfs_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_search_iddfs_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_search_iddfs_series_scale(s : GraphsearchiddfsSeries, f : Double) -> GraphsearchiddfsSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_search_iddfs_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_search_iddfs_series_add(a : GraphsearchiddfsSeries, b : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_search_iddfs_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_search_iddfs_series_sub(a : GraphsearchiddfsSeries, b : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_search_iddfs_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_search_iddfs_series_normalize(s : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  let mn = graph_search_iddfs_series_min(s)
  let mx = graph_search_iddfs_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = graph_search_iddfs_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_search_iddfs_series_cumsum(s : GraphsearchiddfsSeries) -> GraphsearchiddfsSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = graph_search_iddfs_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_search_iddfs_series_to_string(s : GraphsearchiddfsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_search_iddfs_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchiddfsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_iddfs_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchiddfsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_iddfs_matrix_identity(n : Int) -> GraphsearchiddfsMatrix {
  let m = graph_search_iddfs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_search_iddfs_matrix_get(m : GraphsearchiddfsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_search_iddfs_matrix_transpose(m : GraphsearchiddfsMatrix) -> GraphsearchiddfsMatrix {
  let result = graph_search_iddfs_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_search_iddfs_matrix_add(a : GraphsearchiddfsMatrix, b : GraphsearchiddfsMatrix) -> GraphsearchiddfsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_search_iddfs_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_search_iddfs_matrix_scale(m : GraphsearchiddfsMatrix, s : Double) -> GraphsearchiddfsMatrix {
  let result = graph_search_iddfs_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_search_iddfs_matrix_multiply(a : GraphsearchiddfsMatrix, b : GraphsearchiddfsMatrix) -> GraphsearchiddfsMatrix {
  if a.cols != b.rows { return graph_search_iddfs_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_search_iddfs_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_search_iddfs_matrix_trace(m : GraphsearchiddfsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_search_iddfs_matrix_det(m : GraphsearchiddfsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_search_iddfs_matrix_norm(m : GraphsearchiddfsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  graph_search_iddfs_sqrt(sum)
}

pub fn graph_search_iddfs_matrix_to_string(m : GraphsearchiddfsMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_search_iddfs_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphsearchiddfsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_iddfs_make_vector(comps : Array[Double]) -> GraphsearchiddfsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_iddfs_vector_zero(dim : Int) -> GraphsearchiddfsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_search_iddfs_vector_add(a : GraphsearchiddfsVector, b : GraphsearchiddfsVector) -> GraphsearchiddfsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_search_iddfs_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_iddfs_vector_sub(a : GraphsearchiddfsVector, b : GraphsearchiddfsVector) -> GraphsearchiddfsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_search_iddfs_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_iddfs_vector_scale(v : GraphsearchiddfsVector, s : Double) -> GraphsearchiddfsVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_search_iddfs_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_search_iddfs_vector_dot(a : GraphsearchiddfsVector, b : GraphsearchiddfsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_search_iddfs_vector_norm(v : GraphsearchiddfsVector) -> Double { graph_search_iddfs_sqrt(graph_search_iddfs_vector_dot(v, v)) }

pub fn graph_search_iddfs_vector_normalize(v : GraphsearchiddfsVector) -> GraphsearchiddfsVector {
  let n = graph_search_iddfs_vector_norm(v)
  if n < 0.0000001 { v } else { graph_search_iddfs_vector_scale(v, 1.0 / n) }
}

pub fn graph_search_iddfs_vector_dist(a : GraphsearchiddfsVector, b : GraphsearchiddfsVector) -> Double {
  graph_search_iddfs_vector_norm(graph_search_iddfs_vector_sub(a, b))
}

pub fn graph_search_iddfs_vector_to_string(v : GraphsearchiddfsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_search_iddfs_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_iddfs_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_search_iddfs_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_search_iddfs_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_search_iddfs_std(data : Array[Double]) -> Double { graph_search_iddfs_sqrt(graph_search_iddfs_var(data)) }

pub fn graph_search_iddfs_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_search_iddfs_mean(a); let mb = graph_search_iddfs_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_search_iddfs_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_search_iddfs_std(a); let sb = graph_search_iddfs_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_search_iddfs_cov(a, b) / (sa * sb) }
}

pub fn graph_search_iddfs_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_search_iddfs_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_search_iddfs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_search_iddfs_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_search_iddfs_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  graph_search_iddfs_sqrt(graph_search_iddfs_mse(pred, labels))
}

pub fn graph_search_iddfs_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + graph_search_iddfs_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_search_iddfs_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_search_iddfs_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_search_iddfs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_search_iddfs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_search_iddfs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_search_iddfs_precision(pred, labels, pos); let r = graph_search_iddfs_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_search_iddfs_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_search_iddfs_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_search_iddfs_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_search_iddfs_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_search_iddfs_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_search_iddfs_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_search_iddfs_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_search_iddfs_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_search_iddfs_fibonacci(n : Int) -> Int {
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

pub fn graph_search_iddfs_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_search_iddfs_min(data); let mx = graph_search_iddfs_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_search_iddfs_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_search_iddfs_mean(data); let sd = graph_search_iddfs_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_search_iddfs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_search_iddfs_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_search_iddfs_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_search_iddfs_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_search_iddfs_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_search_iddfs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn graph_search_iddfs_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn graph_search_iddfs_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn graph_search_iddfs_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_search_iddfs_int(x) } else { -graph_search_iddfs_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_search_iddfs_int(f * 1000000.0) } else { graph_search_iddfs_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_search_iddfs_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_search_iddfs_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GraphsearchiddfsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_frame_make(size : Int) -> GraphsearchiddfsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_frame_len(s : GraphsearchiddfsFrame) -> Int { s.size }

pub fn graph_search_iddfs_frame_get(s : GraphsearchiddfsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_frame_set(s : GraphsearchiddfsFrame, i : Int, v : Double) -> GraphsearchiddfsFrame {
  let result = graph_search_iddfs_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_frame_sum(s : GraphsearchiddfsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_frame_mean(s : GraphsearchiddfsFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_frame_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_frame_scale(s : GraphsearchiddfsFrame, f : Double) -> GraphsearchiddfsFrame {
  let result = graph_search_iddfs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_frame_add(a : GraphsearchiddfsFrame, b : GraphsearchiddfsFrame) -> GraphsearchiddfsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_frame_copy(s : GraphsearchiddfsFrame) -> GraphsearchiddfsFrame {
  let result = graph_search_iddfs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_frame_fill(s : GraphsearchiddfsFrame, v : Double) -> GraphsearchiddfsFrame {
  let result = graph_search_iddfs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_frame_min(s : GraphsearchiddfsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_frame_max(s : GraphsearchiddfsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_frame_to_string(s : GraphsearchiddfsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_table_make(size : Int) -> GraphsearchiddfsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_table_len(s : GraphsearchiddfsTable) -> Int { s.size }

pub fn graph_search_iddfs_table_get(s : GraphsearchiddfsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_table_set(s : GraphsearchiddfsTable, i : Int, v : Double) -> GraphsearchiddfsTable {
  let result = graph_search_iddfs_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_table_sum(s : GraphsearchiddfsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_table_mean(s : GraphsearchiddfsTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_table_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_table_scale(s : GraphsearchiddfsTable, f : Double) -> GraphsearchiddfsTable {
  let result = graph_search_iddfs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_table_add(a : GraphsearchiddfsTable, b : GraphsearchiddfsTable) -> GraphsearchiddfsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_table_copy(s : GraphsearchiddfsTable) -> GraphsearchiddfsTable {
  let result = graph_search_iddfs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_table_fill(s : GraphsearchiddfsTable, v : Double) -> GraphsearchiddfsTable {
  let result = graph_search_iddfs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_table_min(s : GraphsearchiddfsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_table_max(s : GraphsearchiddfsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_table_to_string(s : GraphsearchiddfsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_graphn_make(size : Int) -> GraphsearchiddfsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_graphn_len(s : GraphsearchiddfsGraphN) -> Int { s.size }

pub fn graph_search_iddfs_graphn_get(s : GraphsearchiddfsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_graphn_set(s : GraphsearchiddfsGraphN, i : Int, v : Double) -> GraphsearchiddfsGraphN {
  let result = graph_search_iddfs_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_graphn_sum(s : GraphsearchiddfsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_graphn_mean(s : GraphsearchiddfsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_graphn_scale(s : GraphsearchiddfsGraphN, f : Double) -> GraphsearchiddfsGraphN {
  let result = graph_search_iddfs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_graphn_add(a : GraphsearchiddfsGraphN, b : GraphsearchiddfsGraphN) -> GraphsearchiddfsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_graphn_copy(s : GraphsearchiddfsGraphN) -> GraphsearchiddfsGraphN {
  let result = graph_search_iddfs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_graphn_fill(s : GraphsearchiddfsGraphN, v : Double) -> GraphsearchiddfsGraphN {
  let result = graph_search_iddfs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_graphn_min(s : GraphsearchiddfsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_graphn_max(s : GraphsearchiddfsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_graphn_to_string(s : GraphsearchiddfsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_node_make(size : Int) -> GraphsearchiddfsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_node_len(s : GraphsearchiddfsNode) -> Int { s.size }

pub fn graph_search_iddfs_node_get(s : GraphsearchiddfsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_node_set(s : GraphsearchiddfsNode, i : Int, v : Double) -> GraphsearchiddfsNode {
  let result = graph_search_iddfs_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_node_sum(s : GraphsearchiddfsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_node_mean(s : GraphsearchiddfsNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_node_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_node_scale(s : GraphsearchiddfsNode, f : Double) -> GraphsearchiddfsNode {
  let result = graph_search_iddfs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_node_add(a : GraphsearchiddfsNode, b : GraphsearchiddfsNode) -> GraphsearchiddfsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_node_copy(s : GraphsearchiddfsNode) -> GraphsearchiddfsNode {
  let result = graph_search_iddfs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_node_fill(s : GraphsearchiddfsNode, v : Double) -> GraphsearchiddfsNode {
  let result = graph_search_iddfs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_node_min(s : GraphsearchiddfsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_node_max(s : GraphsearchiddfsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_node_to_string(s : GraphsearchiddfsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_edge_make(size : Int) -> GraphsearchiddfsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_edge_len(s : GraphsearchiddfsEdge) -> Int { s.size }

pub fn graph_search_iddfs_edge_get(s : GraphsearchiddfsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_edge_set(s : GraphsearchiddfsEdge, i : Int, v : Double) -> GraphsearchiddfsEdge {
  let result = graph_search_iddfs_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_edge_sum(s : GraphsearchiddfsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_edge_mean(s : GraphsearchiddfsEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_edge_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_edge_scale(s : GraphsearchiddfsEdge, f : Double) -> GraphsearchiddfsEdge {
  let result = graph_search_iddfs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_edge_add(a : GraphsearchiddfsEdge, b : GraphsearchiddfsEdge) -> GraphsearchiddfsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_edge_copy(s : GraphsearchiddfsEdge) -> GraphsearchiddfsEdge {
  let result = graph_search_iddfs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_edge_fill(s : GraphsearchiddfsEdge, v : Double) -> GraphsearchiddfsEdge {
  let result = graph_search_iddfs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_edge_min(s : GraphsearchiddfsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_edge_max(s : GraphsearchiddfsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_edge_to_string(s : GraphsearchiddfsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_path_make(size : Int) -> GraphsearchiddfsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_path_len(s : GraphsearchiddfsPath) -> Int { s.size }

pub fn graph_search_iddfs_path_get(s : GraphsearchiddfsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_path_set(s : GraphsearchiddfsPath, i : Int, v : Double) -> GraphsearchiddfsPath {
  let result = graph_search_iddfs_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_path_sum(s : GraphsearchiddfsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_path_mean(s : GraphsearchiddfsPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_path_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_path_scale(s : GraphsearchiddfsPath, f : Double) -> GraphsearchiddfsPath {
  let result = graph_search_iddfs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_path_add(a : GraphsearchiddfsPath, b : GraphsearchiddfsPath) -> GraphsearchiddfsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_path_copy(s : GraphsearchiddfsPath) -> GraphsearchiddfsPath {
  let result = graph_search_iddfs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_path_fill(s : GraphsearchiddfsPath, v : Double) -> GraphsearchiddfsPath {
  let result = graph_search_iddfs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_path_min(s : GraphsearchiddfsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_path_max(s : GraphsearchiddfsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_path_to_string(s : GraphsearchiddfsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_cluster_make(size : Int) -> GraphsearchiddfsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_cluster_len(s : GraphsearchiddfsCluster) -> Int { s.size }

pub fn graph_search_iddfs_cluster_get(s : GraphsearchiddfsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_cluster_set(s : GraphsearchiddfsCluster, i : Int, v : Double) -> GraphsearchiddfsCluster {
  let result = graph_search_iddfs_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_cluster_sum(s : GraphsearchiddfsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_cluster_mean(s : GraphsearchiddfsCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_cluster_scale(s : GraphsearchiddfsCluster, f : Double) -> GraphsearchiddfsCluster {
  let result = graph_search_iddfs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_cluster_add(a : GraphsearchiddfsCluster, b : GraphsearchiddfsCluster) -> GraphsearchiddfsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_cluster_copy(s : GraphsearchiddfsCluster) -> GraphsearchiddfsCluster {
  let result = graph_search_iddfs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_cluster_fill(s : GraphsearchiddfsCluster, v : Double) -> GraphsearchiddfsCluster {
  let result = graph_search_iddfs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_cluster_min(s : GraphsearchiddfsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_cluster_max(s : GraphsearchiddfsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_cluster_to_string(s : GraphsearchiddfsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_model_make(size : Int) -> GraphsearchiddfsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_model_len(s : GraphsearchiddfsModel) -> Int { s.size }

pub fn graph_search_iddfs_model_get(s : GraphsearchiddfsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_model_set(s : GraphsearchiddfsModel, i : Int, v : Double) -> GraphsearchiddfsModel {
  let result = graph_search_iddfs_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_model_sum(s : GraphsearchiddfsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_model_mean(s : GraphsearchiddfsModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_model_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_model_scale(s : GraphsearchiddfsModel, f : Double) -> GraphsearchiddfsModel {
  let result = graph_search_iddfs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_model_add(a : GraphsearchiddfsModel, b : GraphsearchiddfsModel) -> GraphsearchiddfsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_model_copy(s : GraphsearchiddfsModel) -> GraphsearchiddfsModel {
  let result = graph_search_iddfs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_model_fill(s : GraphsearchiddfsModel, v : Double) -> GraphsearchiddfsModel {
  let result = graph_search_iddfs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_model_min(s : GraphsearchiddfsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_model_max(s : GraphsearchiddfsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_model_to_string(s : GraphsearchiddfsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_layer_make(size : Int) -> GraphsearchiddfsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_layer_len(s : GraphsearchiddfsLayer) -> Int { s.size }

pub fn graph_search_iddfs_layer_get(s : GraphsearchiddfsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_layer_set(s : GraphsearchiddfsLayer, i : Int, v : Double) -> GraphsearchiddfsLayer {
  let result = graph_search_iddfs_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_layer_sum(s : GraphsearchiddfsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_layer_mean(s : GraphsearchiddfsLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_layer_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_layer_scale(s : GraphsearchiddfsLayer, f : Double) -> GraphsearchiddfsLayer {
  let result = graph_search_iddfs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_layer_add(a : GraphsearchiddfsLayer, b : GraphsearchiddfsLayer) -> GraphsearchiddfsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_layer_copy(s : GraphsearchiddfsLayer) -> GraphsearchiddfsLayer {
  let result = graph_search_iddfs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_layer_fill(s : GraphsearchiddfsLayer, v : Double) -> GraphsearchiddfsLayer {
  let result = graph_search_iddfs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_layer_min(s : GraphsearchiddfsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_layer_max(s : GraphsearchiddfsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_layer_to_string(s : GraphsearchiddfsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_buffer_make(size : Int) -> GraphsearchiddfsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_buffer_len(s : GraphsearchiddfsBuffer) -> Int { s.size }

pub fn graph_search_iddfs_buffer_get(s : GraphsearchiddfsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_buffer_set(s : GraphsearchiddfsBuffer, i : Int, v : Double) -> GraphsearchiddfsBuffer {
  let result = graph_search_iddfs_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_buffer_sum(s : GraphsearchiddfsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_buffer_mean(s : GraphsearchiddfsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_buffer_scale(s : GraphsearchiddfsBuffer, f : Double) -> GraphsearchiddfsBuffer {
  let result = graph_search_iddfs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_buffer_add(a : GraphsearchiddfsBuffer, b : GraphsearchiddfsBuffer) -> GraphsearchiddfsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_buffer_copy(s : GraphsearchiddfsBuffer) -> GraphsearchiddfsBuffer {
  let result = graph_search_iddfs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_buffer_fill(s : GraphsearchiddfsBuffer, v : Double) -> GraphsearchiddfsBuffer {
  let result = graph_search_iddfs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_buffer_min(s : GraphsearchiddfsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_buffer_max(s : GraphsearchiddfsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_buffer_to_string(s : GraphsearchiddfsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_cursor_make(size : Int) -> GraphsearchiddfsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_cursor_len(s : GraphsearchiddfsCursor) -> Int { s.size }

pub fn graph_search_iddfs_cursor_get(s : GraphsearchiddfsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_cursor_set(s : GraphsearchiddfsCursor, i : Int, v : Double) -> GraphsearchiddfsCursor {
  let result = graph_search_iddfs_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_cursor_sum(s : GraphsearchiddfsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_cursor_mean(s : GraphsearchiddfsCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_cursor_scale(s : GraphsearchiddfsCursor, f : Double) -> GraphsearchiddfsCursor {
  let result = graph_search_iddfs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_cursor_add(a : GraphsearchiddfsCursor, b : GraphsearchiddfsCursor) -> GraphsearchiddfsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_cursor_copy(s : GraphsearchiddfsCursor) -> GraphsearchiddfsCursor {
  let result = graph_search_iddfs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_cursor_fill(s : GraphsearchiddfsCursor, v : Double) -> GraphsearchiddfsCursor {
  let result = graph_search_iddfs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_cursor_min(s : GraphsearchiddfsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_cursor_max(s : GraphsearchiddfsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_cursor_to_string(s : GraphsearchiddfsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_view_make(size : Int) -> GraphsearchiddfsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_view_len(s : GraphsearchiddfsView) -> Int { s.size }

pub fn graph_search_iddfs_view_get(s : GraphsearchiddfsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_view_set(s : GraphsearchiddfsView, i : Int, v : Double) -> GraphsearchiddfsView {
  let result = graph_search_iddfs_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_view_sum(s : GraphsearchiddfsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_view_mean(s : GraphsearchiddfsView) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_view_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_view_scale(s : GraphsearchiddfsView, f : Double) -> GraphsearchiddfsView {
  let result = graph_search_iddfs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_view_add(a : GraphsearchiddfsView, b : GraphsearchiddfsView) -> GraphsearchiddfsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_view_copy(s : GraphsearchiddfsView) -> GraphsearchiddfsView {
  let result = graph_search_iddfs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_view_fill(s : GraphsearchiddfsView, v : Double) -> GraphsearchiddfsView {
  let result = graph_search_iddfs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_view_min(s : GraphsearchiddfsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_view_max(s : GraphsearchiddfsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_view_to_string(s : GraphsearchiddfsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_range_make(size : Int) -> GraphsearchiddfsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_range_len(s : GraphsearchiddfsRange) -> Int { s.size }

pub fn graph_search_iddfs_range_get(s : GraphsearchiddfsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_range_set(s : GraphsearchiddfsRange, i : Int, v : Double) -> GraphsearchiddfsRange {
  let result = graph_search_iddfs_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_range_sum(s : GraphsearchiddfsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_range_mean(s : GraphsearchiddfsRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_range_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_range_scale(s : GraphsearchiddfsRange, f : Double) -> GraphsearchiddfsRange {
  let result = graph_search_iddfs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_range_add(a : GraphsearchiddfsRange, b : GraphsearchiddfsRange) -> GraphsearchiddfsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_range_copy(s : GraphsearchiddfsRange) -> GraphsearchiddfsRange {
  let result = graph_search_iddfs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_range_fill(s : GraphsearchiddfsRange, v : Double) -> GraphsearchiddfsRange {
  let result = graph_search_iddfs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_range_min(s : GraphsearchiddfsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_range_max(s : GraphsearchiddfsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_range_to_string(s : GraphsearchiddfsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchiddfsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_iddfs_slice_make(size : Int) -> GraphsearchiddfsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_iddfs_slice_len(s : GraphsearchiddfsSlice) -> Int { s.size }

pub fn graph_search_iddfs_slice_get(s : GraphsearchiddfsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_iddfs_slice_set(s : GraphsearchiddfsSlice, i : Int, v : Double) -> GraphsearchiddfsSlice {
  let result = graph_search_iddfs_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_slice_sum(s : GraphsearchiddfsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_iddfs_slice_mean(s : GraphsearchiddfsSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_iddfs_slice_sum(s) / s.size.to_double() }
}

pub fn graph_search_iddfs_slice_scale(s : GraphsearchiddfsSlice, f : Double) -> GraphsearchiddfsSlice {
  let result = graph_search_iddfs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_iddfs_slice_add(a : GraphsearchiddfsSlice, b : GraphsearchiddfsSlice) -> GraphsearchiddfsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_iddfs_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_iddfs_slice_copy(s : GraphsearchiddfsSlice) -> GraphsearchiddfsSlice {
  let result = graph_search_iddfs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_iddfs_slice_fill(s : GraphsearchiddfsSlice, v : Double) -> GraphsearchiddfsSlice {
  let result = graph_search_iddfs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_iddfs_slice_min(s : GraphsearchiddfsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_slice_max(s : GraphsearchiddfsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_iddfs_slice_to_string(s : GraphsearchiddfsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn graph_search_iddfs_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_iddfs_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

