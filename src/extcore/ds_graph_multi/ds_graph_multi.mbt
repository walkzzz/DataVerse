///===
/// extcore/ds_graph_multi

pub(all) struct DsgraphmultiPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_multi_make_point(x : Double, y : Double) -> DsgraphmultiPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_multi_make_point3(x : Double, y : Double, z : Double) -> DsgraphmultiPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_multi_point_x(pt : DsgraphmultiPoint) -> Double { pt.x }

pub fn ds_graph_multi_point_y(pt : DsgraphmultiPoint) -> Double { pt.y }

pub fn ds_graph_multi_point_z(pt : DsgraphmultiPoint) -> Double { pt.z }

pub fn ds_graph_multi_point_label(pt : DsgraphmultiPoint) -> Int { pt.label }

pub fn ds_graph_multi_point_dist(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_graph_multi_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_multi_point_add(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_multi_point_sub(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_multi_point_scale(pt : DsgraphmultiPoint, s : Double) -> DsgraphmultiPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_multi_point_dot(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_multi_point_cross(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_multi_point_norm(pt : DsgraphmultiPoint) -> Double {
  ds_graph_multi_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_multi_point_normalize(pt : DsgraphmultiPoint) -> DsgraphmultiPoint {
  let n = ds_graph_multi_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_multi_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_multi_point_negate(pt : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_multi_point_mid(a : DsgraphmultiPoint, b : DsgraphmultiPoint) -> DsgraphmultiPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_multi_point_lerp(a : DsgraphmultiPoint, b : DsgraphmultiPoint, t : Double) -> DsgraphmultiPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_multi_point_to_string(pt : DsgraphmultiPoint) -> String {
  "(" + ds_graph_multi_dbl(pt.x) + ", " + ds_graph_multi_dbl(pt.y) + ", " + ds_graph_multi_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphmultiSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_multi_make_series(vals : Array[Double], name : String) -> DsgraphmultiSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_multi_series_len(s : DsgraphmultiSeries) -> Int { s.vals.length() }

pub fn ds_graph_multi_series_sum(s : DsgraphmultiSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_graph_multi_series_mean(s : DsgraphmultiSeries) -> Double {
  let n = ds_graph_multi_series_len(s)
  if n == 0 { 0.0 } else { ds_graph_multi_series_sum(s) / n.to_double() }
}

pub fn ds_graph_multi_series_min(s : DsgraphmultiSeries) -> Double {
  let n = ds_graph_multi_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_multi_series_max(s : DsgraphmultiSeries) -> Double {
  let n = ds_graph_multi_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_multi_series_range(s : DsgraphmultiSeries) -> Double {
  ds_graph_multi_series_max(s) - ds_graph_multi_series_min(s)
}

pub fn ds_graph_multi_series_var(s : DsgraphmultiSeries) -> Double {
  let n = ds_graph_multi_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_graph_multi_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_graph_multi_series_std(s : DsgraphmultiSeries) -> Double { ds_graph_multi_sqrt(ds_graph_multi_series_var(s)) }

pub fn ds_graph_multi_series_median(s : DsgraphmultiSeries) -> Double {
  let n = ds_graph_multi_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_multi_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_multi_series_scale(s : DsgraphmultiSeries, f : Double) -> DsgraphmultiSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_graph_multi_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_graph_multi_series_add(a : DsgraphmultiSeries, b : DsgraphmultiSeries) -> DsgraphmultiSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_graph_multi_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_multi_series_sub(a : DsgraphmultiSeries, b : DsgraphmultiSeries) -> DsgraphmultiSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_graph_multi_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_multi_series_normalize(s : DsgraphmultiSeries) -> DsgraphmultiSeries {
  let mn = ds_graph_multi_series_min(s)
  let mx = ds_graph_multi_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_graph_multi_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_multi_series_cumsum(s : DsgraphmultiSeries) -> DsgraphmultiSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_graph_multi_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_multi_series_to_string(s : DsgraphmultiSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_graph_multi_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphmultiMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_multi_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphmultiMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_multi_matrix_identity(n : Int) -> DsgraphmultiMatrix {
  let m = ds_graph_multi_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_multi_matrix_get(m : DsgraphmultiMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_multi_matrix_transpose(m : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  let result = ds_graph_multi_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_multi_matrix_add(a : DsgraphmultiMatrix, b : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_multi_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_multi_matrix_scale(m : DsgraphmultiMatrix, s : Double) -> DsgraphmultiMatrix {
  let result = ds_graph_multi_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_multi_matrix_multiply(a : DsgraphmultiMatrix, b : DsgraphmultiMatrix) -> DsgraphmultiMatrix {
  if a.cols != b.rows { return ds_graph_multi_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_multi_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_multi_matrix_trace(m : DsgraphmultiMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_multi_matrix_det(m : DsgraphmultiMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_multi_matrix_norm(m : DsgraphmultiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_graph_multi_sqrt(sum)
}

pub fn ds_graph_multi_matrix_to_string(m : DsgraphmultiMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_graph_multi_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DsgraphmultiVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_multi_make_vector(comps : Array[Double]) -> DsgraphmultiVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_multi_vector_zero(dim : Int) -> DsgraphmultiVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_multi_vector_add(a : DsgraphmultiVector, b : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_graph_multi_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_multi_vector_sub(a : DsgraphmultiVector, b : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_graph_multi_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_multi_vector_scale(v : DsgraphmultiVector, s : Double) -> DsgraphmultiVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_graph_multi_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_graph_multi_vector_dot(a : DsgraphmultiVector, b : DsgraphmultiVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_multi_vector_norm(v : DsgraphmultiVector) -> Double { ds_graph_multi_sqrt(ds_graph_multi_vector_dot(v, v)) }

pub fn ds_graph_multi_vector_normalize(v : DsgraphmultiVector) -> DsgraphmultiVector {
  let n = ds_graph_multi_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_multi_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_multi_vector_dist(a : DsgraphmultiVector, b : DsgraphmultiVector) -> Double {
  ds_graph_multi_vector_norm(ds_graph_multi_vector_sub(a, b))
}

pub fn ds_graph_multi_vector_to_string(v : DsgraphmultiVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_graph_multi_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_multi_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_graph_multi_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_graph_multi_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_graph_multi_std(data : Array[Double]) -> Double { ds_graph_multi_sqrt(ds_graph_multi_var(data)) }

pub fn ds_graph_multi_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_graph_multi_mean(a); let mb = ds_graph_multi_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_graph_multi_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_graph_multi_std(a); let sb = ds_graph_multi_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_graph_multi_cov(a, b) / (sa * sb) }
}

pub fn ds_graph_multi_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_multi_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_multi_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_graph_multi_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_graph_multi_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_graph_multi_sqrt(ds_graph_multi_mse(pred, labels))
}

pub fn ds_graph_multi_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_graph_multi_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_graph_multi_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_graph_multi_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_graph_multi_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_graph_multi_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_graph_multi_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_graph_multi_precision(pred, labels, pos); let r = ds_graph_multi_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_graph_multi_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_graph_multi_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_graph_multi_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_graph_multi_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_graph_multi_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_graph_multi_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_graph_multi_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_graph_multi_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_graph_multi_fibonacci(n : Int) -> Int {
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

pub fn ds_graph_multi_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_graph_multi_min(data); let mx = ds_graph_multi_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_graph_multi_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_graph_multi_mean(data); let sd = ds_graph_multi_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_graph_multi_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_graph_multi_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_graph_multi_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_graph_multi_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_graph_multi_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_graph_multi_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_graph_multi_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_graph_multi_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_graph_multi_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_graph_multi_int(x) } else { -ds_graph_multi_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_graph_multi_int(f * 1000000.0) } else { ds_graph_multi_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_graph_multi_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_graph_multi_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DsgraphmultiFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_frame_make(size : Int) -> DsgraphmultiFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_frame_len(s : DsgraphmultiFrame) -> Int { s.size }

pub fn ds_graph_multi_frame_get(s : DsgraphmultiFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_frame_set(s : DsgraphmultiFrame, i : Int, v : Double) -> DsgraphmultiFrame {
  let result = ds_graph_multi_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_frame_sum(s : DsgraphmultiFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_frame_mean(s : DsgraphmultiFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_frame_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_frame_scale(s : DsgraphmultiFrame, f : Double) -> DsgraphmultiFrame {
  let result = ds_graph_multi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_frame_add(a : DsgraphmultiFrame, b : DsgraphmultiFrame) -> DsgraphmultiFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_frame_copy(s : DsgraphmultiFrame) -> DsgraphmultiFrame {
  let result = ds_graph_multi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_frame_fill(s : DsgraphmultiFrame, v : Double) -> DsgraphmultiFrame {
  let result = ds_graph_multi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_frame_min(s : DsgraphmultiFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_frame_max(s : DsgraphmultiFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_frame_to_string(s : DsgraphmultiFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_table_make(size : Int) -> DsgraphmultiTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_table_len(s : DsgraphmultiTable) -> Int { s.size }

pub fn ds_graph_multi_table_get(s : DsgraphmultiTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_table_set(s : DsgraphmultiTable, i : Int, v : Double) -> DsgraphmultiTable {
  let result = ds_graph_multi_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_table_sum(s : DsgraphmultiTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_table_mean(s : DsgraphmultiTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_table_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_table_scale(s : DsgraphmultiTable, f : Double) -> DsgraphmultiTable {
  let result = ds_graph_multi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_table_add(a : DsgraphmultiTable, b : DsgraphmultiTable) -> DsgraphmultiTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_table_copy(s : DsgraphmultiTable) -> DsgraphmultiTable {
  let result = ds_graph_multi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_table_fill(s : DsgraphmultiTable, v : Double) -> DsgraphmultiTable {
  let result = ds_graph_multi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_table_min(s : DsgraphmultiTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_table_max(s : DsgraphmultiTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_table_to_string(s : DsgraphmultiTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_graphn_make(size : Int) -> DsgraphmultiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_graphn_len(s : DsgraphmultiGraphN) -> Int { s.size }

pub fn ds_graph_multi_graphn_get(s : DsgraphmultiGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_graphn_set(s : DsgraphmultiGraphN, i : Int, v : Double) -> DsgraphmultiGraphN {
  let result = ds_graph_multi_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_graphn_sum(s : DsgraphmultiGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_graphn_mean(s : DsgraphmultiGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_graphn_scale(s : DsgraphmultiGraphN, f : Double) -> DsgraphmultiGraphN {
  let result = ds_graph_multi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_graphn_add(a : DsgraphmultiGraphN, b : DsgraphmultiGraphN) -> DsgraphmultiGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_graphn_copy(s : DsgraphmultiGraphN) -> DsgraphmultiGraphN {
  let result = ds_graph_multi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_graphn_fill(s : DsgraphmultiGraphN, v : Double) -> DsgraphmultiGraphN {
  let result = ds_graph_multi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_graphn_min(s : DsgraphmultiGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_graphn_max(s : DsgraphmultiGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_graphn_to_string(s : DsgraphmultiGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_node_make(size : Int) -> DsgraphmultiNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_node_len(s : DsgraphmultiNode) -> Int { s.size }

pub fn ds_graph_multi_node_get(s : DsgraphmultiNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_node_set(s : DsgraphmultiNode, i : Int, v : Double) -> DsgraphmultiNode {
  let result = ds_graph_multi_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_node_sum(s : DsgraphmultiNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_node_mean(s : DsgraphmultiNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_node_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_node_scale(s : DsgraphmultiNode, f : Double) -> DsgraphmultiNode {
  let result = ds_graph_multi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_node_add(a : DsgraphmultiNode, b : DsgraphmultiNode) -> DsgraphmultiNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_node_copy(s : DsgraphmultiNode) -> DsgraphmultiNode {
  let result = ds_graph_multi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_node_fill(s : DsgraphmultiNode, v : Double) -> DsgraphmultiNode {
  let result = ds_graph_multi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_node_min(s : DsgraphmultiNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_node_max(s : DsgraphmultiNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_node_to_string(s : DsgraphmultiNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_edge_make(size : Int) -> DsgraphmultiEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_edge_len(s : DsgraphmultiEdge) -> Int { s.size }

pub fn ds_graph_multi_edge_get(s : DsgraphmultiEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_edge_set(s : DsgraphmultiEdge, i : Int, v : Double) -> DsgraphmultiEdge {
  let result = ds_graph_multi_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_edge_sum(s : DsgraphmultiEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_edge_mean(s : DsgraphmultiEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_edge_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_edge_scale(s : DsgraphmultiEdge, f : Double) -> DsgraphmultiEdge {
  let result = ds_graph_multi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_edge_add(a : DsgraphmultiEdge, b : DsgraphmultiEdge) -> DsgraphmultiEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_edge_copy(s : DsgraphmultiEdge) -> DsgraphmultiEdge {
  let result = ds_graph_multi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_edge_fill(s : DsgraphmultiEdge, v : Double) -> DsgraphmultiEdge {
  let result = ds_graph_multi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_edge_min(s : DsgraphmultiEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_edge_max(s : DsgraphmultiEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_edge_to_string(s : DsgraphmultiEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_path_make(size : Int) -> DsgraphmultiPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_path_len(s : DsgraphmultiPath) -> Int { s.size }

pub fn ds_graph_multi_path_get(s : DsgraphmultiPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_path_set(s : DsgraphmultiPath, i : Int, v : Double) -> DsgraphmultiPath {
  let result = ds_graph_multi_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_path_sum(s : DsgraphmultiPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_path_mean(s : DsgraphmultiPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_path_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_path_scale(s : DsgraphmultiPath, f : Double) -> DsgraphmultiPath {
  let result = ds_graph_multi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_path_add(a : DsgraphmultiPath, b : DsgraphmultiPath) -> DsgraphmultiPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_path_copy(s : DsgraphmultiPath) -> DsgraphmultiPath {
  let result = ds_graph_multi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_path_fill(s : DsgraphmultiPath, v : Double) -> DsgraphmultiPath {
  let result = ds_graph_multi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_path_min(s : DsgraphmultiPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_path_max(s : DsgraphmultiPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_path_to_string(s : DsgraphmultiPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_cluster_make(size : Int) -> DsgraphmultiCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_cluster_len(s : DsgraphmultiCluster) -> Int { s.size }

pub fn ds_graph_multi_cluster_get(s : DsgraphmultiCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_cluster_set(s : DsgraphmultiCluster, i : Int, v : Double) -> DsgraphmultiCluster {
  let result = ds_graph_multi_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_cluster_sum(s : DsgraphmultiCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_cluster_mean(s : DsgraphmultiCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_cluster_scale(s : DsgraphmultiCluster, f : Double) -> DsgraphmultiCluster {
  let result = ds_graph_multi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_cluster_add(a : DsgraphmultiCluster, b : DsgraphmultiCluster) -> DsgraphmultiCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_cluster_copy(s : DsgraphmultiCluster) -> DsgraphmultiCluster {
  let result = ds_graph_multi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_cluster_fill(s : DsgraphmultiCluster, v : Double) -> DsgraphmultiCluster {
  let result = ds_graph_multi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_cluster_min(s : DsgraphmultiCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_cluster_max(s : DsgraphmultiCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_cluster_to_string(s : DsgraphmultiCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_model_make(size : Int) -> DsgraphmultiModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_model_len(s : DsgraphmultiModel) -> Int { s.size }

pub fn ds_graph_multi_model_get(s : DsgraphmultiModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_model_set(s : DsgraphmultiModel, i : Int, v : Double) -> DsgraphmultiModel {
  let result = ds_graph_multi_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_model_sum(s : DsgraphmultiModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_model_mean(s : DsgraphmultiModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_model_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_model_scale(s : DsgraphmultiModel, f : Double) -> DsgraphmultiModel {
  let result = ds_graph_multi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_model_add(a : DsgraphmultiModel, b : DsgraphmultiModel) -> DsgraphmultiModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_model_copy(s : DsgraphmultiModel) -> DsgraphmultiModel {
  let result = ds_graph_multi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_model_fill(s : DsgraphmultiModel, v : Double) -> DsgraphmultiModel {
  let result = ds_graph_multi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_model_min(s : DsgraphmultiModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_model_max(s : DsgraphmultiModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_model_to_string(s : DsgraphmultiModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_layer_make(size : Int) -> DsgraphmultiLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_layer_len(s : DsgraphmultiLayer) -> Int { s.size }

pub fn ds_graph_multi_layer_get(s : DsgraphmultiLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_layer_set(s : DsgraphmultiLayer, i : Int, v : Double) -> DsgraphmultiLayer {
  let result = ds_graph_multi_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_layer_sum(s : DsgraphmultiLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_layer_mean(s : DsgraphmultiLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_layer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_layer_scale(s : DsgraphmultiLayer, f : Double) -> DsgraphmultiLayer {
  let result = ds_graph_multi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_layer_add(a : DsgraphmultiLayer, b : DsgraphmultiLayer) -> DsgraphmultiLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_layer_copy(s : DsgraphmultiLayer) -> DsgraphmultiLayer {
  let result = ds_graph_multi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_layer_fill(s : DsgraphmultiLayer, v : Double) -> DsgraphmultiLayer {
  let result = ds_graph_multi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_layer_min(s : DsgraphmultiLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_layer_max(s : DsgraphmultiLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_layer_to_string(s : DsgraphmultiLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_buffer_make(size : Int) -> DsgraphmultiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_buffer_len(s : DsgraphmultiBuffer) -> Int { s.size }

pub fn ds_graph_multi_buffer_get(s : DsgraphmultiBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_buffer_set(s : DsgraphmultiBuffer, i : Int, v : Double) -> DsgraphmultiBuffer {
  let result = ds_graph_multi_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_buffer_sum(s : DsgraphmultiBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_buffer_mean(s : DsgraphmultiBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_buffer_scale(s : DsgraphmultiBuffer, f : Double) -> DsgraphmultiBuffer {
  let result = ds_graph_multi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_buffer_add(a : DsgraphmultiBuffer, b : DsgraphmultiBuffer) -> DsgraphmultiBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_buffer_copy(s : DsgraphmultiBuffer) -> DsgraphmultiBuffer {
  let result = ds_graph_multi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_buffer_fill(s : DsgraphmultiBuffer, v : Double) -> DsgraphmultiBuffer {
  let result = ds_graph_multi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_buffer_min(s : DsgraphmultiBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_buffer_max(s : DsgraphmultiBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_buffer_to_string(s : DsgraphmultiBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_cursor_make(size : Int) -> DsgraphmultiCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_cursor_len(s : DsgraphmultiCursor) -> Int { s.size }

pub fn ds_graph_multi_cursor_get(s : DsgraphmultiCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_cursor_set(s : DsgraphmultiCursor, i : Int, v : Double) -> DsgraphmultiCursor {
  let result = ds_graph_multi_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_cursor_sum(s : DsgraphmultiCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_cursor_mean(s : DsgraphmultiCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_cursor_scale(s : DsgraphmultiCursor, f : Double) -> DsgraphmultiCursor {
  let result = ds_graph_multi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_cursor_add(a : DsgraphmultiCursor, b : DsgraphmultiCursor) -> DsgraphmultiCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_cursor_copy(s : DsgraphmultiCursor) -> DsgraphmultiCursor {
  let result = ds_graph_multi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_cursor_fill(s : DsgraphmultiCursor, v : Double) -> DsgraphmultiCursor {
  let result = ds_graph_multi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_cursor_min(s : DsgraphmultiCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_cursor_max(s : DsgraphmultiCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_cursor_to_string(s : DsgraphmultiCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_view_make(size : Int) -> DsgraphmultiView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_view_len(s : DsgraphmultiView) -> Int { s.size }

pub fn ds_graph_multi_view_get(s : DsgraphmultiView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_view_set(s : DsgraphmultiView, i : Int, v : Double) -> DsgraphmultiView {
  let result = ds_graph_multi_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_view_sum(s : DsgraphmultiView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_view_mean(s : DsgraphmultiView) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_view_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_view_scale(s : DsgraphmultiView, f : Double) -> DsgraphmultiView {
  let result = ds_graph_multi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_view_add(a : DsgraphmultiView, b : DsgraphmultiView) -> DsgraphmultiView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_view_copy(s : DsgraphmultiView) -> DsgraphmultiView {
  let result = ds_graph_multi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_view_fill(s : DsgraphmultiView, v : Double) -> DsgraphmultiView {
  let result = ds_graph_multi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_view_min(s : DsgraphmultiView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_view_max(s : DsgraphmultiView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_view_to_string(s : DsgraphmultiView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_range_make(size : Int) -> DsgraphmultiRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_range_len(s : DsgraphmultiRange) -> Int { s.size }

pub fn ds_graph_multi_range_get(s : DsgraphmultiRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_range_set(s : DsgraphmultiRange, i : Int, v : Double) -> DsgraphmultiRange {
  let result = ds_graph_multi_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_range_sum(s : DsgraphmultiRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_range_mean(s : DsgraphmultiRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_range_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_range_scale(s : DsgraphmultiRange, f : Double) -> DsgraphmultiRange {
  let result = ds_graph_multi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_range_add(a : DsgraphmultiRange, b : DsgraphmultiRange) -> DsgraphmultiRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_range_copy(s : DsgraphmultiRange) -> DsgraphmultiRange {
  let result = ds_graph_multi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_range_fill(s : DsgraphmultiRange, v : Double) -> DsgraphmultiRange {
  let result = ds_graph_multi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_range_min(s : DsgraphmultiRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_range_max(s : DsgraphmultiRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_range_to_string(s : DsgraphmultiRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphmultiSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_multi_slice_make(size : Int) -> DsgraphmultiSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_multi_slice_len(s : DsgraphmultiSlice) -> Int { s.size }

pub fn ds_graph_multi_slice_get(s : DsgraphmultiSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_multi_slice_set(s : DsgraphmultiSlice, i : Int, v : Double) -> DsgraphmultiSlice {
  let result = ds_graph_multi_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_slice_sum(s : DsgraphmultiSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_multi_slice_mean(s : DsgraphmultiSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_multi_slice_sum(s) / s.size.to_double() }
}

pub fn ds_graph_multi_slice_scale(s : DsgraphmultiSlice, f : Double) -> DsgraphmultiSlice {
  let result = ds_graph_multi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_multi_slice_add(a : DsgraphmultiSlice, b : DsgraphmultiSlice) -> DsgraphmultiSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_multi_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_multi_slice_copy(s : DsgraphmultiSlice) -> DsgraphmultiSlice {
  let result = ds_graph_multi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_multi_slice_fill(s : DsgraphmultiSlice, v : Double) -> DsgraphmultiSlice {
  let result = ds_graph_multi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_multi_slice_min(s : DsgraphmultiSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_slice_max(s : DsgraphmultiSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_multi_slice_to_string(s : DsgraphmultiSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_graph_multi_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_multi_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

