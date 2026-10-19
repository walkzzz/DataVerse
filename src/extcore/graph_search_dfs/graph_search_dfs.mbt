///===
/// extcore/graph_search_dfs

pub(all) struct GraphsearchdfsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_dfs_make_point(x : Double, y : Double) -> GraphsearchdfsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_dfs_make_point3(x : Double, y : Double, z : Double) -> GraphsearchdfsPoint {
  { x, y, z, label: 0 }
}

pub fn graph_search_dfs_point_x(pt : GraphsearchdfsPoint) -> Double { pt.x }

pub fn graph_search_dfs_point_y(pt : GraphsearchdfsPoint) -> Double { pt.y }

pub fn graph_search_dfs_point_z(pt : GraphsearchdfsPoint) -> Double { pt.z }

pub fn graph_search_dfs_point_label(pt : GraphsearchdfsPoint) -> Int { pt.label }

pub fn graph_search_dfs_point_dist(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  graph_search_dfs_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_search_dfs_point_add(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_search_dfs_point_sub(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_search_dfs_point_scale(pt : GraphsearchdfsPoint, s : Double) -> GraphsearchdfsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_search_dfs_point_dot(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_search_dfs_point_cross(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_search_dfs_point_norm(pt : GraphsearchdfsPoint) -> Double {
  graph_search_dfs_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_search_dfs_point_normalize(pt : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  let n = graph_search_dfs_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_search_dfs_point_scale(pt, 1.0 / n) }
}

pub fn graph_search_dfs_point_negate(pt : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_search_dfs_point_mid(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint) -> GraphsearchdfsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_search_dfs_point_lerp(a : GraphsearchdfsPoint, b : GraphsearchdfsPoint, t : Double) -> GraphsearchdfsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_search_dfs_point_to_string(pt : GraphsearchdfsPoint) -> String {
  "(" + graph_search_dfs_dbl(pt.x) + ", " + graph_search_dfs_dbl(pt.y) + ", " + graph_search_dfs_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphsearchdfsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_dfs_make_series(vals : Array[Double], name : String) -> GraphsearchdfsSeries {
  { vals, name, meta: 0 }
}

pub fn graph_search_dfs_series_len(s : GraphsearchdfsSeries) -> Int { s.vals.length() }

pub fn graph_search_dfs_series_sum(s : GraphsearchdfsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_search_dfs_series_mean(s : GraphsearchdfsSeries) -> Double {
  let n = graph_search_dfs_series_len(s)
  if n == 0 { 0.0 } else { graph_search_dfs_series_sum(s) / n.to_double() }
}

pub fn graph_search_dfs_series_min(s : GraphsearchdfsSeries) -> Double {
  let n = graph_search_dfs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_dfs_series_max(s : GraphsearchdfsSeries) -> Double {
  let n = graph_search_dfs_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_dfs_series_range(s : GraphsearchdfsSeries) -> Double {
  graph_search_dfs_series_max(s) - graph_search_dfs_series_min(s)
}

pub fn graph_search_dfs_series_var(s : GraphsearchdfsSeries) -> Double {
  let n = graph_search_dfs_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_search_dfs_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_search_dfs_series_std(s : GraphsearchdfsSeries) -> Double { graph_search_dfs_sqrt(graph_search_dfs_series_var(s)) }

pub fn graph_search_dfs_series_median(s : GraphsearchdfsSeries) -> Double {
  let n = graph_search_dfs_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_search_dfs_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_search_dfs_series_scale(s : GraphsearchdfsSeries, f : Double) -> GraphsearchdfsSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = graph_search_dfs_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_search_dfs_series_add(a : GraphsearchdfsSeries, b : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_search_dfs_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_search_dfs_series_sub(a : GraphsearchdfsSeries, b : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = graph_search_dfs_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_search_dfs_series_normalize(s : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  let mn = graph_search_dfs_series_min(s)
  let mx = graph_search_dfs_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = graph_search_dfs_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_search_dfs_series_cumsum(s : GraphsearchdfsSeries) -> GraphsearchdfsSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = graph_search_dfs_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_search_dfs_series_to_string(s : GraphsearchdfsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_search_dfs_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchdfsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_dfs_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchdfsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_dfs_matrix_identity(n : Int) -> GraphsearchdfsMatrix {
  let m = graph_search_dfs_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_search_dfs_matrix_get(m : GraphsearchdfsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_search_dfs_matrix_transpose(m : GraphsearchdfsMatrix) -> GraphsearchdfsMatrix {
  let result = graph_search_dfs_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_search_dfs_matrix_add(a : GraphsearchdfsMatrix, b : GraphsearchdfsMatrix) -> GraphsearchdfsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_search_dfs_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_search_dfs_matrix_scale(m : GraphsearchdfsMatrix, s : Double) -> GraphsearchdfsMatrix {
  let result = graph_search_dfs_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_search_dfs_matrix_multiply(a : GraphsearchdfsMatrix, b : GraphsearchdfsMatrix) -> GraphsearchdfsMatrix {
  if a.cols != b.rows { return graph_search_dfs_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_search_dfs_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_search_dfs_matrix_trace(m : GraphsearchdfsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_search_dfs_matrix_det(m : GraphsearchdfsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_search_dfs_matrix_norm(m : GraphsearchdfsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  graph_search_dfs_sqrt(sum)
}

pub fn graph_search_dfs_matrix_to_string(m : GraphsearchdfsMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + graph_search_dfs_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct GraphsearchdfsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_dfs_make_vector(comps : Array[Double]) -> GraphsearchdfsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_dfs_vector_zero(dim : Int) -> GraphsearchdfsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_search_dfs_vector_add(a : GraphsearchdfsVector, b : GraphsearchdfsVector) -> GraphsearchdfsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_search_dfs_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_dfs_vector_sub(a : GraphsearchdfsVector, b : GraphsearchdfsVector) -> GraphsearchdfsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = graph_search_dfs_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_dfs_vector_scale(v : GraphsearchdfsVector, s : Double) -> GraphsearchdfsVector {
  let mut result = []
  for i in 0..<v.dim { result = graph_search_dfs_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_search_dfs_vector_dot(a : GraphsearchdfsVector, b : GraphsearchdfsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_search_dfs_vector_norm(v : GraphsearchdfsVector) -> Double { graph_search_dfs_sqrt(graph_search_dfs_vector_dot(v, v)) }

pub fn graph_search_dfs_vector_normalize(v : GraphsearchdfsVector) -> GraphsearchdfsVector {
  let n = graph_search_dfs_vector_norm(v)
  if n < 0.0000001 { v } else { graph_search_dfs_vector_scale(v, 1.0 / n) }
}

pub fn graph_search_dfs_vector_dist(a : GraphsearchdfsVector, b : GraphsearchdfsVector) -> Double {
  graph_search_dfs_vector_norm(graph_search_dfs_vector_sub(a, b))
}

pub fn graph_search_dfs_vector_to_string(v : GraphsearchdfsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + graph_search_dfs_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_dfs_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_search_dfs_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_search_dfs_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_search_dfs_std(data : Array[Double]) -> Double { graph_search_dfs_sqrt(graph_search_dfs_var(data)) }

pub fn graph_search_dfs_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_search_dfs_mean(a); let mb = graph_search_dfs_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_search_dfs_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_search_dfs_std(a); let sb = graph_search_dfs_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_search_dfs_cov(a, b) / (sa * sb) }
}

pub fn graph_search_dfs_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_search_dfs_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_search_dfs_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_search_dfs_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_search_dfs_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  graph_search_dfs_sqrt(graph_search_dfs_mse(pred, labels))
}

pub fn graph_search_dfs_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + graph_search_dfs_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_search_dfs_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_search_dfs_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_search_dfs_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_search_dfs_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_search_dfs_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_search_dfs_precision(pred, labels, pos); let r = graph_search_dfs_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_search_dfs_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_search_dfs_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_search_dfs_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_search_dfs_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_search_dfs_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_search_dfs_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_search_dfs_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_search_dfs_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_search_dfs_fibonacci(n : Int) -> Int {
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

pub fn graph_search_dfs_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_search_dfs_min(data); let mx = graph_search_dfs_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_search_dfs_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_search_dfs_mean(data); let sd = graph_search_dfs_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_search_dfs_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_search_dfs_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_search_dfs_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_search_dfs_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_search_dfs_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_search_dfs_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn graph_search_dfs_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn graph_search_dfs_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn graph_search_dfs_dbl(x : Double) -> String {
  let i = if x >= 0.0 { graph_search_dfs_int(x) } else { -graph_search_dfs_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { graph_search_dfs_int(f * 1000000.0) } else { graph_search_dfs_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn graph_search_dfs_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn graph_search_dfs_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct GraphsearchdfsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_frame_make(size : Int) -> GraphsearchdfsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_frame_len(s : GraphsearchdfsFrame) -> Int { s.size }

pub fn graph_search_dfs_frame_get(s : GraphsearchdfsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_frame_set(s : GraphsearchdfsFrame, i : Int, v : Double) -> GraphsearchdfsFrame {
  let result = graph_search_dfs_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_frame_sum(s : GraphsearchdfsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_frame_mean(s : GraphsearchdfsFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_frame_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_frame_scale(s : GraphsearchdfsFrame, f : Double) -> GraphsearchdfsFrame {
  let result = graph_search_dfs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_frame_add(a : GraphsearchdfsFrame, b : GraphsearchdfsFrame) -> GraphsearchdfsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_frame_copy(s : GraphsearchdfsFrame) -> GraphsearchdfsFrame {
  let result = graph_search_dfs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_frame_fill(s : GraphsearchdfsFrame, v : Double) -> GraphsearchdfsFrame {
  let result = graph_search_dfs_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_frame_min(s : GraphsearchdfsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_frame_max(s : GraphsearchdfsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_frame_to_string(s : GraphsearchdfsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_table_make(size : Int) -> GraphsearchdfsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_table_len(s : GraphsearchdfsTable) -> Int { s.size }

pub fn graph_search_dfs_table_get(s : GraphsearchdfsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_table_set(s : GraphsearchdfsTable, i : Int, v : Double) -> GraphsearchdfsTable {
  let result = graph_search_dfs_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_table_sum(s : GraphsearchdfsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_table_mean(s : GraphsearchdfsTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_table_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_table_scale(s : GraphsearchdfsTable, f : Double) -> GraphsearchdfsTable {
  let result = graph_search_dfs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_table_add(a : GraphsearchdfsTable, b : GraphsearchdfsTable) -> GraphsearchdfsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_table_copy(s : GraphsearchdfsTable) -> GraphsearchdfsTable {
  let result = graph_search_dfs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_table_fill(s : GraphsearchdfsTable, v : Double) -> GraphsearchdfsTable {
  let result = graph_search_dfs_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_table_min(s : GraphsearchdfsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_table_max(s : GraphsearchdfsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_table_to_string(s : GraphsearchdfsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_graphn_make(size : Int) -> GraphsearchdfsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_graphn_len(s : GraphsearchdfsGraphN) -> Int { s.size }

pub fn graph_search_dfs_graphn_get(s : GraphsearchdfsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_graphn_set(s : GraphsearchdfsGraphN, i : Int, v : Double) -> GraphsearchdfsGraphN {
  let result = graph_search_dfs_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_graphn_sum(s : GraphsearchdfsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_graphn_mean(s : GraphsearchdfsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_graphn_scale(s : GraphsearchdfsGraphN, f : Double) -> GraphsearchdfsGraphN {
  let result = graph_search_dfs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_graphn_add(a : GraphsearchdfsGraphN, b : GraphsearchdfsGraphN) -> GraphsearchdfsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_graphn_copy(s : GraphsearchdfsGraphN) -> GraphsearchdfsGraphN {
  let result = graph_search_dfs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_graphn_fill(s : GraphsearchdfsGraphN, v : Double) -> GraphsearchdfsGraphN {
  let result = graph_search_dfs_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_graphn_min(s : GraphsearchdfsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_graphn_max(s : GraphsearchdfsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_graphn_to_string(s : GraphsearchdfsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_node_make(size : Int) -> GraphsearchdfsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_node_len(s : GraphsearchdfsNode) -> Int { s.size }

pub fn graph_search_dfs_node_get(s : GraphsearchdfsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_node_set(s : GraphsearchdfsNode, i : Int, v : Double) -> GraphsearchdfsNode {
  let result = graph_search_dfs_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_node_sum(s : GraphsearchdfsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_node_mean(s : GraphsearchdfsNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_node_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_node_scale(s : GraphsearchdfsNode, f : Double) -> GraphsearchdfsNode {
  let result = graph_search_dfs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_node_add(a : GraphsearchdfsNode, b : GraphsearchdfsNode) -> GraphsearchdfsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_node_copy(s : GraphsearchdfsNode) -> GraphsearchdfsNode {
  let result = graph_search_dfs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_node_fill(s : GraphsearchdfsNode, v : Double) -> GraphsearchdfsNode {
  let result = graph_search_dfs_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_node_min(s : GraphsearchdfsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_node_max(s : GraphsearchdfsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_node_to_string(s : GraphsearchdfsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_edge_make(size : Int) -> GraphsearchdfsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_edge_len(s : GraphsearchdfsEdge) -> Int { s.size }

pub fn graph_search_dfs_edge_get(s : GraphsearchdfsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_edge_set(s : GraphsearchdfsEdge, i : Int, v : Double) -> GraphsearchdfsEdge {
  let result = graph_search_dfs_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_edge_sum(s : GraphsearchdfsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_edge_mean(s : GraphsearchdfsEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_edge_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_edge_scale(s : GraphsearchdfsEdge, f : Double) -> GraphsearchdfsEdge {
  let result = graph_search_dfs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_edge_add(a : GraphsearchdfsEdge, b : GraphsearchdfsEdge) -> GraphsearchdfsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_edge_copy(s : GraphsearchdfsEdge) -> GraphsearchdfsEdge {
  let result = graph_search_dfs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_edge_fill(s : GraphsearchdfsEdge, v : Double) -> GraphsearchdfsEdge {
  let result = graph_search_dfs_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_edge_min(s : GraphsearchdfsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_edge_max(s : GraphsearchdfsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_edge_to_string(s : GraphsearchdfsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_path_make(size : Int) -> GraphsearchdfsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_path_len(s : GraphsearchdfsPath) -> Int { s.size }

pub fn graph_search_dfs_path_get(s : GraphsearchdfsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_path_set(s : GraphsearchdfsPath, i : Int, v : Double) -> GraphsearchdfsPath {
  let result = graph_search_dfs_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_path_sum(s : GraphsearchdfsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_path_mean(s : GraphsearchdfsPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_path_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_path_scale(s : GraphsearchdfsPath, f : Double) -> GraphsearchdfsPath {
  let result = graph_search_dfs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_path_add(a : GraphsearchdfsPath, b : GraphsearchdfsPath) -> GraphsearchdfsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_path_copy(s : GraphsearchdfsPath) -> GraphsearchdfsPath {
  let result = graph_search_dfs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_path_fill(s : GraphsearchdfsPath, v : Double) -> GraphsearchdfsPath {
  let result = graph_search_dfs_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_path_min(s : GraphsearchdfsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_path_max(s : GraphsearchdfsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_path_to_string(s : GraphsearchdfsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_cluster_make(size : Int) -> GraphsearchdfsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_cluster_len(s : GraphsearchdfsCluster) -> Int { s.size }

pub fn graph_search_dfs_cluster_get(s : GraphsearchdfsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_cluster_set(s : GraphsearchdfsCluster, i : Int, v : Double) -> GraphsearchdfsCluster {
  let result = graph_search_dfs_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_cluster_sum(s : GraphsearchdfsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_cluster_mean(s : GraphsearchdfsCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_cluster_scale(s : GraphsearchdfsCluster, f : Double) -> GraphsearchdfsCluster {
  let result = graph_search_dfs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_cluster_add(a : GraphsearchdfsCluster, b : GraphsearchdfsCluster) -> GraphsearchdfsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_cluster_copy(s : GraphsearchdfsCluster) -> GraphsearchdfsCluster {
  let result = graph_search_dfs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_cluster_fill(s : GraphsearchdfsCluster, v : Double) -> GraphsearchdfsCluster {
  let result = graph_search_dfs_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_cluster_min(s : GraphsearchdfsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_cluster_max(s : GraphsearchdfsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_cluster_to_string(s : GraphsearchdfsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_model_make(size : Int) -> GraphsearchdfsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_model_len(s : GraphsearchdfsModel) -> Int { s.size }

pub fn graph_search_dfs_model_get(s : GraphsearchdfsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_model_set(s : GraphsearchdfsModel, i : Int, v : Double) -> GraphsearchdfsModel {
  let result = graph_search_dfs_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_model_sum(s : GraphsearchdfsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_model_mean(s : GraphsearchdfsModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_model_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_model_scale(s : GraphsearchdfsModel, f : Double) -> GraphsearchdfsModel {
  let result = graph_search_dfs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_model_add(a : GraphsearchdfsModel, b : GraphsearchdfsModel) -> GraphsearchdfsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_model_copy(s : GraphsearchdfsModel) -> GraphsearchdfsModel {
  let result = graph_search_dfs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_model_fill(s : GraphsearchdfsModel, v : Double) -> GraphsearchdfsModel {
  let result = graph_search_dfs_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_model_min(s : GraphsearchdfsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_model_max(s : GraphsearchdfsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_model_to_string(s : GraphsearchdfsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_layer_make(size : Int) -> GraphsearchdfsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_layer_len(s : GraphsearchdfsLayer) -> Int { s.size }

pub fn graph_search_dfs_layer_get(s : GraphsearchdfsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_layer_set(s : GraphsearchdfsLayer, i : Int, v : Double) -> GraphsearchdfsLayer {
  let result = graph_search_dfs_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_layer_sum(s : GraphsearchdfsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_layer_mean(s : GraphsearchdfsLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_layer_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_layer_scale(s : GraphsearchdfsLayer, f : Double) -> GraphsearchdfsLayer {
  let result = graph_search_dfs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_layer_add(a : GraphsearchdfsLayer, b : GraphsearchdfsLayer) -> GraphsearchdfsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_layer_copy(s : GraphsearchdfsLayer) -> GraphsearchdfsLayer {
  let result = graph_search_dfs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_layer_fill(s : GraphsearchdfsLayer, v : Double) -> GraphsearchdfsLayer {
  let result = graph_search_dfs_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_layer_min(s : GraphsearchdfsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_layer_max(s : GraphsearchdfsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_layer_to_string(s : GraphsearchdfsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_buffer_make(size : Int) -> GraphsearchdfsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_buffer_len(s : GraphsearchdfsBuffer) -> Int { s.size }

pub fn graph_search_dfs_buffer_get(s : GraphsearchdfsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_buffer_set(s : GraphsearchdfsBuffer, i : Int, v : Double) -> GraphsearchdfsBuffer {
  let result = graph_search_dfs_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_buffer_sum(s : GraphsearchdfsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_buffer_mean(s : GraphsearchdfsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_buffer_scale(s : GraphsearchdfsBuffer, f : Double) -> GraphsearchdfsBuffer {
  let result = graph_search_dfs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_buffer_add(a : GraphsearchdfsBuffer, b : GraphsearchdfsBuffer) -> GraphsearchdfsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_buffer_copy(s : GraphsearchdfsBuffer) -> GraphsearchdfsBuffer {
  let result = graph_search_dfs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_buffer_fill(s : GraphsearchdfsBuffer, v : Double) -> GraphsearchdfsBuffer {
  let result = graph_search_dfs_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_buffer_min(s : GraphsearchdfsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_buffer_max(s : GraphsearchdfsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_buffer_to_string(s : GraphsearchdfsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_cursor_make(size : Int) -> GraphsearchdfsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_cursor_len(s : GraphsearchdfsCursor) -> Int { s.size }

pub fn graph_search_dfs_cursor_get(s : GraphsearchdfsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_cursor_set(s : GraphsearchdfsCursor, i : Int, v : Double) -> GraphsearchdfsCursor {
  let result = graph_search_dfs_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_cursor_sum(s : GraphsearchdfsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_cursor_mean(s : GraphsearchdfsCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_cursor_scale(s : GraphsearchdfsCursor, f : Double) -> GraphsearchdfsCursor {
  let result = graph_search_dfs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_cursor_add(a : GraphsearchdfsCursor, b : GraphsearchdfsCursor) -> GraphsearchdfsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_cursor_copy(s : GraphsearchdfsCursor) -> GraphsearchdfsCursor {
  let result = graph_search_dfs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_cursor_fill(s : GraphsearchdfsCursor, v : Double) -> GraphsearchdfsCursor {
  let result = graph_search_dfs_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_cursor_min(s : GraphsearchdfsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_cursor_max(s : GraphsearchdfsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_cursor_to_string(s : GraphsearchdfsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_view_make(size : Int) -> GraphsearchdfsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_view_len(s : GraphsearchdfsView) -> Int { s.size }

pub fn graph_search_dfs_view_get(s : GraphsearchdfsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_view_set(s : GraphsearchdfsView, i : Int, v : Double) -> GraphsearchdfsView {
  let result = graph_search_dfs_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_view_sum(s : GraphsearchdfsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_view_mean(s : GraphsearchdfsView) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_view_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_view_scale(s : GraphsearchdfsView, f : Double) -> GraphsearchdfsView {
  let result = graph_search_dfs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_view_add(a : GraphsearchdfsView, b : GraphsearchdfsView) -> GraphsearchdfsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_view_copy(s : GraphsearchdfsView) -> GraphsearchdfsView {
  let result = graph_search_dfs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_view_fill(s : GraphsearchdfsView, v : Double) -> GraphsearchdfsView {
  let result = graph_search_dfs_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_view_min(s : GraphsearchdfsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_view_max(s : GraphsearchdfsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_view_to_string(s : GraphsearchdfsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_range_make(size : Int) -> GraphsearchdfsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_range_len(s : GraphsearchdfsRange) -> Int { s.size }

pub fn graph_search_dfs_range_get(s : GraphsearchdfsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_range_set(s : GraphsearchdfsRange, i : Int, v : Double) -> GraphsearchdfsRange {
  let result = graph_search_dfs_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_range_sum(s : GraphsearchdfsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_range_mean(s : GraphsearchdfsRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_range_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_range_scale(s : GraphsearchdfsRange, f : Double) -> GraphsearchdfsRange {
  let result = graph_search_dfs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_range_add(a : GraphsearchdfsRange, b : GraphsearchdfsRange) -> GraphsearchdfsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_range_copy(s : GraphsearchdfsRange) -> GraphsearchdfsRange {
  let result = graph_search_dfs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_range_fill(s : GraphsearchdfsRange, v : Double) -> GraphsearchdfsRange {
  let result = graph_search_dfs_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_range_min(s : GraphsearchdfsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_range_max(s : GraphsearchdfsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_range_to_string(s : GraphsearchdfsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchdfsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_dfs_slice_make(size : Int) -> GraphsearchdfsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_dfs_slice_len(s : GraphsearchdfsSlice) -> Int { s.size }

pub fn graph_search_dfs_slice_get(s : GraphsearchdfsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_dfs_slice_set(s : GraphsearchdfsSlice, i : Int, v : Double) -> GraphsearchdfsSlice {
  let result = graph_search_dfs_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_slice_sum(s : GraphsearchdfsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_dfs_slice_mean(s : GraphsearchdfsSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_dfs_slice_sum(s) / s.size.to_double() }
}

pub fn graph_search_dfs_slice_scale(s : GraphsearchdfsSlice, f : Double) -> GraphsearchdfsSlice {
  let result = graph_search_dfs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_dfs_slice_add(a : GraphsearchdfsSlice, b : GraphsearchdfsSlice) -> GraphsearchdfsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_dfs_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_dfs_slice_copy(s : GraphsearchdfsSlice) -> GraphsearchdfsSlice {
  let result = graph_search_dfs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_dfs_slice_fill(s : GraphsearchdfsSlice, v : Double) -> GraphsearchdfsSlice {
  let result = graph_search_dfs_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_dfs_slice_min(s : GraphsearchdfsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_slice_max(s : GraphsearchdfsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_dfs_slice_to_string(s : GraphsearchdfsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn graph_search_dfs_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn graph_search_dfs_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

