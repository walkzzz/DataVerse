///===
/// extcore/ds_graph_weighted

pub(all) struct DsgraphweightedPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_graph_weighted_make_point(x : Double, y : Double) -> DsgraphweightedPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_graph_weighted_make_point3(x : Double, y : Double, z : Double) -> DsgraphweightedPoint {
  { x, y, z, label: 0 }
}

pub fn ds_graph_weighted_point_x(pt : DsgraphweightedPoint) -> Double { pt.x }

pub fn ds_graph_weighted_point_y(pt : DsgraphweightedPoint) -> Double { pt.y }

pub fn ds_graph_weighted_point_z(pt : DsgraphweightedPoint) -> Double { pt.z }

pub fn ds_graph_weighted_point_label(pt : DsgraphweightedPoint) -> Int { pt.label }

pub fn ds_graph_weighted_point_dist(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  ds_graph_weighted_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_graph_weighted_point_add(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_graph_weighted_point_sub(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_graph_weighted_point_scale(pt : DsgraphweightedPoint, s : Double) -> DsgraphweightedPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_graph_weighted_point_dot(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_graph_weighted_point_cross(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_graph_weighted_point_norm(pt : DsgraphweightedPoint) -> Double {
  ds_graph_weighted_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_graph_weighted_point_normalize(pt : DsgraphweightedPoint) -> DsgraphweightedPoint {
  let n = ds_graph_weighted_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_graph_weighted_point_scale(pt, 1.0 / n) }
}

pub fn ds_graph_weighted_point_negate(pt : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_graph_weighted_point_mid(a : DsgraphweightedPoint, b : DsgraphweightedPoint) -> DsgraphweightedPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_graph_weighted_point_lerp(a : DsgraphweightedPoint, b : DsgraphweightedPoint, t : Double) -> DsgraphweightedPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_graph_weighted_point_to_string(pt : DsgraphweightedPoint) -> String {
  "(" + ds_graph_weighted_dbl(pt.x) + ", " + ds_graph_weighted_dbl(pt.y) + ", " + ds_graph_weighted_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DsgraphweightedSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_graph_weighted_make_series(vals : Array[Double], name : String) -> DsgraphweightedSeries {
  { vals, name, meta: 0 }
}

pub fn ds_graph_weighted_series_len(s : DsgraphweightedSeries) -> Int { s.vals.length() }

pub fn ds_graph_weighted_series_sum(s : DsgraphweightedSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_graph_weighted_series_mean(s : DsgraphweightedSeries) -> Double {
  let n = ds_graph_weighted_series_len(s)
  if n == 0 { 0.0 } else { ds_graph_weighted_series_sum(s) / n.to_double() }
}

pub fn ds_graph_weighted_series_min(s : DsgraphweightedSeries) -> Double {
  let n = ds_graph_weighted_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_weighted_series_max(s : DsgraphweightedSeries) -> Double {
  let n = ds_graph_weighted_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_graph_weighted_series_range(s : DsgraphweightedSeries) -> Double {
  ds_graph_weighted_series_max(s) - ds_graph_weighted_series_min(s)
}

pub fn ds_graph_weighted_series_var(s : DsgraphweightedSeries) -> Double {
  let n = ds_graph_weighted_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_graph_weighted_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_graph_weighted_series_std(s : DsgraphweightedSeries) -> Double { ds_graph_weighted_sqrt(ds_graph_weighted_series_var(s)) }

pub fn ds_graph_weighted_series_median(s : DsgraphweightedSeries) -> Double {
  let n = ds_graph_weighted_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_weighted_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_weighted_series_scale(s : DsgraphweightedSeries, f : Double) -> DsgraphweightedSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = ds_graph_weighted_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_graph_weighted_series_add(a : DsgraphweightedSeries, b : DsgraphweightedSeries) -> DsgraphweightedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_graph_weighted_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_graph_weighted_series_sub(a : DsgraphweightedSeries, b : DsgraphweightedSeries) -> DsgraphweightedSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = ds_graph_weighted_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_graph_weighted_series_normalize(s : DsgraphweightedSeries) -> DsgraphweightedSeries {
  let mn = ds_graph_weighted_series_min(s)
  let mx = ds_graph_weighted_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = ds_graph_weighted_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_graph_weighted_series_cumsum(s : DsgraphweightedSeries) -> DsgraphweightedSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = ds_graph_weighted_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_graph_weighted_series_to_string(s : DsgraphweightedSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_graph_weighted_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DsgraphweightedMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_graph_weighted_make_matrix(rows : Int, cols : Int, val : Double) -> DsgraphweightedMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_graph_weighted_matrix_identity(n : Int) -> DsgraphweightedMatrix {
  let m = ds_graph_weighted_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_graph_weighted_matrix_get(m : DsgraphweightedMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_graph_weighted_matrix_transpose(m : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  let result = ds_graph_weighted_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_graph_weighted_matrix_add(a : DsgraphweightedMatrix, b : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_graph_weighted_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_graph_weighted_matrix_scale(m : DsgraphweightedMatrix, s : Double) -> DsgraphweightedMatrix {
  let result = ds_graph_weighted_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_graph_weighted_matrix_multiply(a : DsgraphweightedMatrix, b : DsgraphweightedMatrix) -> DsgraphweightedMatrix {
  if a.cols != b.rows { return ds_graph_weighted_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_graph_weighted_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_graph_weighted_matrix_trace(m : DsgraphweightedMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_graph_weighted_matrix_det(m : DsgraphweightedMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_graph_weighted_matrix_norm(m : DsgraphweightedMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  ds_graph_weighted_sqrt(sum)
}

pub fn ds_graph_weighted_matrix_to_string(m : DsgraphweightedMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + ds_graph_weighted_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DsgraphweightedVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_graph_weighted_make_vector(comps : Array[Double]) -> DsgraphweightedVector {
  { comps, dim: comps.length() }
}

pub fn ds_graph_weighted_vector_zero(dim : Int) -> DsgraphweightedVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_graph_weighted_vector_add(a : DsgraphweightedVector, b : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_graph_weighted_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_weighted_vector_sub(a : DsgraphweightedVector, b : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = ds_graph_weighted_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_graph_weighted_vector_scale(v : DsgraphweightedVector, s : Double) -> DsgraphweightedVector {
  let mut result = []
  for i in 0..<v.dim { result = ds_graph_weighted_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_graph_weighted_vector_dot(a : DsgraphweightedVector, b : DsgraphweightedVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_graph_weighted_vector_norm(v : DsgraphweightedVector) -> Double { ds_graph_weighted_sqrt(ds_graph_weighted_vector_dot(v, v)) }

pub fn ds_graph_weighted_vector_normalize(v : DsgraphweightedVector) -> DsgraphweightedVector {
  let n = ds_graph_weighted_vector_norm(v)
  if n < 0.0000001 { v } else { ds_graph_weighted_vector_scale(v, 1.0 / n) }
}

pub fn ds_graph_weighted_vector_dist(a : DsgraphweightedVector, b : DsgraphweightedVector) -> Double {
  ds_graph_weighted_vector_norm(ds_graph_weighted_vector_sub(a, b))
}

pub fn ds_graph_weighted_vector_to_string(v : DsgraphweightedVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + ds_graph_weighted_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_graph_weighted_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_graph_weighted_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_graph_weighted_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_graph_weighted_std(data : Array[Double]) -> Double { ds_graph_weighted_sqrt(ds_graph_weighted_var(data)) }

pub fn ds_graph_weighted_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_graph_weighted_mean(a); let mb = ds_graph_weighted_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_graph_weighted_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_graph_weighted_std(a); let sb = ds_graph_weighted_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_graph_weighted_cov(a, b) / (sa * sb) }
}

pub fn ds_graph_weighted_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_graph_weighted_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_graph_weighted_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_graph_weighted_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_graph_weighted_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  ds_graph_weighted_sqrt(ds_graph_weighted_mse(pred, labels))
}

pub fn ds_graph_weighted_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + ds_graph_weighted_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_graph_weighted_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_graph_weighted_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_graph_weighted_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_graph_weighted_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_graph_weighted_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_graph_weighted_precision(pred, labels, pos); let r = ds_graph_weighted_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_graph_weighted_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_graph_weighted_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_graph_weighted_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_graph_weighted_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_graph_weighted_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_graph_weighted_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_graph_weighted_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_graph_weighted_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_graph_weighted_fibonacci(n : Int) -> Int {
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

pub fn ds_graph_weighted_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_graph_weighted_min(data); let mx = ds_graph_weighted_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_graph_weighted_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_graph_weighted_mean(data); let sd = ds_graph_weighted_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_graph_weighted_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_graph_weighted_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_graph_weighted_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_graph_weighted_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_graph_weighted_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_graph_weighted_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn ds_graph_weighted_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn ds_graph_weighted_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn ds_graph_weighted_dbl(x : Double) -> String {
  let i = if x >= 0.0 { ds_graph_weighted_int(x) } else { -ds_graph_weighted_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { ds_graph_weighted_int(f * 1000000.0) } else { ds_graph_weighted_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn ds_graph_weighted_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn ds_graph_weighted_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DsgraphweightedFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_frame_make(size : Int) -> DsgraphweightedFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_frame_len(s : DsgraphweightedFrame) -> Int { s.size }

pub fn ds_graph_weighted_frame_get(s : DsgraphweightedFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_frame_set(s : DsgraphweightedFrame, i : Int, v : Double) -> DsgraphweightedFrame {
  let result = ds_graph_weighted_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_frame_sum(s : DsgraphweightedFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_frame_mean(s : DsgraphweightedFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_frame_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_frame_scale(s : DsgraphweightedFrame, f : Double) -> DsgraphweightedFrame {
  let result = ds_graph_weighted_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_frame_add(a : DsgraphweightedFrame, b : DsgraphweightedFrame) -> DsgraphweightedFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_frame_copy(s : DsgraphweightedFrame) -> DsgraphweightedFrame {
  let result = ds_graph_weighted_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_frame_fill(s : DsgraphweightedFrame, v : Double) -> DsgraphweightedFrame {
  let result = ds_graph_weighted_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_frame_min(s : DsgraphweightedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_frame_max(s : DsgraphweightedFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_frame_to_string(s : DsgraphweightedFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_table_make(size : Int) -> DsgraphweightedTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_table_len(s : DsgraphweightedTable) -> Int { s.size }

pub fn ds_graph_weighted_table_get(s : DsgraphweightedTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_table_set(s : DsgraphweightedTable, i : Int, v : Double) -> DsgraphweightedTable {
  let result = ds_graph_weighted_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_table_sum(s : DsgraphweightedTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_table_mean(s : DsgraphweightedTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_table_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_table_scale(s : DsgraphweightedTable, f : Double) -> DsgraphweightedTable {
  let result = ds_graph_weighted_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_table_add(a : DsgraphweightedTable, b : DsgraphweightedTable) -> DsgraphweightedTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_table_copy(s : DsgraphweightedTable) -> DsgraphweightedTable {
  let result = ds_graph_weighted_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_table_fill(s : DsgraphweightedTable, v : Double) -> DsgraphweightedTable {
  let result = ds_graph_weighted_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_table_min(s : DsgraphweightedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_table_max(s : DsgraphweightedTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_table_to_string(s : DsgraphweightedTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_graphn_make(size : Int) -> DsgraphweightedGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_graphn_len(s : DsgraphweightedGraphN) -> Int { s.size }

pub fn ds_graph_weighted_graphn_get(s : DsgraphweightedGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_graphn_set(s : DsgraphweightedGraphN, i : Int, v : Double) -> DsgraphweightedGraphN {
  let result = ds_graph_weighted_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_graphn_sum(s : DsgraphweightedGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_graphn_mean(s : DsgraphweightedGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_graphn_scale(s : DsgraphweightedGraphN, f : Double) -> DsgraphweightedGraphN {
  let result = ds_graph_weighted_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_graphn_add(a : DsgraphweightedGraphN, b : DsgraphweightedGraphN) -> DsgraphweightedGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_graphn_copy(s : DsgraphweightedGraphN) -> DsgraphweightedGraphN {
  let result = ds_graph_weighted_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_graphn_fill(s : DsgraphweightedGraphN, v : Double) -> DsgraphweightedGraphN {
  let result = ds_graph_weighted_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_graphn_min(s : DsgraphweightedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_graphn_max(s : DsgraphweightedGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_graphn_to_string(s : DsgraphweightedGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_node_make(size : Int) -> DsgraphweightedNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_node_len(s : DsgraphweightedNode) -> Int { s.size }

pub fn ds_graph_weighted_node_get(s : DsgraphweightedNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_node_set(s : DsgraphweightedNode, i : Int, v : Double) -> DsgraphweightedNode {
  let result = ds_graph_weighted_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_node_sum(s : DsgraphweightedNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_node_mean(s : DsgraphweightedNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_node_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_node_scale(s : DsgraphweightedNode, f : Double) -> DsgraphweightedNode {
  let result = ds_graph_weighted_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_node_add(a : DsgraphweightedNode, b : DsgraphweightedNode) -> DsgraphweightedNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_node_copy(s : DsgraphweightedNode) -> DsgraphweightedNode {
  let result = ds_graph_weighted_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_node_fill(s : DsgraphweightedNode, v : Double) -> DsgraphweightedNode {
  let result = ds_graph_weighted_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_node_min(s : DsgraphweightedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_node_max(s : DsgraphweightedNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_node_to_string(s : DsgraphweightedNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_edge_make(size : Int) -> DsgraphweightedEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_edge_len(s : DsgraphweightedEdge) -> Int { s.size }

pub fn ds_graph_weighted_edge_get(s : DsgraphweightedEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_edge_set(s : DsgraphweightedEdge, i : Int, v : Double) -> DsgraphweightedEdge {
  let result = ds_graph_weighted_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_edge_sum(s : DsgraphweightedEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_edge_mean(s : DsgraphweightedEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_edge_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_edge_scale(s : DsgraphweightedEdge, f : Double) -> DsgraphweightedEdge {
  let result = ds_graph_weighted_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_edge_add(a : DsgraphweightedEdge, b : DsgraphweightedEdge) -> DsgraphweightedEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_edge_copy(s : DsgraphweightedEdge) -> DsgraphweightedEdge {
  let result = ds_graph_weighted_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_edge_fill(s : DsgraphweightedEdge, v : Double) -> DsgraphweightedEdge {
  let result = ds_graph_weighted_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_edge_min(s : DsgraphweightedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_edge_max(s : DsgraphweightedEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_edge_to_string(s : DsgraphweightedEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_path_make(size : Int) -> DsgraphweightedPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_path_len(s : DsgraphweightedPath) -> Int { s.size }

pub fn ds_graph_weighted_path_get(s : DsgraphweightedPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_path_set(s : DsgraphweightedPath, i : Int, v : Double) -> DsgraphweightedPath {
  let result = ds_graph_weighted_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_path_sum(s : DsgraphweightedPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_path_mean(s : DsgraphweightedPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_path_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_path_scale(s : DsgraphweightedPath, f : Double) -> DsgraphweightedPath {
  let result = ds_graph_weighted_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_path_add(a : DsgraphweightedPath, b : DsgraphweightedPath) -> DsgraphweightedPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_path_copy(s : DsgraphweightedPath) -> DsgraphweightedPath {
  let result = ds_graph_weighted_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_path_fill(s : DsgraphweightedPath, v : Double) -> DsgraphweightedPath {
  let result = ds_graph_weighted_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_path_min(s : DsgraphweightedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_path_max(s : DsgraphweightedPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_path_to_string(s : DsgraphweightedPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_cluster_make(size : Int) -> DsgraphweightedCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_cluster_len(s : DsgraphweightedCluster) -> Int { s.size }

pub fn ds_graph_weighted_cluster_get(s : DsgraphweightedCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_cluster_set(s : DsgraphweightedCluster, i : Int, v : Double) -> DsgraphweightedCluster {
  let result = ds_graph_weighted_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_cluster_sum(s : DsgraphweightedCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_cluster_mean(s : DsgraphweightedCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_cluster_scale(s : DsgraphweightedCluster, f : Double) -> DsgraphweightedCluster {
  let result = ds_graph_weighted_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_cluster_add(a : DsgraphweightedCluster, b : DsgraphweightedCluster) -> DsgraphweightedCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_cluster_copy(s : DsgraphweightedCluster) -> DsgraphweightedCluster {
  let result = ds_graph_weighted_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_cluster_fill(s : DsgraphweightedCluster, v : Double) -> DsgraphweightedCluster {
  let result = ds_graph_weighted_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_cluster_min(s : DsgraphweightedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_cluster_max(s : DsgraphweightedCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_cluster_to_string(s : DsgraphweightedCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_model_make(size : Int) -> DsgraphweightedModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_model_len(s : DsgraphweightedModel) -> Int { s.size }

pub fn ds_graph_weighted_model_get(s : DsgraphweightedModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_model_set(s : DsgraphweightedModel, i : Int, v : Double) -> DsgraphweightedModel {
  let result = ds_graph_weighted_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_model_sum(s : DsgraphweightedModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_model_mean(s : DsgraphweightedModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_model_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_model_scale(s : DsgraphweightedModel, f : Double) -> DsgraphweightedModel {
  let result = ds_graph_weighted_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_model_add(a : DsgraphweightedModel, b : DsgraphweightedModel) -> DsgraphweightedModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_model_copy(s : DsgraphweightedModel) -> DsgraphweightedModel {
  let result = ds_graph_weighted_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_model_fill(s : DsgraphweightedModel, v : Double) -> DsgraphweightedModel {
  let result = ds_graph_weighted_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_model_min(s : DsgraphweightedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_model_max(s : DsgraphweightedModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_model_to_string(s : DsgraphweightedModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_layer_make(size : Int) -> DsgraphweightedLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_layer_len(s : DsgraphweightedLayer) -> Int { s.size }

pub fn ds_graph_weighted_layer_get(s : DsgraphweightedLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_layer_set(s : DsgraphweightedLayer, i : Int, v : Double) -> DsgraphweightedLayer {
  let result = ds_graph_weighted_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_layer_sum(s : DsgraphweightedLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_layer_mean(s : DsgraphweightedLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_layer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_layer_scale(s : DsgraphweightedLayer, f : Double) -> DsgraphweightedLayer {
  let result = ds_graph_weighted_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_layer_add(a : DsgraphweightedLayer, b : DsgraphweightedLayer) -> DsgraphweightedLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_layer_copy(s : DsgraphweightedLayer) -> DsgraphweightedLayer {
  let result = ds_graph_weighted_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_layer_fill(s : DsgraphweightedLayer, v : Double) -> DsgraphweightedLayer {
  let result = ds_graph_weighted_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_layer_min(s : DsgraphweightedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_layer_max(s : DsgraphweightedLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_layer_to_string(s : DsgraphweightedLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_buffer_make(size : Int) -> DsgraphweightedBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_buffer_len(s : DsgraphweightedBuffer) -> Int { s.size }

pub fn ds_graph_weighted_buffer_get(s : DsgraphweightedBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_buffer_set(s : DsgraphweightedBuffer, i : Int, v : Double) -> DsgraphweightedBuffer {
  let result = ds_graph_weighted_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_buffer_sum(s : DsgraphweightedBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_buffer_mean(s : DsgraphweightedBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_buffer_scale(s : DsgraphweightedBuffer, f : Double) -> DsgraphweightedBuffer {
  let result = ds_graph_weighted_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_buffer_add(a : DsgraphweightedBuffer, b : DsgraphweightedBuffer) -> DsgraphweightedBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_buffer_copy(s : DsgraphweightedBuffer) -> DsgraphweightedBuffer {
  let result = ds_graph_weighted_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_buffer_fill(s : DsgraphweightedBuffer, v : Double) -> DsgraphweightedBuffer {
  let result = ds_graph_weighted_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_buffer_min(s : DsgraphweightedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_buffer_max(s : DsgraphweightedBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_buffer_to_string(s : DsgraphweightedBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_cursor_make(size : Int) -> DsgraphweightedCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_cursor_len(s : DsgraphweightedCursor) -> Int { s.size }

pub fn ds_graph_weighted_cursor_get(s : DsgraphweightedCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_cursor_set(s : DsgraphweightedCursor, i : Int, v : Double) -> DsgraphweightedCursor {
  let result = ds_graph_weighted_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_cursor_sum(s : DsgraphweightedCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_cursor_mean(s : DsgraphweightedCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_cursor_scale(s : DsgraphweightedCursor, f : Double) -> DsgraphweightedCursor {
  let result = ds_graph_weighted_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_cursor_add(a : DsgraphweightedCursor, b : DsgraphweightedCursor) -> DsgraphweightedCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_cursor_copy(s : DsgraphweightedCursor) -> DsgraphweightedCursor {
  let result = ds_graph_weighted_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_cursor_fill(s : DsgraphweightedCursor, v : Double) -> DsgraphweightedCursor {
  let result = ds_graph_weighted_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_cursor_min(s : DsgraphweightedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_cursor_max(s : DsgraphweightedCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_cursor_to_string(s : DsgraphweightedCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_view_make(size : Int) -> DsgraphweightedView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_view_len(s : DsgraphweightedView) -> Int { s.size }

pub fn ds_graph_weighted_view_get(s : DsgraphweightedView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_view_set(s : DsgraphweightedView, i : Int, v : Double) -> DsgraphweightedView {
  let result = ds_graph_weighted_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_view_sum(s : DsgraphweightedView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_view_mean(s : DsgraphweightedView) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_view_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_view_scale(s : DsgraphweightedView, f : Double) -> DsgraphweightedView {
  let result = ds_graph_weighted_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_view_add(a : DsgraphweightedView, b : DsgraphweightedView) -> DsgraphweightedView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_view_copy(s : DsgraphweightedView) -> DsgraphweightedView {
  let result = ds_graph_weighted_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_view_fill(s : DsgraphweightedView, v : Double) -> DsgraphweightedView {
  let result = ds_graph_weighted_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_view_min(s : DsgraphweightedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_view_max(s : DsgraphweightedView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_view_to_string(s : DsgraphweightedView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_range_make(size : Int) -> DsgraphweightedRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_range_len(s : DsgraphweightedRange) -> Int { s.size }

pub fn ds_graph_weighted_range_get(s : DsgraphweightedRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_range_set(s : DsgraphweightedRange, i : Int, v : Double) -> DsgraphweightedRange {
  let result = ds_graph_weighted_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_range_sum(s : DsgraphweightedRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_range_mean(s : DsgraphweightedRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_range_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_range_scale(s : DsgraphweightedRange, f : Double) -> DsgraphweightedRange {
  let result = ds_graph_weighted_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_range_add(a : DsgraphweightedRange, b : DsgraphweightedRange) -> DsgraphweightedRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_range_copy(s : DsgraphweightedRange) -> DsgraphweightedRange {
  let result = ds_graph_weighted_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_range_fill(s : DsgraphweightedRange, v : Double) -> DsgraphweightedRange {
  let result = ds_graph_weighted_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_range_min(s : DsgraphweightedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_range_max(s : DsgraphweightedRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_range_to_string(s : DsgraphweightedRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DsgraphweightedSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_graph_weighted_slice_make(size : Int) -> DsgraphweightedSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_graph_weighted_slice_len(s : DsgraphweightedSlice) -> Int { s.size }

pub fn ds_graph_weighted_slice_get(s : DsgraphweightedSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_graph_weighted_slice_set(s : DsgraphweightedSlice, i : Int, v : Double) -> DsgraphweightedSlice {
  let result = ds_graph_weighted_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_slice_sum(s : DsgraphweightedSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_graph_weighted_slice_mean(s : DsgraphweightedSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_graph_weighted_slice_sum(s) / s.size.to_double() }
}

pub fn ds_graph_weighted_slice_scale(s : DsgraphweightedSlice, f : Double) -> DsgraphweightedSlice {
  let result = ds_graph_weighted_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_graph_weighted_slice_add(a : DsgraphweightedSlice, b : DsgraphweightedSlice) -> DsgraphweightedSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_graph_weighted_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_graph_weighted_slice_copy(s : DsgraphweightedSlice) -> DsgraphweightedSlice {
  let result = ds_graph_weighted_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_graph_weighted_slice_fill(s : DsgraphweightedSlice, v : Double) -> DsgraphweightedSlice {
  let result = ds_graph_weighted_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_graph_weighted_slice_min(s : DsgraphweightedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_slice_max(s : DsgraphweightedSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_graph_weighted_slice_to_string(s : DsgraphweightedSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn ds_graph_weighted_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn ds_graph_weighted_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

