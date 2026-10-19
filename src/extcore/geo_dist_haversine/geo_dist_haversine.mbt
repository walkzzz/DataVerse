///===
/// extcore/geo_dist_haversine

pub(all) struct GeodisthaversinePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_haversine_make_point(x : Double, y : Double) -> GeodisthaversinePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_haversine_make_point3(x : Double, y : Double, z : Double) -> GeodisthaversinePoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_haversine_point_x(pt : GeodisthaversinePoint) -> Double { pt.x }

pub fn geo_dist_haversine_point_y(pt : GeodisthaversinePoint) -> Double { pt.y }

pub fn geo_dist_haversine_point_z(pt : GeodisthaversinePoint) -> Double { pt.z }

pub fn geo_dist_haversine_point_label(pt : GeodisthaversinePoint) -> Int { pt.label }

pub fn geo_dist_haversine_point_dist(a : GeodisthaversinePoint, b : GeodisthaversinePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_haversine_point_add(a : GeodisthaversinePoint, b : GeodisthaversinePoint) -> GeodisthaversinePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_haversine_point_sub(a : GeodisthaversinePoint, b : GeodisthaversinePoint) -> GeodisthaversinePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_haversine_point_scale(pt : GeodisthaversinePoint, s : Double) -> GeodisthaversinePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_haversine_point_dot(a : GeodisthaversinePoint, b : GeodisthaversinePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_haversine_point_cross(a : GeodisthaversinePoint, b : GeodisthaversinePoint) -> GeodisthaversinePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_haversine_point_norm(pt : GeodisthaversinePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_haversine_point_normalize(pt : GeodisthaversinePoint) -> GeodisthaversinePoint {
  let n = geo_dist_haversine_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_haversine_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_haversine_point_negate(pt : GeodisthaversinePoint) -> GeodisthaversinePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_haversine_point_mid(a : GeodisthaversinePoint, b : GeodisthaversinePoint) -> GeodisthaversinePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_haversine_point_lerp(a : GeodisthaversinePoint, b : GeodisthaversinePoint, t : Double) -> GeodisthaversinePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_haversine_point_to_string(pt : GeodisthaversinePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodisthaversineSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_haversine_make_series(vals : Array[Double], name : String) -> GeodisthaversineSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_haversine_series_len(s : GeodisthaversineSeries) -> Int { s.vals.length() }

pub fn geo_dist_haversine_series_sum(s : GeodisthaversineSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_dist_haversine_series_mean(s : GeodisthaversineSeries) -> Double {
  let n = geo_dist_haversine_series_len(s)
  if n == 0 { 0.0 } else { geo_dist_haversine_series_sum(s) / n.to_double() }
}

pub fn geo_dist_haversine_series_min(s : GeodisthaversineSeries) -> Double {
  let n = geo_dist_haversine_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_haversine_series_max(s : GeodisthaversineSeries) -> Double {
  let n = geo_dist_haversine_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_haversine_series_range(s : GeodisthaversineSeries) -> Double {
  geo_dist_haversine_series_max(s) - geo_dist_haversine_series_min(s)
}

pub fn geo_dist_haversine_series_var(s : GeodisthaversineSeries) -> Double {
  let n = geo_dist_haversine_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_dist_haversine_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_dist_haversine_series_std(s : GeodisthaversineSeries) -> Double { @_common.sqrt(geo_dist_haversine_series_var(s)) }

pub fn geo_dist_haversine_series_median(s : GeodisthaversineSeries) -> Double {
  let n = geo_dist_haversine_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_haversine_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_haversine_series_scale(s : GeodisthaversineSeries, f : Double) -> GeodisthaversineSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_haversine_series_add(a : GeodisthaversineSeries, b : GeodisthaversineSeries) -> GeodisthaversineSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_haversine_series_sub(a : GeodisthaversineSeries, b : GeodisthaversineSeries) -> GeodisthaversineSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_haversine_series_normalize(s : GeodisthaversineSeries) -> GeodisthaversineSeries {
  let mn = geo_dist_haversine_series_min(s)
  let mx = geo_dist_haversine_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_haversine_series_cumsum(s : GeodisthaversineSeries) -> GeodisthaversineSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_haversine_series_to_string(s : GeodisthaversineSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodisthaversineMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_haversine_make_matrix(rows : Int, cols : Int, val : Double) -> GeodisthaversineMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_haversine_matrix_identity(n : Int) -> GeodisthaversineMatrix {
  let m = geo_dist_haversine_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_haversine_matrix_get(m : GeodisthaversineMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_haversine_matrix_transpose(m : GeodisthaversineMatrix) -> GeodisthaversineMatrix {
  let result = geo_dist_haversine_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_haversine_matrix_add(a : GeodisthaversineMatrix, b : GeodisthaversineMatrix) -> GeodisthaversineMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_haversine_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_haversine_matrix_scale(m : GeodisthaversineMatrix, s : Double) -> GeodisthaversineMatrix {
  let result = geo_dist_haversine_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_haversine_matrix_multiply(a : GeodisthaversineMatrix, b : GeodisthaversineMatrix) -> GeodisthaversineMatrix {
  if a.cols != b.rows { return geo_dist_haversine_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_haversine_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_haversine_matrix_trace(m : GeodisthaversineMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_haversine_matrix_det(m : GeodisthaversineMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_haversine_matrix_norm(m : GeodisthaversineMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_dist_haversine_matrix_to_string(m : GeodisthaversineMatrix) -> String {
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

pub(all) struct GeodisthaversineVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_haversine_make_vector(comps : Array[Double]) -> GeodisthaversineVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_haversine_vector_zero(dim : Int) -> GeodisthaversineVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_haversine_vector_add(a : GeodisthaversineVector, b : GeodisthaversineVector) -> GeodisthaversineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_haversine_vector_sub(a : GeodisthaversineVector, b : GeodisthaversineVector) -> GeodisthaversineVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_haversine_vector_scale(v : GeodisthaversineVector, s : Double) -> GeodisthaversineVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_haversine_vector_dot(a : GeodisthaversineVector, b : GeodisthaversineVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_haversine_vector_norm(v : GeodisthaversineVector) -> Double { @_common.sqrt(geo_dist_haversine_vector_dot(v, v)) }

pub fn geo_dist_haversine_vector_normalize(v : GeodisthaversineVector) -> GeodisthaversineVector {
  let n = geo_dist_haversine_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_haversine_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_haversine_vector_dist(a : GeodisthaversineVector, b : GeodisthaversineVector) -> Double {
  geo_dist_haversine_vector_norm(geo_dist_haversine_vector_sub(a, b))
}

pub fn geo_dist_haversine_vector_to_string(v : GeodisthaversineVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_haversine_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_dist_haversine_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_dist_haversine_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_haversine_std(data : Array[Double]) -> Double { @_common.sqrt(geo_dist_haversine_var(data)) }

pub fn geo_dist_haversine_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_dist_haversine_mean(a); let mb = geo_dist_haversine_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_dist_haversine_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_dist_haversine_std(a); let sb = geo_dist_haversine_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_dist_haversine_cov(a, b) / (sa * sb) }
}

pub fn geo_dist_haversine_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_haversine_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_haversine_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_dist_haversine_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_haversine_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(geo_dist_haversine_mse(pred, labels))
}

pub fn geo_dist_haversine_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_dist_haversine_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_dist_haversine_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_dist_haversine_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_dist_haversine_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_dist_haversine_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_dist_haversine_precision(pred, labels, pos); let r = geo_dist_haversine_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_dist_haversine_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_dist_haversine_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_dist_haversine_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_dist_haversine_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_dist_haversine_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_dist_haversine_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_dist_haversine_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_dist_haversine_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_dist_haversine_fibonacci(n : Int) -> Int {
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

pub fn geo_dist_haversine_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_dist_haversine_min(data); let mx = geo_dist_haversine_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_dist_haversine_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_dist_haversine_mean(data); let sd = geo_dist_haversine_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_dist_haversine_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_dist_haversine_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_dist_haversine_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_dist_haversine_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_dist_haversine_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_dist_haversine_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GeodisthaversineFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_frame_make(size : Int) -> GeodisthaversineFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_frame_len(s : GeodisthaversineFrame) -> Int { s.size }

pub fn geo_dist_haversine_frame_get(s : GeodisthaversineFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_frame_set(s : GeodisthaversineFrame, i : Int, v : Double) -> GeodisthaversineFrame {
  let result = geo_dist_haversine_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_frame_sum(s : GeodisthaversineFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_frame_mean(s : GeodisthaversineFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_frame_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_frame_scale(s : GeodisthaversineFrame, f : Double) -> GeodisthaversineFrame {
  let result = geo_dist_haversine_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_frame_add(a : GeodisthaversineFrame, b : GeodisthaversineFrame) -> GeodisthaversineFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_frame_copy(s : GeodisthaversineFrame) -> GeodisthaversineFrame {
  let result = geo_dist_haversine_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_frame_fill(s : GeodisthaversineFrame, v : Double) -> GeodisthaversineFrame {
  let result = geo_dist_haversine_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_frame_min(s : GeodisthaversineFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_frame_max(s : GeodisthaversineFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_frame_to_string(s : GeodisthaversineFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_table_make(size : Int) -> GeodisthaversineTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_table_len(s : GeodisthaversineTable) -> Int { s.size }

pub fn geo_dist_haversine_table_get(s : GeodisthaversineTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_table_set(s : GeodisthaversineTable, i : Int, v : Double) -> GeodisthaversineTable {
  let result = geo_dist_haversine_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_table_sum(s : GeodisthaversineTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_table_mean(s : GeodisthaversineTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_table_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_table_scale(s : GeodisthaversineTable, f : Double) -> GeodisthaversineTable {
  let result = geo_dist_haversine_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_table_add(a : GeodisthaversineTable, b : GeodisthaversineTable) -> GeodisthaversineTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_table_copy(s : GeodisthaversineTable) -> GeodisthaversineTable {
  let result = geo_dist_haversine_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_table_fill(s : GeodisthaversineTable, v : Double) -> GeodisthaversineTable {
  let result = geo_dist_haversine_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_table_min(s : GeodisthaversineTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_table_max(s : GeodisthaversineTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_table_to_string(s : GeodisthaversineTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_graphn_make(size : Int) -> GeodisthaversineGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_graphn_len(s : GeodisthaversineGraphN) -> Int { s.size }

pub fn geo_dist_haversine_graphn_get(s : GeodisthaversineGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_graphn_set(s : GeodisthaversineGraphN, i : Int, v : Double) -> GeodisthaversineGraphN {
  let result = geo_dist_haversine_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_graphn_sum(s : GeodisthaversineGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_graphn_mean(s : GeodisthaversineGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_graphn_scale(s : GeodisthaversineGraphN, f : Double) -> GeodisthaversineGraphN {
  let result = geo_dist_haversine_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_graphn_add(a : GeodisthaversineGraphN, b : GeodisthaversineGraphN) -> GeodisthaversineGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_graphn_copy(s : GeodisthaversineGraphN) -> GeodisthaversineGraphN {
  let result = geo_dist_haversine_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_graphn_fill(s : GeodisthaversineGraphN, v : Double) -> GeodisthaversineGraphN {
  let result = geo_dist_haversine_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_graphn_min(s : GeodisthaversineGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_graphn_max(s : GeodisthaversineGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_graphn_to_string(s : GeodisthaversineGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_node_make(size : Int) -> GeodisthaversineNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_node_len(s : GeodisthaversineNode) -> Int { s.size }

pub fn geo_dist_haversine_node_get(s : GeodisthaversineNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_node_set(s : GeodisthaversineNode, i : Int, v : Double) -> GeodisthaversineNode {
  let result = geo_dist_haversine_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_node_sum(s : GeodisthaversineNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_node_mean(s : GeodisthaversineNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_node_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_node_scale(s : GeodisthaversineNode, f : Double) -> GeodisthaversineNode {
  let result = geo_dist_haversine_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_node_add(a : GeodisthaversineNode, b : GeodisthaversineNode) -> GeodisthaversineNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_node_copy(s : GeodisthaversineNode) -> GeodisthaversineNode {
  let result = geo_dist_haversine_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_node_fill(s : GeodisthaversineNode, v : Double) -> GeodisthaversineNode {
  let result = geo_dist_haversine_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_node_min(s : GeodisthaversineNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_node_max(s : GeodisthaversineNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_node_to_string(s : GeodisthaversineNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_edge_make(size : Int) -> GeodisthaversineEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_edge_len(s : GeodisthaversineEdge) -> Int { s.size }

pub fn geo_dist_haversine_edge_get(s : GeodisthaversineEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_edge_set(s : GeodisthaversineEdge, i : Int, v : Double) -> GeodisthaversineEdge {
  let result = geo_dist_haversine_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_edge_sum(s : GeodisthaversineEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_edge_mean(s : GeodisthaversineEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_edge_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_edge_scale(s : GeodisthaversineEdge, f : Double) -> GeodisthaversineEdge {
  let result = geo_dist_haversine_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_edge_add(a : GeodisthaversineEdge, b : GeodisthaversineEdge) -> GeodisthaversineEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_edge_copy(s : GeodisthaversineEdge) -> GeodisthaversineEdge {
  let result = geo_dist_haversine_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_edge_fill(s : GeodisthaversineEdge, v : Double) -> GeodisthaversineEdge {
  let result = geo_dist_haversine_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_edge_min(s : GeodisthaversineEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_edge_max(s : GeodisthaversineEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_edge_to_string(s : GeodisthaversineEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversinePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_path_make(size : Int) -> GeodisthaversinePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_path_len(s : GeodisthaversinePath) -> Int { s.size }

pub fn geo_dist_haversine_path_get(s : GeodisthaversinePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_path_set(s : GeodisthaversinePath, i : Int, v : Double) -> GeodisthaversinePath {
  let result = geo_dist_haversine_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_path_sum(s : GeodisthaversinePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_path_mean(s : GeodisthaversinePath) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_path_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_path_scale(s : GeodisthaversinePath, f : Double) -> GeodisthaversinePath {
  let result = geo_dist_haversine_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_path_add(a : GeodisthaversinePath, b : GeodisthaversinePath) -> GeodisthaversinePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_path_copy(s : GeodisthaversinePath) -> GeodisthaversinePath {
  let result = geo_dist_haversine_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_path_fill(s : GeodisthaversinePath, v : Double) -> GeodisthaversinePath {
  let result = geo_dist_haversine_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_path_min(s : GeodisthaversinePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_path_max(s : GeodisthaversinePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_path_to_string(s : GeodisthaversinePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_cluster_make(size : Int) -> GeodisthaversineCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_cluster_len(s : GeodisthaversineCluster) -> Int { s.size }

pub fn geo_dist_haversine_cluster_get(s : GeodisthaversineCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_cluster_set(s : GeodisthaversineCluster, i : Int, v : Double) -> GeodisthaversineCluster {
  let result = geo_dist_haversine_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_cluster_sum(s : GeodisthaversineCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_cluster_mean(s : GeodisthaversineCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_cluster_scale(s : GeodisthaversineCluster, f : Double) -> GeodisthaversineCluster {
  let result = geo_dist_haversine_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_cluster_add(a : GeodisthaversineCluster, b : GeodisthaversineCluster) -> GeodisthaversineCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_cluster_copy(s : GeodisthaversineCluster) -> GeodisthaversineCluster {
  let result = geo_dist_haversine_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_cluster_fill(s : GeodisthaversineCluster, v : Double) -> GeodisthaversineCluster {
  let result = geo_dist_haversine_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_cluster_min(s : GeodisthaversineCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_cluster_max(s : GeodisthaversineCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_cluster_to_string(s : GeodisthaversineCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_model_make(size : Int) -> GeodisthaversineModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_model_len(s : GeodisthaversineModel) -> Int { s.size }

pub fn geo_dist_haversine_model_get(s : GeodisthaversineModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_model_set(s : GeodisthaversineModel, i : Int, v : Double) -> GeodisthaversineModel {
  let result = geo_dist_haversine_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_model_sum(s : GeodisthaversineModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_model_mean(s : GeodisthaversineModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_model_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_model_scale(s : GeodisthaversineModel, f : Double) -> GeodisthaversineModel {
  let result = geo_dist_haversine_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_model_add(a : GeodisthaversineModel, b : GeodisthaversineModel) -> GeodisthaversineModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_model_copy(s : GeodisthaversineModel) -> GeodisthaversineModel {
  let result = geo_dist_haversine_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_model_fill(s : GeodisthaversineModel, v : Double) -> GeodisthaversineModel {
  let result = geo_dist_haversine_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_model_min(s : GeodisthaversineModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_model_max(s : GeodisthaversineModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_model_to_string(s : GeodisthaversineModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_layer_make(size : Int) -> GeodisthaversineLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_layer_len(s : GeodisthaversineLayer) -> Int { s.size }

pub fn geo_dist_haversine_layer_get(s : GeodisthaversineLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_layer_set(s : GeodisthaversineLayer, i : Int, v : Double) -> GeodisthaversineLayer {
  let result = geo_dist_haversine_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_layer_sum(s : GeodisthaversineLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_layer_mean(s : GeodisthaversineLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_layer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_layer_scale(s : GeodisthaversineLayer, f : Double) -> GeodisthaversineLayer {
  let result = geo_dist_haversine_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_layer_add(a : GeodisthaversineLayer, b : GeodisthaversineLayer) -> GeodisthaversineLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_layer_copy(s : GeodisthaversineLayer) -> GeodisthaversineLayer {
  let result = geo_dist_haversine_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_layer_fill(s : GeodisthaversineLayer, v : Double) -> GeodisthaversineLayer {
  let result = geo_dist_haversine_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_layer_min(s : GeodisthaversineLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_layer_max(s : GeodisthaversineLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_layer_to_string(s : GeodisthaversineLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_buffer_make(size : Int) -> GeodisthaversineBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_buffer_len(s : GeodisthaversineBuffer) -> Int { s.size }

pub fn geo_dist_haversine_buffer_get(s : GeodisthaversineBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_buffer_set(s : GeodisthaversineBuffer, i : Int, v : Double) -> GeodisthaversineBuffer {
  let result = geo_dist_haversine_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_buffer_sum(s : GeodisthaversineBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_buffer_mean(s : GeodisthaversineBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_buffer_scale(s : GeodisthaversineBuffer, f : Double) -> GeodisthaversineBuffer {
  let result = geo_dist_haversine_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_buffer_add(a : GeodisthaversineBuffer, b : GeodisthaversineBuffer) -> GeodisthaversineBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_buffer_copy(s : GeodisthaversineBuffer) -> GeodisthaversineBuffer {
  let result = geo_dist_haversine_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_buffer_fill(s : GeodisthaversineBuffer, v : Double) -> GeodisthaversineBuffer {
  let result = geo_dist_haversine_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_buffer_min(s : GeodisthaversineBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_buffer_max(s : GeodisthaversineBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_buffer_to_string(s : GeodisthaversineBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_cursor_make(size : Int) -> GeodisthaversineCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_cursor_len(s : GeodisthaversineCursor) -> Int { s.size }

pub fn geo_dist_haversine_cursor_get(s : GeodisthaversineCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_cursor_set(s : GeodisthaversineCursor, i : Int, v : Double) -> GeodisthaversineCursor {
  let result = geo_dist_haversine_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_cursor_sum(s : GeodisthaversineCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_cursor_mean(s : GeodisthaversineCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_cursor_scale(s : GeodisthaversineCursor, f : Double) -> GeodisthaversineCursor {
  let result = geo_dist_haversine_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_cursor_add(a : GeodisthaversineCursor, b : GeodisthaversineCursor) -> GeodisthaversineCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_cursor_copy(s : GeodisthaversineCursor) -> GeodisthaversineCursor {
  let result = geo_dist_haversine_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_cursor_fill(s : GeodisthaversineCursor, v : Double) -> GeodisthaversineCursor {
  let result = geo_dist_haversine_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_cursor_min(s : GeodisthaversineCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_cursor_max(s : GeodisthaversineCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_cursor_to_string(s : GeodisthaversineCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_view_make(size : Int) -> GeodisthaversineView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_view_len(s : GeodisthaversineView) -> Int { s.size }

pub fn geo_dist_haversine_view_get(s : GeodisthaversineView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_view_set(s : GeodisthaversineView, i : Int, v : Double) -> GeodisthaversineView {
  let result = geo_dist_haversine_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_view_sum(s : GeodisthaversineView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_view_mean(s : GeodisthaversineView) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_view_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_view_scale(s : GeodisthaversineView, f : Double) -> GeodisthaversineView {
  let result = geo_dist_haversine_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_view_add(a : GeodisthaversineView, b : GeodisthaversineView) -> GeodisthaversineView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_view_copy(s : GeodisthaversineView) -> GeodisthaversineView {
  let result = geo_dist_haversine_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_view_fill(s : GeodisthaversineView, v : Double) -> GeodisthaversineView {
  let result = geo_dist_haversine_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_view_min(s : GeodisthaversineView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_view_max(s : GeodisthaversineView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_view_to_string(s : GeodisthaversineView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_range_make(size : Int) -> GeodisthaversineRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_range_len(s : GeodisthaversineRange) -> Int { s.size }

pub fn geo_dist_haversine_range_get(s : GeodisthaversineRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_range_set(s : GeodisthaversineRange, i : Int, v : Double) -> GeodisthaversineRange {
  let result = geo_dist_haversine_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_range_sum(s : GeodisthaversineRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_range_mean(s : GeodisthaversineRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_range_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_range_scale(s : GeodisthaversineRange, f : Double) -> GeodisthaversineRange {
  let result = geo_dist_haversine_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_range_add(a : GeodisthaversineRange, b : GeodisthaversineRange) -> GeodisthaversineRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_range_copy(s : GeodisthaversineRange) -> GeodisthaversineRange {
  let result = geo_dist_haversine_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_range_fill(s : GeodisthaversineRange, v : Double) -> GeodisthaversineRange {
  let result = geo_dist_haversine_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_range_min(s : GeodisthaversineRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_range_max(s : GeodisthaversineRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_range_to_string(s : GeodisthaversineRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodisthaversineSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_haversine_slice_make(size : Int) -> GeodisthaversineSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_haversine_slice_len(s : GeodisthaversineSlice) -> Int { s.size }

pub fn geo_dist_haversine_slice_get(s : GeodisthaversineSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_haversine_slice_set(s : GeodisthaversineSlice, i : Int, v : Double) -> GeodisthaversineSlice {
  let result = geo_dist_haversine_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_slice_sum(s : GeodisthaversineSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_haversine_slice_mean(s : GeodisthaversineSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_haversine_slice_sum(s) / s.size.to_double() }
}

pub fn geo_dist_haversine_slice_scale(s : GeodisthaversineSlice, f : Double) -> GeodisthaversineSlice {
  let result = geo_dist_haversine_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_haversine_slice_add(a : GeodisthaversineSlice, b : GeodisthaversineSlice) -> GeodisthaversineSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_haversine_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_haversine_slice_copy(s : GeodisthaversineSlice) -> GeodisthaversineSlice {
  let result = geo_dist_haversine_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_haversine_slice_fill(s : GeodisthaversineSlice, v : Double) -> GeodisthaversineSlice {
  let result = geo_dist_haversine_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_haversine_slice_min(s : GeodisthaversineSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_slice_max(s : GeodisthaversineSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_haversine_slice_to_string(s : GeodisthaversineSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

