///===
/// extcore/graph_search_astar

pub(all) struct GraphsearchastarPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_astar_make_point(x : Double, y : Double) -> GraphsearchastarPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_astar_make_point3(x : Double, y : Double, z : Double) -> GraphsearchastarPoint {
  { x, y, z, label: 0 }
}

pub fn graph_search_astar_point_x(pt : GraphsearchastarPoint) -> Double { pt.x }

pub fn graph_search_astar_point_y(pt : GraphsearchastarPoint) -> Double { pt.y }

pub fn graph_search_astar_point_z(pt : GraphsearchastarPoint) -> Double { pt.z }

pub fn graph_search_astar_point_label(pt : GraphsearchastarPoint) -> Int { pt.label }

pub fn graph_search_astar_point_dist(a : GraphsearchastarPoint, b : GraphsearchastarPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_search_astar_point_add(a : GraphsearchastarPoint, b : GraphsearchastarPoint) -> GraphsearchastarPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_search_astar_point_sub(a : GraphsearchastarPoint, b : GraphsearchastarPoint) -> GraphsearchastarPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_search_astar_point_scale(pt : GraphsearchastarPoint, s : Double) -> GraphsearchastarPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_search_astar_point_dot(a : GraphsearchastarPoint, b : GraphsearchastarPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_search_astar_point_cross(a : GraphsearchastarPoint, b : GraphsearchastarPoint) -> GraphsearchastarPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_search_astar_point_norm(pt : GraphsearchastarPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_search_astar_point_normalize(pt : GraphsearchastarPoint) -> GraphsearchastarPoint {
  let n = graph_search_astar_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_search_astar_point_scale(pt, 1.0 / n) }
}

pub fn graph_search_astar_point_negate(pt : GraphsearchastarPoint) -> GraphsearchastarPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_search_astar_point_mid(a : GraphsearchastarPoint, b : GraphsearchastarPoint) -> GraphsearchastarPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_search_astar_point_lerp(a : GraphsearchastarPoint, b : GraphsearchastarPoint, t : Double) -> GraphsearchastarPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_search_astar_point_to_string(pt : GraphsearchastarPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphsearchastarSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_astar_make_series(vals : Array[Double], name : String) -> GraphsearchastarSeries {
  { vals, name, meta: 0 }
}

pub fn graph_search_astar_series_len(s : GraphsearchastarSeries) -> Int { s.vals.length() }

pub fn graph_search_astar_series_sum(s : GraphsearchastarSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_search_astar_series_mean(s : GraphsearchastarSeries) -> Double {
  let n = graph_search_astar_series_len(s)
  if n == 0 { 0.0 } else { graph_search_astar_series_sum(s) / n.to_double() }
}

pub fn graph_search_astar_series_min(s : GraphsearchastarSeries) -> Double {
  let n = graph_search_astar_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_astar_series_max(s : GraphsearchastarSeries) -> Double {
  let n = graph_search_astar_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_astar_series_range(s : GraphsearchastarSeries) -> Double {
  graph_search_astar_series_max(s) - graph_search_astar_series_min(s)
}

pub fn graph_search_astar_series_var(s : GraphsearchastarSeries) -> Double {
  let n = graph_search_astar_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_search_astar_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_search_astar_series_std(s : GraphsearchastarSeries) -> Double { @_common.sqrt(graph_search_astar_series_var(s)) }

pub fn graph_search_astar_series_median(s : GraphsearchastarSeries) -> Double {
  let n = graph_search_astar_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_search_astar_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_search_astar_series_scale(s : GraphsearchastarSeries, f : Double) -> GraphsearchastarSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_search_astar_series_add(a : GraphsearchastarSeries, b : GraphsearchastarSeries) -> GraphsearchastarSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_search_astar_series_sub(a : GraphsearchastarSeries, b : GraphsearchastarSeries) -> GraphsearchastarSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_search_astar_series_normalize(s : GraphsearchastarSeries) -> GraphsearchastarSeries {
  let mn = graph_search_astar_series_min(s)
  let mx = graph_search_astar_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_search_astar_series_cumsum(s : GraphsearchastarSeries) -> GraphsearchastarSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_search_astar_series_to_string(s : GraphsearchastarSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchastarMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_astar_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchastarMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_astar_matrix_identity(n : Int) -> GraphsearchastarMatrix {
  let m = graph_search_astar_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_search_astar_matrix_get(m : GraphsearchastarMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_search_astar_matrix_transpose(m : GraphsearchastarMatrix) -> GraphsearchastarMatrix {
  let result = graph_search_astar_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_search_astar_matrix_add(a : GraphsearchastarMatrix, b : GraphsearchastarMatrix) -> GraphsearchastarMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_search_astar_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_search_astar_matrix_scale(m : GraphsearchastarMatrix, s : Double) -> GraphsearchastarMatrix {
  let result = graph_search_astar_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_search_astar_matrix_multiply(a : GraphsearchastarMatrix, b : GraphsearchastarMatrix) -> GraphsearchastarMatrix {
  if a.cols != b.rows { return graph_search_astar_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_search_astar_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_search_astar_matrix_trace(m : GraphsearchastarMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_search_astar_matrix_det(m : GraphsearchastarMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_search_astar_matrix_norm(m : GraphsearchastarMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_search_astar_matrix_to_string(m : GraphsearchastarMatrix) -> String {
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

pub(all) struct GraphsearchastarVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_astar_make_vector(comps : Array[Double]) -> GraphsearchastarVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_astar_vector_zero(dim : Int) -> GraphsearchastarVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_search_astar_vector_add(a : GraphsearchastarVector, b : GraphsearchastarVector) -> GraphsearchastarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_astar_vector_sub(a : GraphsearchastarVector, b : GraphsearchastarVector) -> GraphsearchastarVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_astar_vector_scale(v : GraphsearchastarVector, s : Double) -> GraphsearchastarVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_search_astar_vector_dot(a : GraphsearchastarVector, b : GraphsearchastarVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_search_astar_vector_norm(v : GraphsearchastarVector) -> Double { @_common.sqrt(graph_search_astar_vector_dot(v, v)) }

pub fn graph_search_astar_vector_normalize(v : GraphsearchastarVector) -> GraphsearchastarVector {
  let n = graph_search_astar_vector_norm(v)
  if n < 0.0000001 { v } else { graph_search_astar_vector_scale(v, 1.0 / n) }
}

pub fn graph_search_astar_vector_dist(a : GraphsearchastarVector, b : GraphsearchastarVector) -> Double {
  graph_search_astar_vector_norm(graph_search_astar_vector_sub(a, b))
}

pub fn graph_search_astar_vector_to_string(v : GraphsearchastarVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_astar_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_search_astar_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_search_astar_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_search_astar_std(data : Array[Double]) -> Double { @_common.sqrt(graph_search_astar_var(data)) }

pub fn graph_search_astar_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_search_astar_mean(a); let mb = graph_search_astar_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_search_astar_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_search_astar_std(a); let sb = graph_search_astar_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_search_astar_cov(a, b) / (sa * sb) }
}

pub fn graph_search_astar_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_search_astar_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_search_astar_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_search_astar_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_search_astar_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(graph_search_astar_mse(pred, labels))
}

pub fn graph_search_astar_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_search_astar_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_search_astar_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_search_astar_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_search_astar_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_search_astar_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_search_astar_precision(pred, labels, pos); let r = graph_search_astar_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_search_astar_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_search_astar_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_search_astar_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_search_astar_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_search_astar_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_search_astar_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_search_astar_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_search_astar_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_search_astar_fibonacci(n : Int) -> Int {
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

pub fn graph_search_astar_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_search_astar_min(data); let mx = graph_search_astar_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_search_astar_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_search_astar_mean(data); let sd = graph_search_astar_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_search_astar_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_search_astar_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_search_astar_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_search_astar_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_search_astar_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_search_astar_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GraphsearchastarFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_frame_make(size : Int) -> GraphsearchastarFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_frame_len(s : GraphsearchastarFrame) -> Int { s.size }

pub fn graph_search_astar_frame_get(s : GraphsearchastarFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_frame_set(s : GraphsearchastarFrame, i : Int, v : Double) -> GraphsearchastarFrame {
  let result = graph_search_astar_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_frame_sum(s : GraphsearchastarFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_frame_mean(s : GraphsearchastarFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_frame_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_frame_scale(s : GraphsearchastarFrame, f : Double) -> GraphsearchastarFrame {
  let result = graph_search_astar_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_frame_add(a : GraphsearchastarFrame, b : GraphsearchastarFrame) -> GraphsearchastarFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_frame_copy(s : GraphsearchastarFrame) -> GraphsearchastarFrame {
  let result = graph_search_astar_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_frame_fill(s : GraphsearchastarFrame, v : Double) -> GraphsearchastarFrame {
  let result = graph_search_astar_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_frame_min(s : GraphsearchastarFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_frame_max(s : GraphsearchastarFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_frame_to_string(s : GraphsearchastarFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_table_make(size : Int) -> GraphsearchastarTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_table_len(s : GraphsearchastarTable) -> Int { s.size }

pub fn graph_search_astar_table_get(s : GraphsearchastarTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_table_set(s : GraphsearchastarTable, i : Int, v : Double) -> GraphsearchastarTable {
  let result = graph_search_astar_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_table_sum(s : GraphsearchastarTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_table_mean(s : GraphsearchastarTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_table_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_table_scale(s : GraphsearchastarTable, f : Double) -> GraphsearchastarTable {
  let result = graph_search_astar_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_table_add(a : GraphsearchastarTable, b : GraphsearchastarTable) -> GraphsearchastarTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_table_copy(s : GraphsearchastarTable) -> GraphsearchastarTable {
  let result = graph_search_astar_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_table_fill(s : GraphsearchastarTable, v : Double) -> GraphsearchastarTable {
  let result = graph_search_astar_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_table_min(s : GraphsearchastarTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_table_max(s : GraphsearchastarTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_table_to_string(s : GraphsearchastarTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_graphn_make(size : Int) -> GraphsearchastarGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_graphn_len(s : GraphsearchastarGraphN) -> Int { s.size }

pub fn graph_search_astar_graphn_get(s : GraphsearchastarGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_graphn_set(s : GraphsearchastarGraphN, i : Int, v : Double) -> GraphsearchastarGraphN {
  let result = graph_search_astar_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_graphn_sum(s : GraphsearchastarGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_graphn_mean(s : GraphsearchastarGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_graphn_scale(s : GraphsearchastarGraphN, f : Double) -> GraphsearchastarGraphN {
  let result = graph_search_astar_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_graphn_add(a : GraphsearchastarGraphN, b : GraphsearchastarGraphN) -> GraphsearchastarGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_graphn_copy(s : GraphsearchastarGraphN) -> GraphsearchastarGraphN {
  let result = graph_search_astar_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_graphn_fill(s : GraphsearchastarGraphN, v : Double) -> GraphsearchastarGraphN {
  let result = graph_search_astar_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_graphn_min(s : GraphsearchastarGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_graphn_max(s : GraphsearchastarGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_graphn_to_string(s : GraphsearchastarGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_node_make(size : Int) -> GraphsearchastarNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_node_len(s : GraphsearchastarNode) -> Int { s.size }

pub fn graph_search_astar_node_get(s : GraphsearchastarNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_node_set(s : GraphsearchastarNode, i : Int, v : Double) -> GraphsearchastarNode {
  let result = graph_search_astar_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_node_sum(s : GraphsearchastarNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_node_mean(s : GraphsearchastarNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_node_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_node_scale(s : GraphsearchastarNode, f : Double) -> GraphsearchastarNode {
  let result = graph_search_astar_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_node_add(a : GraphsearchastarNode, b : GraphsearchastarNode) -> GraphsearchastarNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_node_copy(s : GraphsearchastarNode) -> GraphsearchastarNode {
  let result = graph_search_astar_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_node_fill(s : GraphsearchastarNode, v : Double) -> GraphsearchastarNode {
  let result = graph_search_astar_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_node_min(s : GraphsearchastarNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_node_max(s : GraphsearchastarNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_node_to_string(s : GraphsearchastarNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_edge_make(size : Int) -> GraphsearchastarEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_edge_len(s : GraphsearchastarEdge) -> Int { s.size }

pub fn graph_search_astar_edge_get(s : GraphsearchastarEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_edge_set(s : GraphsearchastarEdge, i : Int, v : Double) -> GraphsearchastarEdge {
  let result = graph_search_astar_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_edge_sum(s : GraphsearchastarEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_edge_mean(s : GraphsearchastarEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_edge_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_edge_scale(s : GraphsearchastarEdge, f : Double) -> GraphsearchastarEdge {
  let result = graph_search_astar_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_edge_add(a : GraphsearchastarEdge, b : GraphsearchastarEdge) -> GraphsearchastarEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_edge_copy(s : GraphsearchastarEdge) -> GraphsearchastarEdge {
  let result = graph_search_astar_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_edge_fill(s : GraphsearchastarEdge, v : Double) -> GraphsearchastarEdge {
  let result = graph_search_astar_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_edge_min(s : GraphsearchastarEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_edge_max(s : GraphsearchastarEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_edge_to_string(s : GraphsearchastarEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_path_make(size : Int) -> GraphsearchastarPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_path_len(s : GraphsearchastarPath) -> Int { s.size }

pub fn graph_search_astar_path_get(s : GraphsearchastarPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_path_set(s : GraphsearchastarPath, i : Int, v : Double) -> GraphsearchastarPath {
  let result = graph_search_astar_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_path_sum(s : GraphsearchastarPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_path_mean(s : GraphsearchastarPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_path_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_path_scale(s : GraphsearchastarPath, f : Double) -> GraphsearchastarPath {
  let result = graph_search_astar_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_path_add(a : GraphsearchastarPath, b : GraphsearchastarPath) -> GraphsearchastarPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_path_copy(s : GraphsearchastarPath) -> GraphsearchastarPath {
  let result = graph_search_astar_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_path_fill(s : GraphsearchastarPath, v : Double) -> GraphsearchastarPath {
  let result = graph_search_astar_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_path_min(s : GraphsearchastarPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_path_max(s : GraphsearchastarPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_path_to_string(s : GraphsearchastarPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_cluster_make(size : Int) -> GraphsearchastarCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_cluster_len(s : GraphsearchastarCluster) -> Int { s.size }

pub fn graph_search_astar_cluster_get(s : GraphsearchastarCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_cluster_set(s : GraphsearchastarCluster, i : Int, v : Double) -> GraphsearchastarCluster {
  let result = graph_search_astar_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_cluster_sum(s : GraphsearchastarCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_cluster_mean(s : GraphsearchastarCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_cluster_scale(s : GraphsearchastarCluster, f : Double) -> GraphsearchastarCluster {
  let result = graph_search_astar_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_cluster_add(a : GraphsearchastarCluster, b : GraphsearchastarCluster) -> GraphsearchastarCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_cluster_copy(s : GraphsearchastarCluster) -> GraphsearchastarCluster {
  let result = graph_search_astar_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_cluster_fill(s : GraphsearchastarCluster, v : Double) -> GraphsearchastarCluster {
  let result = graph_search_astar_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_cluster_min(s : GraphsearchastarCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_cluster_max(s : GraphsearchastarCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_cluster_to_string(s : GraphsearchastarCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_model_make(size : Int) -> GraphsearchastarModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_model_len(s : GraphsearchastarModel) -> Int { s.size }

pub fn graph_search_astar_model_get(s : GraphsearchastarModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_model_set(s : GraphsearchastarModel, i : Int, v : Double) -> GraphsearchastarModel {
  let result = graph_search_astar_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_model_sum(s : GraphsearchastarModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_model_mean(s : GraphsearchastarModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_model_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_model_scale(s : GraphsearchastarModel, f : Double) -> GraphsearchastarModel {
  let result = graph_search_astar_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_model_add(a : GraphsearchastarModel, b : GraphsearchastarModel) -> GraphsearchastarModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_model_copy(s : GraphsearchastarModel) -> GraphsearchastarModel {
  let result = graph_search_astar_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_model_fill(s : GraphsearchastarModel, v : Double) -> GraphsearchastarModel {
  let result = graph_search_astar_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_model_min(s : GraphsearchastarModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_model_max(s : GraphsearchastarModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_model_to_string(s : GraphsearchastarModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_layer_make(size : Int) -> GraphsearchastarLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_layer_len(s : GraphsearchastarLayer) -> Int { s.size }

pub fn graph_search_astar_layer_get(s : GraphsearchastarLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_layer_set(s : GraphsearchastarLayer, i : Int, v : Double) -> GraphsearchastarLayer {
  let result = graph_search_astar_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_layer_sum(s : GraphsearchastarLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_layer_mean(s : GraphsearchastarLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_layer_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_layer_scale(s : GraphsearchastarLayer, f : Double) -> GraphsearchastarLayer {
  let result = graph_search_astar_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_layer_add(a : GraphsearchastarLayer, b : GraphsearchastarLayer) -> GraphsearchastarLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_layer_copy(s : GraphsearchastarLayer) -> GraphsearchastarLayer {
  let result = graph_search_astar_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_layer_fill(s : GraphsearchastarLayer, v : Double) -> GraphsearchastarLayer {
  let result = graph_search_astar_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_layer_min(s : GraphsearchastarLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_layer_max(s : GraphsearchastarLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_layer_to_string(s : GraphsearchastarLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_buffer_make(size : Int) -> GraphsearchastarBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_buffer_len(s : GraphsearchastarBuffer) -> Int { s.size }

pub fn graph_search_astar_buffer_get(s : GraphsearchastarBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_buffer_set(s : GraphsearchastarBuffer, i : Int, v : Double) -> GraphsearchastarBuffer {
  let result = graph_search_astar_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_buffer_sum(s : GraphsearchastarBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_buffer_mean(s : GraphsearchastarBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_buffer_scale(s : GraphsearchastarBuffer, f : Double) -> GraphsearchastarBuffer {
  let result = graph_search_astar_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_buffer_add(a : GraphsearchastarBuffer, b : GraphsearchastarBuffer) -> GraphsearchastarBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_buffer_copy(s : GraphsearchastarBuffer) -> GraphsearchastarBuffer {
  let result = graph_search_astar_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_buffer_fill(s : GraphsearchastarBuffer, v : Double) -> GraphsearchastarBuffer {
  let result = graph_search_astar_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_buffer_min(s : GraphsearchastarBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_buffer_max(s : GraphsearchastarBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_buffer_to_string(s : GraphsearchastarBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_cursor_make(size : Int) -> GraphsearchastarCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_cursor_len(s : GraphsearchastarCursor) -> Int { s.size }

pub fn graph_search_astar_cursor_get(s : GraphsearchastarCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_cursor_set(s : GraphsearchastarCursor, i : Int, v : Double) -> GraphsearchastarCursor {
  let result = graph_search_astar_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_cursor_sum(s : GraphsearchastarCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_cursor_mean(s : GraphsearchastarCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_cursor_scale(s : GraphsearchastarCursor, f : Double) -> GraphsearchastarCursor {
  let result = graph_search_astar_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_cursor_add(a : GraphsearchastarCursor, b : GraphsearchastarCursor) -> GraphsearchastarCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_cursor_copy(s : GraphsearchastarCursor) -> GraphsearchastarCursor {
  let result = graph_search_astar_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_cursor_fill(s : GraphsearchastarCursor, v : Double) -> GraphsearchastarCursor {
  let result = graph_search_astar_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_cursor_min(s : GraphsearchastarCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_cursor_max(s : GraphsearchastarCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_cursor_to_string(s : GraphsearchastarCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_view_make(size : Int) -> GraphsearchastarView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_view_len(s : GraphsearchastarView) -> Int { s.size }

pub fn graph_search_astar_view_get(s : GraphsearchastarView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_view_set(s : GraphsearchastarView, i : Int, v : Double) -> GraphsearchastarView {
  let result = graph_search_astar_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_view_sum(s : GraphsearchastarView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_view_mean(s : GraphsearchastarView) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_view_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_view_scale(s : GraphsearchastarView, f : Double) -> GraphsearchastarView {
  let result = graph_search_astar_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_view_add(a : GraphsearchastarView, b : GraphsearchastarView) -> GraphsearchastarView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_view_copy(s : GraphsearchastarView) -> GraphsearchastarView {
  let result = graph_search_astar_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_view_fill(s : GraphsearchastarView, v : Double) -> GraphsearchastarView {
  let result = graph_search_astar_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_view_min(s : GraphsearchastarView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_view_max(s : GraphsearchastarView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_view_to_string(s : GraphsearchastarView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_range_make(size : Int) -> GraphsearchastarRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_range_len(s : GraphsearchastarRange) -> Int { s.size }

pub fn graph_search_astar_range_get(s : GraphsearchastarRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_range_set(s : GraphsearchastarRange, i : Int, v : Double) -> GraphsearchastarRange {
  let result = graph_search_astar_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_range_sum(s : GraphsearchastarRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_range_mean(s : GraphsearchastarRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_range_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_range_scale(s : GraphsearchastarRange, f : Double) -> GraphsearchastarRange {
  let result = graph_search_astar_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_range_add(a : GraphsearchastarRange, b : GraphsearchastarRange) -> GraphsearchastarRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_range_copy(s : GraphsearchastarRange) -> GraphsearchastarRange {
  let result = graph_search_astar_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_range_fill(s : GraphsearchastarRange, v : Double) -> GraphsearchastarRange {
  let result = graph_search_astar_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_range_min(s : GraphsearchastarRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_range_max(s : GraphsearchastarRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_range_to_string(s : GraphsearchastarRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchastarSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_astar_slice_make(size : Int) -> GraphsearchastarSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_astar_slice_len(s : GraphsearchastarSlice) -> Int { s.size }

pub fn graph_search_astar_slice_get(s : GraphsearchastarSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_astar_slice_set(s : GraphsearchastarSlice, i : Int, v : Double) -> GraphsearchastarSlice {
  let result = graph_search_astar_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_slice_sum(s : GraphsearchastarSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_astar_slice_mean(s : GraphsearchastarSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_astar_slice_sum(s) / s.size.to_double() }
}

pub fn graph_search_astar_slice_scale(s : GraphsearchastarSlice, f : Double) -> GraphsearchastarSlice {
  let result = graph_search_astar_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_astar_slice_add(a : GraphsearchastarSlice, b : GraphsearchastarSlice) -> GraphsearchastarSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_astar_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_astar_slice_copy(s : GraphsearchastarSlice) -> GraphsearchastarSlice {
  let result = graph_search_astar_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_astar_slice_fill(s : GraphsearchastarSlice, v : Double) -> GraphsearchastarSlice {
  let result = graph_search_astar_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_astar_slice_min(s : GraphsearchastarSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_slice_max(s : GraphsearchastarSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_astar_slice_to_string(s : GraphsearchastarSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

