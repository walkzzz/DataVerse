///===
/// extcore/ds_graph_edge_list

pub(all) struct DsgraphedgelistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_edge_list_make_point(x : Double, y : Double) -> DsgraphedgelistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_edge_list_make_point3(x : Double, y : Double, z : Double) -> DsgraphedgelistPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_edge_list_point_x(pt : DsgraphedgelistPoint) -> Double { pt.x }

pub fn ds_graph_edge_list_point_y(pt : DsgraphedgelistPoint) -> Double { pt.y }

pub fn ds_graph_edge_list_point_z(pt : DsgraphedgelistPoint) -> Double { pt.z }

pub fn ds_graph_edge_list_point_label(pt : DsgraphedgelistPoint) -> Int { pt.label }

pub fn ds_graph_edge_list_point_dist(a : DsgraphedgelistPoint, b : DsgraphedgelistPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_graph_edge_list_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_edge_list_point_add(a : DsgraphedgelistPoint, b : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_edge_list_point_sub(a : DsgraphedgelistPoint, b : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_edge_list_point_scale(pt : DsgraphedgelistPoint, s : Double) -> DsgraphedgelistPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_edge_list_point_dot(a : DsgraphedgelistPoint, b : DsgraphedgelistPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_edge_list_point_cross(a : DsgraphedgelistPoint, b : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_edge_list_point_norm(pt : DsgraphedgelistPoint) -> Double {
  ds_graph_edge_list_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_edge_list_point_normalize(pt : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  let n = ds_graph_edge_list_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_edge_list_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_edge_list_point_negate(pt : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_edge_list_point_mid(a : DsgraphedgelistPoint, b : DsgraphedgelistPoint) -> DsgraphedgelistPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_edge_list_point_lerp(a : DsgraphedgelistPoint, b : DsgraphedgelistPoint, t : Double) -> DsgraphedgelistPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_edge_list_point_to_string(pt : DsgraphedgelistPoint) -> String {
  "(" + ds_graph_edge_list_dbl(pt.x) + ", " + ds_graph_edge_list_dbl(pt.y) + ", " + ds_graph_edge_list_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphedgelistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_edge_list_make_series(vals : Array[Double], name : String) -> DsgraphedgelistSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_edge_list_series_len(s : DsgraphedgelistSeries) -> Int { s.vals.length() }

pub fn ds_graph_edge_list_series_sum(s : DsgraphedgelistSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_graph_edge_list_series_mean(s : DsgraphedgelistSeries) -> Double {
  let n = ds_graph_edge_list_series_len(s)
  if n == 0 { 0.0 } else { ds_graph_edge_list_series_sum(s) / n.to_double() }
}

pub fn ds_graph_edge_list_series_min(s : DsgraphedgelistSeries) -> Double {
  let n = ds_graph_edge_list_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_edge_list_series_max(s : DsgraphedgelistSeries) -> Double {
  let n = ds_graph_edge_list_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_edge_list_series_range(s : DsgraphedgelistSeries) -> Double {
  ds_graph_edge_list_series_max(s) - ds_graph_edge_list_series_min(s)
}

pub fn ds_graph_edge_list_series_var(s : DsgraphedgelistSeries) -> Double {
  let n = ds_graph_edge_list_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_graph_edge_list_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_graph_edge_list_series_std(s : DsgraphedgelistSeries) -> Double { ds_graph_edge_list_sqrt(ds_graph_edge_list_series_var(s)) }

pub fn ds_graph_edge_list_series_median(s : DsgraphedgelistSeries) -> Double {
  let n = ds_graph_edge_list_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_edge_list_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_edge_list_series_scale(s : DsgraphedgelistSeries, f : Double) -> DsgraphedgelistSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_graph_edge_list_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_graph_edge_list_series_add(a : DsgraphedgelistSeries, b : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_graph_edge_list_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_edge_list_series_sub(a : DsgraphedgelistSeries, b : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_graph_edge_list_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_edge_list_series_normalize(s : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  let mn = ds_graph_edge_list_series_min(s)
  let mx = ds_graph_edge_list_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_graph_edge_list_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_edge_list_series_cumsum(s : DsgraphedgelistSeries) -> DsgraphedgelistSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_graph_edge_list_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_edge_list_series_to_string(s : DsgraphedgelistSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_graph_edge_list_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphedgelistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_edge_list_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphedgelistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_edge_list_matrix_identity(n : Int) -> DsgraphedgelistMatrix {
  let m = ds_graph_edge_list_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_edge_list_matrix_get(m : DsgraphedgelistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_edge_list_matrix_transpose(m : DsgraphedgelistMatrix) -> DsgraphedgelistMatrix {
  let result = ds_graph_edge_list_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_edge_list_matrix_add(a : DsgraphedgelistMatrix, b : DsgraphedgelistMatrix) -> DsgraphedgelistMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_edge_list_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_edge_list_matrix_scale(m : DsgraphedgelistMatrix, s : Double) -> DsgraphedgelistMatrix {
  let result = ds_graph_edge_list_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_edge_list_matrix_multiply(a : DsgraphedgelistMatrix, b : DsgraphedgelistMatrix) -> DsgraphedgelistMatrix {
  if a.cols != b.rows { return ds_graph_edge_list_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_edge_list_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_edge_list_matrix_trace(m : DsgraphedgelistMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_edge_list_matrix_det(m : DsgraphedgelistMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_edge_list_matrix_norm(m : DsgraphedgelistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_graph_edge_list_sqrt(sum)
}

pub fn ds_graph_edge_list_matrix_to_string(m : DsgraphedgelistMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_graph_edge_list_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DsgraphedgelistVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_edge_list_make_vector(comps : Array[Double]) -> DsgraphedgelistVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_edge_list_vector_zero(dim : Int) -> DsgraphedgelistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_edge_list_vector_add(a : DsgraphedgelistVector, b : DsgraphedgelistVector) -> DsgraphedgelistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_graph_edge_list_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_edge_list_vector_sub(a : DsgraphedgelistVector, b : DsgraphedgelistVector) -> DsgraphedgelistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_graph_edge_list_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_edge_list_vector_scale(v : DsgraphedgelistVector, s : Double) -> DsgraphedgelistVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_graph_edge_list_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_graph_edge_list_vector_dot(a : DsgraphedgelistVector, b : DsgraphedgelistVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_edge_list_vector_norm(v : DsgraphedgelistVector) -> Double { ds_graph_edge_list_sqrt(ds_graph_edge_list_vector_dot(v, v)) }

pub fn ds_graph_edge_list_vector_normalize(v : DsgraphedgelistVector) -> DsgraphedgelistVector {
  let n = ds_graph_edge_list_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_edge_list_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_edge_list_vector_dist(a : DsgraphedgelistVector, b : DsgraphedgelistVector) -> Double {
  ds_graph_edge_list_vector_norm(ds_graph_edge_list_vector_sub(a, b))
}

pub fn ds_graph_edge_list_vector_to_string(v : DsgraphedgelistVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_graph_edge_list_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_edge_list_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_graph_edge_list_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_graph_edge_list_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_graph_edge_list_std(data : Array[Double]) -> Double { ds_graph_edge_list_sqrt(ds_graph_edge_list_var(data)) }

pub fn ds_graph_edge_list_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_graph_edge_list_mean(a); let mb = ds_graph_edge_list_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_graph_edge_list_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_graph_edge_list_std(a); let sb = ds_graph_edge_list_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_graph_edge_list_cov(a, b) / (sa * sb) }
}

pub fn ds_graph_edge_list_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_edge_list_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_edge_list_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_graph_edge_list_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_graph_edge_list_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_graph_edge_list_sqrt(ds_graph_edge_list_mse(pred, labels))
}

pub fn ds_graph_edge_list_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_graph_edge_list_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_graph_edge_list_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_graph_edge_list_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_graph_edge_list_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_graph_edge_list_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_graph_edge_list_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_graph_edge_list_precision(pred, labels, pos); let r = ds_graph_edge_list_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_graph_edge_list_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_graph_edge_list_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_graph_edge_list_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_graph_edge_list_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_graph_edge_list_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_graph_edge_list_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_graph_edge_list_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_graph_edge_list_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_graph_edge_list_fibonacci(n : Int) -> Int {
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

pub fn ds_graph_edge_list_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_graph_edge_list_min(data); let mx = ds_graph_edge_list_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_graph_edge_list_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_graph_edge_list_mean(data); let sd = ds_graph_edge_list_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_graph_edge_list_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_graph_edge_list_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_graph_edge_list_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_graph_edge_list_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_graph_edge_list_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_graph_edge_list_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_graph_edge_list_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_graph_edge_list_int(x) } else { -ds_graph_edge_list_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_graph_edge_list_int(f * 1000000.0) } else { ds_graph_edge_list_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_graph_edge_list_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_graph_edge_list_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DsgraphedgelistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_frame_make(size : Int) -> DsgraphedgelistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_frame_len(s : DsgraphedgelistFrame) -> Int { s.size }

pub fn ds_graph_edge_list_frame_get(s : DsgraphedgelistFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_frame_set(s : DsgraphedgelistFrame, i : Int, v : Double) -> DsgraphedgelistFrame {
  let result = ds_graph_edge_list_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_frame_sum(s : DsgraphedgelistFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_frame_mean(s : DsgraphedgelistFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_frame_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_frame_scale(s : DsgraphedgelistFrame, f : Double) -> DsgraphedgelistFrame {
  let result = ds_graph_edge_list_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_frame_add(a : DsgraphedgelistFrame, b : DsgraphedgelistFrame) -> DsgraphedgelistFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_frame_copy(s : DsgraphedgelistFrame) -> DsgraphedgelistFrame {
  let result = ds_graph_edge_list_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_frame_fill(s : DsgraphedgelistFrame, v : Double) -> DsgraphedgelistFrame {
  let result = ds_graph_edge_list_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_frame_min(s : DsgraphedgelistFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_frame_max(s : DsgraphedgelistFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_frame_to_string(s : DsgraphedgelistFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_table_make(size : Int) -> DsgraphedgelistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_table_len(s : DsgraphedgelistTable) -> Int { s.size }

pub fn ds_graph_edge_list_table_get(s : DsgraphedgelistTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_table_set(s : DsgraphedgelistTable, i : Int, v : Double) -> DsgraphedgelistTable {
  let result = ds_graph_edge_list_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_table_sum(s : DsgraphedgelistTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_table_mean(s : DsgraphedgelistTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_table_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_table_scale(s : DsgraphedgelistTable, f : Double) -> DsgraphedgelistTable {
  let result = ds_graph_edge_list_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_table_add(a : DsgraphedgelistTable, b : DsgraphedgelistTable) -> DsgraphedgelistTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_table_copy(s : DsgraphedgelistTable) -> DsgraphedgelistTable {
  let result = ds_graph_edge_list_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_table_fill(s : DsgraphedgelistTable, v : Double) -> DsgraphedgelistTable {
  let result = ds_graph_edge_list_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_table_min(s : DsgraphedgelistTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_table_max(s : DsgraphedgelistTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_table_to_string(s : DsgraphedgelistTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_graphn_make(size : Int) -> DsgraphedgelistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_graphn_len(s : DsgraphedgelistGraphN) -> Int { s.size }

pub fn ds_graph_edge_list_graphn_get(s : DsgraphedgelistGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_graphn_set(s : DsgraphedgelistGraphN, i : Int, v : Double) -> DsgraphedgelistGraphN {
  let result = ds_graph_edge_list_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_graphn_sum(s : DsgraphedgelistGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_graphn_mean(s : DsgraphedgelistGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_graphn_scale(s : DsgraphedgelistGraphN, f : Double) -> DsgraphedgelistGraphN {
  let result = ds_graph_edge_list_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_graphn_add(a : DsgraphedgelistGraphN, b : DsgraphedgelistGraphN) -> DsgraphedgelistGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_graphn_copy(s : DsgraphedgelistGraphN) -> DsgraphedgelistGraphN {
  let result = ds_graph_edge_list_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_graphn_fill(s : DsgraphedgelistGraphN, v : Double) -> DsgraphedgelistGraphN {
  let result = ds_graph_edge_list_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_graphn_min(s : DsgraphedgelistGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_graphn_max(s : DsgraphedgelistGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_graphn_to_string(s : DsgraphedgelistGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_node_make(size : Int) -> DsgraphedgelistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_node_len(s : DsgraphedgelistNode) -> Int { s.size }

pub fn ds_graph_edge_list_node_get(s : DsgraphedgelistNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_node_set(s : DsgraphedgelistNode, i : Int, v : Double) -> DsgraphedgelistNode {
  let result = ds_graph_edge_list_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_node_sum(s : DsgraphedgelistNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_node_mean(s : DsgraphedgelistNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_node_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_node_scale(s : DsgraphedgelistNode, f : Double) -> DsgraphedgelistNode {
  let result = ds_graph_edge_list_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_node_add(a : DsgraphedgelistNode, b : DsgraphedgelistNode) -> DsgraphedgelistNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_node_copy(s : DsgraphedgelistNode) -> DsgraphedgelistNode {
  let result = ds_graph_edge_list_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_node_fill(s : DsgraphedgelistNode, v : Double) -> DsgraphedgelistNode {
  let result = ds_graph_edge_list_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_node_min(s : DsgraphedgelistNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_node_max(s : DsgraphedgelistNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_node_to_string(s : DsgraphedgelistNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_edge_make(size : Int) -> DsgraphedgelistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_edge_len(s : DsgraphedgelistEdge) -> Int { s.size }

pub fn ds_graph_edge_list_edge_get(s : DsgraphedgelistEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_edge_set(s : DsgraphedgelistEdge, i : Int, v : Double) -> DsgraphedgelistEdge {
  let result = ds_graph_edge_list_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_edge_sum(s : DsgraphedgelistEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_edge_mean(s : DsgraphedgelistEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_edge_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_edge_scale(s : DsgraphedgelistEdge, f : Double) -> DsgraphedgelistEdge {
  let result = ds_graph_edge_list_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_edge_add(a : DsgraphedgelistEdge, b : DsgraphedgelistEdge) -> DsgraphedgelistEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_edge_copy(s : DsgraphedgelistEdge) -> DsgraphedgelistEdge {
  let result = ds_graph_edge_list_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_edge_fill(s : DsgraphedgelistEdge, v : Double) -> DsgraphedgelistEdge {
  let result = ds_graph_edge_list_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_edge_min(s : DsgraphedgelistEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_edge_max(s : DsgraphedgelistEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_edge_to_string(s : DsgraphedgelistEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_path_make(size : Int) -> DsgraphedgelistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_path_len(s : DsgraphedgelistPath) -> Int { s.size }

pub fn ds_graph_edge_list_path_get(s : DsgraphedgelistPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_path_set(s : DsgraphedgelistPath, i : Int, v : Double) -> DsgraphedgelistPath {
  let result = ds_graph_edge_list_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_path_sum(s : DsgraphedgelistPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_path_mean(s : DsgraphedgelistPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_path_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_path_scale(s : DsgraphedgelistPath, f : Double) -> DsgraphedgelistPath {
  let result = ds_graph_edge_list_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_path_add(a : DsgraphedgelistPath, b : DsgraphedgelistPath) -> DsgraphedgelistPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_path_copy(s : DsgraphedgelistPath) -> DsgraphedgelistPath {
  let result = ds_graph_edge_list_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_path_fill(s : DsgraphedgelistPath, v : Double) -> DsgraphedgelistPath {
  let result = ds_graph_edge_list_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_path_min(s : DsgraphedgelistPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_path_max(s : DsgraphedgelistPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_path_to_string(s : DsgraphedgelistPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_cluster_make(size : Int) -> DsgraphedgelistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_cluster_len(s : DsgraphedgelistCluster) -> Int { s.size }

pub fn ds_graph_edge_list_cluster_get(s : DsgraphedgelistCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_cluster_set(s : DsgraphedgelistCluster, i : Int, v : Double) -> DsgraphedgelistCluster {
  let result = ds_graph_edge_list_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_cluster_sum(s : DsgraphedgelistCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_cluster_mean(s : DsgraphedgelistCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_cluster_scale(s : DsgraphedgelistCluster, f : Double) -> DsgraphedgelistCluster {
  let result = ds_graph_edge_list_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_cluster_add(a : DsgraphedgelistCluster, b : DsgraphedgelistCluster) -> DsgraphedgelistCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_cluster_copy(s : DsgraphedgelistCluster) -> DsgraphedgelistCluster {
  let result = ds_graph_edge_list_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_cluster_fill(s : DsgraphedgelistCluster, v : Double) -> DsgraphedgelistCluster {
  let result = ds_graph_edge_list_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_cluster_min(s : DsgraphedgelistCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_cluster_max(s : DsgraphedgelistCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_cluster_to_string(s : DsgraphedgelistCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_model_make(size : Int) -> DsgraphedgelistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_model_len(s : DsgraphedgelistModel) -> Int { s.size }

pub fn ds_graph_edge_list_model_get(s : DsgraphedgelistModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_model_set(s : DsgraphedgelistModel, i : Int, v : Double) -> DsgraphedgelistModel {
  let result = ds_graph_edge_list_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_model_sum(s : DsgraphedgelistModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_model_mean(s : DsgraphedgelistModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_model_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_model_scale(s : DsgraphedgelistModel, f : Double) -> DsgraphedgelistModel {
  let result = ds_graph_edge_list_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_model_add(a : DsgraphedgelistModel, b : DsgraphedgelistModel) -> DsgraphedgelistModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_model_copy(s : DsgraphedgelistModel) -> DsgraphedgelistModel {
  let result = ds_graph_edge_list_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_model_fill(s : DsgraphedgelistModel, v : Double) -> DsgraphedgelistModel {
  let result = ds_graph_edge_list_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_model_min(s : DsgraphedgelistModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_model_max(s : DsgraphedgelistModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_model_to_string(s : DsgraphedgelistModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_layer_make(size : Int) -> DsgraphedgelistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_layer_len(s : DsgraphedgelistLayer) -> Int { s.size }

pub fn ds_graph_edge_list_layer_get(s : DsgraphedgelistLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_layer_set(s : DsgraphedgelistLayer, i : Int, v : Double) -> DsgraphedgelistLayer {
  let result = ds_graph_edge_list_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_layer_sum(s : DsgraphedgelistLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_layer_mean(s : DsgraphedgelistLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_layer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_layer_scale(s : DsgraphedgelistLayer, f : Double) -> DsgraphedgelistLayer {
  let result = ds_graph_edge_list_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_layer_add(a : DsgraphedgelistLayer, b : DsgraphedgelistLayer) -> DsgraphedgelistLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_layer_copy(s : DsgraphedgelistLayer) -> DsgraphedgelistLayer {
  let result = ds_graph_edge_list_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_layer_fill(s : DsgraphedgelistLayer, v : Double) -> DsgraphedgelistLayer {
  let result = ds_graph_edge_list_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_layer_min(s : DsgraphedgelistLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_layer_max(s : DsgraphedgelistLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_layer_to_string(s : DsgraphedgelistLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_buffer_make(size : Int) -> DsgraphedgelistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_buffer_len(s : DsgraphedgelistBuffer) -> Int { s.size }

pub fn ds_graph_edge_list_buffer_get(s : DsgraphedgelistBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_buffer_set(s : DsgraphedgelistBuffer, i : Int, v : Double) -> DsgraphedgelistBuffer {
  let result = ds_graph_edge_list_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_buffer_sum(s : DsgraphedgelistBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_buffer_mean(s : DsgraphedgelistBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_buffer_scale(s : DsgraphedgelistBuffer, f : Double) -> DsgraphedgelistBuffer {
  let result = ds_graph_edge_list_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_buffer_add(a : DsgraphedgelistBuffer, b : DsgraphedgelistBuffer) -> DsgraphedgelistBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_buffer_copy(s : DsgraphedgelistBuffer) -> DsgraphedgelistBuffer {
  let result = ds_graph_edge_list_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_buffer_fill(s : DsgraphedgelistBuffer, v : Double) -> DsgraphedgelistBuffer {
  let result = ds_graph_edge_list_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_buffer_min(s : DsgraphedgelistBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_buffer_max(s : DsgraphedgelistBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_buffer_to_string(s : DsgraphedgelistBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_cursor_make(size : Int) -> DsgraphedgelistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_cursor_len(s : DsgraphedgelistCursor) -> Int { s.size }

pub fn ds_graph_edge_list_cursor_get(s : DsgraphedgelistCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_cursor_set(s : DsgraphedgelistCursor, i : Int, v : Double) -> DsgraphedgelistCursor {
  let result = ds_graph_edge_list_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_cursor_sum(s : DsgraphedgelistCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_cursor_mean(s : DsgraphedgelistCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_cursor_scale(s : DsgraphedgelistCursor, f : Double) -> DsgraphedgelistCursor {
  let result = ds_graph_edge_list_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_cursor_add(a : DsgraphedgelistCursor, b : DsgraphedgelistCursor) -> DsgraphedgelistCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_cursor_copy(s : DsgraphedgelistCursor) -> DsgraphedgelistCursor {
  let result = ds_graph_edge_list_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_cursor_fill(s : DsgraphedgelistCursor, v : Double) -> DsgraphedgelistCursor {
  let result = ds_graph_edge_list_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_cursor_min(s : DsgraphedgelistCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_cursor_max(s : DsgraphedgelistCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_cursor_to_string(s : DsgraphedgelistCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_view_make(size : Int) -> DsgraphedgelistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_view_len(s : DsgraphedgelistView) -> Int { s.size }

pub fn ds_graph_edge_list_view_get(s : DsgraphedgelistView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_view_set(s : DsgraphedgelistView, i : Int, v : Double) -> DsgraphedgelistView {
  let result = ds_graph_edge_list_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_view_sum(s : DsgraphedgelistView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_view_mean(s : DsgraphedgelistView) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_view_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_view_scale(s : DsgraphedgelistView, f : Double) -> DsgraphedgelistView {
  let result = ds_graph_edge_list_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_view_add(a : DsgraphedgelistView, b : DsgraphedgelistView) -> DsgraphedgelistView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_view_copy(s : DsgraphedgelistView) -> DsgraphedgelistView {
  let result = ds_graph_edge_list_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_view_fill(s : DsgraphedgelistView, v : Double) -> DsgraphedgelistView {
  let result = ds_graph_edge_list_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_view_min(s : DsgraphedgelistView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_view_max(s : DsgraphedgelistView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_view_to_string(s : DsgraphedgelistView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_range_make(size : Int) -> DsgraphedgelistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_range_len(s : DsgraphedgelistRange) -> Int { s.size }

pub fn ds_graph_edge_list_range_get(s : DsgraphedgelistRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_range_set(s : DsgraphedgelistRange, i : Int, v : Double) -> DsgraphedgelistRange {
  let result = ds_graph_edge_list_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_range_sum(s : DsgraphedgelistRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_range_mean(s : DsgraphedgelistRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_range_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_range_scale(s : DsgraphedgelistRange, f : Double) -> DsgraphedgelistRange {
  let result = ds_graph_edge_list_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_range_add(a : DsgraphedgelistRange, b : DsgraphedgelistRange) -> DsgraphedgelistRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_range_copy(s : DsgraphedgelistRange) -> DsgraphedgelistRange {
  let result = ds_graph_edge_list_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_range_fill(s : DsgraphedgelistRange, v : Double) -> DsgraphedgelistRange {
  let result = ds_graph_edge_list_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_range_min(s : DsgraphedgelistRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_range_max(s : DsgraphedgelistRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_range_to_string(s : DsgraphedgelistRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphedgelistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_edge_list_slice_make(size : Int) -> DsgraphedgelistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_edge_list_slice_len(s : DsgraphedgelistSlice) -> Int { s.size }

pub fn ds_graph_edge_list_slice_get(s : DsgraphedgelistSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_edge_list_slice_set(s : DsgraphedgelistSlice, i : Int, v : Double) -> DsgraphedgelistSlice {
  let result = ds_graph_edge_list_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_slice_sum(s : DsgraphedgelistSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_edge_list_slice_mean(s : DsgraphedgelistSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_edge_list_slice_sum(s) / s.size.to_double() }
}

pub fn ds_graph_edge_list_slice_scale(s : DsgraphedgelistSlice, f : Double) -> DsgraphedgelistSlice {
  let result = ds_graph_edge_list_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_edge_list_slice_add(a : DsgraphedgelistSlice, b : DsgraphedgelistSlice) -> DsgraphedgelistSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_edge_list_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_edge_list_slice_copy(s : DsgraphedgelistSlice) -> DsgraphedgelistSlice {
  let result = ds_graph_edge_list_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_edge_list_slice_fill(s : DsgraphedgelistSlice, v : Double) -> DsgraphedgelistSlice {
  let result = ds_graph_edge_list_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_edge_list_slice_min(s : DsgraphedgelistSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_slice_max(s : DsgraphedgelistSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_edge_list_slice_to_string(s : DsgraphedgelistSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_graph_edge_list_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_edge_list_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

