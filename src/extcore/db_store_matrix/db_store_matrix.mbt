///===
/// extcore/db_store_matrix

pub(all) struct DbstorematrixPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_matrix_make_point(x : Double, y : Double) -> DbstorematrixPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_matrix_make_point3(x : Double, y : Double, z : Double) -> DbstorematrixPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_matrix_point_x(pt : DbstorematrixPoint) -> Double { pt.x }

pub fn db_store_matrix_point_y(pt : DbstorematrixPoint) -> Double { pt.y }

pub fn db_store_matrix_point_z(pt : DbstorematrixPoint) -> Double { pt.z }

pub fn db_store_matrix_point_label(pt : DbstorematrixPoint) -> Int { pt.label }

pub fn db_store_matrix_point_dist(a : DbstorematrixPoint, b : DbstorematrixPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_matrix_point_add(a : DbstorematrixPoint, b : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_matrix_point_sub(a : DbstorematrixPoint, b : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_matrix_point_scale(pt : DbstorematrixPoint, s : Double) -> DbstorematrixPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_matrix_point_dot(a : DbstorematrixPoint, b : DbstorematrixPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_matrix_point_cross(a : DbstorematrixPoint, b : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_matrix_point_norm(pt : DbstorematrixPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_matrix_point_normalize(pt : DbstorematrixPoint) -> DbstorematrixPoint {
  let n = db_store_matrix_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_matrix_point_scale(pt, 1.0 / n) }
}

pub fn db_store_matrix_point_negate(pt : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_matrix_point_mid(a : DbstorematrixPoint, b : DbstorematrixPoint) -> DbstorematrixPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_matrix_point_lerp(a : DbstorematrixPoint, b : DbstorematrixPoint, t : Double) -> DbstorematrixPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_matrix_point_to_string(pt : DbstorematrixPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstorematrixSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_matrix_make_series(vals : Array[Double], name : String) -> DbstorematrixSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_matrix_series_len(s : DbstorematrixSeries) -> Int { s.vals.length() }

pub fn db_store_matrix_series_sum(s : DbstorematrixSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_store_matrix_series_mean(s : DbstorematrixSeries) -> Double {
  let n = db_store_matrix_series_len(s)
  if n == 0 { 0.0 } else { db_store_matrix_series_sum(s) / n.to_double() }
}

pub fn db_store_matrix_series_min(s : DbstorematrixSeries) -> Double {
  let n = db_store_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_matrix_series_max(s : DbstorematrixSeries) -> Double {
  let n = db_store_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_matrix_series_range(s : DbstorematrixSeries) -> Double {
  db_store_matrix_series_max(s) - db_store_matrix_series_min(s)
}

pub fn db_store_matrix_series_var(s : DbstorematrixSeries) -> Double {
  let n = db_store_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_store_matrix_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_store_matrix_series_std(s : DbstorematrixSeries) -> Double { @_common.sqrt(db_store_matrix_series_var(s)) }

pub fn db_store_matrix_series_median(s : DbstorematrixSeries) -> Double {
  let n = db_store_matrix_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_store_matrix_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_store_matrix_series_scale(s : DbstorematrixSeries, f : Double) -> DbstorematrixSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_store_matrix_series_add(a : DbstorematrixSeries, b : DbstorematrixSeries) -> DbstorematrixSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_matrix_series_sub(a : DbstorematrixSeries, b : DbstorematrixSeries) -> DbstorematrixSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_matrix_series_normalize(s : DbstorematrixSeries) -> DbstorematrixSeries {
  let mn = db_store_matrix_series_min(s)
  let mx = db_store_matrix_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_matrix_series_cumsum(s : DbstorematrixSeries) -> DbstorematrixSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_matrix_series_to_string(s : DbstorematrixSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorematrixMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_matrix_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorematrixMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_matrix_matrix_identity(n : Int) -> DbstorematrixMatrix {
  let m = db_store_matrix_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_matrix_matrix_get(m : DbstorematrixMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_matrix_matrix_transpose(m : DbstorematrixMatrix) -> DbstorematrixMatrix {
  let result = db_store_matrix_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_matrix_matrix_add(a : DbstorematrixMatrix, b : DbstorematrixMatrix) -> DbstorematrixMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_matrix_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_matrix_matrix_scale(m : DbstorematrixMatrix, s : Double) -> DbstorematrixMatrix {
  let result = db_store_matrix_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_matrix_matrix_multiply(a : DbstorematrixMatrix, b : DbstorematrixMatrix) -> DbstorematrixMatrix {
  if a.cols != b.rows { return db_store_matrix_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_matrix_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_matrix_matrix_trace(m : DbstorematrixMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_matrix_matrix_det(m : DbstorematrixMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_matrix_matrix_norm(m : DbstorematrixMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_matrix_matrix_to_string(m : DbstorematrixMatrix) -> String {
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

pub(all) struct DbstorematrixVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_matrix_make_vector(comps : Array[Double]) -> DbstorematrixVector {
  { comps, dim: comps.length() }
}

pub fn db_store_matrix_vector_zero(dim : Int) -> DbstorematrixVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_matrix_vector_add(a : DbstorematrixVector, b : DbstorematrixVector) -> DbstorematrixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_matrix_vector_sub(a : DbstorematrixVector, b : DbstorematrixVector) -> DbstorematrixVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_matrix_vector_scale(v : DbstorematrixVector, s : Double) -> DbstorematrixVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_store_matrix_vector_dot(a : DbstorematrixVector, b : DbstorematrixVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_matrix_vector_norm(v : DbstorematrixVector) -> Double { @_common.sqrt(db_store_matrix_vector_dot(v, v)) }

pub fn db_store_matrix_vector_normalize(v : DbstorematrixVector) -> DbstorematrixVector {
  let n = db_store_matrix_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_matrix_vector_scale(v, 1.0 / n) }
}

pub fn db_store_matrix_vector_dist(a : DbstorematrixVector, b : DbstorematrixVector) -> Double {
  db_store_matrix_vector_norm(db_store_matrix_vector_sub(a, b))
}

pub fn db_store_matrix_vector_to_string(v : DbstorematrixVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_matrix_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_store_matrix_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_store_matrix_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_store_matrix_std(data : Array[Double]) -> Double { @_common.sqrt(db_store_matrix_var(data)) }

pub fn db_store_matrix_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_store_matrix_mean(a); let mb = db_store_matrix_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_store_matrix_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_store_matrix_std(a); let sb = db_store_matrix_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_store_matrix_cov(a, b) / (sa * sb) }
}

pub fn db_store_matrix_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_store_matrix_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_store_matrix_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_store_matrix_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_store_matrix_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(db_store_matrix_mse(pred, labels))
}

pub fn db_store_matrix_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_store_matrix_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_store_matrix_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_store_matrix_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_store_matrix_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_store_matrix_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_store_matrix_precision(pred, labels, pos); let r = db_store_matrix_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_store_matrix_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_store_matrix_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_store_matrix_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_store_matrix_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_store_matrix_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_store_matrix_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_store_matrix_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_store_matrix_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_store_matrix_fibonacci(n : Int) -> Int {
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

pub fn db_store_matrix_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_store_matrix_min(data); let mx = db_store_matrix_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_store_matrix_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_store_matrix_mean(data); let sd = db_store_matrix_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_store_matrix_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_store_matrix_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_store_matrix_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_store_matrix_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_store_matrix_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_store_matrix_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DbstorematrixFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_frame_make(size : Int) -> DbstorematrixFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_frame_len(s : DbstorematrixFrame) -> Int { s.size }

pub fn db_store_matrix_frame_get(s : DbstorematrixFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_frame_set(s : DbstorematrixFrame, i : Int, v : Double) -> DbstorematrixFrame {
  let result = db_store_matrix_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_frame_sum(s : DbstorematrixFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_frame_mean(s : DbstorematrixFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_frame_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_frame_scale(s : DbstorematrixFrame, f : Double) -> DbstorematrixFrame {
  let result = db_store_matrix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_frame_add(a : DbstorematrixFrame, b : DbstorematrixFrame) -> DbstorematrixFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_frame_copy(s : DbstorematrixFrame) -> DbstorematrixFrame {
  let result = db_store_matrix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_frame_fill(s : DbstorematrixFrame, v : Double) -> DbstorematrixFrame {
  let result = db_store_matrix_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_frame_min(s : DbstorematrixFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_frame_max(s : DbstorematrixFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_frame_to_string(s : DbstorematrixFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_table_make(size : Int) -> DbstorematrixTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_table_len(s : DbstorematrixTable) -> Int { s.size }

pub fn db_store_matrix_table_get(s : DbstorematrixTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_table_set(s : DbstorematrixTable, i : Int, v : Double) -> DbstorematrixTable {
  let result = db_store_matrix_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_table_sum(s : DbstorematrixTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_table_mean(s : DbstorematrixTable) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_table_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_table_scale(s : DbstorematrixTable, f : Double) -> DbstorematrixTable {
  let result = db_store_matrix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_table_add(a : DbstorematrixTable, b : DbstorematrixTable) -> DbstorematrixTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_table_copy(s : DbstorematrixTable) -> DbstorematrixTable {
  let result = db_store_matrix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_table_fill(s : DbstorematrixTable, v : Double) -> DbstorematrixTable {
  let result = db_store_matrix_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_table_min(s : DbstorematrixTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_table_max(s : DbstorematrixTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_table_to_string(s : DbstorematrixTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_graphn_make(size : Int) -> DbstorematrixGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_graphn_len(s : DbstorematrixGraphN) -> Int { s.size }

pub fn db_store_matrix_graphn_get(s : DbstorematrixGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_graphn_set(s : DbstorematrixGraphN, i : Int, v : Double) -> DbstorematrixGraphN {
  let result = db_store_matrix_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_graphn_sum(s : DbstorematrixGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_graphn_mean(s : DbstorematrixGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_graphn_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_graphn_scale(s : DbstorematrixGraphN, f : Double) -> DbstorematrixGraphN {
  let result = db_store_matrix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_graphn_add(a : DbstorematrixGraphN, b : DbstorematrixGraphN) -> DbstorematrixGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_graphn_copy(s : DbstorematrixGraphN) -> DbstorematrixGraphN {
  let result = db_store_matrix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_graphn_fill(s : DbstorematrixGraphN, v : Double) -> DbstorematrixGraphN {
  let result = db_store_matrix_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_graphn_min(s : DbstorematrixGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_graphn_max(s : DbstorematrixGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_graphn_to_string(s : DbstorematrixGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_node_make(size : Int) -> DbstorematrixNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_node_len(s : DbstorematrixNode) -> Int { s.size }

pub fn db_store_matrix_node_get(s : DbstorematrixNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_node_set(s : DbstorematrixNode, i : Int, v : Double) -> DbstorematrixNode {
  let result = db_store_matrix_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_node_sum(s : DbstorematrixNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_node_mean(s : DbstorematrixNode) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_node_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_node_scale(s : DbstorematrixNode, f : Double) -> DbstorematrixNode {
  let result = db_store_matrix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_node_add(a : DbstorematrixNode, b : DbstorematrixNode) -> DbstorematrixNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_node_copy(s : DbstorematrixNode) -> DbstorematrixNode {
  let result = db_store_matrix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_node_fill(s : DbstorematrixNode, v : Double) -> DbstorematrixNode {
  let result = db_store_matrix_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_node_min(s : DbstorematrixNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_node_max(s : DbstorematrixNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_node_to_string(s : DbstorematrixNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_edge_make(size : Int) -> DbstorematrixEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_edge_len(s : DbstorematrixEdge) -> Int { s.size }

pub fn db_store_matrix_edge_get(s : DbstorematrixEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_edge_set(s : DbstorematrixEdge, i : Int, v : Double) -> DbstorematrixEdge {
  let result = db_store_matrix_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_edge_sum(s : DbstorematrixEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_edge_mean(s : DbstorematrixEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_edge_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_edge_scale(s : DbstorematrixEdge, f : Double) -> DbstorematrixEdge {
  let result = db_store_matrix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_edge_add(a : DbstorematrixEdge, b : DbstorematrixEdge) -> DbstorematrixEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_edge_copy(s : DbstorematrixEdge) -> DbstorematrixEdge {
  let result = db_store_matrix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_edge_fill(s : DbstorematrixEdge, v : Double) -> DbstorematrixEdge {
  let result = db_store_matrix_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_edge_min(s : DbstorematrixEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_edge_max(s : DbstorematrixEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_edge_to_string(s : DbstorematrixEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_path_make(size : Int) -> DbstorematrixPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_path_len(s : DbstorematrixPath) -> Int { s.size }

pub fn db_store_matrix_path_get(s : DbstorematrixPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_path_set(s : DbstorematrixPath, i : Int, v : Double) -> DbstorematrixPath {
  let result = db_store_matrix_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_path_sum(s : DbstorematrixPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_path_mean(s : DbstorematrixPath) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_path_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_path_scale(s : DbstorematrixPath, f : Double) -> DbstorematrixPath {
  let result = db_store_matrix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_path_add(a : DbstorematrixPath, b : DbstorematrixPath) -> DbstorematrixPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_path_copy(s : DbstorematrixPath) -> DbstorematrixPath {
  let result = db_store_matrix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_path_fill(s : DbstorematrixPath, v : Double) -> DbstorematrixPath {
  let result = db_store_matrix_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_path_min(s : DbstorematrixPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_path_max(s : DbstorematrixPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_path_to_string(s : DbstorematrixPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_cluster_make(size : Int) -> DbstorematrixCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_cluster_len(s : DbstorematrixCluster) -> Int { s.size }

pub fn db_store_matrix_cluster_get(s : DbstorematrixCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_cluster_set(s : DbstorematrixCluster, i : Int, v : Double) -> DbstorematrixCluster {
  let result = db_store_matrix_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_cluster_sum(s : DbstorematrixCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_cluster_mean(s : DbstorematrixCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_cluster_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_cluster_scale(s : DbstorematrixCluster, f : Double) -> DbstorematrixCluster {
  let result = db_store_matrix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_cluster_add(a : DbstorematrixCluster, b : DbstorematrixCluster) -> DbstorematrixCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_cluster_copy(s : DbstorematrixCluster) -> DbstorematrixCluster {
  let result = db_store_matrix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_cluster_fill(s : DbstorematrixCluster, v : Double) -> DbstorematrixCluster {
  let result = db_store_matrix_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_cluster_min(s : DbstorematrixCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_cluster_max(s : DbstorematrixCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_cluster_to_string(s : DbstorematrixCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_model_make(size : Int) -> DbstorematrixModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_model_len(s : DbstorematrixModel) -> Int { s.size }

pub fn db_store_matrix_model_get(s : DbstorematrixModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_model_set(s : DbstorematrixModel, i : Int, v : Double) -> DbstorematrixModel {
  let result = db_store_matrix_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_model_sum(s : DbstorematrixModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_model_mean(s : DbstorematrixModel) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_model_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_model_scale(s : DbstorematrixModel, f : Double) -> DbstorematrixModel {
  let result = db_store_matrix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_model_add(a : DbstorematrixModel, b : DbstorematrixModel) -> DbstorematrixModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_model_copy(s : DbstorematrixModel) -> DbstorematrixModel {
  let result = db_store_matrix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_model_fill(s : DbstorematrixModel, v : Double) -> DbstorematrixModel {
  let result = db_store_matrix_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_model_min(s : DbstorematrixModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_model_max(s : DbstorematrixModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_model_to_string(s : DbstorematrixModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_layer_make(size : Int) -> DbstorematrixLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_layer_len(s : DbstorematrixLayer) -> Int { s.size }

pub fn db_store_matrix_layer_get(s : DbstorematrixLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_layer_set(s : DbstorematrixLayer, i : Int, v : Double) -> DbstorematrixLayer {
  let result = db_store_matrix_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_layer_sum(s : DbstorematrixLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_layer_mean(s : DbstorematrixLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_layer_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_layer_scale(s : DbstorematrixLayer, f : Double) -> DbstorematrixLayer {
  let result = db_store_matrix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_layer_add(a : DbstorematrixLayer, b : DbstorematrixLayer) -> DbstorematrixLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_layer_copy(s : DbstorematrixLayer) -> DbstorematrixLayer {
  let result = db_store_matrix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_layer_fill(s : DbstorematrixLayer, v : Double) -> DbstorematrixLayer {
  let result = db_store_matrix_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_layer_min(s : DbstorematrixLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_layer_max(s : DbstorematrixLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_layer_to_string(s : DbstorematrixLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_buffer_make(size : Int) -> DbstorematrixBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_buffer_len(s : DbstorematrixBuffer) -> Int { s.size }

pub fn db_store_matrix_buffer_get(s : DbstorematrixBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_buffer_set(s : DbstorematrixBuffer, i : Int, v : Double) -> DbstorematrixBuffer {
  let result = db_store_matrix_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_buffer_sum(s : DbstorematrixBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_buffer_mean(s : DbstorematrixBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_buffer_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_buffer_scale(s : DbstorematrixBuffer, f : Double) -> DbstorematrixBuffer {
  let result = db_store_matrix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_buffer_add(a : DbstorematrixBuffer, b : DbstorematrixBuffer) -> DbstorematrixBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_buffer_copy(s : DbstorematrixBuffer) -> DbstorematrixBuffer {
  let result = db_store_matrix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_buffer_fill(s : DbstorematrixBuffer, v : Double) -> DbstorematrixBuffer {
  let result = db_store_matrix_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_buffer_min(s : DbstorematrixBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_buffer_max(s : DbstorematrixBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_buffer_to_string(s : DbstorematrixBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_cursor_make(size : Int) -> DbstorematrixCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_cursor_len(s : DbstorematrixCursor) -> Int { s.size }

pub fn db_store_matrix_cursor_get(s : DbstorematrixCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_cursor_set(s : DbstorematrixCursor, i : Int, v : Double) -> DbstorematrixCursor {
  let result = db_store_matrix_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_cursor_sum(s : DbstorematrixCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_cursor_mean(s : DbstorematrixCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_cursor_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_cursor_scale(s : DbstorematrixCursor, f : Double) -> DbstorematrixCursor {
  let result = db_store_matrix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_cursor_add(a : DbstorematrixCursor, b : DbstorematrixCursor) -> DbstorematrixCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_cursor_copy(s : DbstorematrixCursor) -> DbstorematrixCursor {
  let result = db_store_matrix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_cursor_fill(s : DbstorematrixCursor, v : Double) -> DbstorematrixCursor {
  let result = db_store_matrix_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_cursor_min(s : DbstorematrixCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_cursor_max(s : DbstorematrixCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_cursor_to_string(s : DbstorematrixCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_view_make(size : Int) -> DbstorematrixView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_view_len(s : DbstorematrixView) -> Int { s.size }

pub fn db_store_matrix_view_get(s : DbstorematrixView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_view_set(s : DbstorematrixView, i : Int, v : Double) -> DbstorematrixView {
  let result = db_store_matrix_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_view_sum(s : DbstorematrixView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_view_mean(s : DbstorematrixView) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_view_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_view_scale(s : DbstorematrixView, f : Double) -> DbstorematrixView {
  let result = db_store_matrix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_view_add(a : DbstorematrixView, b : DbstorematrixView) -> DbstorematrixView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_view_copy(s : DbstorematrixView) -> DbstorematrixView {
  let result = db_store_matrix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_view_fill(s : DbstorematrixView, v : Double) -> DbstorematrixView {
  let result = db_store_matrix_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_view_min(s : DbstorematrixView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_view_max(s : DbstorematrixView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_view_to_string(s : DbstorematrixView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_range_make(size : Int) -> DbstorematrixRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_range_len(s : DbstorematrixRange) -> Int { s.size }

pub fn db_store_matrix_range_get(s : DbstorematrixRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_range_set(s : DbstorematrixRange, i : Int, v : Double) -> DbstorematrixRange {
  let result = db_store_matrix_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_range_sum(s : DbstorematrixRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_range_mean(s : DbstorematrixRange) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_range_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_range_scale(s : DbstorematrixRange, f : Double) -> DbstorematrixRange {
  let result = db_store_matrix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_range_add(a : DbstorematrixRange, b : DbstorematrixRange) -> DbstorematrixRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_range_copy(s : DbstorematrixRange) -> DbstorematrixRange {
  let result = db_store_matrix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_range_fill(s : DbstorematrixRange, v : Double) -> DbstorematrixRange {
  let result = db_store_matrix_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_range_min(s : DbstorematrixRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_range_max(s : DbstorematrixRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_range_to_string(s : DbstorematrixRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorematrixSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_matrix_slice_make(size : Int) -> DbstorematrixSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_matrix_slice_len(s : DbstorematrixSlice) -> Int { s.size }

pub fn db_store_matrix_slice_get(s : DbstorematrixSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_matrix_slice_set(s : DbstorematrixSlice, i : Int, v : Double) -> DbstorematrixSlice {
  let result = db_store_matrix_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_slice_sum(s : DbstorematrixSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_matrix_slice_mean(s : DbstorematrixSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_store_matrix_slice_sum(s) / s.size.to_double() }
}

pub fn db_store_matrix_slice_scale(s : DbstorematrixSlice, f : Double) -> DbstorematrixSlice {
  let result = db_store_matrix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_matrix_slice_add(a : DbstorematrixSlice, b : DbstorematrixSlice) -> DbstorematrixSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_matrix_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_matrix_slice_copy(s : DbstorematrixSlice) -> DbstorematrixSlice {
  let result = db_store_matrix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_matrix_slice_fill(s : DbstorematrixSlice, v : Double) -> DbstorematrixSlice {
  let result = db_store_matrix_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_matrix_slice_min(s : DbstorematrixSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_slice_max(s : DbstorematrixSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_matrix_slice_to_string(s : DbstorematrixSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

