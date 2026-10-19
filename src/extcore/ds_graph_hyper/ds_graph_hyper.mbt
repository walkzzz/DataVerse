///===
/// extcore/ds_graph_hyper

pub(all) struct DsgraphhyperPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_hyper_make_point(x : Double, y : Double) -> DsgraphhyperPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_hyper_make_point3(x : Double, y : Double, z : Double) -> DsgraphhyperPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_hyper_point_x(pt : DsgraphhyperPoint) -> Double { pt.x }

pub fn ds_graph_hyper_point_y(pt : DsgraphhyperPoint) -> Double { pt.y }

pub fn ds_graph_hyper_point_z(pt : DsgraphhyperPoint) -> Double { pt.z }

pub fn ds_graph_hyper_point_label(pt : DsgraphhyperPoint) -> Int { pt.label }

pub fn ds_graph_hyper_point_dist(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_hyper_point_add(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_hyper_point_sub(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_hyper_point_scale(pt : DsgraphhyperPoint, s : Double) -> DsgraphhyperPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_hyper_point_dot(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_hyper_point_cross(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_hyper_point_norm(pt : DsgraphhyperPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_hyper_point_normalize(pt : DsgraphhyperPoint) -> DsgraphhyperPoint {
  let n = ds_graph_hyper_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_hyper_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_hyper_point_negate(pt : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_hyper_point_mid(a : DsgraphhyperPoint, b : DsgraphhyperPoint) -> DsgraphhyperPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_hyper_point_lerp(a : DsgraphhyperPoint, b : DsgraphhyperPoint, t : Double) -> DsgraphhyperPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_hyper_point_to_string(pt : DsgraphhyperPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphhyperSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_hyper_make_series(vals : Array[Double], name : String) -> DsgraphhyperSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_hyper_series_len(s : DsgraphhyperSeries) -> Int { s.vals.length() }

pub fn ds_graph_hyper_series_sum(s : DsgraphhyperSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_graph_hyper_series_mean(s : DsgraphhyperSeries) -> Double {
  let n = ds_graph_hyper_series_len(s)
  if n == 0 { 0.0 } else { ds_graph_hyper_series_sum(s) / n.to_double() }
}

pub fn ds_graph_hyper_series_min(s : DsgraphhyperSeries) -> Double {
  let n = ds_graph_hyper_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_hyper_series_max(s : DsgraphhyperSeries) -> Double {
  let n = ds_graph_hyper_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_hyper_series_range(s : DsgraphhyperSeries) -> Double {
  ds_graph_hyper_series_max(s) - ds_graph_hyper_series_min(s)
}

pub fn ds_graph_hyper_series_var(s : DsgraphhyperSeries) -> Double {
  let n = ds_graph_hyper_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_graph_hyper_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_graph_hyper_series_std(s : DsgraphhyperSeries) -> Double { @_common.sqrt(ds_graph_hyper_series_var(s)) }

pub fn ds_graph_hyper_series_median(s : DsgraphhyperSeries) -> Double {
  let n = ds_graph_hyper_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_hyper_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_hyper_series_scale(s : DsgraphhyperSeries, f : Double) -> DsgraphhyperSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_graph_hyper_series_add(a : DsgraphhyperSeries, b : DsgraphhyperSeries) -> DsgraphhyperSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_hyper_series_sub(a : DsgraphhyperSeries, b : DsgraphhyperSeries) -> DsgraphhyperSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_hyper_series_normalize(s : DsgraphhyperSeries) -> DsgraphhyperSeries {
  let mn = ds_graph_hyper_series_min(s)
  let mx = ds_graph_hyper_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_hyper_series_cumsum(s : DsgraphhyperSeries) -> DsgraphhyperSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_hyper_series_to_string(s : DsgraphhyperSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphhyperMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_hyper_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphhyperMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_hyper_matrix_identity(n : Int) -> DsgraphhyperMatrix {
  let m = ds_graph_hyper_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_hyper_matrix_get(m : DsgraphhyperMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_hyper_matrix_transpose(m : DsgraphhyperMatrix) -> DsgraphhyperMatrix {
  let result = ds_graph_hyper_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_hyper_matrix_add(a : DsgraphhyperMatrix, b : DsgraphhyperMatrix) -> DsgraphhyperMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_hyper_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_hyper_matrix_scale(m : DsgraphhyperMatrix, s : Double) -> DsgraphhyperMatrix {
  let result = ds_graph_hyper_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_hyper_matrix_multiply(a : DsgraphhyperMatrix, b : DsgraphhyperMatrix) -> DsgraphhyperMatrix {
  if a.cols != b.rows { return ds_graph_hyper_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_hyper_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_hyper_matrix_trace(m : DsgraphhyperMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_hyper_matrix_det(m : DsgraphhyperMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_hyper_matrix_norm(m : DsgraphhyperMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_graph_hyper_matrix_to_string(m : DsgraphhyperMatrix) -> String {
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

pub(all) struct DsgraphhyperVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_hyper_make_vector(comps : Array[Double]) -> DsgraphhyperVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_hyper_vector_zero(dim : Int) -> DsgraphhyperVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_hyper_vector_add(a : DsgraphhyperVector, b : DsgraphhyperVector) -> DsgraphhyperVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_hyper_vector_sub(a : DsgraphhyperVector, b : DsgraphhyperVector) -> DsgraphhyperVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_hyper_vector_scale(v : DsgraphhyperVector, s : Double) -> DsgraphhyperVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_graph_hyper_vector_dot(a : DsgraphhyperVector, b : DsgraphhyperVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_hyper_vector_norm(v : DsgraphhyperVector) -> Double { @_common.sqrt(ds_graph_hyper_vector_dot(v, v)) }

pub fn ds_graph_hyper_vector_normalize(v : DsgraphhyperVector) -> DsgraphhyperVector {
  let n = ds_graph_hyper_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_hyper_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_hyper_vector_dist(a : DsgraphhyperVector, b : DsgraphhyperVector) -> Double {
  ds_graph_hyper_vector_norm(ds_graph_hyper_vector_sub(a, b))
}

pub fn ds_graph_hyper_vector_to_string(v : DsgraphhyperVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_hyper_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_graph_hyper_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_graph_hyper_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_graph_hyper_std(data : Array[Double]) -> Double { @_common.sqrt(ds_graph_hyper_var(data)) }

pub fn ds_graph_hyper_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_graph_hyper_mean(a); let mb = ds_graph_hyper_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_graph_hyper_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_graph_hyper_std(a); let sb = ds_graph_hyper_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_graph_hyper_cov(a, b) / (sa * sb) }
}

pub fn ds_graph_hyper_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_hyper_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_hyper_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_graph_hyper_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_graph_hyper_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ds_graph_hyper_mse(pred, labels))
}

pub fn ds_graph_hyper_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_graph_hyper_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_graph_hyper_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_graph_hyper_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_graph_hyper_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_graph_hyper_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_graph_hyper_precision(pred, labels, pos); let r = ds_graph_hyper_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_graph_hyper_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_graph_hyper_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_graph_hyper_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_graph_hyper_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_graph_hyper_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_graph_hyper_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_graph_hyper_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_graph_hyper_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_graph_hyper_fibonacci(n : Int) -> Int {
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

pub fn ds_graph_hyper_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_graph_hyper_min(data); let mx = ds_graph_hyper_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_graph_hyper_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_graph_hyper_mean(data); let sd = ds_graph_hyper_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_graph_hyper_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_graph_hyper_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_graph_hyper_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_graph_hyper_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_graph_hyper_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_graph_hyper_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DsgraphhyperFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_frame_make(size : Int) -> DsgraphhyperFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_frame_len(s : DsgraphhyperFrame) -> Int { s.size }

pub fn ds_graph_hyper_frame_get(s : DsgraphhyperFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_frame_set(s : DsgraphhyperFrame, i : Int, v : Double) -> DsgraphhyperFrame {
  let result = ds_graph_hyper_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_frame_sum(s : DsgraphhyperFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_frame_mean(s : DsgraphhyperFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_frame_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_frame_scale(s : DsgraphhyperFrame, f : Double) -> DsgraphhyperFrame {
  let result = ds_graph_hyper_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_frame_add(a : DsgraphhyperFrame, b : DsgraphhyperFrame) -> DsgraphhyperFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_frame_copy(s : DsgraphhyperFrame) -> DsgraphhyperFrame {
  let result = ds_graph_hyper_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_frame_fill(s : DsgraphhyperFrame, v : Double) -> DsgraphhyperFrame {
  let result = ds_graph_hyper_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_frame_min(s : DsgraphhyperFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_frame_max(s : DsgraphhyperFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_frame_to_string(s : DsgraphhyperFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_table_make(size : Int) -> DsgraphhyperTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_table_len(s : DsgraphhyperTable) -> Int { s.size }

pub fn ds_graph_hyper_table_get(s : DsgraphhyperTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_table_set(s : DsgraphhyperTable, i : Int, v : Double) -> DsgraphhyperTable {
  let result = ds_graph_hyper_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_table_sum(s : DsgraphhyperTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_table_mean(s : DsgraphhyperTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_table_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_table_scale(s : DsgraphhyperTable, f : Double) -> DsgraphhyperTable {
  let result = ds_graph_hyper_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_table_add(a : DsgraphhyperTable, b : DsgraphhyperTable) -> DsgraphhyperTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_table_copy(s : DsgraphhyperTable) -> DsgraphhyperTable {
  let result = ds_graph_hyper_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_table_fill(s : DsgraphhyperTable, v : Double) -> DsgraphhyperTable {
  let result = ds_graph_hyper_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_table_min(s : DsgraphhyperTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_table_max(s : DsgraphhyperTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_table_to_string(s : DsgraphhyperTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_graphn_make(size : Int) -> DsgraphhyperGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_graphn_len(s : DsgraphhyperGraphN) -> Int { s.size }

pub fn ds_graph_hyper_graphn_get(s : DsgraphhyperGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_graphn_set(s : DsgraphhyperGraphN, i : Int, v : Double) -> DsgraphhyperGraphN {
  let result = ds_graph_hyper_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_graphn_sum(s : DsgraphhyperGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_graphn_mean(s : DsgraphhyperGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_graphn_scale(s : DsgraphhyperGraphN, f : Double) -> DsgraphhyperGraphN {
  let result = ds_graph_hyper_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_graphn_add(a : DsgraphhyperGraphN, b : DsgraphhyperGraphN) -> DsgraphhyperGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_graphn_copy(s : DsgraphhyperGraphN) -> DsgraphhyperGraphN {
  let result = ds_graph_hyper_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_graphn_fill(s : DsgraphhyperGraphN, v : Double) -> DsgraphhyperGraphN {
  let result = ds_graph_hyper_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_graphn_min(s : DsgraphhyperGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_graphn_max(s : DsgraphhyperGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_graphn_to_string(s : DsgraphhyperGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_node_make(size : Int) -> DsgraphhyperNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_node_len(s : DsgraphhyperNode) -> Int { s.size }

pub fn ds_graph_hyper_node_get(s : DsgraphhyperNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_node_set(s : DsgraphhyperNode, i : Int, v : Double) -> DsgraphhyperNode {
  let result = ds_graph_hyper_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_node_sum(s : DsgraphhyperNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_node_mean(s : DsgraphhyperNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_node_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_node_scale(s : DsgraphhyperNode, f : Double) -> DsgraphhyperNode {
  let result = ds_graph_hyper_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_node_add(a : DsgraphhyperNode, b : DsgraphhyperNode) -> DsgraphhyperNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_node_copy(s : DsgraphhyperNode) -> DsgraphhyperNode {
  let result = ds_graph_hyper_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_node_fill(s : DsgraphhyperNode, v : Double) -> DsgraphhyperNode {
  let result = ds_graph_hyper_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_node_min(s : DsgraphhyperNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_node_max(s : DsgraphhyperNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_node_to_string(s : DsgraphhyperNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_edge_make(size : Int) -> DsgraphhyperEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_edge_len(s : DsgraphhyperEdge) -> Int { s.size }

pub fn ds_graph_hyper_edge_get(s : DsgraphhyperEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_edge_set(s : DsgraphhyperEdge, i : Int, v : Double) -> DsgraphhyperEdge {
  let result = ds_graph_hyper_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_edge_sum(s : DsgraphhyperEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_edge_mean(s : DsgraphhyperEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_edge_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_edge_scale(s : DsgraphhyperEdge, f : Double) -> DsgraphhyperEdge {
  let result = ds_graph_hyper_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_edge_add(a : DsgraphhyperEdge, b : DsgraphhyperEdge) -> DsgraphhyperEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_edge_copy(s : DsgraphhyperEdge) -> DsgraphhyperEdge {
  let result = ds_graph_hyper_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_edge_fill(s : DsgraphhyperEdge, v : Double) -> DsgraphhyperEdge {
  let result = ds_graph_hyper_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_edge_min(s : DsgraphhyperEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_edge_max(s : DsgraphhyperEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_edge_to_string(s : DsgraphhyperEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_path_make(size : Int) -> DsgraphhyperPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_path_len(s : DsgraphhyperPath) -> Int { s.size }

pub fn ds_graph_hyper_path_get(s : DsgraphhyperPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_path_set(s : DsgraphhyperPath, i : Int, v : Double) -> DsgraphhyperPath {
  let result = ds_graph_hyper_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_path_sum(s : DsgraphhyperPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_path_mean(s : DsgraphhyperPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_path_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_path_scale(s : DsgraphhyperPath, f : Double) -> DsgraphhyperPath {
  let result = ds_graph_hyper_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_path_add(a : DsgraphhyperPath, b : DsgraphhyperPath) -> DsgraphhyperPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_path_copy(s : DsgraphhyperPath) -> DsgraphhyperPath {
  let result = ds_graph_hyper_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_path_fill(s : DsgraphhyperPath, v : Double) -> DsgraphhyperPath {
  let result = ds_graph_hyper_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_path_min(s : DsgraphhyperPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_path_max(s : DsgraphhyperPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_path_to_string(s : DsgraphhyperPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_cluster_make(size : Int) -> DsgraphhyperCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_cluster_len(s : DsgraphhyperCluster) -> Int { s.size }

pub fn ds_graph_hyper_cluster_get(s : DsgraphhyperCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_cluster_set(s : DsgraphhyperCluster, i : Int, v : Double) -> DsgraphhyperCluster {
  let result = ds_graph_hyper_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_cluster_sum(s : DsgraphhyperCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_cluster_mean(s : DsgraphhyperCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_cluster_scale(s : DsgraphhyperCluster, f : Double) -> DsgraphhyperCluster {
  let result = ds_graph_hyper_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_cluster_add(a : DsgraphhyperCluster, b : DsgraphhyperCluster) -> DsgraphhyperCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_cluster_copy(s : DsgraphhyperCluster) -> DsgraphhyperCluster {
  let result = ds_graph_hyper_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_cluster_fill(s : DsgraphhyperCluster, v : Double) -> DsgraphhyperCluster {
  let result = ds_graph_hyper_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_cluster_min(s : DsgraphhyperCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_cluster_max(s : DsgraphhyperCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_cluster_to_string(s : DsgraphhyperCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_model_make(size : Int) -> DsgraphhyperModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_model_len(s : DsgraphhyperModel) -> Int { s.size }

pub fn ds_graph_hyper_model_get(s : DsgraphhyperModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_model_set(s : DsgraphhyperModel, i : Int, v : Double) -> DsgraphhyperModel {
  let result = ds_graph_hyper_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_model_sum(s : DsgraphhyperModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_model_mean(s : DsgraphhyperModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_model_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_model_scale(s : DsgraphhyperModel, f : Double) -> DsgraphhyperModel {
  let result = ds_graph_hyper_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_model_add(a : DsgraphhyperModel, b : DsgraphhyperModel) -> DsgraphhyperModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_model_copy(s : DsgraphhyperModel) -> DsgraphhyperModel {
  let result = ds_graph_hyper_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_model_fill(s : DsgraphhyperModel, v : Double) -> DsgraphhyperModel {
  let result = ds_graph_hyper_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_model_min(s : DsgraphhyperModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_model_max(s : DsgraphhyperModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_model_to_string(s : DsgraphhyperModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_layer_make(size : Int) -> DsgraphhyperLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_layer_len(s : DsgraphhyperLayer) -> Int { s.size }

pub fn ds_graph_hyper_layer_get(s : DsgraphhyperLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_layer_set(s : DsgraphhyperLayer, i : Int, v : Double) -> DsgraphhyperLayer {
  let result = ds_graph_hyper_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_layer_sum(s : DsgraphhyperLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_layer_mean(s : DsgraphhyperLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_layer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_layer_scale(s : DsgraphhyperLayer, f : Double) -> DsgraphhyperLayer {
  let result = ds_graph_hyper_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_layer_add(a : DsgraphhyperLayer, b : DsgraphhyperLayer) -> DsgraphhyperLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_layer_copy(s : DsgraphhyperLayer) -> DsgraphhyperLayer {
  let result = ds_graph_hyper_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_layer_fill(s : DsgraphhyperLayer, v : Double) -> DsgraphhyperLayer {
  let result = ds_graph_hyper_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_layer_min(s : DsgraphhyperLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_layer_max(s : DsgraphhyperLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_layer_to_string(s : DsgraphhyperLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_buffer_make(size : Int) -> DsgraphhyperBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_buffer_len(s : DsgraphhyperBuffer) -> Int { s.size }

pub fn ds_graph_hyper_buffer_get(s : DsgraphhyperBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_buffer_set(s : DsgraphhyperBuffer, i : Int, v : Double) -> DsgraphhyperBuffer {
  let result = ds_graph_hyper_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_buffer_sum(s : DsgraphhyperBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_buffer_mean(s : DsgraphhyperBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_buffer_scale(s : DsgraphhyperBuffer, f : Double) -> DsgraphhyperBuffer {
  let result = ds_graph_hyper_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_buffer_add(a : DsgraphhyperBuffer, b : DsgraphhyperBuffer) -> DsgraphhyperBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_buffer_copy(s : DsgraphhyperBuffer) -> DsgraphhyperBuffer {
  let result = ds_graph_hyper_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_buffer_fill(s : DsgraphhyperBuffer, v : Double) -> DsgraphhyperBuffer {
  let result = ds_graph_hyper_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_buffer_min(s : DsgraphhyperBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_buffer_max(s : DsgraphhyperBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_buffer_to_string(s : DsgraphhyperBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_cursor_make(size : Int) -> DsgraphhyperCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_cursor_len(s : DsgraphhyperCursor) -> Int { s.size }

pub fn ds_graph_hyper_cursor_get(s : DsgraphhyperCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_cursor_set(s : DsgraphhyperCursor, i : Int, v : Double) -> DsgraphhyperCursor {
  let result = ds_graph_hyper_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_cursor_sum(s : DsgraphhyperCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_cursor_mean(s : DsgraphhyperCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_cursor_scale(s : DsgraphhyperCursor, f : Double) -> DsgraphhyperCursor {
  let result = ds_graph_hyper_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_cursor_add(a : DsgraphhyperCursor, b : DsgraphhyperCursor) -> DsgraphhyperCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_cursor_copy(s : DsgraphhyperCursor) -> DsgraphhyperCursor {
  let result = ds_graph_hyper_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_cursor_fill(s : DsgraphhyperCursor, v : Double) -> DsgraphhyperCursor {
  let result = ds_graph_hyper_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_cursor_min(s : DsgraphhyperCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_cursor_max(s : DsgraphhyperCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_cursor_to_string(s : DsgraphhyperCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_view_make(size : Int) -> DsgraphhyperView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_view_len(s : DsgraphhyperView) -> Int { s.size }

pub fn ds_graph_hyper_view_get(s : DsgraphhyperView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_view_set(s : DsgraphhyperView, i : Int, v : Double) -> DsgraphhyperView {
  let result = ds_graph_hyper_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_view_sum(s : DsgraphhyperView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_view_mean(s : DsgraphhyperView) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_view_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_view_scale(s : DsgraphhyperView, f : Double) -> DsgraphhyperView {
  let result = ds_graph_hyper_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_view_add(a : DsgraphhyperView, b : DsgraphhyperView) -> DsgraphhyperView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_view_copy(s : DsgraphhyperView) -> DsgraphhyperView {
  let result = ds_graph_hyper_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_view_fill(s : DsgraphhyperView, v : Double) -> DsgraphhyperView {
  let result = ds_graph_hyper_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_view_min(s : DsgraphhyperView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_view_max(s : DsgraphhyperView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_view_to_string(s : DsgraphhyperView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_range_make(size : Int) -> DsgraphhyperRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_range_len(s : DsgraphhyperRange) -> Int { s.size }

pub fn ds_graph_hyper_range_get(s : DsgraphhyperRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_range_set(s : DsgraphhyperRange, i : Int, v : Double) -> DsgraphhyperRange {
  let result = ds_graph_hyper_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_range_sum(s : DsgraphhyperRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_range_mean(s : DsgraphhyperRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_range_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_range_scale(s : DsgraphhyperRange, f : Double) -> DsgraphhyperRange {
  let result = ds_graph_hyper_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_range_add(a : DsgraphhyperRange, b : DsgraphhyperRange) -> DsgraphhyperRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_range_copy(s : DsgraphhyperRange) -> DsgraphhyperRange {
  let result = ds_graph_hyper_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_range_fill(s : DsgraphhyperRange, v : Double) -> DsgraphhyperRange {
  let result = ds_graph_hyper_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_range_min(s : DsgraphhyperRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_range_max(s : DsgraphhyperRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_range_to_string(s : DsgraphhyperRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphhyperSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_hyper_slice_make(size : Int) -> DsgraphhyperSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_hyper_slice_len(s : DsgraphhyperSlice) -> Int { s.size }

pub fn ds_graph_hyper_slice_get(s : DsgraphhyperSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_hyper_slice_set(s : DsgraphhyperSlice, i : Int, v : Double) -> DsgraphhyperSlice {
  let result = ds_graph_hyper_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_slice_sum(s : DsgraphhyperSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_hyper_slice_mean(s : DsgraphhyperSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_hyper_slice_sum(s) / s.size.to_double() }
}

pub fn ds_graph_hyper_slice_scale(s : DsgraphhyperSlice, f : Double) -> DsgraphhyperSlice {
  let result = ds_graph_hyper_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_hyper_slice_add(a : DsgraphhyperSlice, b : DsgraphhyperSlice) -> DsgraphhyperSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_hyper_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_hyper_slice_copy(s : DsgraphhyperSlice) -> DsgraphhyperSlice {
  let result = ds_graph_hyper_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_hyper_slice_fill(s : DsgraphhyperSlice, v : Double) -> DsgraphhyperSlice {
  let result = ds_graph_hyper_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_hyper_slice_min(s : DsgraphhyperSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_slice_max(s : DsgraphhyperSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_hyper_slice_to_string(s : DsgraphhyperSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

