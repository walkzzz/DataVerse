///===
/// extcore/graph_connect_euler

pub(all) struct GraphconnecteulerPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_euler_make_point(x : Double, y : Double) -> GraphconnecteulerPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_euler_make_point3(x : Double, y : Double, z : Double) -> GraphconnecteulerPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_euler_point_x(pt : GraphconnecteulerPoint) -> Double { pt.x }

pub fn graph_connect_euler_point_y(pt : GraphconnecteulerPoint) -> Double { pt.y }

pub fn graph_connect_euler_point_z(pt : GraphconnecteulerPoint) -> Double { pt.z }

pub fn graph_connect_euler_point_label(pt : GraphconnecteulerPoint) -> Int { pt.label }

pub fn graph_connect_euler_point_dist(a : GraphconnecteulerPoint, b : GraphconnecteulerPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_euler_point_add(a : GraphconnecteulerPoint, b : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_euler_point_sub(a : GraphconnecteulerPoint, b : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_euler_point_scale(pt : GraphconnecteulerPoint, s : Double) -> GraphconnecteulerPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_euler_point_dot(a : GraphconnecteulerPoint, b : GraphconnecteulerPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_euler_point_cross(a : GraphconnecteulerPoint, b : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_euler_point_norm(pt : GraphconnecteulerPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_euler_point_normalize(pt : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  let n = graph_connect_euler_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_euler_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_euler_point_negate(pt : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_euler_point_mid(a : GraphconnecteulerPoint, b : GraphconnecteulerPoint) -> GraphconnecteulerPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_euler_point_lerp(a : GraphconnecteulerPoint, b : GraphconnecteulerPoint, t : Double) -> GraphconnecteulerPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_euler_point_to_string(pt : GraphconnecteulerPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnecteulerSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_euler_make_series(vals : Array[Double], name : String) -> GraphconnecteulerSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_euler_series_len(s : GraphconnecteulerSeries) -> Int { s.vals.length() }

pub fn graph_connect_euler_series_sum(s : GraphconnecteulerSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_connect_euler_series_mean(s : GraphconnecteulerSeries) -> Double {
  let n = graph_connect_euler_series_len(s)
  if n == 0 { 0.0 } else { graph_connect_euler_series_sum(s) / n.to_double() }
}

pub fn graph_connect_euler_series_min(s : GraphconnecteulerSeries) -> Double {
  let n = graph_connect_euler_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_connect_euler_series_max(s : GraphconnecteulerSeries) -> Double {
  let n = graph_connect_euler_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_connect_euler_series_range(s : GraphconnecteulerSeries) -> Double {
  graph_connect_euler_series_max(s) - graph_connect_euler_series_min(s)
}

pub fn graph_connect_euler_series_var(s : GraphconnecteulerSeries) -> Double {
  let n = graph_connect_euler_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_connect_euler_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_connect_euler_series_std(s : GraphconnecteulerSeries) -> Double { @_common.sqrt(graph_connect_euler_series_var(s)) }

pub fn graph_connect_euler_series_median(s : GraphconnecteulerSeries) -> Double {
  let n = graph_connect_euler_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_connect_euler_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_connect_euler_series_scale(s : GraphconnecteulerSeries, f : Double) -> GraphconnecteulerSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_connect_euler_series_add(a : GraphconnecteulerSeries, b : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_euler_series_sub(a : GraphconnecteulerSeries, b : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_euler_series_normalize(s : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  let mn = graph_connect_euler_series_min(s)
  let mx = graph_connect_euler_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_euler_series_cumsum(s : GraphconnecteulerSeries) -> GraphconnecteulerSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_euler_series_to_string(s : GraphconnecteulerSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnecteulerMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_euler_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnecteulerMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_euler_matrix_identity(n : Int) -> GraphconnecteulerMatrix {
  let m = graph_connect_euler_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_euler_matrix_get(m : GraphconnecteulerMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_euler_matrix_transpose(m : GraphconnecteulerMatrix) -> GraphconnecteulerMatrix {
  let result = graph_connect_euler_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_euler_matrix_add(a : GraphconnecteulerMatrix, b : GraphconnecteulerMatrix) -> GraphconnecteulerMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_euler_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_euler_matrix_scale(m : GraphconnecteulerMatrix, s : Double) -> GraphconnecteulerMatrix {
  let result = graph_connect_euler_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_euler_matrix_multiply(a : GraphconnecteulerMatrix, b : GraphconnecteulerMatrix) -> GraphconnecteulerMatrix {
  if a.cols != b.rows { return graph_connect_euler_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_euler_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_euler_matrix_trace(m : GraphconnecteulerMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_euler_matrix_det(m : GraphconnecteulerMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_euler_matrix_norm(m : GraphconnecteulerMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_connect_euler_matrix_to_string(m : GraphconnecteulerMatrix) -> String {
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

pub(all) struct GraphconnecteulerVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_euler_make_vector(comps : Array[Double]) -> GraphconnecteulerVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_euler_vector_zero(dim : Int) -> GraphconnecteulerVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_euler_vector_add(a : GraphconnecteulerVector, b : GraphconnecteulerVector) -> GraphconnecteulerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_euler_vector_sub(a : GraphconnecteulerVector, b : GraphconnecteulerVector) -> GraphconnecteulerVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_euler_vector_scale(v : GraphconnecteulerVector, s : Double) -> GraphconnecteulerVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_connect_euler_vector_dot(a : GraphconnecteulerVector, b : GraphconnecteulerVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_euler_vector_norm(v : GraphconnecteulerVector) -> Double { @_common.sqrt(graph_connect_euler_vector_dot(v, v)) }

pub fn graph_connect_euler_vector_normalize(v : GraphconnecteulerVector) -> GraphconnecteulerVector {
  let n = graph_connect_euler_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_euler_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_euler_vector_dist(a : GraphconnecteulerVector, b : GraphconnecteulerVector) -> Double {
  graph_connect_euler_vector_norm(graph_connect_euler_vector_sub(a, b))
}

pub fn graph_connect_euler_vector_to_string(v : GraphconnecteulerVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_euler_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_connect_euler_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_connect_euler_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_connect_euler_std(data : Array[Double]) -> Double { @_common.sqrt(graph_connect_euler_var(data)) }

pub fn graph_connect_euler_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_connect_euler_mean(a); let mb = graph_connect_euler_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_connect_euler_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_connect_euler_std(a); let sb = graph_connect_euler_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_connect_euler_cov(a, b) / (sa * sb) }
}

pub fn graph_connect_euler_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_connect_euler_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_connect_euler_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_connect_euler_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_connect_euler_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(graph_connect_euler_mse(pred, labels))
}

pub fn graph_connect_euler_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_connect_euler_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_connect_euler_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_connect_euler_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_connect_euler_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_connect_euler_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_connect_euler_precision(pred, labels, pos); let r = graph_connect_euler_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_connect_euler_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_connect_euler_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_connect_euler_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_connect_euler_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_connect_euler_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_connect_euler_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_connect_euler_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_connect_euler_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_connect_euler_fibonacci(n : Int) -> Int {
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

pub fn graph_connect_euler_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_connect_euler_min(data); let mx = graph_connect_euler_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_connect_euler_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_connect_euler_mean(data); let sd = graph_connect_euler_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_connect_euler_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_connect_euler_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_connect_euler_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_connect_euler_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_connect_euler_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_connect_euler_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GraphconnecteulerFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_frame_make(size : Int) -> GraphconnecteulerFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_frame_len(s : GraphconnecteulerFrame) -> Int { s.size }

pub fn graph_connect_euler_frame_get(s : GraphconnecteulerFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_frame_set(s : GraphconnecteulerFrame, i : Int, v : Double) -> GraphconnecteulerFrame {
  let result = graph_connect_euler_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_frame_sum(s : GraphconnecteulerFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_frame_mean(s : GraphconnecteulerFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_frame_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_frame_scale(s : GraphconnecteulerFrame, f : Double) -> GraphconnecteulerFrame {
  let result = graph_connect_euler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_frame_add(a : GraphconnecteulerFrame, b : GraphconnecteulerFrame) -> GraphconnecteulerFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_frame_copy(s : GraphconnecteulerFrame) -> GraphconnecteulerFrame {
  let result = graph_connect_euler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_frame_fill(s : GraphconnecteulerFrame, v : Double) -> GraphconnecteulerFrame {
  let result = graph_connect_euler_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_frame_min(s : GraphconnecteulerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_frame_max(s : GraphconnecteulerFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_frame_to_string(s : GraphconnecteulerFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_table_make(size : Int) -> GraphconnecteulerTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_table_len(s : GraphconnecteulerTable) -> Int { s.size }

pub fn graph_connect_euler_table_get(s : GraphconnecteulerTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_table_set(s : GraphconnecteulerTable, i : Int, v : Double) -> GraphconnecteulerTable {
  let result = graph_connect_euler_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_table_sum(s : GraphconnecteulerTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_table_mean(s : GraphconnecteulerTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_table_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_table_scale(s : GraphconnecteulerTable, f : Double) -> GraphconnecteulerTable {
  let result = graph_connect_euler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_table_add(a : GraphconnecteulerTable, b : GraphconnecteulerTable) -> GraphconnecteulerTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_table_copy(s : GraphconnecteulerTable) -> GraphconnecteulerTable {
  let result = graph_connect_euler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_table_fill(s : GraphconnecteulerTable, v : Double) -> GraphconnecteulerTable {
  let result = graph_connect_euler_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_table_min(s : GraphconnecteulerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_table_max(s : GraphconnecteulerTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_table_to_string(s : GraphconnecteulerTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_graphn_make(size : Int) -> GraphconnecteulerGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_graphn_len(s : GraphconnecteulerGraphN) -> Int { s.size }

pub fn graph_connect_euler_graphn_get(s : GraphconnecteulerGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_graphn_set(s : GraphconnecteulerGraphN, i : Int, v : Double) -> GraphconnecteulerGraphN {
  let result = graph_connect_euler_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_graphn_sum(s : GraphconnecteulerGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_graphn_mean(s : GraphconnecteulerGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_graphn_scale(s : GraphconnecteulerGraphN, f : Double) -> GraphconnecteulerGraphN {
  let result = graph_connect_euler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_graphn_add(a : GraphconnecteulerGraphN, b : GraphconnecteulerGraphN) -> GraphconnecteulerGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_graphn_copy(s : GraphconnecteulerGraphN) -> GraphconnecteulerGraphN {
  let result = graph_connect_euler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_graphn_fill(s : GraphconnecteulerGraphN, v : Double) -> GraphconnecteulerGraphN {
  let result = graph_connect_euler_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_graphn_min(s : GraphconnecteulerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_graphn_max(s : GraphconnecteulerGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_graphn_to_string(s : GraphconnecteulerGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_node_make(size : Int) -> GraphconnecteulerNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_node_len(s : GraphconnecteulerNode) -> Int { s.size }

pub fn graph_connect_euler_node_get(s : GraphconnecteulerNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_node_set(s : GraphconnecteulerNode, i : Int, v : Double) -> GraphconnecteulerNode {
  let result = graph_connect_euler_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_node_sum(s : GraphconnecteulerNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_node_mean(s : GraphconnecteulerNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_node_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_node_scale(s : GraphconnecteulerNode, f : Double) -> GraphconnecteulerNode {
  let result = graph_connect_euler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_node_add(a : GraphconnecteulerNode, b : GraphconnecteulerNode) -> GraphconnecteulerNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_node_copy(s : GraphconnecteulerNode) -> GraphconnecteulerNode {
  let result = graph_connect_euler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_node_fill(s : GraphconnecteulerNode, v : Double) -> GraphconnecteulerNode {
  let result = graph_connect_euler_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_node_min(s : GraphconnecteulerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_node_max(s : GraphconnecteulerNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_node_to_string(s : GraphconnecteulerNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_edge_make(size : Int) -> GraphconnecteulerEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_edge_len(s : GraphconnecteulerEdge) -> Int { s.size }

pub fn graph_connect_euler_edge_get(s : GraphconnecteulerEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_edge_set(s : GraphconnecteulerEdge, i : Int, v : Double) -> GraphconnecteulerEdge {
  let result = graph_connect_euler_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_edge_sum(s : GraphconnecteulerEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_edge_mean(s : GraphconnecteulerEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_edge_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_edge_scale(s : GraphconnecteulerEdge, f : Double) -> GraphconnecteulerEdge {
  let result = graph_connect_euler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_edge_add(a : GraphconnecteulerEdge, b : GraphconnecteulerEdge) -> GraphconnecteulerEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_edge_copy(s : GraphconnecteulerEdge) -> GraphconnecteulerEdge {
  let result = graph_connect_euler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_edge_fill(s : GraphconnecteulerEdge, v : Double) -> GraphconnecteulerEdge {
  let result = graph_connect_euler_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_edge_min(s : GraphconnecteulerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_edge_max(s : GraphconnecteulerEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_edge_to_string(s : GraphconnecteulerEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_path_make(size : Int) -> GraphconnecteulerPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_path_len(s : GraphconnecteulerPath) -> Int { s.size }

pub fn graph_connect_euler_path_get(s : GraphconnecteulerPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_path_set(s : GraphconnecteulerPath, i : Int, v : Double) -> GraphconnecteulerPath {
  let result = graph_connect_euler_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_path_sum(s : GraphconnecteulerPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_path_mean(s : GraphconnecteulerPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_path_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_path_scale(s : GraphconnecteulerPath, f : Double) -> GraphconnecteulerPath {
  let result = graph_connect_euler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_path_add(a : GraphconnecteulerPath, b : GraphconnecteulerPath) -> GraphconnecteulerPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_path_copy(s : GraphconnecteulerPath) -> GraphconnecteulerPath {
  let result = graph_connect_euler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_path_fill(s : GraphconnecteulerPath, v : Double) -> GraphconnecteulerPath {
  let result = graph_connect_euler_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_path_min(s : GraphconnecteulerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_path_max(s : GraphconnecteulerPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_path_to_string(s : GraphconnecteulerPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_cluster_make(size : Int) -> GraphconnecteulerCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_cluster_len(s : GraphconnecteulerCluster) -> Int { s.size }

pub fn graph_connect_euler_cluster_get(s : GraphconnecteulerCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_cluster_set(s : GraphconnecteulerCluster, i : Int, v : Double) -> GraphconnecteulerCluster {
  let result = graph_connect_euler_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_cluster_sum(s : GraphconnecteulerCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_cluster_mean(s : GraphconnecteulerCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_cluster_scale(s : GraphconnecteulerCluster, f : Double) -> GraphconnecteulerCluster {
  let result = graph_connect_euler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_cluster_add(a : GraphconnecteulerCluster, b : GraphconnecteulerCluster) -> GraphconnecteulerCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_cluster_copy(s : GraphconnecteulerCluster) -> GraphconnecteulerCluster {
  let result = graph_connect_euler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_cluster_fill(s : GraphconnecteulerCluster, v : Double) -> GraphconnecteulerCluster {
  let result = graph_connect_euler_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_cluster_min(s : GraphconnecteulerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_cluster_max(s : GraphconnecteulerCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_cluster_to_string(s : GraphconnecteulerCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_model_make(size : Int) -> GraphconnecteulerModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_model_len(s : GraphconnecteulerModel) -> Int { s.size }

pub fn graph_connect_euler_model_get(s : GraphconnecteulerModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_model_set(s : GraphconnecteulerModel, i : Int, v : Double) -> GraphconnecteulerModel {
  let result = graph_connect_euler_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_model_sum(s : GraphconnecteulerModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_model_mean(s : GraphconnecteulerModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_model_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_model_scale(s : GraphconnecteulerModel, f : Double) -> GraphconnecteulerModel {
  let result = graph_connect_euler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_model_add(a : GraphconnecteulerModel, b : GraphconnecteulerModel) -> GraphconnecteulerModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_model_copy(s : GraphconnecteulerModel) -> GraphconnecteulerModel {
  let result = graph_connect_euler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_model_fill(s : GraphconnecteulerModel, v : Double) -> GraphconnecteulerModel {
  let result = graph_connect_euler_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_model_min(s : GraphconnecteulerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_model_max(s : GraphconnecteulerModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_model_to_string(s : GraphconnecteulerModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_layer_make(size : Int) -> GraphconnecteulerLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_layer_len(s : GraphconnecteulerLayer) -> Int { s.size }

pub fn graph_connect_euler_layer_get(s : GraphconnecteulerLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_layer_set(s : GraphconnecteulerLayer, i : Int, v : Double) -> GraphconnecteulerLayer {
  let result = graph_connect_euler_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_layer_sum(s : GraphconnecteulerLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_layer_mean(s : GraphconnecteulerLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_layer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_layer_scale(s : GraphconnecteulerLayer, f : Double) -> GraphconnecteulerLayer {
  let result = graph_connect_euler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_layer_add(a : GraphconnecteulerLayer, b : GraphconnecteulerLayer) -> GraphconnecteulerLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_layer_copy(s : GraphconnecteulerLayer) -> GraphconnecteulerLayer {
  let result = graph_connect_euler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_layer_fill(s : GraphconnecteulerLayer, v : Double) -> GraphconnecteulerLayer {
  let result = graph_connect_euler_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_layer_min(s : GraphconnecteulerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_layer_max(s : GraphconnecteulerLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_layer_to_string(s : GraphconnecteulerLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_buffer_make(size : Int) -> GraphconnecteulerBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_buffer_len(s : GraphconnecteulerBuffer) -> Int { s.size }

pub fn graph_connect_euler_buffer_get(s : GraphconnecteulerBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_buffer_set(s : GraphconnecteulerBuffer, i : Int, v : Double) -> GraphconnecteulerBuffer {
  let result = graph_connect_euler_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_buffer_sum(s : GraphconnecteulerBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_buffer_mean(s : GraphconnecteulerBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_buffer_scale(s : GraphconnecteulerBuffer, f : Double) -> GraphconnecteulerBuffer {
  let result = graph_connect_euler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_buffer_add(a : GraphconnecteulerBuffer, b : GraphconnecteulerBuffer) -> GraphconnecteulerBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_buffer_copy(s : GraphconnecteulerBuffer) -> GraphconnecteulerBuffer {
  let result = graph_connect_euler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_buffer_fill(s : GraphconnecteulerBuffer, v : Double) -> GraphconnecteulerBuffer {
  let result = graph_connect_euler_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_buffer_min(s : GraphconnecteulerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_buffer_max(s : GraphconnecteulerBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_buffer_to_string(s : GraphconnecteulerBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_cursor_make(size : Int) -> GraphconnecteulerCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_cursor_len(s : GraphconnecteulerCursor) -> Int { s.size }

pub fn graph_connect_euler_cursor_get(s : GraphconnecteulerCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_cursor_set(s : GraphconnecteulerCursor, i : Int, v : Double) -> GraphconnecteulerCursor {
  let result = graph_connect_euler_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_cursor_sum(s : GraphconnecteulerCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_cursor_mean(s : GraphconnecteulerCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_cursor_scale(s : GraphconnecteulerCursor, f : Double) -> GraphconnecteulerCursor {
  let result = graph_connect_euler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_cursor_add(a : GraphconnecteulerCursor, b : GraphconnecteulerCursor) -> GraphconnecteulerCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_cursor_copy(s : GraphconnecteulerCursor) -> GraphconnecteulerCursor {
  let result = graph_connect_euler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_cursor_fill(s : GraphconnecteulerCursor, v : Double) -> GraphconnecteulerCursor {
  let result = graph_connect_euler_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_cursor_min(s : GraphconnecteulerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_cursor_max(s : GraphconnecteulerCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_cursor_to_string(s : GraphconnecteulerCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_view_make(size : Int) -> GraphconnecteulerView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_view_len(s : GraphconnecteulerView) -> Int { s.size }

pub fn graph_connect_euler_view_get(s : GraphconnecteulerView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_view_set(s : GraphconnecteulerView, i : Int, v : Double) -> GraphconnecteulerView {
  let result = graph_connect_euler_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_view_sum(s : GraphconnecteulerView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_view_mean(s : GraphconnecteulerView) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_view_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_view_scale(s : GraphconnecteulerView, f : Double) -> GraphconnecteulerView {
  let result = graph_connect_euler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_view_add(a : GraphconnecteulerView, b : GraphconnecteulerView) -> GraphconnecteulerView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_view_copy(s : GraphconnecteulerView) -> GraphconnecteulerView {
  let result = graph_connect_euler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_view_fill(s : GraphconnecteulerView, v : Double) -> GraphconnecteulerView {
  let result = graph_connect_euler_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_view_min(s : GraphconnecteulerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_view_max(s : GraphconnecteulerView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_view_to_string(s : GraphconnecteulerView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_range_make(size : Int) -> GraphconnecteulerRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_range_len(s : GraphconnecteulerRange) -> Int { s.size }

pub fn graph_connect_euler_range_get(s : GraphconnecteulerRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_range_set(s : GraphconnecteulerRange, i : Int, v : Double) -> GraphconnecteulerRange {
  let result = graph_connect_euler_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_range_sum(s : GraphconnecteulerRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_range_mean(s : GraphconnecteulerRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_range_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_range_scale(s : GraphconnecteulerRange, f : Double) -> GraphconnecteulerRange {
  let result = graph_connect_euler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_range_add(a : GraphconnecteulerRange, b : GraphconnecteulerRange) -> GraphconnecteulerRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_range_copy(s : GraphconnecteulerRange) -> GraphconnecteulerRange {
  let result = graph_connect_euler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_range_fill(s : GraphconnecteulerRange, v : Double) -> GraphconnecteulerRange {
  let result = graph_connect_euler_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_range_min(s : GraphconnecteulerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_range_max(s : GraphconnecteulerRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_range_to_string(s : GraphconnecteulerRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnecteulerSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_euler_slice_make(size : Int) -> GraphconnecteulerSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_euler_slice_len(s : GraphconnecteulerSlice) -> Int { s.size }

pub fn graph_connect_euler_slice_get(s : GraphconnecteulerSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_euler_slice_set(s : GraphconnecteulerSlice, i : Int, v : Double) -> GraphconnecteulerSlice {
  let result = graph_connect_euler_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_slice_sum(s : GraphconnecteulerSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_euler_slice_mean(s : GraphconnecteulerSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_euler_slice_sum(s) / s.size.to_double() }
}

pub fn graph_connect_euler_slice_scale(s : GraphconnecteulerSlice, f : Double) -> GraphconnecteulerSlice {
  let result = graph_connect_euler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_euler_slice_add(a : GraphconnecteulerSlice, b : GraphconnecteulerSlice) -> GraphconnecteulerSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_euler_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_euler_slice_copy(s : GraphconnecteulerSlice) -> GraphconnecteulerSlice {
  let result = graph_connect_euler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_euler_slice_fill(s : GraphconnecteulerSlice, v : Double) -> GraphconnecteulerSlice {
  let result = graph_connect_euler_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_euler_slice_min(s : GraphconnecteulerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_slice_max(s : GraphconnecteulerSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_euler_slice_to_string(s : GraphconnecteulerSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

