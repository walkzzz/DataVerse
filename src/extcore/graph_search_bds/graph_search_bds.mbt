///===
/// extcore/graph_search_bds

pub(all) struct GraphsearchbdsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn graph_search_bds_make_point(x : Double, y : Double) -> GraphsearchbdsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn graph_search_bds_make_point3(x : Double, y : Double, z : Double) -> GraphsearchbdsPoint {
  { x, y, z, label: 0 }
}

pub fn graph_search_bds_point_x(pt : GraphsearchbdsPoint) -> Double { pt.x }

pub fn graph_search_bds_point_y(pt : GraphsearchbdsPoint) -> Double { pt.y }

pub fn graph_search_bds_point_z(pt : GraphsearchbdsPoint) -> Double { pt.z }

pub fn graph_search_bds_point_label(pt : GraphsearchbdsPoint) -> Int { pt.label }

pub fn graph_search_bds_point_dist(a : GraphsearchbdsPoint, b : GraphsearchbdsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn graph_search_bds_point_add(a : GraphsearchbdsPoint, b : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn graph_search_bds_point_sub(a : GraphsearchbdsPoint, b : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn graph_search_bds_point_scale(pt : GraphsearchbdsPoint, s : Double) -> GraphsearchbdsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn graph_search_bds_point_dot(a : GraphsearchbdsPoint, b : GraphsearchbdsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn graph_search_bds_point_cross(a : GraphsearchbdsPoint, b : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn graph_search_bds_point_norm(pt : GraphsearchbdsPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn graph_search_bds_point_normalize(pt : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  let n = graph_search_bds_point_norm(pt)
  if n < 0.0000001 { pt } else { graph_search_bds_point_scale(pt, 1.0 / n) }
}

pub fn graph_search_bds_point_negate(pt : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn graph_search_bds_point_mid(a : GraphsearchbdsPoint, b : GraphsearchbdsPoint) -> GraphsearchbdsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn graph_search_bds_point_lerp(a : GraphsearchbdsPoint, b : GraphsearchbdsPoint, t : Double) -> GraphsearchbdsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn graph_search_bds_point_to_string(pt : GraphsearchbdsPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GraphsearchbdsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn graph_search_bds_make_series(vals : Array[Double], name : String) -> GraphsearchbdsSeries {
  { vals, name, meta: 0 }
}

pub fn graph_search_bds_series_len(s : GraphsearchbdsSeries) -> Int { s.vals.length() }

pub fn graph_search_bds_series_sum(s : GraphsearchbdsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn graph_search_bds_series_mean(s : GraphsearchbdsSeries) -> Double {
  let n = graph_search_bds_series_len(s)
  if n == 0 { 0.0 } else { graph_search_bds_series_sum(s) / n.to_double() }
}

pub fn graph_search_bds_series_min(s : GraphsearchbdsSeries) -> Double {
  let n = graph_search_bds_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_bds_series_max(s : GraphsearchbdsSeries) -> Double {
  let n = graph_search_bds_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn graph_search_bds_series_range(s : GraphsearchbdsSeries) -> Double {
  graph_search_bds_series_max(s) - graph_search_bds_series_min(s)
}

pub fn graph_search_bds_series_var(s : GraphsearchbdsSeries) -> Double {
  let n = graph_search_bds_series_len(s)
  if n == 0 { 0.0 } else {
    let m = graph_search_bds_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn graph_search_bds_series_std(s : GraphsearchbdsSeries) -> Double { @_common.sqrt(graph_search_bds_series_var(s)) }

pub fn graph_search_bds_series_median(s : GraphsearchbdsSeries) -> Double {
  let n = graph_search_bds_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = graph_search_bds_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_search_bds_series_scale(s : GraphsearchbdsSeries, f : Double) -> GraphsearchbdsSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn graph_search_bds_series_add(a : GraphsearchbdsSeries, b : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn graph_search_bds_series_sub(a : GraphsearchbdsSeries, b : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn graph_search_bds_series_normalize(s : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  let mn = graph_search_bds_series_min(s)
  let mx = graph_search_bds_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn graph_search_bds_series_cumsum(s : GraphsearchbdsSeries) -> GraphsearchbdsSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn graph_search_bds_series_to_string(s : GraphsearchbdsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GraphsearchbdsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn graph_search_bds_make_matrix(rows : Int, cols : Int, val : Double) -> GraphsearchbdsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn graph_search_bds_matrix_identity(n : Int) -> GraphsearchbdsMatrix {
  let m = graph_search_bds_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn graph_search_bds_matrix_get(m : GraphsearchbdsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn graph_search_bds_matrix_transpose(m : GraphsearchbdsMatrix) -> GraphsearchbdsMatrix {
  let result = graph_search_bds_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn graph_search_bds_matrix_add(a : GraphsearchbdsMatrix, b : GraphsearchbdsMatrix) -> GraphsearchbdsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = graph_search_bds_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn graph_search_bds_matrix_scale(m : GraphsearchbdsMatrix, s : Double) -> GraphsearchbdsMatrix {
  let result = graph_search_bds_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn graph_search_bds_matrix_multiply(a : GraphsearchbdsMatrix, b : GraphsearchbdsMatrix) -> GraphsearchbdsMatrix {
  if a.cols != b.rows { return graph_search_bds_make_matrix(a.rows, b.cols, 0.0) }
  let result = graph_search_bds_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn graph_search_bds_matrix_trace(m : GraphsearchbdsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn graph_search_bds_matrix_det(m : GraphsearchbdsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn graph_search_bds_matrix_norm(m : GraphsearchbdsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn graph_search_bds_matrix_to_string(m : GraphsearchbdsMatrix) -> String {
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

pub(all) struct GraphsearchbdsVector {
  comps : Array[Double]
  dim : Int
}

pub fn graph_search_bds_make_vector(comps : Array[Double]) -> GraphsearchbdsVector {
  { comps, dim: comps.length() }
}

pub fn graph_search_bds_vector_zero(dim : Int) -> GraphsearchbdsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn graph_search_bds_vector_add(a : GraphsearchbdsVector, b : GraphsearchbdsVector) -> GraphsearchbdsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_bds_vector_sub(a : GraphsearchbdsVector, b : GraphsearchbdsVector) -> GraphsearchbdsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn graph_search_bds_vector_scale(v : GraphsearchbdsVector, s : Double) -> GraphsearchbdsVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn graph_search_bds_vector_dot(a : GraphsearchbdsVector, b : GraphsearchbdsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn graph_search_bds_vector_norm(v : GraphsearchbdsVector) -> Double { @_common.sqrt(graph_search_bds_vector_dot(v, v)) }

pub fn graph_search_bds_vector_normalize(v : GraphsearchbdsVector) -> GraphsearchbdsVector {
  let n = graph_search_bds_vector_norm(v)
  if n < 0.0000001 { v } else { graph_search_bds_vector_scale(v, 1.0 / n) }
}

pub fn graph_search_bds_vector_dist(a : GraphsearchbdsVector, b : GraphsearchbdsVector) -> Double {
  graph_search_bds_vector_norm(graph_search_bds_vector_sub(a, b))
}

pub fn graph_search_bds_vector_to_string(v : GraphsearchbdsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn graph_search_bds_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn graph_search_bds_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = graph_search_bds_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_search_bds_std(data : Array[Double]) -> Double { @_common.sqrt(graph_search_bds_var(data)) }

pub fn graph_search_bds_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = graph_search_bds_mean(a); let mb = graph_search_bds_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn graph_search_bds_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = graph_search_bds_std(a); let sb = graph_search_bds_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { graph_search_bds_cov(a, b) / (sa * sb) }
}

pub fn graph_search_bds_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = graph_search_bds_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn graph_search_bds_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn graph_search_bds_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn graph_search_bds_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(graph_search_bds_mse(pred, labels))
}

pub fn graph_search_bds_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn graph_search_bds_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = graph_search_bds_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn graph_search_bds_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn graph_search_bds_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn graph_search_bds_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = graph_search_bds_precision(pred, labels, pos); let r = graph_search_bds_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn graph_search_bds_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn graph_search_bds_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = graph_search_bds_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn graph_search_bds_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn graph_search_bds_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn graph_search_bds_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = graph_search_bds_gcd(a, b)
    (a / g) * b
  }
}

pub fn graph_search_bds_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn graph_search_bds_fibonacci(n : Int) -> Int {
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

pub fn graph_search_bds_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = graph_search_bds_min(data); let mx = graph_search_bds_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn graph_search_bds_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = graph_search_bds_mean(data); let sd = graph_search_bds_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn graph_search_bds_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn graph_search_bds_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn graph_search_bds_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn graph_search_bds_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn graph_search_bds_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn graph_search_bds_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GraphsearchbdsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_frame_make(size : Int) -> GraphsearchbdsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_frame_len(s : GraphsearchbdsFrame) -> Int { s.size }

pub fn graph_search_bds_frame_get(s : GraphsearchbdsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_frame_set(s : GraphsearchbdsFrame, i : Int, v : Double) -> GraphsearchbdsFrame {
  let result = graph_search_bds_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_frame_sum(s : GraphsearchbdsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_frame_mean(s : GraphsearchbdsFrame) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_frame_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_frame_scale(s : GraphsearchbdsFrame, f : Double) -> GraphsearchbdsFrame {
  let result = graph_search_bds_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_frame_add(a : GraphsearchbdsFrame, b : GraphsearchbdsFrame) -> GraphsearchbdsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_frame_copy(s : GraphsearchbdsFrame) -> GraphsearchbdsFrame {
  let result = graph_search_bds_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_frame_fill(s : GraphsearchbdsFrame, v : Double) -> GraphsearchbdsFrame {
  let result = graph_search_bds_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_frame_min(s : GraphsearchbdsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_frame_max(s : GraphsearchbdsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_frame_to_string(s : GraphsearchbdsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_table_make(size : Int) -> GraphsearchbdsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_table_len(s : GraphsearchbdsTable) -> Int { s.size }

pub fn graph_search_bds_table_get(s : GraphsearchbdsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_table_set(s : GraphsearchbdsTable, i : Int, v : Double) -> GraphsearchbdsTable {
  let result = graph_search_bds_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_table_sum(s : GraphsearchbdsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_table_mean(s : GraphsearchbdsTable) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_table_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_table_scale(s : GraphsearchbdsTable, f : Double) -> GraphsearchbdsTable {
  let result = graph_search_bds_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_table_add(a : GraphsearchbdsTable, b : GraphsearchbdsTable) -> GraphsearchbdsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_table_copy(s : GraphsearchbdsTable) -> GraphsearchbdsTable {
  let result = graph_search_bds_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_table_fill(s : GraphsearchbdsTable, v : Double) -> GraphsearchbdsTable {
  let result = graph_search_bds_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_table_min(s : GraphsearchbdsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_table_max(s : GraphsearchbdsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_table_to_string(s : GraphsearchbdsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_graphn_make(size : Int) -> GraphsearchbdsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_graphn_len(s : GraphsearchbdsGraphN) -> Int { s.size }

pub fn graph_search_bds_graphn_get(s : GraphsearchbdsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_graphn_set(s : GraphsearchbdsGraphN, i : Int, v : Double) -> GraphsearchbdsGraphN {
  let result = graph_search_bds_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_graphn_sum(s : GraphsearchbdsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_graphn_mean(s : GraphsearchbdsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_graphn_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_graphn_scale(s : GraphsearchbdsGraphN, f : Double) -> GraphsearchbdsGraphN {
  let result = graph_search_bds_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_graphn_add(a : GraphsearchbdsGraphN, b : GraphsearchbdsGraphN) -> GraphsearchbdsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_graphn_copy(s : GraphsearchbdsGraphN) -> GraphsearchbdsGraphN {
  let result = graph_search_bds_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_graphn_fill(s : GraphsearchbdsGraphN, v : Double) -> GraphsearchbdsGraphN {
  let result = graph_search_bds_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_graphn_min(s : GraphsearchbdsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_graphn_max(s : GraphsearchbdsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_graphn_to_string(s : GraphsearchbdsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_node_make(size : Int) -> GraphsearchbdsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_node_len(s : GraphsearchbdsNode) -> Int { s.size }

pub fn graph_search_bds_node_get(s : GraphsearchbdsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_node_set(s : GraphsearchbdsNode, i : Int, v : Double) -> GraphsearchbdsNode {
  let result = graph_search_bds_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_node_sum(s : GraphsearchbdsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_node_mean(s : GraphsearchbdsNode) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_node_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_node_scale(s : GraphsearchbdsNode, f : Double) -> GraphsearchbdsNode {
  let result = graph_search_bds_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_node_add(a : GraphsearchbdsNode, b : GraphsearchbdsNode) -> GraphsearchbdsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_node_copy(s : GraphsearchbdsNode) -> GraphsearchbdsNode {
  let result = graph_search_bds_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_node_fill(s : GraphsearchbdsNode, v : Double) -> GraphsearchbdsNode {
  let result = graph_search_bds_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_node_min(s : GraphsearchbdsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_node_max(s : GraphsearchbdsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_node_to_string(s : GraphsearchbdsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_edge_make(size : Int) -> GraphsearchbdsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_edge_len(s : GraphsearchbdsEdge) -> Int { s.size }

pub fn graph_search_bds_edge_get(s : GraphsearchbdsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_edge_set(s : GraphsearchbdsEdge, i : Int, v : Double) -> GraphsearchbdsEdge {
  let result = graph_search_bds_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_edge_sum(s : GraphsearchbdsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_edge_mean(s : GraphsearchbdsEdge) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_edge_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_edge_scale(s : GraphsearchbdsEdge, f : Double) -> GraphsearchbdsEdge {
  let result = graph_search_bds_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_edge_add(a : GraphsearchbdsEdge, b : GraphsearchbdsEdge) -> GraphsearchbdsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_edge_copy(s : GraphsearchbdsEdge) -> GraphsearchbdsEdge {
  let result = graph_search_bds_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_edge_fill(s : GraphsearchbdsEdge, v : Double) -> GraphsearchbdsEdge {
  let result = graph_search_bds_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_edge_min(s : GraphsearchbdsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_edge_max(s : GraphsearchbdsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_edge_to_string(s : GraphsearchbdsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_path_make(size : Int) -> GraphsearchbdsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_path_len(s : GraphsearchbdsPath) -> Int { s.size }

pub fn graph_search_bds_path_get(s : GraphsearchbdsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_path_set(s : GraphsearchbdsPath, i : Int, v : Double) -> GraphsearchbdsPath {
  let result = graph_search_bds_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_path_sum(s : GraphsearchbdsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_path_mean(s : GraphsearchbdsPath) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_path_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_path_scale(s : GraphsearchbdsPath, f : Double) -> GraphsearchbdsPath {
  let result = graph_search_bds_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_path_add(a : GraphsearchbdsPath, b : GraphsearchbdsPath) -> GraphsearchbdsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_path_copy(s : GraphsearchbdsPath) -> GraphsearchbdsPath {
  let result = graph_search_bds_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_path_fill(s : GraphsearchbdsPath, v : Double) -> GraphsearchbdsPath {
  let result = graph_search_bds_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_path_min(s : GraphsearchbdsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_path_max(s : GraphsearchbdsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_path_to_string(s : GraphsearchbdsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_cluster_make(size : Int) -> GraphsearchbdsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_cluster_len(s : GraphsearchbdsCluster) -> Int { s.size }

pub fn graph_search_bds_cluster_get(s : GraphsearchbdsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_cluster_set(s : GraphsearchbdsCluster, i : Int, v : Double) -> GraphsearchbdsCluster {
  let result = graph_search_bds_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_cluster_sum(s : GraphsearchbdsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_cluster_mean(s : GraphsearchbdsCluster) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_cluster_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_cluster_scale(s : GraphsearchbdsCluster, f : Double) -> GraphsearchbdsCluster {
  let result = graph_search_bds_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_cluster_add(a : GraphsearchbdsCluster, b : GraphsearchbdsCluster) -> GraphsearchbdsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_cluster_copy(s : GraphsearchbdsCluster) -> GraphsearchbdsCluster {
  let result = graph_search_bds_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_cluster_fill(s : GraphsearchbdsCluster, v : Double) -> GraphsearchbdsCluster {
  let result = graph_search_bds_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_cluster_min(s : GraphsearchbdsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_cluster_max(s : GraphsearchbdsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_cluster_to_string(s : GraphsearchbdsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_model_make(size : Int) -> GraphsearchbdsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_model_len(s : GraphsearchbdsModel) -> Int { s.size }

pub fn graph_search_bds_model_get(s : GraphsearchbdsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_model_set(s : GraphsearchbdsModel, i : Int, v : Double) -> GraphsearchbdsModel {
  let result = graph_search_bds_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_model_sum(s : GraphsearchbdsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_model_mean(s : GraphsearchbdsModel) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_model_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_model_scale(s : GraphsearchbdsModel, f : Double) -> GraphsearchbdsModel {
  let result = graph_search_bds_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_model_add(a : GraphsearchbdsModel, b : GraphsearchbdsModel) -> GraphsearchbdsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_model_copy(s : GraphsearchbdsModel) -> GraphsearchbdsModel {
  let result = graph_search_bds_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_model_fill(s : GraphsearchbdsModel, v : Double) -> GraphsearchbdsModel {
  let result = graph_search_bds_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_model_min(s : GraphsearchbdsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_model_max(s : GraphsearchbdsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_model_to_string(s : GraphsearchbdsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_layer_make(size : Int) -> GraphsearchbdsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_layer_len(s : GraphsearchbdsLayer) -> Int { s.size }

pub fn graph_search_bds_layer_get(s : GraphsearchbdsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_layer_set(s : GraphsearchbdsLayer, i : Int, v : Double) -> GraphsearchbdsLayer {
  let result = graph_search_bds_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_layer_sum(s : GraphsearchbdsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_layer_mean(s : GraphsearchbdsLayer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_layer_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_layer_scale(s : GraphsearchbdsLayer, f : Double) -> GraphsearchbdsLayer {
  let result = graph_search_bds_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_layer_add(a : GraphsearchbdsLayer, b : GraphsearchbdsLayer) -> GraphsearchbdsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_layer_copy(s : GraphsearchbdsLayer) -> GraphsearchbdsLayer {
  let result = graph_search_bds_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_layer_fill(s : GraphsearchbdsLayer, v : Double) -> GraphsearchbdsLayer {
  let result = graph_search_bds_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_layer_min(s : GraphsearchbdsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_layer_max(s : GraphsearchbdsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_layer_to_string(s : GraphsearchbdsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_buffer_make(size : Int) -> GraphsearchbdsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_buffer_len(s : GraphsearchbdsBuffer) -> Int { s.size }

pub fn graph_search_bds_buffer_get(s : GraphsearchbdsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_buffer_set(s : GraphsearchbdsBuffer, i : Int, v : Double) -> GraphsearchbdsBuffer {
  let result = graph_search_bds_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_buffer_sum(s : GraphsearchbdsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_buffer_mean(s : GraphsearchbdsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_buffer_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_buffer_scale(s : GraphsearchbdsBuffer, f : Double) -> GraphsearchbdsBuffer {
  let result = graph_search_bds_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_buffer_add(a : GraphsearchbdsBuffer, b : GraphsearchbdsBuffer) -> GraphsearchbdsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_buffer_copy(s : GraphsearchbdsBuffer) -> GraphsearchbdsBuffer {
  let result = graph_search_bds_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_buffer_fill(s : GraphsearchbdsBuffer, v : Double) -> GraphsearchbdsBuffer {
  let result = graph_search_bds_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_buffer_min(s : GraphsearchbdsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_buffer_max(s : GraphsearchbdsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_buffer_to_string(s : GraphsearchbdsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_cursor_make(size : Int) -> GraphsearchbdsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_cursor_len(s : GraphsearchbdsCursor) -> Int { s.size }

pub fn graph_search_bds_cursor_get(s : GraphsearchbdsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_cursor_set(s : GraphsearchbdsCursor, i : Int, v : Double) -> GraphsearchbdsCursor {
  let result = graph_search_bds_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_cursor_sum(s : GraphsearchbdsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_cursor_mean(s : GraphsearchbdsCursor) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_cursor_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_cursor_scale(s : GraphsearchbdsCursor, f : Double) -> GraphsearchbdsCursor {
  let result = graph_search_bds_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_cursor_add(a : GraphsearchbdsCursor, b : GraphsearchbdsCursor) -> GraphsearchbdsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_cursor_copy(s : GraphsearchbdsCursor) -> GraphsearchbdsCursor {
  let result = graph_search_bds_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_cursor_fill(s : GraphsearchbdsCursor, v : Double) -> GraphsearchbdsCursor {
  let result = graph_search_bds_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_cursor_min(s : GraphsearchbdsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_cursor_max(s : GraphsearchbdsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_cursor_to_string(s : GraphsearchbdsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_view_make(size : Int) -> GraphsearchbdsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_view_len(s : GraphsearchbdsView) -> Int { s.size }

pub fn graph_search_bds_view_get(s : GraphsearchbdsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_view_set(s : GraphsearchbdsView, i : Int, v : Double) -> GraphsearchbdsView {
  let result = graph_search_bds_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_view_sum(s : GraphsearchbdsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_view_mean(s : GraphsearchbdsView) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_view_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_view_scale(s : GraphsearchbdsView, f : Double) -> GraphsearchbdsView {
  let result = graph_search_bds_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_view_add(a : GraphsearchbdsView, b : GraphsearchbdsView) -> GraphsearchbdsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_view_copy(s : GraphsearchbdsView) -> GraphsearchbdsView {
  let result = graph_search_bds_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_view_fill(s : GraphsearchbdsView, v : Double) -> GraphsearchbdsView {
  let result = graph_search_bds_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_view_min(s : GraphsearchbdsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_view_max(s : GraphsearchbdsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_view_to_string(s : GraphsearchbdsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_range_make(size : Int) -> GraphsearchbdsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_range_len(s : GraphsearchbdsRange) -> Int { s.size }

pub fn graph_search_bds_range_get(s : GraphsearchbdsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_range_set(s : GraphsearchbdsRange, i : Int, v : Double) -> GraphsearchbdsRange {
  let result = graph_search_bds_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_range_sum(s : GraphsearchbdsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_range_mean(s : GraphsearchbdsRange) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_range_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_range_scale(s : GraphsearchbdsRange, f : Double) -> GraphsearchbdsRange {
  let result = graph_search_bds_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_range_add(a : GraphsearchbdsRange, b : GraphsearchbdsRange) -> GraphsearchbdsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_range_copy(s : GraphsearchbdsRange) -> GraphsearchbdsRange {
  let result = graph_search_bds_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_range_fill(s : GraphsearchbdsRange, v : Double) -> GraphsearchbdsRange {
  let result = graph_search_bds_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_range_min(s : GraphsearchbdsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_range_max(s : GraphsearchbdsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_range_to_string(s : GraphsearchbdsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GraphsearchbdsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn graph_search_bds_slice_make(size : Int) -> GraphsearchbdsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn graph_search_bds_slice_len(s : GraphsearchbdsSlice) -> Int { s.size }

pub fn graph_search_bds_slice_get(s : GraphsearchbdsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn graph_search_bds_slice_set(s : GraphsearchbdsSlice, i : Int, v : Double) -> GraphsearchbdsSlice {
  let result = graph_search_bds_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_slice_sum(s : GraphsearchbdsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn graph_search_bds_slice_mean(s : GraphsearchbdsSlice) -> Double {
  if s.size == 0 { 0.0 } else { graph_search_bds_slice_sum(s) / s.size.to_double() }
}

pub fn graph_search_bds_slice_scale(s : GraphsearchbdsSlice, f : Double) -> GraphsearchbdsSlice {
  let result = graph_search_bds_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn graph_search_bds_slice_add(a : GraphsearchbdsSlice, b : GraphsearchbdsSlice) -> GraphsearchbdsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = graph_search_bds_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn graph_search_bds_slice_copy(s : GraphsearchbdsSlice) -> GraphsearchbdsSlice {
  let result = graph_search_bds_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn graph_search_bds_slice_fill(s : GraphsearchbdsSlice, v : Double) -> GraphsearchbdsSlice {
  let result = graph_search_bds_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn graph_search_bds_slice_min(s : GraphsearchbdsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_slice_max(s : GraphsearchbdsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn graph_search_bds_slice_to_string(s : GraphsearchbdsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

