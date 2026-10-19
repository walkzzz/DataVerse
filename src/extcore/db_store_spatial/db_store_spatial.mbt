///===
/// extcore/db_store_spatial

pub(all) struct DbstorespatialPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_spatial_make_point(x : Double, y : Double) -> DbstorespatialPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_spatial_make_point3(x : Double, y : Double, z : Double) -> DbstorespatialPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_spatial_point_x(pt : DbstorespatialPoint) -> Double { pt.x }

pub fn db_store_spatial_point_y(pt : DbstorespatialPoint) -> Double { pt.y }

pub fn db_store_spatial_point_z(pt : DbstorespatialPoint) -> Double { pt.z }

pub fn db_store_spatial_point_label(pt : DbstorespatialPoint) -> Int { pt.label }

pub fn db_store_spatial_point_dist(a : DbstorespatialPoint, b : DbstorespatialPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_spatial_point_add(a : DbstorespatialPoint, b : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_spatial_point_sub(a : DbstorespatialPoint, b : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_spatial_point_scale(pt : DbstorespatialPoint, s : Double) -> DbstorespatialPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_spatial_point_dot(a : DbstorespatialPoint, b : DbstorespatialPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_spatial_point_cross(a : DbstorespatialPoint, b : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_spatial_point_norm(pt : DbstorespatialPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_spatial_point_normalize(pt : DbstorespatialPoint) -> DbstorespatialPoint {
  let n = db_store_spatial_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_spatial_point_scale(pt, 1.0 / n) }
}

pub fn db_store_spatial_point_negate(pt : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_spatial_point_mid(a : DbstorespatialPoint, b : DbstorespatialPoint) -> DbstorespatialPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_spatial_point_lerp(a : DbstorespatialPoint, b : DbstorespatialPoint, t : Double) -> DbstorespatialPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_spatial_point_to_string(pt : DbstorespatialPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstorespatialSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_spatial_make_series(vals : Array[Double], name : String) -> DbstorespatialSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_spatial_series_len(s : DbstorespatialSeries) -> Int { s.vals.length() }

pub fn db_store_spatial_series_sum(s : DbstorespatialSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_store_spatial_series_mean(s : DbstorespatialSeries) -> Double {
  let n = db_store_spatial_series_len(s)
  if n == 0 { 0.0 } else { db_store_spatial_series_sum(s) / n.to_double() }
}

pub fn db_store_spatial_series_min(s : DbstorespatialSeries) -> Double {
  let n = db_store_spatial_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_spatial_series_max(s : DbstorespatialSeries) -> Double {
  let n = db_store_spatial_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_spatial_series_range(s : DbstorespatialSeries) -> Double {
  db_store_spatial_series_max(s) - db_store_spatial_series_min(s)
}

pub fn db_store_spatial_series_var(s : DbstorespatialSeries) -> Double {
  let n = db_store_spatial_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_store_spatial_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_store_spatial_series_std(s : DbstorespatialSeries) -> Double { @_common.sqrt(db_store_spatial_series_var(s)) }

pub fn db_store_spatial_series_median(s : DbstorespatialSeries) -> Double {
  let n = db_store_spatial_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_store_spatial_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_store_spatial_series_scale(s : DbstorespatialSeries, f : Double) -> DbstorespatialSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_store_spatial_series_add(a : DbstorespatialSeries, b : DbstorespatialSeries) -> DbstorespatialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_spatial_series_sub(a : DbstorespatialSeries, b : DbstorespatialSeries) -> DbstorespatialSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_spatial_series_normalize(s : DbstorespatialSeries) -> DbstorespatialSeries {
  let mn = db_store_spatial_series_min(s)
  let mx = db_store_spatial_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_spatial_series_cumsum(s : DbstorespatialSeries) -> DbstorespatialSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_spatial_series_to_string(s : DbstorespatialSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorespatialMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_spatial_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorespatialMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_spatial_matrix_identity(n : Int) -> DbstorespatialMatrix {
  let m = db_store_spatial_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_spatial_matrix_get(m : DbstorespatialMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_spatial_matrix_transpose(m : DbstorespatialMatrix) -> DbstorespatialMatrix {
  let result = db_store_spatial_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_spatial_matrix_add(a : DbstorespatialMatrix, b : DbstorespatialMatrix) -> DbstorespatialMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_spatial_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_spatial_matrix_scale(m : DbstorespatialMatrix, s : Double) -> DbstorespatialMatrix {
  let result = db_store_spatial_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_spatial_matrix_multiply(a : DbstorespatialMatrix, b : DbstorespatialMatrix) -> DbstorespatialMatrix {
  if a.cols != b.rows { return db_store_spatial_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_spatial_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_spatial_matrix_trace(m : DbstorespatialMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_spatial_matrix_det(m : DbstorespatialMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_spatial_matrix_norm(m : DbstorespatialMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_spatial_matrix_to_string(m : DbstorespatialMatrix) -> String {
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

pub(all) struct DbstorespatialVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_spatial_make_vector(comps : Array[Double]) -> DbstorespatialVector {
  { comps, dim: comps.length() }
}

pub fn db_store_spatial_vector_zero(dim : Int) -> DbstorespatialVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_spatial_vector_add(a : DbstorespatialVector, b : DbstorespatialVector) -> DbstorespatialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_spatial_vector_sub(a : DbstorespatialVector, b : DbstorespatialVector) -> DbstorespatialVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_spatial_vector_scale(v : DbstorespatialVector, s : Double) -> DbstorespatialVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_store_spatial_vector_dot(a : DbstorespatialVector, b : DbstorespatialVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_spatial_vector_norm(v : DbstorespatialVector) -> Double { @_common.sqrt(db_store_spatial_vector_dot(v, v)) }

pub fn db_store_spatial_vector_normalize(v : DbstorespatialVector) -> DbstorespatialVector {
  let n = db_store_spatial_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_spatial_vector_scale(v, 1.0 / n) }
}

pub fn db_store_spatial_vector_dist(a : DbstorespatialVector, b : DbstorespatialVector) -> Double {
  db_store_spatial_vector_norm(db_store_spatial_vector_sub(a, b))
}

pub fn db_store_spatial_vector_to_string(v : DbstorespatialVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_spatial_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_store_spatial_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_store_spatial_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_store_spatial_std(data : Array[Double]) -> Double { @_common.sqrt(db_store_spatial_var(data)) }

pub fn db_store_spatial_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_store_spatial_mean(a); let mb = db_store_spatial_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_store_spatial_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_store_spatial_std(a); let sb = db_store_spatial_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_store_spatial_cov(a, b) / (sa * sb) }
}

pub fn db_store_spatial_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_store_spatial_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_store_spatial_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_store_spatial_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_store_spatial_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(db_store_spatial_mse(pred, labels))
}

pub fn db_store_spatial_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_store_spatial_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_store_spatial_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_store_spatial_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_store_spatial_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_store_spatial_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_store_spatial_precision(pred, labels, pos); let r = db_store_spatial_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_store_spatial_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_store_spatial_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_store_spatial_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_store_spatial_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_store_spatial_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_store_spatial_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_store_spatial_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_store_spatial_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_store_spatial_fibonacci(n : Int) -> Int {
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

pub fn db_store_spatial_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_store_spatial_min(data); let mx = db_store_spatial_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_store_spatial_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_store_spatial_mean(data); let sd = db_store_spatial_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_store_spatial_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_store_spatial_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_store_spatial_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_store_spatial_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_store_spatial_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_store_spatial_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DbstorespatialFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_frame_make(size : Int) -> DbstorespatialFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_frame_len(s : DbstorespatialFrame) -> Int { s.size }

pub fn db_store_spatial_frame_get(s : DbstorespatialFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_frame_set(s : DbstorespatialFrame, i : Int, v : Double) -> DbstorespatialFrame {
  let result = db_store_spatial_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_frame_sum(s : DbstorespatialFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_frame_mean(s : DbstorespatialFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_frame_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_frame_scale(s : DbstorespatialFrame, f : Double) -> DbstorespatialFrame {
  let result = db_store_spatial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_frame_add(a : DbstorespatialFrame, b : DbstorespatialFrame) -> DbstorespatialFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_frame_copy(s : DbstorespatialFrame) -> DbstorespatialFrame {
  let result = db_store_spatial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_frame_fill(s : DbstorespatialFrame, v : Double) -> DbstorespatialFrame {
  let result = db_store_spatial_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_frame_min(s : DbstorespatialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_frame_max(s : DbstorespatialFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_frame_to_string(s : DbstorespatialFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_table_make(size : Int) -> DbstorespatialTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_table_len(s : DbstorespatialTable) -> Int { s.size }

pub fn db_store_spatial_table_get(s : DbstorespatialTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_table_set(s : DbstorespatialTable, i : Int, v : Double) -> DbstorespatialTable {
  let result = db_store_spatial_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_table_sum(s : DbstorespatialTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_table_mean(s : DbstorespatialTable) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_table_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_table_scale(s : DbstorespatialTable, f : Double) -> DbstorespatialTable {
  let result = db_store_spatial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_table_add(a : DbstorespatialTable, b : DbstorespatialTable) -> DbstorespatialTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_table_copy(s : DbstorespatialTable) -> DbstorespatialTable {
  let result = db_store_spatial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_table_fill(s : DbstorespatialTable, v : Double) -> DbstorespatialTable {
  let result = db_store_spatial_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_table_min(s : DbstorespatialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_table_max(s : DbstorespatialTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_table_to_string(s : DbstorespatialTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_graphn_make(size : Int) -> DbstorespatialGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_graphn_len(s : DbstorespatialGraphN) -> Int { s.size }

pub fn db_store_spatial_graphn_get(s : DbstorespatialGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_graphn_set(s : DbstorespatialGraphN, i : Int, v : Double) -> DbstorespatialGraphN {
  let result = db_store_spatial_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_graphn_sum(s : DbstorespatialGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_graphn_mean(s : DbstorespatialGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_graphn_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_graphn_scale(s : DbstorespatialGraphN, f : Double) -> DbstorespatialGraphN {
  let result = db_store_spatial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_graphn_add(a : DbstorespatialGraphN, b : DbstorespatialGraphN) -> DbstorespatialGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_graphn_copy(s : DbstorespatialGraphN) -> DbstorespatialGraphN {
  let result = db_store_spatial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_graphn_fill(s : DbstorespatialGraphN, v : Double) -> DbstorespatialGraphN {
  let result = db_store_spatial_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_graphn_min(s : DbstorespatialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_graphn_max(s : DbstorespatialGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_graphn_to_string(s : DbstorespatialGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_node_make(size : Int) -> DbstorespatialNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_node_len(s : DbstorespatialNode) -> Int { s.size }

pub fn db_store_spatial_node_get(s : DbstorespatialNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_node_set(s : DbstorespatialNode, i : Int, v : Double) -> DbstorespatialNode {
  let result = db_store_spatial_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_node_sum(s : DbstorespatialNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_node_mean(s : DbstorespatialNode) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_node_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_node_scale(s : DbstorespatialNode, f : Double) -> DbstorespatialNode {
  let result = db_store_spatial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_node_add(a : DbstorespatialNode, b : DbstorespatialNode) -> DbstorespatialNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_node_copy(s : DbstorespatialNode) -> DbstorespatialNode {
  let result = db_store_spatial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_node_fill(s : DbstorespatialNode, v : Double) -> DbstorespatialNode {
  let result = db_store_spatial_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_node_min(s : DbstorespatialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_node_max(s : DbstorespatialNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_node_to_string(s : DbstorespatialNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_edge_make(size : Int) -> DbstorespatialEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_edge_len(s : DbstorespatialEdge) -> Int { s.size }

pub fn db_store_spatial_edge_get(s : DbstorespatialEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_edge_set(s : DbstorespatialEdge, i : Int, v : Double) -> DbstorespatialEdge {
  let result = db_store_spatial_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_edge_sum(s : DbstorespatialEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_edge_mean(s : DbstorespatialEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_edge_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_edge_scale(s : DbstorespatialEdge, f : Double) -> DbstorespatialEdge {
  let result = db_store_spatial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_edge_add(a : DbstorespatialEdge, b : DbstorespatialEdge) -> DbstorespatialEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_edge_copy(s : DbstorespatialEdge) -> DbstorespatialEdge {
  let result = db_store_spatial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_edge_fill(s : DbstorespatialEdge, v : Double) -> DbstorespatialEdge {
  let result = db_store_spatial_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_edge_min(s : DbstorespatialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_edge_max(s : DbstorespatialEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_edge_to_string(s : DbstorespatialEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_path_make(size : Int) -> DbstorespatialPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_path_len(s : DbstorespatialPath) -> Int { s.size }

pub fn db_store_spatial_path_get(s : DbstorespatialPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_path_set(s : DbstorespatialPath, i : Int, v : Double) -> DbstorespatialPath {
  let result = db_store_spatial_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_path_sum(s : DbstorespatialPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_path_mean(s : DbstorespatialPath) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_path_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_path_scale(s : DbstorespatialPath, f : Double) -> DbstorespatialPath {
  let result = db_store_spatial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_path_add(a : DbstorespatialPath, b : DbstorespatialPath) -> DbstorespatialPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_path_copy(s : DbstorespatialPath) -> DbstorespatialPath {
  let result = db_store_spatial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_path_fill(s : DbstorespatialPath, v : Double) -> DbstorespatialPath {
  let result = db_store_spatial_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_path_min(s : DbstorespatialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_path_max(s : DbstorespatialPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_path_to_string(s : DbstorespatialPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_cluster_make(size : Int) -> DbstorespatialCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_cluster_len(s : DbstorespatialCluster) -> Int { s.size }

pub fn db_store_spatial_cluster_get(s : DbstorespatialCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_cluster_set(s : DbstorespatialCluster, i : Int, v : Double) -> DbstorespatialCluster {
  let result = db_store_spatial_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_cluster_sum(s : DbstorespatialCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_cluster_mean(s : DbstorespatialCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_cluster_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_cluster_scale(s : DbstorespatialCluster, f : Double) -> DbstorespatialCluster {
  let result = db_store_spatial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_cluster_add(a : DbstorespatialCluster, b : DbstorespatialCluster) -> DbstorespatialCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_cluster_copy(s : DbstorespatialCluster) -> DbstorespatialCluster {
  let result = db_store_spatial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_cluster_fill(s : DbstorespatialCluster, v : Double) -> DbstorespatialCluster {
  let result = db_store_spatial_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_cluster_min(s : DbstorespatialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_cluster_max(s : DbstorespatialCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_cluster_to_string(s : DbstorespatialCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_model_make(size : Int) -> DbstorespatialModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_model_len(s : DbstorespatialModel) -> Int { s.size }

pub fn db_store_spatial_model_get(s : DbstorespatialModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_model_set(s : DbstorespatialModel, i : Int, v : Double) -> DbstorespatialModel {
  let result = db_store_spatial_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_model_sum(s : DbstorespatialModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_model_mean(s : DbstorespatialModel) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_model_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_model_scale(s : DbstorespatialModel, f : Double) -> DbstorespatialModel {
  let result = db_store_spatial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_model_add(a : DbstorespatialModel, b : DbstorespatialModel) -> DbstorespatialModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_model_copy(s : DbstorespatialModel) -> DbstorespatialModel {
  let result = db_store_spatial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_model_fill(s : DbstorespatialModel, v : Double) -> DbstorespatialModel {
  let result = db_store_spatial_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_model_min(s : DbstorespatialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_model_max(s : DbstorespatialModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_model_to_string(s : DbstorespatialModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_layer_make(size : Int) -> DbstorespatialLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_layer_len(s : DbstorespatialLayer) -> Int { s.size }

pub fn db_store_spatial_layer_get(s : DbstorespatialLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_layer_set(s : DbstorespatialLayer, i : Int, v : Double) -> DbstorespatialLayer {
  let result = db_store_spatial_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_layer_sum(s : DbstorespatialLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_layer_mean(s : DbstorespatialLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_layer_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_layer_scale(s : DbstorespatialLayer, f : Double) -> DbstorespatialLayer {
  let result = db_store_spatial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_layer_add(a : DbstorespatialLayer, b : DbstorespatialLayer) -> DbstorespatialLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_layer_copy(s : DbstorespatialLayer) -> DbstorespatialLayer {
  let result = db_store_spatial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_layer_fill(s : DbstorespatialLayer, v : Double) -> DbstorespatialLayer {
  let result = db_store_spatial_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_layer_min(s : DbstorespatialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_layer_max(s : DbstorespatialLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_layer_to_string(s : DbstorespatialLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_buffer_make(size : Int) -> DbstorespatialBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_buffer_len(s : DbstorespatialBuffer) -> Int { s.size }

pub fn db_store_spatial_buffer_get(s : DbstorespatialBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_buffer_set(s : DbstorespatialBuffer, i : Int, v : Double) -> DbstorespatialBuffer {
  let result = db_store_spatial_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_buffer_sum(s : DbstorespatialBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_buffer_mean(s : DbstorespatialBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_buffer_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_buffer_scale(s : DbstorespatialBuffer, f : Double) -> DbstorespatialBuffer {
  let result = db_store_spatial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_buffer_add(a : DbstorespatialBuffer, b : DbstorespatialBuffer) -> DbstorespatialBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_buffer_copy(s : DbstorespatialBuffer) -> DbstorespatialBuffer {
  let result = db_store_spatial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_buffer_fill(s : DbstorespatialBuffer, v : Double) -> DbstorespatialBuffer {
  let result = db_store_spatial_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_buffer_min(s : DbstorespatialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_buffer_max(s : DbstorespatialBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_buffer_to_string(s : DbstorespatialBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_cursor_make(size : Int) -> DbstorespatialCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_cursor_len(s : DbstorespatialCursor) -> Int { s.size }

pub fn db_store_spatial_cursor_get(s : DbstorespatialCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_cursor_set(s : DbstorespatialCursor, i : Int, v : Double) -> DbstorespatialCursor {
  let result = db_store_spatial_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_cursor_sum(s : DbstorespatialCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_cursor_mean(s : DbstorespatialCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_cursor_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_cursor_scale(s : DbstorespatialCursor, f : Double) -> DbstorespatialCursor {
  let result = db_store_spatial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_cursor_add(a : DbstorespatialCursor, b : DbstorespatialCursor) -> DbstorespatialCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_cursor_copy(s : DbstorespatialCursor) -> DbstorespatialCursor {
  let result = db_store_spatial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_cursor_fill(s : DbstorespatialCursor, v : Double) -> DbstorespatialCursor {
  let result = db_store_spatial_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_cursor_min(s : DbstorespatialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_cursor_max(s : DbstorespatialCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_cursor_to_string(s : DbstorespatialCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_view_make(size : Int) -> DbstorespatialView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_view_len(s : DbstorespatialView) -> Int { s.size }

pub fn db_store_spatial_view_get(s : DbstorespatialView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_view_set(s : DbstorespatialView, i : Int, v : Double) -> DbstorespatialView {
  let result = db_store_spatial_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_view_sum(s : DbstorespatialView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_view_mean(s : DbstorespatialView) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_view_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_view_scale(s : DbstorespatialView, f : Double) -> DbstorespatialView {
  let result = db_store_spatial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_view_add(a : DbstorespatialView, b : DbstorespatialView) -> DbstorespatialView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_view_copy(s : DbstorespatialView) -> DbstorespatialView {
  let result = db_store_spatial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_view_fill(s : DbstorespatialView, v : Double) -> DbstorespatialView {
  let result = db_store_spatial_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_view_min(s : DbstorespatialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_view_max(s : DbstorespatialView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_view_to_string(s : DbstorespatialView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_range_make(size : Int) -> DbstorespatialRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_range_len(s : DbstorespatialRange) -> Int { s.size }

pub fn db_store_spatial_range_get(s : DbstorespatialRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_range_set(s : DbstorespatialRange, i : Int, v : Double) -> DbstorespatialRange {
  let result = db_store_spatial_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_range_sum(s : DbstorespatialRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_range_mean(s : DbstorespatialRange) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_range_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_range_scale(s : DbstorespatialRange, f : Double) -> DbstorespatialRange {
  let result = db_store_spatial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_range_add(a : DbstorespatialRange, b : DbstorespatialRange) -> DbstorespatialRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_range_copy(s : DbstorespatialRange) -> DbstorespatialRange {
  let result = db_store_spatial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_range_fill(s : DbstorespatialRange, v : Double) -> DbstorespatialRange {
  let result = db_store_spatial_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_range_min(s : DbstorespatialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_range_max(s : DbstorespatialRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_range_to_string(s : DbstorespatialRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorespatialSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_spatial_slice_make(size : Int) -> DbstorespatialSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_spatial_slice_len(s : DbstorespatialSlice) -> Int { s.size }

pub fn db_store_spatial_slice_get(s : DbstorespatialSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_spatial_slice_set(s : DbstorespatialSlice, i : Int, v : Double) -> DbstorespatialSlice {
  let result = db_store_spatial_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_slice_sum(s : DbstorespatialSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_spatial_slice_mean(s : DbstorespatialSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_store_spatial_slice_sum(s) / s.size.to_double() }
}

pub fn db_store_spatial_slice_scale(s : DbstorespatialSlice, f : Double) -> DbstorespatialSlice {
  let result = db_store_spatial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_spatial_slice_add(a : DbstorespatialSlice, b : DbstorespatialSlice) -> DbstorespatialSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_spatial_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_spatial_slice_copy(s : DbstorespatialSlice) -> DbstorespatialSlice {
  let result = db_store_spatial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_spatial_slice_fill(s : DbstorespatialSlice, v : Double) -> DbstorespatialSlice {
  let result = db_store_spatial_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_spatial_slice_min(s : DbstorespatialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_slice_max(s : DbstorespatialSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_spatial_slice_to_string(s : DbstorespatialSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

