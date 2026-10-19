///===
/// extcore/db_index_lsm

pub(all) struct DbindexlsmPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_lsm_make_point(x : Double, y : Double) -> DbindexlsmPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_lsm_make_point3(x : Double, y : Double, z : Double) -> DbindexlsmPoint {
  { x, y, z, label: 0 }
}

pub fn db_index_lsm_point_x(pt : DbindexlsmPoint) -> Double { pt.x }

pub fn db_index_lsm_point_y(pt : DbindexlsmPoint) -> Double { pt.y }

pub fn db_index_lsm_point_z(pt : DbindexlsmPoint) -> Double { pt.z }

pub fn db_index_lsm_point_label(pt : DbindexlsmPoint) -> Int { pt.label }

pub fn db_index_lsm_point_dist(a : DbindexlsmPoint, b : DbindexlsmPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_index_lsm_point_add(a : DbindexlsmPoint, b : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_index_lsm_point_sub(a : DbindexlsmPoint, b : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_index_lsm_point_scale(pt : DbindexlsmPoint, s : Double) -> DbindexlsmPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_index_lsm_point_dot(a : DbindexlsmPoint, b : DbindexlsmPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_index_lsm_point_cross(a : DbindexlsmPoint, b : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_index_lsm_point_norm(pt : DbindexlsmPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_index_lsm_point_normalize(pt : DbindexlsmPoint) -> DbindexlsmPoint {
  let n = db_index_lsm_point_norm(pt)
  if n < 0.0000001 { pt } else { db_index_lsm_point_scale(pt, 1.0 / n) }
}

pub fn db_index_lsm_point_negate(pt : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_index_lsm_point_mid(a : DbindexlsmPoint, b : DbindexlsmPoint) -> DbindexlsmPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_index_lsm_point_lerp(a : DbindexlsmPoint, b : DbindexlsmPoint, t : Double) -> DbindexlsmPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_index_lsm_point_to_string(pt : DbindexlsmPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbindexlsmSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_lsm_make_series(vals : Array[Double], name : String) -> DbindexlsmSeries {
  { vals, name, meta: 0 }
}

pub fn db_index_lsm_series_len(s : DbindexlsmSeries) -> Int { s.vals.length() }

pub fn db_index_lsm_series_sum(s : DbindexlsmSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_index_lsm_series_mean(s : DbindexlsmSeries) -> Double {
  let n = db_index_lsm_series_len(s)
  if n == 0 { 0.0 } else { db_index_lsm_series_sum(s) / n.to_double() }
}

pub fn db_index_lsm_series_min(s : DbindexlsmSeries) -> Double {
  let n = db_index_lsm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_lsm_series_max(s : DbindexlsmSeries) -> Double {
  let n = db_index_lsm_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_lsm_series_range(s : DbindexlsmSeries) -> Double {
  db_index_lsm_series_max(s) - db_index_lsm_series_min(s)
}

pub fn db_index_lsm_series_var(s : DbindexlsmSeries) -> Double {
  let n = db_index_lsm_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_index_lsm_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_index_lsm_series_std(s : DbindexlsmSeries) -> Double { @_common.sqrt(db_index_lsm_series_var(s)) }

pub fn db_index_lsm_series_median(s : DbindexlsmSeries) -> Double {
  let n = db_index_lsm_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_index_lsm_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_lsm_series_scale(s : DbindexlsmSeries, f : Double) -> DbindexlsmSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_index_lsm_series_add(a : DbindexlsmSeries, b : DbindexlsmSeries) -> DbindexlsmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_index_lsm_series_sub(a : DbindexlsmSeries, b : DbindexlsmSeries) -> DbindexlsmSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_index_lsm_series_normalize(s : DbindexlsmSeries) -> DbindexlsmSeries {
  let mn = db_index_lsm_series_min(s)
  let mx = db_index_lsm_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_index_lsm_series_cumsum(s : DbindexlsmSeries) -> DbindexlsmSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_index_lsm_series_to_string(s : DbindexlsmSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexlsmMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_lsm_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexlsmMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_lsm_matrix_identity(n : Int) -> DbindexlsmMatrix {
  let m = db_index_lsm_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_index_lsm_matrix_get(m : DbindexlsmMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_index_lsm_matrix_transpose(m : DbindexlsmMatrix) -> DbindexlsmMatrix {
  let result = db_index_lsm_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_index_lsm_matrix_add(a : DbindexlsmMatrix, b : DbindexlsmMatrix) -> DbindexlsmMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_index_lsm_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_index_lsm_matrix_scale(m : DbindexlsmMatrix, s : Double) -> DbindexlsmMatrix {
  let result = db_index_lsm_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_index_lsm_matrix_multiply(a : DbindexlsmMatrix, b : DbindexlsmMatrix) -> DbindexlsmMatrix {
  if a.cols != b.rows { return db_index_lsm_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_index_lsm_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_index_lsm_matrix_trace(m : DbindexlsmMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_index_lsm_matrix_det(m : DbindexlsmMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_index_lsm_matrix_norm(m : DbindexlsmMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_index_lsm_matrix_to_string(m : DbindexlsmMatrix) -> String {
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

pub(all) struct DbindexlsmVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_lsm_make_vector(comps : Array[Double]) -> DbindexlsmVector {
  { comps, dim: comps.length() }
}

pub fn db_index_lsm_vector_zero(dim : Int) -> DbindexlsmVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_index_lsm_vector_add(a : DbindexlsmVector, b : DbindexlsmVector) -> DbindexlsmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_lsm_vector_sub(a : DbindexlsmVector, b : DbindexlsmVector) -> DbindexlsmVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_lsm_vector_scale(v : DbindexlsmVector, s : Double) -> DbindexlsmVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_index_lsm_vector_dot(a : DbindexlsmVector, b : DbindexlsmVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_index_lsm_vector_norm(v : DbindexlsmVector) -> Double { @_common.sqrt(db_index_lsm_vector_dot(v, v)) }

pub fn db_index_lsm_vector_normalize(v : DbindexlsmVector) -> DbindexlsmVector {
  let n = db_index_lsm_vector_norm(v)
  if n < 0.0000001 { v } else { db_index_lsm_vector_scale(v, 1.0 / n) }
}

pub fn db_index_lsm_vector_dist(a : DbindexlsmVector, b : DbindexlsmVector) -> Double {
  db_index_lsm_vector_norm(db_index_lsm_vector_sub(a, b))
}

pub fn db_index_lsm_vector_to_string(v : DbindexlsmVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_lsm_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_index_lsm_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_index_lsm_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_index_lsm_std(data : Array[Double]) -> Double { @_common.sqrt(db_index_lsm_var(data)) }

pub fn db_index_lsm_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_index_lsm_mean(a); let mb = db_index_lsm_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_index_lsm_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_index_lsm_std(a); let sb = db_index_lsm_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_index_lsm_cov(a, b) / (sa * sb) }
}

pub fn db_index_lsm_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_index_lsm_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_lsm_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_index_lsm_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_index_lsm_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(db_index_lsm_mse(pred, labels))
}

pub fn db_index_lsm_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_index_lsm_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_index_lsm_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_index_lsm_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_index_lsm_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_index_lsm_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_index_lsm_precision(pred, labels, pos); let r = db_index_lsm_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_index_lsm_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_index_lsm_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_index_lsm_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_index_lsm_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_index_lsm_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_index_lsm_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_index_lsm_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_index_lsm_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_index_lsm_fibonacci(n : Int) -> Int {
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

pub fn db_index_lsm_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_index_lsm_min(data); let mx = db_index_lsm_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_index_lsm_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_index_lsm_mean(data); let sd = db_index_lsm_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_index_lsm_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_index_lsm_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_index_lsm_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_index_lsm_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_index_lsm_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_index_lsm_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DbindexlsmFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_frame_make(size : Int) -> DbindexlsmFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_frame_len(s : DbindexlsmFrame) -> Int { s.size }

pub fn db_index_lsm_frame_get(s : DbindexlsmFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_frame_set(s : DbindexlsmFrame, i : Int, v : Double) -> DbindexlsmFrame {
  let result = db_index_lsm_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_frame_sum(s : DbindexlsmFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_frame_mean(s : DbindexlsmFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_frame_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_frame_scale(s : DbindexlsmFrame, f : Double) -> DbindexlsmFrame {
  let result = db_index_lsm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_frame_add(a : DbindexlsmFrame, b : DbindexlsmFrame) -> DbindexlsmFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_frame_copy(s : DbindexlsmFrame) -> DbindexlsmFrame {
  let result = db_index_lsm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_frame_fill(s : DbindexlsmFrame, v : Double) -> DbindexlsmFrame {
  let result = db_index_lsm_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_frame_min(s : DbindexlsmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_frame_max(s : DbindexlsmFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_frame_to_string(s : DbindexlsmFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_table_make(size : Int) -> DbindexlsmTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_table_len(s : DbindexlsmTable) -> Int { s.size }

pub fn db_index_lsm_table_get(s : DbindexlsmTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_table_set(s : DbindexlsmTable, i : Int, v : Double) -> DbindexlsmTable {
  let result = db_index_lsm_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_table_sum(s : DbindexlsmTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_table_mean(s : DbindexlsmTable) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_table_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_table_scale(s : DbindexlsmTable, f : Double) -> DbindexlsmTable {
  let result = db_index_lsm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_table_add(a : DbindexlsmTable, b : DbindexlsmTable) -> DbindexlsmTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_table_copy(s : DbindexlsmTable) -> DbindexlsmTable {
  let result = db_index_lsm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_table_fill(s : DbindexlsmTable, v : Double) -> DbindexlsmTable {
  let result = db_index_lsm_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_table_min(s : DbindexlsmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_table_max(s : DbindexlsmTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_table_to_string(s : DbindexlsmTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_graphn_make(size : Int) -> DbindexlsmGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_graphn_len(s : DbindexlsmGraphN) -> Int { s.size }

pub fn db_index_lsm_graphn_get(s : DbindexlsmGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_graphn_set(s : DbindexlsmGraphN, i : Int, v : Double) -> DbindexlsmGraphN {
  let result = db_index_lsm_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_graphn_sum(s : DbindexlsmGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_graphn_mean(s : DbindexlsmGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_graphn_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_graphn_scale(s : DbindexlsmGraphN, f : Double) -> DbindexlsmGraphN {
  let result = db_index_lsm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_graphn_add(a : DbindexlsmGraphN, b : DbindexlsmGraphN) -> DbindexlsmGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_graphn_copy(s : DbindexlsmGraphN) -> DbindexlsmGraphN {
  let result = db_index_lsm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_graphn_fill(s : DbindexlsmGraphN, v : Double) -> DbindexlsmGraphN {
  let result = db_index_lsm_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_graphn_min(s : DbindexlsmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_graphn_max(s : DbindexlsmGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_graphn_to_string(s : DbindexlsmGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_node_make(size : Int) -> DbindexlsmNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_node_len(s : DbindexlsmNode) -> Int { s.size }

pub fn db_index_lsm_node_get(s : DbindexlsmNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_node_set(s : DbindexlsmNode, i : Int, v : Double) -> DbindexlsmNode {
  let result = db_index_lsm_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_node_sum(s : DbindexlsmNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_node_mean(s : DbindexlsmNode) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_node_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_node_scale(s : DbindexlsmNode, f : Double) -> DbindexlsmNode {
  let result = db_index_lsm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_node_add(a : DbindexlsmNode, b : DbindexlsmNode) -> DbindexlsmNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_node_copy(s : DbindexlsmNode) -> DbindexlsmNode {
  let result = db_index_lsm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_node_fill(s : DbindexlsmNode, v : Double) -> DbindexlsmNode {
  let result = db_index_lsm_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_node_min(s : DbindexlsmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_node_max(s : DbindexlsmNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_node_to_string(s : DbindexlsmNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_edge_make(size : Int) -> DbindexlsmEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_edge_len(s : DbindexlsmEdge) -> Int { s.size }

pub fn db_index_lsm_edge_get(s : DbindexlsmEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_edge_set(s : DbindexlsmEdge, i : Int, v : Double) -> DbindexlsmEdge {
  let result = db_index_lsm_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_edge_sum(s : DbindexlsmEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_edge_mean(s : DbindexlsmEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_edge_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_edge_scale(s : DbindexlsmEdge, f : Double) -> DbindexlsmEdge {
  let result = db_index_lsm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_edge_add(a : DbindexlsmEdge, b : DbindexlsmEdge) -> DbindexlsmEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_edge_copy(s : DbindexlsmEdge) -> DbindexlsmEdge {
  let result = db_index_lsm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_edge_fill(s : DbindexlsmEdge, v : Double) -> DbindexlsmEdge {
  let result = db_index_lsm_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_edge_min(s : DbindexlsmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_edge_max(s : DbindexlsmEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_edge_to_string(s : DbindexlsmEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_path_make(size : Int) -> DbindexlsmPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_path_len(s : DbindexlsmPath) -> Int { s.size }

pub fn db_index_lsm_path_get(s : DbindexlsmPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_path_set(s : DbindexlsmPath, i : Int, v : Double) -> DbindexlsmPath {
  let result = db_index_lsm_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_path_sum(s : DbindexlsmPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_path_mean(s : DbindexlsmPath) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_path_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_path_scale(s : DbindexlsmPath, f : Double) -> DbindexlsmPath {
  let result = db_index_lsm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_path_add(a : DbindexlsmPath, b : DbindexlsmPath) -> DbindexlsmPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_path_copy(s : DbindexlsmPath) -> DbindexlsmPath {
  let result = db_index_lsm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_path_fill(s : DbindexlsmPath, v : Double) -> DbindexlsmPath {
  let result = db_index_lsm_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_path_min(s : DbindexlsmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_path_max(s : DbindexlsmPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_path_to_string(s : DbindexlsmPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_cluster_make(size : Int) -> DbindexlsmCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_cluster_len(s : DbindexlsmCluster) -> Int { s.size }

pub fn db_index_lsm_cluster_get(s : DbindexlsmCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_cluster_set(s : DbindexlsmCluster, i : Int, v : Double) -> DbindexlsmCluster {
  let result = db_index_lsm_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_cluster_sum(s : DbindexlsmCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_cluster_mean(s : DbindexlsmCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_cluster_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_cluster_scale(s : DbindexlsmCluster, f : Double) -> DbindexlsmCluster {
  let result = db_index_lsm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_cluster_add(a : DbindexlsmCluster, b : DbindexlsmCluster) -> DbindexlsmCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_cluster_copy(s : DbindexlsmCluster) -> DbindexlsmCluster {
  let result = db_index_lsm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_cluster_fill(s : DbindexlsmCluster, v : Double) -> DbindexlsmCluster {
  let result = db_index_lsm_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_cluster_min(s : DbindexlsmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_cluster_max(s : DbindexlsmCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_cluster_to_string(s : DbindexlsmCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_model_make(size : Int) -> DbindexlsmModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_model_len(s : DbindexlsmModel) -> Int { s.size }

pub fn db_index_lsm_model_get(s : DbindexlsmModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_model_set(s : DbindexlsmModel, i : Int, v : Double) -> DbindexlsmModel {
  let result = db_index_lsm_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_model_sum(s : DbindexlsmModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_model_mean(s : DbindexlsmModel) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_model_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_model_scale(s : DbindexlsmModel, f : Double) -> DbindexlsmModel {
  let result = db_index_lsm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_model_add(a : DbindexlsmModel, b : DbindexlsmModel) -> DbindexlsmModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_model_copy(s : DbindexlsmModel) -> DbindexlsmModel {
  let result = db_index_lsm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_model_fill(s : DbindexlsmModel, v : Double) -> DbindexlsmModel {
  let result = db_index_lsm_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_model_min(s : DbindexlsmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_model_max(s : DbindexlsmModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_model_to_string(s : DbindexlsmModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_layer_make(size : Int) -> DbindexlsmLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_layer_len(s : DbindexlsmLayer) -> Int { s.size }

pub fn db_index_lsm_layer_get(s : DbindexlsmLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_layer_set(s : DbindexlsmLayer, i : Int, v : Double) -> DbindexlsmLayer {
  let result = db_index_lsm_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_layer_sum(s : DbindexlsmLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_layer_mean(s : DbindexlsmLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_layer_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_layer_scale(s : DbindexlsmLayer, f : Double) -> DbindexlsmLayer {
  let result = db_index_lsm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_layer_add(a : DbindexlsmLayer, b : DbindexlsmLayer) -> DbindexlsmLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_layer_copy(s : DbindexlsmLayer) -> DbindexlsmLayer {
  let result = db_index_lsm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_layer_fill(s : DbindexlsmLayer, v : Double) -> DbindexlsmLayer {
  let result = db_index_lsm_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_layer_min(s : DbindexlsmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_layer_max(s : DbindexlsmLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_layer_to_string(s : DbindexlsmLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_buffer_make(size : Int) -> DbindexlsmBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_buffer_len(s : DbindexlsmBuffer) -> Int { s.size }

pub fn db_index_lsm_buffer_get(s : DbindexlsmBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_buffer_set(s : DbindexlsmBuffer, i : Int, v : Double) -> DbindexlsmBuffer {
  let result = db_index_lsm_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_buffer_sum(s : DbindexlsmBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_buffer_mean(s : DbindexlsmBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_buffer_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_buffer_scale(s : DbindexlsmBuffer, f : Double) -> DbindexlsmBuffer {
  let result = db_index_lsm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_buffer_add(a : DbindexlsmBuffer, b : DbindexlsmBuffer) -> DbindexlsmBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_buffer_copy(s : DbindexlsmBuffer) -> DbindexlsmBuffer {
  let result = db_index_lsm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_buffer_fill(s : DbindexlsmBuffer, v : Double) -> DbindexlsmBuffer {
  let result = db_index_lsm_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_buffer_min(s : DbindexlsmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_buffer_max(s : DbindexlsmBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_buffer_to_string(s : DbindexlsmBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_cursor_make(size : Int) -> DbindexlsmCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_cursor_len(s : DbindexlsmCursor) -> Int { s.size }

pub fn db_index_lsm_cursor_get(s : DbindexlsmCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_cursor_set(s : DbindexlsmCursor, i : Int, v : Double) -> DbindexlsmCursor {
  let result = db_index_lsm_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_cursor_sum(s : DbindexlsmCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_cursor_mean(s : DbindexlsmCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_cursor_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_cursor_scale(s : DbindexlsmCursor, f : Double) -> DbindexlsmCursor {
  let result = db_index_lsm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_cursor_add(a : DbindexlsmCursor, b : DbindexlsmCursor) -> DbindexlsmCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_cursor_copy(s : DbindexlsmCursor) -> DbindexlsmCursor {
  let result = db_index_lsm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_cursor_fill(s : DbindexlsmCursor, v : Double) -> DbindexlsmCursor {
  let result = db_index_lsm_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_cursor_min(s : DbindexlsmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_cursor_max(s : DbindexlsmCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_cursor_to_string(s : DbindexlsmCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_view_make(size : Int) -> DbindexlsmView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_view_len(s : DbindexlsmView) -> Int { s.size }

pub fn db_index_lsm_view_get(s : DbindexlsmView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_view_set(s : DbindexlsmView, i : Int, v : Double) -> DbindexlsmView {
  let result = db_index_lsm_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_view_sum(s : DbindexlsmView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_view_mean(s : DbindexlsmView) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_view_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_view_scale(s : DbindexlsmView, f : Double) -> DbindexlsmView {
  let result = db_index_lsm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_view_add(a : DbindexlsmView, b : DbindexlsmView) -> DbindexlsmView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_view_copy(s : DbindexlsmView) -> DbindexlsmView {
  let result = db_index_lsm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_view_fill(s : DbindexlsmView, v : Double) -> DbindexlsmView {
  let result = db_index_lsm_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_view_min(s : DbindexlsmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_view_max(s : DbindexlsmView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_view_to_string(s : DbindexlsmView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_range_make(size : Int) -> DbindexlsmRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_range_len(s : DbindexlsmRange) -> Int { s.size }

pub fn db_index_lsm_range_get(s : DbindexlsmRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_range_set(s : DbindexlsmRange, i : Int, v : Double) -> DbindexlsmRange {
  let result = db_index_lsm_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_range_sum(s : DbindexlsmRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_range_mean(s : DbindexlsmRange) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_range_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_range_scale(s : DbindexlsmRange, f : Double) -> DbindexlsmRange {
  let result = db_index_lsm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_range_add(a : DbindexlsmRange, b : DbindexlsmRange) -> DbindexlsmRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_range_copy(s : DbindexlsmRange) -> DbindexlsmRange {
  let result = db_index_lsm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_range_fill(s : DbindexlsmRange, v : Double) -> DbindexlsmRange {
  let result = db_index_lsm_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_range_min(s : DbindexlsmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_range_max(s : DbindexlsmRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_range_to_string(s : DbindexlsmRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexlsmSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_lsm_slice_make(size : Int) -> DbindexlsmSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_lsm_slice_len(s : DbindexlsmSlice) -> Int { s.size }

pub fn db_index_lsm_slice_get(s : DbindexlsmSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_lsm_slice_set(s : DbindexlsmSlice, i : Int, v : Double) -> DbindexlsmSlice {
  let result = db_index_lsm_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_slice_sum(s : DbindexlsmSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_lsm_slice_mean(s : DbindexlsmSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_index_lsm_slice_sum(s) / s.size.to_double() }
}

pub fn db_index_lsm_slice_scale(s : DbindexlsmSlice, f : Double) -> DbindexlsmSlice {
  let result = db_index_lsm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_lsm_slice_add(a : DbindexlsmSlice, b : DbindexlsmSlice) -> DbindexlsmSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_lsm_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_lsm_slice_copy(s : DbindexlsmSlice) -> DbindexlsmSlice {
  let result = db_index_lsm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_lsm_slice_fill(s : DbindexlsmSlice, v : Double) -> DbindexlsmSlice {
  let result = db_index_lsm_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_lsm_slice_min(s : DbindexlsmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_slice_max(s : DbindexlsmSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_lsm_slice_to_string(s : DbindexlsmSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

