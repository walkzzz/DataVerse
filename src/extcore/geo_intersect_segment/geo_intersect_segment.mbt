///===
/// extcore/geo_intersect_segment

pub(all) struct GeointersectsegmentPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_intersect_segment_make_point(x : Double, y : Double) -> GeointersectsegmentPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_intersect_segment_make_point3(x : Double, y : Double, z : Double) -> GeointersectsegmentPoint {
  { x, y, z, label: 0 }
}

pub fn geo_intersect_segment_point_x(pt : GeointersectsegmentPoint) -> Double { pt.x }

pub fn geo_intersect_segment_point_y(pt : GeointersectsegmentPoint) -> Double { pt.y }

pub fn geo_intersect_segment_point_z(pt : GeointersectsegmentPoint) -> Double { pt.z }

pub fn geo_intersect_segment_point_label(pt : GeointersectsegmentPoint) -> Int { pt.label }

pub fn geo_intersect_segment_point_dist(a : GeointersectsegmentPoint, b : GeointersectsegmentPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_intersect_segment_point_add(a : GeointersectsegmentPoint, b : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_intersect_segment_point_sub(a : GeointersectsegmentPoint, b : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_intersect_segment_point_scale(pt : GeointersectsegmentPoint, s : Double) -> GeointersectsegmentPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_intersect_segment_point_dot(a : GeointersectsegmentPoint, b : GeointersectsegmentPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_intersect_segment_point_cross(a : GeointersectsegmentPoint, b : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_intersect_segment_point_norm(pt : GeointersectsegmentPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_intersect_segment_point_normalize(pt : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  let n = geo_intersect_segment_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_intersect_segment_point_scale(pt, 1.0 / n) }
}

pub fn geo_intersect_segment_point_negate(pt : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_intersect_segment_point_mid(a : GeointersectsegmentPoint, b : GeointersectsegmentPoint) -> GeointersectsegmentPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_intersect_segment_point_lerp(a : GeointersectsegmentPoint, b : GeointersectsegmentPoint, t : Double) -> GeointersectsegmentPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_intersect_segment_point_to_string(pt : GeointersectsegmentPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeointersectsegmentSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_intersect_segment_make_series(vals : Array[Double], name : String) -> GeointersectsegmentSeries {
  { vals, name, meta: 0 }
}

pub fn geo_intersect_segment_series_len(s : GeointersectsegmentSeries) -> Int { s.vals.length() }

pub fn geo_intersect_segment_series_sum(s : GeointersectsegmentSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_intersect_segment_series_mean(s : GeointersectsegmentSeries) -> Double {
  let n = geo_intersect_segment_series_len(s)
  if n == 0 { 0.0 } else { geo_intersect_segment_series_sum(s) / n.to_double() }
}

pub fn geo_intersect_segment_series_min(s : GeointersectsegmentSeries) -> Double {
  let n = geo_intersect_segment_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_segment_series_max(s : GeointersectsegmentSeries) -> Double {
  let n = geo_intersect_segment_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_intersect_segment_series_range(s : GeointersectsegmentSeries) -> Double {
  geo_intersect_segment_series_max(s) - geo_intersect_segment_series_min(s)
}

pub fn geo_intersect_segment_series_var(s : GeointersectsegmentSeries) -> Double {
  let n = geo_intersect_segment_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_intersect_segment_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_intersect_segment_series_std(s : GeointersectsegmentSeries) -> Double { @_common.sqrt(geo_intersect_segment_series_var(s)) }

pub fn geo_intersect_segment_series_median(s : GeointersectsegmentSeries) -> Double {
  let n = geo_intersect_segment_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_segment_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_segment_series_scale(s : GeointersectsegmentSeries, f : Double) -> GeointersectsegmentSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_intersect_segment_series_add(a : GeointersectsegmentSeries, b : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_intersect_segment_series_sub(a : GeointersectsegmentSeries, b : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_intersect_segment_series_normalize(s : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  let mn = geo_intersect_segment_series_min(s)
  let mx = geo_intersect_segment_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_intersect_segment_series_cumsum(s : GeointersectsegmentSeries) -> GeointersectsegmentSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_intersect_segment_series_to_string(s : GeointersectsegmentSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeointersectsegmentMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_intersect_segment_make_matrix(rows : Int, cols : Int, val : Double) -> GeointersectsegmentMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_intersect_segment_matrix_identity(n : Int) -> GeointersectsegmentMatrix {
  let m = geo_intersect_segment_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_intersect_segment_matrix_get(m : GeointersectsegmentMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_intersect_segment_matrix_transpose(m : GeointersectsegmentMatrix) -> GeointersectsegmentMatrix {
  let result = geo_intersect_segment_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_intersect_segment_matrix_add(a : GeointersectsegmentMatrix, b : GeointersectsegmentMatrix) -> GeointersectsegmentMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_intersect_segment_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_intersect_segment_matrix_scale(m : GeointersectsegmentMatrix, s : Double) -> GeointersectsegmentMatrix {
  let result = geo_intersect_segment_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_intersect_segment_matrix_multiply(a : GeointersectsegmentMatrix, b : GeointersectsegmentMatrix) -> GeointersectsegmentMatrix {
  if a.cols != b.rows { return geo_intersect_segment_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_intersect_segment_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_intersect_segment_matrix_trace(m : GeointersectsegmentMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_intersect_segment_matrix_det(m : GeointersectsegmentMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_intersect_segment_matrix_norm(m : GeointersectsegmentMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_intersect_segment_matrix_to_string(m : GeointersectsegmentMatrix) -> String {
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

pub(all) struct GeointersectsegmentVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_intersect_segment_make_vector(comps : Array[Double]) -> GeointersectsegmentVector {
  { comps, dim: comps.length() }
}

pub fn geo_intersect_segment_vector_zero(dim : Int) -> GeointersectsegmentVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_intersect_segment_vector_add(a : GeointersectsegmentVector, b : GeointersectsegmentVector) -> GeointersectsegmentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_segment_vector_sub(a : GeointersectsegmentVector, b : GeointersectsegmentVector) -> GeointersectsegmentVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_intersect_segment_vector_scale(v : GeointersectsegmentVector, s : Double) -> GeointersectsegmentVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_intersect_segment_vector_dot(a : GeointersectsegmentVector, b : GeointersectsegmentVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_intersect_segment_vector_norm(v : GeointersectsegmentVector) -> Double { @_common.sqrt(geo_intersect_segment_vector_dot(v, v)) }

pub fn geo_intersect_segment_vector_normalize(v : GeointersectsegmentVector) -> GeointersectsegmentVector {
  let n = geo_intersect_segment_vector_norm(v)
  if n < 0.0000001 { v } else { geo_intersect_segment_vector_scale(v, 1.0 / n) }
}

pub fn geo_intersect_segment_vector_dist(a : GeointersectsegmentVector, b : GeointersectsegmentVector) -> Double {
  geo_intersect_segment_vector_norm(geo_intersect_segment_vector_sub(a, b))
}

pub fn geo_intersect_segment_vector_to_string(v : GeointersectsegmentVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_intersect_segment_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_intersect_segment_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_intersect_segment_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_segment_std(data : Array[Double]) -> Double { @_common.sqrt(geo_intersect_segment_var(data)) }

pub fn geo_intersect_segment_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_intersect_segment_mean(a); let mb = geo_intersect_segment_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_segment_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_intersect_segment_std(a); let sb = geo_intersect_segment_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_intersect_segment_cov(a, b) / (sa * sb) }
}

pub fn geo_intersect_segment_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_intersect_segment_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_intersect_segment_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_intersect_segment_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_intersect_segment_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(geo_intersect_segment_mse(pred, labels))
}

pub fn geo_intersect_segment_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_intersect_segment_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_intersect_segment_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_intersect_segment_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_intersect_segment_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_intersect_segment_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_intersect_segment_precision(pred, labels, pos); let r = geo_intersect_segment_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_intersect_segment_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_intersect_segment_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_intersect_segment_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_intersect_segment_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_intersect_segment_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_intersect_segment_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_intersect_segment_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_intersect_segment_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_intersect_segment_fibonacci(n : Int) -> Int {
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

pub fn geo_intersect_segment_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_intersect_segment_min(data); let mx = geo_intersect_segment_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_intersect_segment_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_intersect_segment_mean(data); let sd = geo_intersect_segment_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_intersect_segment_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_intersect_segment_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_segment_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_intersect_segment_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_intersect_segment_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_intersect_segment_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GeointersectsegmentFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_frame_make(size : Int) -> GeointersectsegmentFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_frame_len(s : GeointersectsegmentFrame) -> Int { s.size }

pub fn geo_intersect_segment_frame_get(s : GeointersectsegmentFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_frame_set(s : GeointersectsegmentFrame, i : Int, v : Double) -> GeointersectsegmentFrame {
  let result = geo_intersect_segment_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_frame_sum(s : GeointersectsegmentFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_frame_mean(s : GeointersectsegmentFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_frame_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_frame_scale(s : GeointersectsegmentFrame, f : Double) -> GeointersectsegmentFrame {
  let result = geo_intersect_segment_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_frame_add(a : GeointersectsegmentFrame, b : GeointersectsegmentFrame) -> GeointersectsegmentFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_frame_copy(s : GeointersectsegmentFrame) -> GeointersectsegmentFrame {
  let result = geo_intersect_segment_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_frame_fill(s : GeointersectsegmentFrame, v : Double) -> GeointersectsegmentFrame {
  let result = geo_intersect_segment_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_frame_min(s : GeointersectsegmentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_frame_max(s : GeointersectsegmentFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_frame_to_string(s : GeointersectsegmentFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_table_make(size : Int) -> GeointersectsegmentTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_table_len(s : GeointersectsegmentTable) -> Int { s.size }

pub fn geo_intersect_segment_table_get(s : GeointersectsegmentTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_table_set(s : GeointersectsegmentTable, i : Int, v : Double) -> GeointersectsegmentTable {
  let result = geo_intersect_segment_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_table_sum(s : GeointersectsegmentTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_table_mean(s : GeointersectsegmentTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_table_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_table_scale(s : GeointersectsegmentTable, f : Double) -> GeointersectsegmentTable {
  let result = geo_intersect_segment_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_table_add(a : GeointersectsegmentTable, b : GeointersectsegmentTable) -> GeointersectsegmentTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_table_copy(s : GeointersectsegmentTable) -> GeointersectsegmentTable {
  let result = geo_intersect_segment_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_table_fill(s : GeointersectsegmentTable, v : Double) -> GeointersectsegmentTable {
  let result = geo_intersect_segment_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_table_min(s : GeointersectsegmentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_table_max(s : GeointersectsegmentTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_table_to_string(s : GeointersectsegmentTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_graphn_make(size : Int) -> GeointersectsegmentGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_graphn_len(s : GeointersectsegmentGraphN) -> Int { s.size }

pub fn geo_intersect_segment_graphn_get(s : GeointersectsegmentGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_graphn_set(s : GeointersectsegmentGraphN, i : Int, v : Double) -> GeointersectsegmentGraphN {
  let result = geo_intersect_segment_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_graphn_sum(s : GeointersectsegmentGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_graphn_mean(s : GeointersectsegmentGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_graphn_scale(s : GeointersectsegmentGraphN, f : Double) -> GeointersectsegmentGraphN {
  let result = geo_intersect_segment_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_graphn_add(a : GeointersectsegmentGraphN, b : GeointersectsegmentGraphN) -> GeointersectsegmentGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_graphn_copy(s : GeointersectsegmentGraphN) -> GeointersectsegmentGraphN {
  let result = geo_intersect_segment_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_graphn_fill(s : GeointersectsegmentGraphN, v : Double) -> GeointersectsegmentGraphN {
  let result = geo_intersect_segment_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_graphn_min(s : GeointersectsegmentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_graphn_max(s : GeointersectsegmentGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_graphn_to_string(s : GeointersectsegmentGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_node_make(size : Int) -> GeointersectsegmentNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_node_len(s : GeointersectsegmentNode) -> Int { s.size }

pub fn geo_intersect_segment_node_get(s : GeointersectsegmentNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_node_set(s : GeointersectsegmentNode, i : Int, v : Double) -> GeointersectsegmentNode {
  let result = geo_intersect_segment_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_node_sum(s : GeointersectsegmentNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_node_mean(s : GeointersectsegmentNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_node_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_node_scale(s : GeointersectsegmentNode, f : Double) -> GeointersectsegmentNode {
  let result = geo_intersect_segment_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_node_add(a : GeointersectsegmentNode, b : GeointersectsegmentNode) -> GeointersectsegmentNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_node_copy(s : GeointersectsegmentNode) -> GeointersectsegmentNode {
  let result = geo_intersect_segment_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_node_fill(s : GeointersectsegmentNode, v : Double) -> GeointersectsegmentNode {
  let result = geo_intersect_segment_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_node_min(s : GeointersectsegmentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_node_max(s : GeointersectsegmentNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_node_to_string(s : GeointersectsegmentNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_edge_make(size : Int) -> GeointersectsegmentEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_edge_len(s : GeointersectsegmentEdge) -> Int { s.size }

pub fn geo_intersect_segment_edge_get(s : GeointersectsegmentEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_edge_set(s : GeointersectsegmentEdge, i : Int, v : Double) -> GeointersectsegmentEdge {
  let result = geo_intersect_segment_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_edge_sum(s : GeointersectsegmentEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_edge_mean(s : GeointersectsegmentEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_edge_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_edge_scale(s : GeointersectsegmentEdge, f : Double) -> GeointersectsegmentEdge {
  let result = geo_intersect_segment_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_edge_add(a : GeointersectsegmentEdge, b : GeointersectsegmentEdge) -> GeointersectsegmentEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_edge_copy(s : GeointersectsegmentEdge) -> GeointersectsegmentEdge {
  let result = geo_intersect_segment_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_edge_fill(s : GeointersectsegmentEdge, v : Double) -> GeointersectsegmentEdge {
  let result = geo_intersect_segment_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_edge_min(s : GeointersectsegmentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_edge_max(s : GeointersectsegmentEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_edge_to_string(s : GeointersectsegmentEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_path_make(size : Int) -> GeointersectsegmentPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_path_len(s : GeointersectsegmentPath) -> Int { s.size }

pub fn geo_intersect_segment_path_get(s : GeointersectsegmentPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_path_set(s : GeointersectsegmentPath, i : Int, v : Double) -> GeointersectsegmentPath {
  let result = geo_intersect_segment_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_path_sum(s : GeointersectsegmentPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_path_mean(s : GeointersectsegmentPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_path_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_path_scale(s : GeointersectsegmentPath, f : Double) -> GeointersectsegmentPath {
  let result = geo_intersect_segment_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_path_add(a : GeointersectsegmentPath, b : GeointersectsegmentPath) -> GeointersectsegmentPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_path_copy(s : GeointersectsegmentPath) -> GeointersectsegmentPath {
  let result = geo_intersect_segment_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_path_fill(s : GeointersectsegmentPath, v : Double) -> GeointersectsegmentPath {
  let result = geo_intersect_segment_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_path_min(s : GeointersectsegmentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_path_max(s : GeointersectsegmentPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_path_to_string(s : GeointersectsegmentPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_cluster_make(size : Int) -> GeointersectsegmentCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_cluster_len(s : GeointersectsegmentCluster) -> Int { s.size }

pub fn geo_intersect_segment_cluster_get(s : GeointersectsegmentCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_cluster_set(s : GeointersectsegmentCluster, i : Int, v : Double) -> GeointersectsegmentCluster {
  let result = geo_intersect_segment_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_cluster_sum(s : GeointersectsegmentCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_cluster_mean(s : GeointersectsegmentCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_cluster_scale(s : GeointersectsegmentCluster, f : Double) -> GeointersectsegmentCluster {
  let result = geo_intersect_segment_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_cluster_add(a : GeointersectsegmentCluster, b : GeointersectsegmentCluster) -> GeointersectsegmentCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_cluster_copy(s : GeointersectsegmentCluster) -> GeointersectsegmentCluster {
  let result = geo_intersect_segment_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_cluster_fill(s : GeointersectsegmentCluster, v : Double) -> GeointersectsegmentCluster {
  let result = geo_intersect_segment_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_cluster_min(s : GeointersectsegmentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_cluster_max(s : GeointersectsegmentCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_cluster_to_string(s : GeointersectsegmentCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_model_make(size : Int) -> GeointersectsegmentModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_model_len(s : GeointersectsegmentModel) -> Int { s.size }

pub fn geo_intersect_segment_model_get(s : GeointersectsegmentModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_model_set(s : GeointersectsegmentModel, i : Int, v : Double) -> GeointersectsegmentModel {
  let result = geo_intersect_segment_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_model_sum(s : GeointersectsegmentModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_model_mean(s : GeointersectsegmentModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_model_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_model_scale(s : GeointersectsegmentModel, f : Double) -> GeointersectsegmentModel {
  let result = geo_intersect_segment_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_model_add(a : GeointersectsegmentModel, b : GeointersectsegmentModel) -> GeointersectsegmentModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_model_copy(s : GeointersectsegmentModel) -> GeointersectsegmentModel {
  let result = geo_intersect_segment_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_model_fill(s : GeointersectsegmentModel, v : Double) -> GeointersectsegmentModel {
  let result = geo_intersect_segment_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_model_min(s : GeointersectsegmentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_model_max(s : GeointersectsegmentModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_model_to_string(s : GeointersectsegmentModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_layer_make(size : Int) -> GeointersectsegmentLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_layer_len(s : GeointersectsegmentLayer) -> Int { s.size }

pub fn geo_intersect_segment_layer_get(s : GeointersectsegmentLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_layer_set(s : GeointersectsegmentLayer, i : Int, v : Double) -> GeointersectsegmentLayer {
  let result = geo_intersect_segment_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_layer_sum(s : GeointersectsegmentLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_layer_mean(s : GeointersectsegmentLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_layer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_layer_scale(s : GeointersectsegmentLayer, f : Double) -> GeointersectsegmentLayer {
  let result = geo_intersect_segment_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_layer_add(a : GeointersectsegmentLayer, b : GeointersectsegmentLayer) -> GeointersectsegmentLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_layer_copy(s : GeointersectsegmentLayer) -> GeointersectsegmentLayer {
  let result = geo_intersect_segment_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_layer_fill(s : GeointersectsegmentLayer, v : Double) -> GeointersectsegmentLayer {
  let result = geo_intersect_segment_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_layer_min(s : GeointersectsegmentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_layer_max(s : GeointersectsegmentLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_layer_to_string(s : GeointersectsegmentLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_buffer_make(size : Int) -> GeointersectsegmentBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_buffer_len(s : GeointersectsegmentBuffer) -> Int { s.size }

pub fn geo_intersect_segment_buffer_get(s : GeointersectsegmentBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_buffer_set(s : GeointersectsegmentBuffer, i : Int, v : Double) -> GeointersectsegmentBuffer {
  let result = geo_intersect_segment_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_buffer_sum(s : GeointersectsegmentBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_buffer_mean(s : GeointersectsegmentBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_buffer_scale(s : GeointersectsegmentBuffer, f : Double) -> GeointersectsegmentBuffer {
  let result = geo_intersect_segment_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_buffer_add(a : GeointersectsegmentBuffer, b : GeointersectsegmentBuffer) -> GeointersectsegmentBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_buffer_copy(s : GeointersectsegmentBuffer) -> GeointersectsegmentBuffer {
  let result = geo_intersect_segment_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_buffer_fill(s : GeointersectsegmentBuffer, v : Double) -> GeointersectsegmentBuffer {
  let result = geo_intersect_segment_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_buffer_min(s : GeointersectsegmentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_buffer_max(s : GeointersectsegmentBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_buffer_to_string(s : GeointersectsegmentBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_cursor_make(size : Int) -> GeointersectsegmentCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_cursor_len(s : GeointersectsegmentCursor) -> Int { s.size }

pub fn geo_intersect_segment_cursor_get(s : GeointersectsegmentCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_cursor_set(s : GeointersectsegmentCursor, i : Int, v : Double) -> GeointersectsegmentCursor {
  let result = geo_intersect_segment_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_cursor_sum(s : GeointersectsegmentCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_cursor_mean(s : GeointersectsegmentCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_cursor_scale(s : GeointersectsegmentCursor, f : Double) -> GeointersectsegmentCursor {
  let result = geo_intersect_segment_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_cursor_add(a : GeointersectsegmentCursor, b : GeointersectsegmentCursor) -> GeointersectsegmentCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_cursor_copy(s : GeointersectsegmentCursor) -> GeointersectsegmentCursor {
  let result = geo_intersect_segment_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_cursor_fill(s : GeointersectsegmentCursor, v : Double) -> GeointersectsegmentCursor {
  let result = geo_intersect_segment_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_cursor_min(s : GeointersectsegmentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_cursor_max(s : GeointersectsegmentCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_cursor_to_string(s : GeointersectsegmentCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_view_make(size : Int) -> GeointersectsegmentView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_view_len(s : GeointersectsegmentView) -> Int { s.size }

pub fn geo_intersect_segment_view_get(s : GeointersectsegmentView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_view_set(s : GeointersectsegmentView, i : Int, v : Double) -> GeointersectsegmentView {
  let result = geo_intersect_segment_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_view_sum(s : GeointersectsegmentView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_view_mean(s : GeointersectsegmentView) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_view_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_view_scale(s : GeointersectsegmentView, f : Double) -> GeointersectsegmentView {
  let result = geo_intersect_segment_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_view_add(a : GeointersectsegmentView, b : GeointersectsegmentView) -> GeointersectsegmentView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_view_copy(s : GeointersectsegmentView) -> GeointersectsegmentView {
  let result = geo_intersect_segment_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_view_fill(s : GeointersectsegmentView, v : Double) -> GeointersectsegmentView {
  let result = geo_intersect_segment_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_view_min(s : GeointersectsegmentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_view_max(s : GeointersectsegmentView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_view_to_string(s : GeointersectsegmentView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_range_make(size : Int) -> GeointersectsegmentRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_range_len(s : GeointersectsegmentRange) -> Int { s.size }

pub fn geo_intersect_segment_range_get(s : GeointersectsegmentRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_range_set(s : GeointersectsegmentRange, i : Int, v : Double) -> GeointersectsegmentRange {
  let result = geo_intersect_segment_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_range_sum(s : GeointersectsegmentRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_range_mean(s : GeointersectsegmentRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_range_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_range_scale(s : GeointersectsegmentRange, f : Double) -> GeointersectsegmentRange {
  let result = geo_intersect_segment_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_range_add(a : GeointersectsegmentRange, b : GeointersectsegmentRange) -> GeointersectsegmentRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_range_copy(s : GeointersectsegmentRange) -> GeointersectsegmentRange {
  let result = geo_intersect_segment_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_range_fill(s : GeointersectsegmentRange, v : Double) -> GeointersectsegmentRange {
  let result = geo_intersect_segment_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_range_min(s : GeointersectsegmentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_range_max(s : GeointersectsegmentRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_range_to_string(s : GeointersectsegmentRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeointersectsegmentSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_intersect_segment_slice_make(size : Int) -> GeointersectsegmentSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_intersect_segment_slice_len(s : GeointersectsegmentSlice) -> Int { s.size }

pub fn geo_intersect_segment_slice_get(s : GeointersectsegmentSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_intersect_segment_slice_set(s : GeointersectsegmentSlice, i : Int, v : Double) -> GeointersectsegmentSlice {
  let result = geo_intersect_segment_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_slice_sum(s : GeointersectsegmentSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_intersect_segment_slice_mean(s : GeointersectsegmentSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_intersect_segment_slice_sum(s) / s.size.to_double() }
}

pub fn geo_intersect_segment_slice_scale(s : GeointersectsegmentSlice, f : Double) -> GeointersectsegmentSlice {
  let result = geo_intersect_segment_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_intersect_segment_slice_add(a : GeointersectsegmentSlice, b : GeointersectsegmentSlice) -> GeointersectsegmentSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_intersect_segment_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_intersect_segment_slice_copy(s : GeointersectsegmentSlice) -> GeointersectsegmentSlice {
  let result = geo_intersect_segment_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_intersect_segment_slice_fill(s : GeointersectsegmentSlice, v : Double) -> GeointersectsegmentSlice {
  let result = geo_intersect_segment_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_intersect_segment_slice_min(s : GeointersectsegmentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_slice_max(s : GeointersectsegmentSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_intersect_segment_slice_to_string(s : GeointersectsegmentSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

