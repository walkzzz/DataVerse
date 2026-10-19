///===
/// extcore/geo_dist_manhattan

pub(all) struct GeodistmanhattanPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn geo_dist_manhattan_make_point(x : Double, y : Double) -> GeodistmanhattanPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn geo_dist_manhattan_make_point3(x : Double, y : Double, z : Double) -> GeodistmanhattanPoint {
  { x, y, z, label: 0 }
}

pub fn geo_dist_manhattan_point_x(pt : GeodistmanhattanPoint) -> Double { pt.x }

pub fn geo_dist_manhattan_point_y(pt : GeodistmanhattanPoint) -> Double { pt.y }

pub fn geo_dist_manhattan_point_z(pt : GeodistmanhattanPoint) -> Double { pt.z }

pub fn geo_dist_manhattan_point_label(pt : GeodistmanhattanPoint) -> Int { pt.label }

pub fn geo_dist_manhattan_point_dist(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn geo_dist_manhattan_point_add(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn geo_dist_manhattan_point_sub(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn geo_dist_manhattan_point_scale(pt : GeodistmanhattanPoint, s : Double) -> GeodistmanhattanPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn geo_dist_manhattan_point_dot(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn geo_dist_manhattan_point_cross(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn geo_dist_manhattan_point_norm(pt : GeodistmanhattanPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn geo_dist_manhattan_point_normalize(pt : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  let n = geo_dist_manhattan_point_norm(pt)
  if n < 0.0000001 { pt } else { geo_dist_manhattan_point_scale(pt, 1.0 / n) }
}

pub fn geo_dist_manhattan_point_negate(pt : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn geo_dist_manhattan_point_mid(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint) -> GeodistmanhattanPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn geo_dist_manhattan_point_lerp(a : GeodistmanhattanPoint, b : GeodistmanhattanPoint, t : Double) -> GeodistmanhattanPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn geo_dist_manhattan_point_to_string(pt : GeodistmanhattanPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct GeodistmanhattanSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn geo_dist_manhattan_make_series(vals : Array[Double], name : String) -> GeodistmanhattanSeries {
  { vals, name, meta: 0 }
}

pub fn geo_dist_manhattan_series_len(s : GeodistmanhattanSeries) -> Int { s.vals.length() }

pub fn geo_dist_manhattan_series_sum(s : GeodistmanhattanSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn geo_dist_manhattan_series_mean(s : GeodistmanhattanSeries) -> Double {
  let n = geo_dist_manhattan_series_len(s)
  if n == 0 { 0.0 } else { geo_dist_manhattan_series_sum(s) / n.to_double() }
}

pub fn geo_dist_manhattan_series_min(s : GeodistmanhattanSeries) -> Double {
  let n = geo_dist_manhattan_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_manhattan_series_max(s : GeodistmanhattanSeries) -> Double {
  let n = geo_dist_manhattan_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn geo_dist_manhattan_series_range(s : GeodistmanhattanSeries) -> Double {
  geo_dist_manhattan_series_max(s) - geo_dist_manhattan_series_min(s)
}

pub fn geo_dist_manhattan_series_var(s : GeodistmanhattanSeries) -> Double {
  let n = geo_dist_manhattan_series_len(s)
  if n == 0 { 0.0 } else {
    let m = geo_dist_manhattan_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn geo_dist_manhattan_series_std(s : GeodistmanhattanSeries) -> Double { @_common.sqrt(geo_dist_manhattan_series_var(s)) }

pub fn geo_dist_manhattan_series_median(s : GeodistmanhattanSeries) -> Double {
  let n = geo_dist_manhattan_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_manhattan_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_manhattan_series_scale(s : GeodistmanhattanSeries, f : Double) -> GeodistmanhattanSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn geo_dist_manhattan_series_add(a : GeodistmanhattanSeries, b : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn geo_dist_manhattan_series_sub(a : GeodistmanhattanSeries, b : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn geo_dist_manhattan_series_normalize(s : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  let mn = geo_dist_manhattan_series_min(s)
  let mx = geo_dist_manhattan_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn geo_dist_manhattan_series_cumsum(s : GeodistmanhattanSeries) -> GeodistmanhattanSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn geo_dist_manhattan_series_to_string(s : GeodistmanhattanSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct GeodistmanhattanMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn geo_dist_manhattan_make_matrix(rows : Int, cols : Int, val : Double) -> GeodistmanhattanMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn geo_dist_manhattan_matrix_identity(n : Int) -> GeodistmanhattanMatrix {
  let m = geo_dist_manhattan_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn geo_dist_manhattan_matrix_get(m : GeodistmanhattanMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn geo_dist_manhattan_matrix_transpose(m : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  let result = geo_dist_manhattan_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn geo_dist_manhattan_matrix_add(a : GeodistmanhattanMatrix, b : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = geo_dist_manhattan_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn geo_dist_manhattan_matrix_scale(m : GeodistmanhattanMatrix, s : Double) -> GeodistmanhattanMatrix {
  let result = geo_dist_manhattan_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn geo_dist_manhattan_matrix_multiply(a : GeodistmanhattanMatrix, b : GeodistmanhattanMatrix) -> GeodistmanhattanMatrix {
  if a.cols != b.rows { return geo_dist_manhattan_make_matrix(a.rows, b.cols, 0.0) }
  let result = geo_dist_manhattan_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn geo_dist_manhattan_matrix_trace(m : GeodistmanhattanMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn geo_dist_manhattan_matrix_det(m : GeodistmanhattanMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn geo_dist_manhattan_matrix_norm(m : GeodistmanhattanMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn geo_dist_manhattan_matrix_to_string(m : GeodistmanhattanMatrix) -> String {
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

pub(all) struct GeodistmanhattanVector {
  comps : Array[Double]
  dim : Int
}

pub fn geo_dist_manhattan_make_vector(comps : Array[Double]) -> GeodistmanhattanVector {
  { comps, dim: comps.length() }
}

pub fn geo_dist_manhattan_vector_zero(dim : Int) -> GeodistmanhattanVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn geo_dist_manhattan_vector_add(a : GeodistmanhattanVector, b : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_manhattan_vector_sub(a : GeodistmanhattanVector, b : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn geo_dist_manhattan_vector_scale(v : GeodistmanhattanVector, s : Double) -> GeodistmanhattanVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn geo_dist_manhattan_vector_dot(a : GeodistmanhattanVector, b : GeodistmanhattanVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn geo_dist_manhattan_vector_norm(v : GeodistmanhattanVector) -> Double { @_common.sqrt(geo_dist_manhattan_vector_dot(v, v)) }

pub fn geo_dist_manhattan_vector_normalize(v : GeodistmanhattanVector) -> GeodistmanhattanVector {
  let n = geo_dist_manhattan_vector_norm(v)
  if n < 0.0000001 { v } else { geo_dist_manhattan_vector_scale(v, 1.0 / n) }
}

pub fn geo_dist_manhattan_vector_dist(a : GeodistmanhattanVector, b : GeodistmanhattanVector) -> Double {
  geo_dist_manhattan_vector_norm(geo_dist_manhattan_vector_sub(a, b))
}

pub fn geo_dist_manhattan_vector_to_string(v : GeodistmanhattanVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn geo_dist_manhattan_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn geo_dist_manhattan_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = geo_dist_manhattan_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_manhattan_std(data : Array[Double]) -> Double { @_common.sqrt(geo_dist_manhattan_var(data)) }

pub fn geo_dist_manhattan_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = geo_dist_manhattan_mean(a); let mb = geo_dist_manhattan_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn geo_dist_manhattan_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = geo_dist_manhattan_std(a); let sb = geo_dist_manhattan_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { geo_dist_manhattan_cov(a, b) / (sa * sb) }
}

pub fn geo_dist_manhattan_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = geo_dist_manhattan_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn geo_dist_manhattan_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn geo_dist_manhattan_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn geo_dist_manhattan_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(geo_dist_manhattan_mse(pred, labels))
}

pub fn geo_dist_manhattan_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn geo_dist_manhattan_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = geo_dist_manhattan_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn geo_dist_manhattan_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn geo_dist_manhattan_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn geo_dist_manhattan_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = geo_dist_manhattan_precision(pred, labels, pos); let r = geo_dist_manhattan_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn geo_dist_manhattan_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn geo_dist_manhattan_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = geo_dist_manhattan_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn geo_dist_manhattan_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn geo_dist_manhattan_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn geo_dist_manhattan_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = geo_dist_manhattan_gcd(a, b)
    (a / g) * b
  }
}

pub fn geo_dist_manhattan_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn geo_dist_manhattan_fibonacci(n : Int) -> Int {
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

pub fn geo_dist_manhattan_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = geo_dist_manhattan_min(data); let mx = geo_dist_manhattan_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn geo_dist_manhattan_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = geo_dist_manhattan_mean(data); let sd = geo_dist_manhattan_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn geo_dist_manhattan_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn geo_dist_manhattan_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn geo_dist_manhattan_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn geo_dist_manhattan_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct GeodistmanhattanFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_frame_make(size : Int) -> GeodistmanhattanFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_frame_len(s : GeodistmanhattanFrame) -> Int { s.size }

pub fn geo_dist_manhattan_frame_get(s : GeodistmanhattanFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_frame_set(s : GeodistmanhattanFrame, i : Int, v : Double) -> GeodistmanhattanFrame {
  let result = geo_dist_manhattan_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_frame_sum(s : GeodistmanhattanFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_frame_mean(s : GeodistmanhattanFrame) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_frame_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_frame_scale(s : GeodistmanhattanFrame, f : Double) -> GeodistmanhattanFrame {
  let result = geo_dist_manhattan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_frame_add(a : GeodistmanhattanFrame, b : GeodistmanhattanFrame) -> GeodistmanhattanFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_frame_copy(s : GeodistmanhattanFrame) -> GeodistmanhattanFrame {
  let result = geo_dist_manhattan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_frame_fill(s : GeodistmanhattanFrame, v : Double) -> GeodistmanhattanFrame {
  let result = geo_dist_manhattan_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_frame_min(s : GeodistmanhattanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_frame_max(s : GeodistmanhattanFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_frame_to_string(s : GeodistmanhattanFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_table_make(size : Int) -> GeodistmanhattanTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_table_len(s : GeodistmanhattanTable) -> Int { s.size }

pub fn geo_dist_manhattan_table_get(s : GeodistmanhattanTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_table_set(s : GeodistmanhattanTable, i : Int, v : Double) -> GeodistmanhattanTable {
  let result = geo_dist_manhattan_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_table_sum(s : GeodistmanhattanTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_table_mean(s : GeodistmanhattanTable) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_table_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_table_scale(s : GeodistmanhattanTable, f : Double) -> GeodistmanhattanTable {
  let result = geo_dist_manhattan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_table_add(a : GeodistmanhattanTable, b : GeodistmanhattanTable) -> GeodistmanhattanTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_table_copy(s : GeodistmanhattanTable) -> GeodistmanhattanTable {
  let result = geo_dist_manhattan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_table_fill(s : GeodistmanhattanTable, v : Double) -> GeodistmanhattanTable {
  let result = geo_dist_manhattan_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_table_min(s : GeodistmanhattanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_table_max(s : GeodistmanhattanTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_table_to_string(s : GeodistmanhattanTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_graphn_make(size : Int) -> GeodistmanhattanGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_graphn_len(s : GeodistmanhattanGraphN) -> Int { s.size }

pub fn geo_dist_manhattan_graphn_get(s : GeodistmanhattanGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_graphn_set(s : GeodistmanhattanGraphN, i : Int, v : Double) -> GeodistmanhattanGraphN {
  let result = geo_dist_manhattan_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_graphn_sum(s : GeodistmanhattanGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_graphn_mean(s : GeodistmanhattanGraphN) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_graphn_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_graphn_scale(s : GeodistmanhattanGraphN, f : Double) -> GeodistmanhattanGraphN {
  let result = geo_dist_manhattan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_graphn_add(a : GeodistmanhattanGraphN, b : GeodistmanhattanGraphN) -> GeodistmanhattanGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_graphn_copy(s : GeodistmanhattanGraphN) -> GeodistmanhattanGraphN {
  let result = geo_dist_manhattan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_graphn_fill(s : GeodistmanhattanGraphN, v : Double) -> GeodistmanhattanGraphN {
  let result = geo_dist_manhattan_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_graphn_min(s : GeodistmanhattanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_graphn_max(s : GeodistmanhattanGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_graphn_to_string(s : GeodistmanhattanGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_node_make(size : Int) -> GeodistmanhattanNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_node_len(s : GeodistmanhattanNode) -> Int { s.size }

pub fn geo_dist_manhattan_node_get(s : GeodistmanhattanNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_node_set(s : GeodistmanhattanNode, i : Int, v : Double) -> GeodistmanhattanNode {
  let result = geo_dist_manhattan_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_node_sum(s : GeodistmanhattanNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_node_mean(s : GeodistmanhattanNode) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_node_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_node_scale(s : GeodistmanhattanNode, f : Double) -> GeodistmanhattanNode {
  let result = geo_dist_manhattan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_node_add(a : GeodistmanhattanNode, b : GeodistmanhattanNode) -> GeodistmanhattanNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_node_copy(s : GeodistmanhattanNode) -> GeodistmanhattanNode {
  let result = geo_dist_manhattan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_node_fill(s : GeodistmanhattanNode, v : Double) -> GeodistmanhattanNode {
  let result = geo_dist_manhattan_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_node_min(s : GeodistmanhattanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_node_max(s : GeodistmanhattanNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_node_to_string(s : GeodistmanhattanNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_edge_make(size : Int) -> GeodistmanhattanEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_edge_len(s : GeodistmanhattanEdge) -> Int { s.size }

pub fn geo_dist_manhattan_edge_get(s : GeodistmanhattanEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_edge_set(s : GeodistmanhattanEdge, i : Int, v : Double) -> GeodistmanhattanEdge {
  let result = geo_dist_manhattan_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_edge_sum(s : GeodistmanhattanEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_edge_mean(s : GeodistmanhattanEdge) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_edge_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_edge_scale(s : GeodistmanhattanEdge, f : Double) -> GeodistmanhattanEdge {
  let result = geo_dist_manhattan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_edge_add(a : GeodistmanhattanEdge, b : GeodistmanhattanEdge) -> GeodistmanhattanEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_edge_copy(s : GeodistmanhattanEdge) -> GeodistmanhattanEdge {
  let result = geo_dist_manhattan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_edge_fill(s : GeodistmanhattanEdge, v : Double) -> GeodistmanhattanEdge {
  let result = geo_dist_manhattan_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_edge_min(s : GeodistmanhattanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_edge_max(s : GeodistmanhattanEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_edge_to_string(s : GeodistmanhattanEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_path_make(size : Int) -> GeodistmanhattanPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_path_len(s : GeodistmanhattanPath) -> Int { s.size }

pub fn geo_dist_manhattan_path_get(s : GeodistmanhattanPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_path_set(s : GeodistmanhattanPath, i : Int, v : Double) -> GeodistmanhattanPath {
  let result = geo_dist_manhattan_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_path_sum(s : GeodistmanhattanPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_path_mean(s : GeodistmanhattanPath) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_path_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_path_scale(s : GeodistmanhattanPath, f : Double) -> GeodistmanhattanPath {
  let result = geo_dist_manhattan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_path_add(a : GeodistmanhattanPath, b : GeodistmanhattanPath) -> GeodistmanhattanPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_path_copy(s : GeodistmanhattanPath) -> GeodistmanhattanPath {
  let result = geo_dist_manhattan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_path_fill(s : GeodistmanhattanPath, v : Double) -> GeodistmanhattanPath {
  let result = geo_dist_manhattan_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_path_min(s : GeodistmanhattanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_path_max(s : GeodistmanhattanPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_path_to_string(s : GeodistmanhattanPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_cluster_make(size : Int) -> GeodistmanhattanCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_cluster_len(s : GeodistmanhattanCluster) -> Int { s.size }

pub fn geo_dist_manhattan_cluster_get(s : GeodistmanhattanCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_cluster_set(s : GeodistmanhattanCluster, i : Int, v : Double) -> GeodistmanhattanCluster {
  let result = geo_dist_manhattan_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_cluster_sum(s : GeodistmanhattanCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_cluster_mean(s : GeodistmanhattanCluster) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_cluster_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_cluster_scale(s : GeodistmanhattanCluster, f : Double) -> GeodistmanhattanCluster {
  let result = geo_dist_manhattan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_cluster_add(a : GeodistmanhattanCluster, b : GeodistmanhattanCluster) -> GeodistmanhattanCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_cluster_copy(s : GeodistmanhattanCluster) -> GeodistmanhattanCluster {
  let result = geo_dist_manhattan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_cluster_fill(s : GeodistmanhattanCluster, v : Double) -> GeodistmanhattanCluster {
  let result = geo_dist_manhattan_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_cluster_min(s : GeodistmanhattanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_cluster_max(s : GeodistmanhattanCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_cluster_to_string(s : GeodistmanhattanCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_model_make(size : Int) -> GeodistmanhattanModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_model_len(s : GeodistmanhattanModel) -> Int { s.size }

pub fn geo_dist_manhattan_model_get(s : GeodistmanhattanModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_model_set(s : GeodistmanhattanModel, i : Int, v : Double) -> GeodistmanhattanModel {
  let result = geo_dist_manhattan_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_model_sum(s : GeodistmanhattanModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_model_mean(s : GeodistmanhattanModel) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_model_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_model_scale(s : GeodistmanhattanModel, f : Double) -> GeodistmanhattanModel {
  let result = geo_dist_manhattan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_model_add(a : GeodistmanhattanModel, b : GeodistmanhattanModel) -> GeodistmanhattanModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_model_copy(s : GeodistmanhattanModel) -> GeodistmanhattanModel {
  let result = geo_dist_manhattan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_model_fill(s : GeodistmanhattanModel, v : Double) -> GeodistmanhattanModel {
  let result = geo_dist_manhattan_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_model_min(s : GeodistmanhattanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_model_max(s : GeodistmanhattanModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_model_to_string(s : GeodistmanhattanModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_layer_make(size : Int) -> GeodistmanhattanLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_layer_len(s : GeodistmanhattanLayer) -> Int { s.size }

pub fn geo_dist_manhattan_layer_get(s : GeodistmanhattanLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_layer_set(s : GeodistmanhattanLayer, i : Int, v : Double) -> GeodistmanhattanLayer {
  let result = geo_dist_manhattan_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_layer_sum(s : GeodistmanhattanLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_layer_mean(s : GeodistmanhattanLayer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_layer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_layer_scale(s : GeodistmanhattanLayer, f : Double) -> GeodistmanhattanLayer {
  let result = geo_dist_manhattan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_layer_add(a : GeodistmanhattanLayer, b : GeodistmanhattanLayer) -> GeodistmanhattanLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_layer_copy(s : GeodistmanhattanLayer) -> GeodistmanhattanLayer {
  let result = geo_dist_manhattan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_layer_fill(s : GeodistmanhattanLayer, v : Double) -> GeodistmanhattanLayer {
  let result = geo_dist_manhattan_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_layer_min(s : GeodistmanhattanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_layer_max(s : GeodistmanhattanLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_layer_to_string(s : GeodistmanhattanLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_buffer_make(size : Int) -> GeodistmanhattanBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_buffer_len(s : GeodistmanhattanBuffer) -> Int { s.size }

pub fn geo_dist_manhattan_buffer_get(s : GeodistmanhattanBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_buffer_set(s : GeodistmanhattanBuffer, i : Int, v : Double) -> GeodistmanhattanBuffer {
  let result = geo_dist_manhattan_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_buffer_sum(s : GeodistmanhattanBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_buffer_mean(s : GeodistmanhattanBuffer) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_buffer_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_buffer_scale(s : GeodistmanhattanBuffer, f : Double) -> GeodistmanhattanBuffer {
  let result = geo_dist_manhattan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_buffer_add(a : GeodistmanhattanBuffer, b : GeodistmanhattanBuffer) -> GeodistmanhattanBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_buffer_copy(s : GeodistmanhattanBuffer) -> GeodistmanhattanBuffer {
  let result = geo_dist_manhattan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_buffer_fill(s : GeodistmanhattanBuffer, v : Double) -> GeodistmanhattanBuffer {
  let result = geo_dist_manhattan_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_buffer_min(s : GeodistmanhattanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_buffer_max(s : GeodistmanhattanBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_buffer_to_string(s : GeodistmanhattanBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_cursor_make(size : Int) -> GeodistmanhattanCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_cursor_len(s : GeodistmanhattanCursor) -> Int { s.size }

pub fn geo_dist_manhattan_cursor_get(s : GeodistmanhattanCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_cursor_set(s : GeodistmanhattanCursor, i : Int, v : Double) -> GeodistmanhattanCursor {
  let result = geo_dist_manhattan_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_cursor_sum(s : GeodistmanhattanCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_cursor_mean(s : GeodistmanhattanCursor) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_cursor_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_cursor_scale(s : GeodistmanhattanCursor, f : Double) -> GeodistmanhattanCursor {
  let result = geo_dist_manhattan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_cursor_add(a : GeodistmanhattanCursor, b : GeodistmanhattanCursor) -> GeodistmanhattanCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_cursor_copy(s : GeodistmanhattanCursor) -> GeodistmanhattanCursor {
  let result = geo_dist_manhattan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_cursor_fill(s : GeodistmanhattanCursor, v : Double) -> GeodistmanhattanCursor {
  let result = geo_dist_manhattan_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_cursor_min(s : GeodistmanhattanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_cursor_max(s : GeodistmanhattanCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_cursor_to_string(s : GeodistmanhattanCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_view_make(size : Int) -> GeodistmanhattanView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_view_len(s : GeodistmanhattanView) -> Int { s.size }

pub fn geo_dist_manhattan_view_get(s : GeodistmanhattanView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_view_set(s : GeodistmanhattanView, i : Int, v : Double) -> GeodistmanhattanView {
  let result = geo_dist_manhattan_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_view_sum(s : GeodistmanhattanView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_view_mean(s : GeodistmanhattanView) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_view_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_view_scale(s : GeodistmanhattanView, f : Double) -> GeodistmanhattanView {
  let result = geo_dist_manhattan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_view_add(a : GeodistmanhattanView, b : GeodistmanhattanView) -> GeodistmanhattanView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_view_copy(s : GeodistmanhattanView) -> GeodistmanhattanView {
  let result = geo_dist_manhattan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_view_fill(s : GeodistmanhattanView, v : Double) -> GeodistmanhattanView {
  let result = geo_dist_manhattan_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_view_min(s : GeodistmanhattanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_view_max(s : GeodistmanhattanView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_view_to_string(s : GeodistmanhattanView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_range_make(size : Int) -> GeodistmanhattanRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_range_len(s : GeodistmanhattanRange) -> Int { s.size }

pub fn geo_dist_manhattan_range_get(s : GeodistmanhattanRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_range_set(s : GeodistmanhattanRange, i : Int, v : Double) -> GeodistmanhattanRange {
  let result = geo_dist_manhattan_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_range_sum(s : GeodistmanhattanRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_range_mean(s : GeodistmanhattanRange) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_range_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_range_scale(s : GeodistmanhattanRange, f : Double) -> GeodistmanhattanRange {
  let result = geo_dist_manhattan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_range_add(a : GeodistmanhattanRange, b : GeodistmanhattanRange) -> GeodistmanhattanRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_range_copy(s : GeodistmanhattanRange) -> GeodistmanhattanRange {
  let result = geo_dist_manhattan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_range_fill(s : GeodistmanhattanRange, v : Double) -> GeodistmanhattanRange {
  let result = geo_dist_manhattan_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_range_min(s : GeodistmanhattanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_range_max(s : GeodistmanhattanRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_range_to_string(s : GeodistmanhattanRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct GeodistmanhattanSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn geo_dist_manhattan_slice_make(size : Int) -> GeodistmanhattanSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn geo_dist_manhattan_slice_len(s : GeodistmanhattanSlice) -> Int { s.size }

pub fn geo_dist_manhattan_slice_get(s : GeodistmanhattanSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn geo_dist_manhattan_slice_set(s : GeodistmanhattanSlice, i : Int, v : Double) -> GeodistmanhattanSlice {
  let result = geo_dist_manhattan_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_slice_sum(s : GeodistmanhattanSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn geo_dist_manhattan_slice_mean(s : GeodistmanhattanSlice) -> Double {
  if s.size == 0 { 0.0 } else { geo_dist_manhattan_slice_sum(s) / s.size.to_double() }
}

pub fn geo_dist_manhattan_slice_scale(s : GeodistmanhattanSlice, f : Double) -> GeodistmanhattanSlice {
  let result = geo_dist_manhattan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn geo_dist_manhattan_slice_add(a : GeodistmanhattanSlice, b : GeodistmanhattanSlice) -> GeodistmanhattanSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = geo_dist_manhattan_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn geo_dist_manhattan_slice_copy(s : GeodistmanhattanSlice) -> GeodistmanhattanSlice {
  let result = geo_dist_manhattan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn geo_dist_manhattan_slice_fill(s : GeodistmanhattanSlice, v : Double) -> GeodistmanhattanSlice {
  let result = geo_dist_manhattan_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn geo_dist_manhattan_slice_min(s : GeodistmanhattanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_slice_max(s : GeodistmanhattanSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn geo_dist_manhattan_slice_to_string(s : GeodistmanhattanSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

