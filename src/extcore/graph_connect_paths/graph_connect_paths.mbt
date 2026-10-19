///===
/// extcore/graph_connect_paths

pub(all) struct GraphconnectpathsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_connect_paths_make_point(x : Double, y : Double) -> GraphconnectpathsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_connect_paths_make_point3(x : Double, y : Double, z : Double) -> GraphconnectpathsPoint {
  { x, y, z, label: 0 }
}

pub fn graph_connect_paths_point_x(pt : GraphconnectpathsPoint) -> Double { pt.x }

pub fn graph_connect_paths_point_y(pt : GraphconnectpathsPoint) -> Double { pt.y }

pub fn graph_connect_paths_point_z(pt : GraphconnectpathsPoint) -> Double { pt.z }

pub fn graph_connect_paths_point_label(pt : GraphconnectpathsPoint) -> Int { pt.label }

pub fn graph_connect_paths_point_dist(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_connect_paths_point_add(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_connect_paths_point_sub(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_connect_paths_point_scale(pt : GraphconnectpathsPoint, s : Double) -> GraphconnectpathsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_connect_paths_point_dot(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_connect_paths_point_cross(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_connect_paths_point_norm(pt : GraphconnectpathsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_connect_paths_point_normalize(pt : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  let n = graph_connect_paths_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_connect_paths_point_scale(pt, 1.0 / n) }
}

pub fn graph_connect_paths_point_negate(pt : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_connect_paths_point_mid(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint) -> GraphconnectpathsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_connect_paths_point_lerp(a : GraphconnectpathsPoint, b : GraphconnectpathsPoint, t : Double) -> GraphconnectpathsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_connect_paths_point_to_string(pt : GraphconnectpathsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphconnectpathsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_connect_paths_make_series(vals : Array[Double], name : String) -> GraphconnectpathsSeries {
  { vals, name, meta: 0 }
}

pub fn graph_connect_paths_series_len(s : GraphconnectpathsSeries) -> Int { s.vals.length() }

pub fn graph_connect_paths_series_sum(s : GraphconnectpathsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_connect_paths_series_mean(s : GraphconnectpathsSeries) -> Double {
  let n = graph_connect_paths_series_len(s)
  if n == 0 { 0.0 } else { graph_connect_paths_series_sum(s) / n.to_double() }
}

pub fn graph_connect_paths_series_min(s : GraphconnectpathsSeries) -> Double {
  let n = graph_connect_paths_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_connect_paths_series_max(s : GraphconnectpathsSeries) -> Double {
  let n = graph_connect_paths_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_connect_paths_series_range(s : GraphconnectpathsSeries) -> Double {
  graph_connect_paths_series_max(s) - graph_connect_paths_series_min(s)
}

pub fn graph_connect_paths_series_var(s : GraphconnectpathsSeries) -> Double {
  let n = graph_connect_paths_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_connect_paths_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_connect_paths_series_std(s : GraphconnectpathsSeries) -> Double { @_common.sqrt(graph_connect_paths_series_var(s)) }

pub fn graph_connect_paths_series_median(s : GraphconnectpathsSeries) -> Double {
  let n = graph_connect_paths_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_connect_paths_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_connect_paths_series_scale(s : GraphconnectpathsSeries, f : Double) -> GraphconnectpathsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_connect_paths_series_add(a : GraphconnectpathsSeries, b : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_connect_paths_series_sub(a : GraphconnectpathsSeries, b : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_connect_paths_series_normalize(s : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  let mn = graph_connect_paths_series_min(s)
  let mx = graph_connect_paths_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_connect_paths_series_cumsum(s : GraphconnectpathsSeries) -> GraphconnectpathsSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_connect_paths_series_to_string(s : GraphconnectpathsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphconnectpathsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_connect_paths_make_matrix(rows : Int, cols : Int, val : Double) -> GraphconnectpathsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_connect_paths_matrix_identity(n : Int) -> GraphconnectpathsMatrix {
  let m = graph_connect_paths_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_connect_paths_matrix_get(m : GraphconnectpathsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_connect_paths_matrix_transpose(m : GraphconnectpathsMatrix) -> GraphconnectpathsMatrix {
  let result = graph_connect_paths_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_connect_paths_matrix_add(a : GraphconnectpathsMatrix, b : GraphconnectpathsMatrix) -> GraphconnectpathsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_connect_paths_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_connect_paths_matrix_scale(m : GraphconnectpathsMatrix, s : Double) -> GraphconnectpathsMatrix {
  let result = graph_connect_paths_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_connect_paths_matrix_multiply(a : GraphconnectpathsMatrix, b : GraphconnectpathsMatrix) -> GraphconnectpathsMatrix {
  if a.cols != b.rows { return graph_connect_paths_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_connect_paths_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_connect_paths_matrix_trace(m : GraphconnectpathsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_connect_paths_matrix_det(m : GraphconnectpathsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_connect_paths_matrix_norm(m : GraphconnectpathsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_connect_paths_matrix_to_string(m : GraphconnectpathsMatrix) -> String {
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

pub(all) struct GraphconnectpathsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_connect_paths_make_vector(comps : Array[Double]) -> GraphconnectpathsVector {
  { comps, dim: comps.length() }
}

pub fn graph_connect_paths_vector_zero(dim : Int) -> GraphconnectpathsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_connect_paths_vector_add(a : GraphconnectpathsVector, b : GraphconnectpathsVector) -> GraphconnectpathsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_paths_vector_sub(a : GraphconnectpathsVector, b : GraphconnectpathsVector) -> GraphconnectpathsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_connect_paths_vector_scale(v : GraphconnectpathsVector, s : Double) -> GraphconnectpathsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_connect_paths_vector_dot(a : GraphconnectpathsVector, b : GraphconnectpathsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_connect_paths_vector_norm(v : GraphconnectpathsVector) -> Double { @_common.sqrt(graph_connect_paths_vector_dot(v, v)) }

pub fn graph_connect_paths_vector_normalize(v : GraphconnectpathsVector) -> GraphconnectpathsVector {
  let n = graph_connect_paths_vector_norm(v)
  if n < 0.0000001 { v } else { graph_connect_paths_vector_scale(v, 1.0 / n) }
}

pub fn graph_connect_paths_vector_dist(a : GraphconnectpathsVector, b : GraphconnectpathsVector) -> Double {
  graph_connect_paths_vector_norm(graph_connect_paths_vector_sub(a, b))
}

pub fn graph_connect_paths_vector_to_string(v : GraphconnectpathsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_connect_paths_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_connect_paths_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_connect_paths_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_connect_paths_std(data : Array[Double]) -> Double { @_common.sqrt(graph_connect_paths_var(data)) }

pub fn graph_connect_paths_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_connect_paths_mean(a); let mb = graph_connect_paths_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_connect_paths_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_connect_paths_std(a); let sb = graph_connect_paths_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_connect_paths_cov(a, b) / (sa * sb) }
}

pub fn graph_connect_paths_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_connect_paths_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_connect_paths_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_connect_paths_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_connect_paths_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(graph_connect_paths_mse(pred, labels))
}

pub fn graph_connect_paths_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_connect_paths_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_connect_paths_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_connect_paths_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_connect_paths_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_connect_paths_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_connect_paths_precision(pred, labels, pos); let r = graph_connect_paths_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_connect_paths_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_connect_paths_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_connect_paths_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_connect_paths_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_connect_paths_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_connect_paths_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_connect_paths_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_connect_paths_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_connect_paths_fibonacci(n : Int) -> Int {
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

pub fn graph_connect_paths_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_connect_paths_min(data); let mx = graph_connect_paths_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_connect_paths_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_connect_paths_mean(data); let sd = graph_connect_paths_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_connect_paths_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_connect_paths_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_connect_paths_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_connect_paths_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_connect_paths_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_connect_paths_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GraphconnectpathsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_frame_make(size : Int) -> GraphconnectpathsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_frame_len(s : GraphconnectpathsFrame) -> Int { s.size }

pub fn graph_connect_paths_frame_get(s : GraphconnectpathsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_frame_set(s : GraphconnectpathsFrame, i : Int, v : Double) -> GraphconnectpathsFrame {
  let result = graph_connect_paths_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_frame_sum(s : GraphconnectpathsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_frame_mean(s : GraphconnectpathsFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_frame_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_frame_scale(s : GraphconnectpathsFrame, f : Double) -> GraphconnectpathsFrame {
  let result = graph_connect_paths_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_frame_add(a : GraphconnectpathsFrame, b : GraphconnectpathsFrame) -> GraphconnectpathsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_frame_copy(s : GraphconnectpathsFrame) -> GraphconnectpathsFrame {
  let result = graph_connect_paths_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_frame_fill(s : GraphconnectpathsFrame, v : Double) -> GraphconnectpathsFrame {
  let result = graph_connect_paths_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_frame_min(s : GraphconnectpathsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_frame_max(s : GraphconnectpathsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_frame_to_string(s : GraphconnectpathsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_table_make(size : Int) -> GraphconnectpathsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_table_len(s : GraphconnectpathsTable) -> Int { s.size }

pub fn graph_connect_paths_table_get(s : GraphconnectpathsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_table_set(s : GraphconnectpathsTable, i : Int, v : Double) -> GraphconnectpathsTable {
  let result = graph_connect_paths_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_table_sum(s : GraphconnectpathsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_table_mean(s : GraphconnectpathsTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_table_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_table_scale(s : GraphconnectpathsTable, f : Double) -> GraphconnectpathsTable {
  let result = graph_connect_paths_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_table_add(a : GraphconnectpathsTable, b : GraphconnectpathsTable) -> GraphconnectpathsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_table_copy(s : GraphconnectpathsTable) -> GraphconnectpathsTable {
  let result = graph_connect_paths_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_table_fill(s : GraphconnectpathsTable, v : Double) -> GraphconnectpathsTable {
  let result = graph_connect_paths_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_table_min(s : GraphconnectpathsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_table_max(s : GraphconnectpathsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_table_to_string(s : GraphconnectpathsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_graphn_make(size : Int) -> GraphconnectpathsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_graphn_len(s : GraphconnectpathsGraphN) -> Int { s.size }

pub fn graph_connect_paths_graphn_get(s : GraphconnectpathsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_graphn_set(s : GraphconnectpathsGraphN, i : Int, v : Double) -> GraphconnectpathsGraphN {
  let result = graph_connect_paths_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_graphn_sum(s : GraphconnectpathsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_graphn_mean(s : GraphconnectpathsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_graphn_scale(s : GraphconnectpathsGraphN, f : Double) -> GraphconnectpathsGraphN {
  let result = graph_connect_paths_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_graphn_add(a : GraphconnectpathsGraphN, b : GraphconnectpathsGraphN) -> GraphconnectpathsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_graphn_copy(s : GraphconnectpathsGraphN) -> GraphconnectpathsGraphN {
  let result = graph_connect_paths_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_graphn_fill(s : GraphconnectpathsGraphN, v : Double) -> GraphconnectpathsGraphN {
  let result = graph_connect_paths_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_graphn_min(s : GraphconnectpathsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_graphn_max(s : GraphconnectpathsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_graphn_to_string(s : GraphconnectpathsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_node_make(size : Int) -> GraphconnectpathsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_node_len(s : GraphconnectpathsNode) -> Int { s.size }

pub fn graph_connect_paths_node_get(s : GraphconnectpathsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_node_set(s : GraphconnectpathsNode, i : Int, v : Double) -> GraphconnectpathsNode {
  let result = graph_connect_paths_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_node_sum(s : GraphconnectpathsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_node_mean(s : GraphconnectpathsNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_node_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_node_scale(s : GraphconnectpathsNode, f : Double) -> GraphconnectpathsNode {
  let result = graph_connect_paths_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_node_add(a : GraphconnectpathsNode, b : GraphconnectpathsNode) -> GraphconnectpathsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_node_copy(s : GraphconnectpathsNode) -> GraphconnectpathsNode {
  let result = graph_connect_paths_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_node_fill(s : GraphconnectpathsNode, v : Double) -> GraphconnectpathsNode {
  let result = graph_connect_paths_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_node_min(s : GraphconnectpathsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_node_max(s : GraphconnectpathsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_node_to_string(s : GraphconnectpathsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_edge_make(size : Int) -> GraphconnectpathsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_edge_len(s : GraphconnectpathsEdge) -> Int { s.size }

pub fn graph_connect_paths_edge_get(s : GraphconnectpathsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_edge_set(s : GraphconnectpathsEdge, i : Int, v : Double) -> GraphconnectpathsEdge {
  let result = graph_connect_paths_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_edge_sum(s : GraphconnectpathsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_edge_mean(s : GraphconnectpathsEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_edge_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_edge_scale(s : GraphconnectpathsEdge, f : Double) -> GraphconnectpathsEdge {
  let result = graph_connect_paths_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_edge_add(a : GraphconnectpathsEdge, b : GraphconnectpathsEdge) -> GraphconnectpathsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_edge_copy(s : GraphconnectpathsEdge) -> GraphconnectpathsEdge {
  let result = graph_connect_paths_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_edge_fill(s : GraphconnectpathsEdge, v : Double) -> GraphconnectpathsEdge {
  let result = graph_connect_paths_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_edge_min(s : GraphconnectpathsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_edge_max(s : GraphconnectpathsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_edge_to_string(s : GraphconnectpathsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_path_make(size : Int) -> GraphconnectpathsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_path_len(s : GraphconnectpathsPath) -> Int { s.size }

pub fn graph_connect_paths_path_get(s : GraphconnectpathsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_path_set(s : GraphconnectpathsPath, i : Int, v : Double) -> GraphconnectpathsPath {
  let result = graph_connect_paths_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_path_sum(s : GraphconnectpathsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_path_mean(s : GraphconnectpathsPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_path_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_path_scale(s : GraphconnectpathsPath, f : Double) -> GraphconnectpathsPath {
  let result = graph_connect_paths_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_path_add(a : GraphconnectpathsPath, b : GraphconnectpathsPath) -> GraphconnectpathsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_path_copy(s : GraphconnectpathsPath) -> GraphconnectpathsPath {
  let result = graph_connect_paths_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_path_fill(s : GraphconnectpathsPath, v : Double) -> GraphconnectpathsPath {
  let result = graph_connect_paths_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_path_min(s : GraphconnectpathsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_path_max(s : GraphconnectpathsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_path_to_string(s : GraphconnectpathsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_cluster_make(size : Int) -> GraphconnectpathsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_cluster_len(s : GraphconnectpathsCluster) -> Int { s.size }

pub fn graph_connect_paths_cluster_get(s : GraphconnectpathsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_cluster_set(s : GraphconnectpathsCluster, i : Int, v : Double) -> GraphconnectpathsCluster {
  let result = graph_connect_paths_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_cluster_sum(s : GraphconnectpathsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_cluster_mean(s : GraphconnectpathsCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_cluster_scale(s : GraphconnectpathsCluster, f : Double) -> GraphconnectpathsCluster {
  let result = graph_connect_paths_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_cluster_add(a : GraphconnectpathsCluster, b : GraphconnectpathsCluster) -> GraphconnectpathsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_cluster_copy(s : GraphconnectpathsCluster) -> GraphconnectpathsCluster {
  let result = graph_connect_paths_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_cluster_fill(s : GraphconnectpathsCluster, v : Double) -> GraphconnectpathsCluster {
  let result = graph_connect_paths_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_cluster_min(s : GraphconnectpathsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_cluster_max(s : GraphconnectpathsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_cluster_to_string(s : GraphconnectpathsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_model_make(size : Int) -> GraphconnectpathsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_model_len(s : GraphconnectpathsModel) -> Int { s.size }

pub fn graph_connect_paths_model_get(s : GraphconnectpathsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_model_set(s : GraphconnectpathsModel, i : Int, v : Double) -> GraphconnectpathsModel {
  let result = graph_connect_paths_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_model_sum(s : GraphconnectpathsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_model_mean(s : GraphconnectpathsModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_model_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_model_scale(s : GraphconnectpathsModel, f : Double) -> GraphconnectpathsModel {
  let result = graph_connect_paths_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_model_add(a : GraphconnectpathsModel, b : GraphconnectpathsModel) -> GraphconnectpathsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_model_copy(s : GraphconnectpathsModel) -> GraphconnectpathsModel {
  let result = graph_connect_paths_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_model_fill(s : GraphconnectpathsModel, v : Double) -> GraphconnectpathsModel {
  let result = graph_connect_paths_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_model_min(s : GraphconnectpathsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_model_max(s : GraphconnectpathsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_model_to_string(s : GraphconnectpathsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_layer_make(size : Int) -> GraphconnectpathsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_layer_len(s : GraphconnectpathsLayer) -> Int { s.size }

pub fn graph_connect_paths_layer_get(s : GraphconnectpathsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_layer_set(s : GraphconnectpathsLayer, i : Int, v : Double) -> GraphconnectpathsLayer {
  let result = graph_connect_paths_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_layer_sum(s : GraphconnectpathsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_layer_mean(s : GraphconnectpathsLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_layer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_layer_scale(s : GraphconnectpathsLayer, f : Double) -> GraphconnectpathsLayer {
  let result = graph_connect_paths_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_layer_add(a : GraphconnectpathsLayer, b : GraphconnectpathsLayer) -> GraphconnectpathsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_layer_copy(s : GraphconnectpathsLayer) -> GraphconnectpathsLayer {
  let result = graph_connect_paths_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_layer_fill(s : GraphconnectpathsLayer, v : Double) -> GraphconnectpathsLayer {
  let result = graph_connect_paths_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_layer_min(s : GraphconnectpathsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_layer_max(s : GraphconnectpathsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_layer_to_string(s : GraphconnectpathsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_buffer_make(size : Int) -> GraphconnectpathsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_buffer_len(s : GraphconnectpathsBuffer) -> Int { s.size }

pub fn graph_connect_paths_buffer_get(s : GraphconnectpathsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_buffer_set(s : GraphconnectpathsBuffer, i : Int, v : Double) -> GraphconnectpathsBuffer {
  let result = graph_connect_paths_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_buffer_sum(s : GraphconnectpathsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_buffer_mean(s : GraphconnectpathsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_buffer_scale(s : GraphconnectpathsBuffer, f : Double) -> GraphconnectpathsBuffer {
  let result = graph_connect_paths_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_buffer_add(a : GraphconnectpathsBuffer, b : GraphconnectpathsBuffer) -> GraphconnectpathsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_buffer_copy(s : GraphconnectpathsBuffer) -> GraphconnectpathsBuffer {
  let result = graph_connect_paths_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_buffer_fill(s : GraphconnectpathsBuffer, v : Double) -> GraphconnectpathsBuffer {
  let result = graph_connect_paths_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_buffer_min(s : GraphconnectpathsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_buffer_max(s : GraphconnectpathsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_buffer_to_string(s : GraphconnectpathsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_cursor_make(size : Int) -> GraphconnectpathsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_cursor_len(s : GraphconnectpathsCursor) -> Int { s.size }

pub fn graph_connect_paths_cursor_get(s : GraphconnectpathsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_cursor_set(s : GraphconnectpathsCursor, i : Int, v : Double) -> GraphconnectpathsCursor {
  let result = graph_connect_paths_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_cursor_sum(s : GraphconnectpathsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_cursor_mean(s : GraphconnectpathsCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_cursor_scale(s : GraphconnectpathsCursor, f : Double) -> GraphconnectpathsCursor {
  let result = graph_connect_paths_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_cursor_add(a : GraphconnectpathsCursor, b : GraphconnectpathsCursor) -> GraphconnectpathsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_cursor_copy(s : GraphconnectpathsCursor) -> GraphconnectpathsCursor {
  let result = graph_connect_paths_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_cursor_fill(s : GraphconnectpathsCursor, v : Double) -> GraphconnectpathsCursor {
  let result = graph_connect_paths_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_cursor_min(s : GraphconnectpathsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_cursor_max(s : GraphconnectpathsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_cursor_to_string(s : GraphconnectpathsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_view_make(size : Int) -> GraphconnectpathsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_view_len(s : GraphconnectpathsView) -> Int { s.size }

pub fn graph_connect_paths_view_get(s : GraphconnectpathsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_view_set(s : GraphconnectpathsView, i : Int, v : Double) -> GraphconnectpathsView {
  let result = graph_connect_paths_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_view_sum(s : GraphconnectpathsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_view_mean(s : GraphconnectpathsView) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_view_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_view_scale(s : GraphconnectpathsView, f : Double) -> GraphconnectpathsView {
  let result = graph_connect_paths_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_view_add(a : GraphconnectpathsView, b : GraphconnectpathsView) -> GraphconnectpathsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_view_copy(s : GraphconnectpathsView) -> GraphconnectpathsView {
  let result = graph_connect_paths_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_view_fill(s : GraphconnectpathsView, v : Double) -> GraphconnectpathsView {
  let result = graph_connect_paths_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_view_min(s : GraphconnectpathsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_view_max(s : GraphconnectpathsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_view_to_string(s : GraphconnectpathsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_range_make(size : Int) -> GraphconnectpathsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_range_len(s : GraphconnectpathsRange) -> Int { s.size }

pub fn graph_connect_paths_range_get(s : GraphconnectpathsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_range_set(s : GraphconnectpathsRange, i : Int, v : Double) -> GraphconnectpathsRange {
  let result = graph_connect_paths_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_range_sum(s : GraphconnectpathsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_range_mean(s : GraphconnectpathsRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_range_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_range_scale(s : GraphconnectpathsRange, f : Double) -> GraphconnectpathsRange {
  let result = graph_connect_paths_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_range_add(a : GraphconnectpathsRange, b : GraphconnectpathsRange) -> GraphconnectpathsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_range_copy(s : GraphconnectpathsRange) -> GraphconnectpathsRange {
  let result = graph_connect_paths_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_range_fill(s : GraphconnectpathsRange, v : Double) -> GraphconnectpathsRange {
  let result = graph_connect_paths_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_range_min(s : GraphconnectpathsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_range_max(s : GraphconnectpathsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_range_to_string(s : GraphconnectpathsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphconnectpathsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_connect_paths_slice_make(size : Int) -> GraphconnectpathsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_connect_paths_slice_len(s : GraphconnectpathsSlice) -> Int { s.size }

pub fn graph_connect_paths_slice_get(s : GraphconnectpathsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_connect_paths_slice_set(s : GraphconnectpathsSlice, i : Int, v : Double) -> GraphconnectpathsSlice {
  let result = graph_connect_paths_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_slice_sum(s : GraphconnectpathsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_connect_paths_slice_mean(s : GraphconnectpathsSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_connect_paths_slice_sum(s) / s.size.to_double() }
}

pub fn graph_connect_paths_slice_scale(s : GraphconnectpathsSlice, f : Double) -> GraphconnectpathsSlice {
  let result = graph_connect_paths_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_connect_paths_slice_add(a : GraphconnectpathsSlice, b : GraphconnectpathsSlice) -> GraphconnectpathsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_connect_paths_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_connect_paths_slice_copy(s : GraphconnectpathsSlice) -> GraphconnectpathsSlice {
  let result = graph_connect_paths_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_connect_paths_slice_fill(s : GraphconnectpathsSlice, v : Double) -> GraphconnectpathsSlice {
  let result = graph_connect_paths_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_connect_paths_slice_min(s : GraphconnectpathsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_slice_max(s : GraphconnectpathsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_connect_paths_slice_to_string(s : GraphconnectpathsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

