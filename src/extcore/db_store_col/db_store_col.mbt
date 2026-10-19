///===
/// extcore/db_store_col

pub(all) struct DbstorecolPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_col_make_point(x : Double, y : Double) -> DbstorecolPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_col_make_point3(x : Double, y : Double, z : Double) -> DbstorecolPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_col_point_x(pt : DbstorecolPoint) -> Double { pt.x }

pub fn db_store_col_point_y(pt : DbstorecolPoint) -> Double { pt.y }

pub fn db_store_col_point_z(pt : DbstorecolPoint) -> Double { pt.z }

pub fn db_store_col_point_label(pt : DbstorecolPoint) -> Int { pt.label }

pub fn db_store_col_point_dist(a : DbstorecolPoint, b : DbstorecolPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_col_point_add(a : DbstorecolPoint, b : DbstorecolPoint) -> DbstorecolPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_col_point_sub(a : DbstorecolPoint, b : DbstorecolPoint) -> DbstorecolPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_col_point_scale(pt : DbstorecolPoint, s : Double) -> DbstorecolPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_col_point_dot(a : DbstorecolPoint, b : DbstorecolPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_col_point_cross(a : DbstorecolPoint, b : DbstorecolPoint) -> DbstorecolPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_col_point_norm(pt : DbstorecolPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_col_point_normalize(pt : DbstorecolPoint) -> DbstorecolPoint {
  let n = db_store_col_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_col_point_scale(pt, 1.0 / n) }
}

pub fn db_store_col_point_negate(pt : DbstorecolPoint) -> DbstorecolPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_col_point_mid(a : DbstorecolPoint, b : DbstorecolPoint) -> DbstorecolPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_col_point_lerp(a : DbstorecolPoint, b : DbstorecolPoint, t : Double) -> DbstorecolPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_col_point_to_string(pt : DbstorecolPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstorecolSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_col_make_series(vals : Array[Double], name : String) -> DbstorecolSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_col_series_len(s : DbstorecolSeries) -> Int { s.vals.length() }

pub fn db_store_col_series_sum(s : DbstorecolSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_store_col_series_mean(s : DbstorecolSeries) -> Double {
  let n = db_store_col_series_len(s)
  if n == 0 { 0.0 } else { db_store_col_series_sum(s) / n.to_double() }
}

pub fn db_store_col_series_min(s : DbstorecolSeries) -> Double {
  let n = db_store_col_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_col_series_max(s : DbstorecolSeries) -> Double {
  let n = db_store_col_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_col_series_range(s : DbstorecolSeries) -> Double {
  db_store_col_series_max(s) - db_store_col_series_min(s)
}

pub fn db_store_col_series_var(s : DbstorecolSeries) -> Double {
  let n = db_store_col_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_store_col_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_store_col_series_std(s : DbstorecolSeries) -> Double { @_common.sqrt(db_store_col_series_var(s)) }

pub fn db_store_col_series_median(s : DbstorecolSeries) -> Double {
  let n = db_store_col_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_store_col_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_store_col_series_scale(s : DbstorecolSeries, f : Double) -> DbstorecolSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_store_col_series_add(a : DbstorecolSeries, b : DbstorecolSeries) -> DbstorecolSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_col_series_sub(a : DbstorecolSeries, b : DbstorecolSeries) -> DbstorecolSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_col_series_normalize(s : DbstorecolSeries) -> DbstorecolSeries {
  let mn = db_store_col_series_min(s)
  let mx = db_store_col_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_col_series_cumsum(s : DbstorecolSeries) -> DbstorecolSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_col_series_to_string(s : DbstorecolSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorecolMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_col_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorecolMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_col_matrix_identity(n : Int) -> DbstorecolMatrix {
  let m = db_store_col_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_col_matrix_get(m : DbstorecolMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_col_matrix_transpose(m : DbstorecolMatrix) -> DbstorecolMatrix {
  let result = db_store_col_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_col_matrix_add(a : DbstorecolMatrix, b : DbstorecolMatrix) -> DbstorecolMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_col_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_col_matrix_scale(m : DbstorecolMatrix, s : Double) -> DbstorecolMatrix {
  let result = db_store_col_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_col_matrix_multiply(a : DbstorecolMatrix, b : DbstorecolMatrix) -> DbstorecolMatrix {
  if a.cols != b.rows { return db_store_col_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_col_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_col_matrix_trace(m : DbstorecolMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_col_matrix_det(m : DbstorecolMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_col_matrix_norm(m : DbstorecolMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_store_col_matrix_to_string(m : DbstorecolMatrix) -> String {
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

pub(all) struct DbstorecolVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_col_make_vector(comps : Array[Double]) -> DbstorecolVector {
  { comps, dim: comps.length() }
}

pub fn db_store_col_vector_zero(dim : Int) -> DbstorecolVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_col_vector_add(a : DbstorecolVector, b : DbstorecolVector) -> DbstorecolVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_col_vector_sub(a : DbstorecolVector, b : DbstorecolVector) -> DbstorecolVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_col_vector_scale(v : DbstorecolVector, s : Double) -> DbstorecolVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_store_col_vector_dot(a : DbstorecolVector, b : DbstorecolVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_col_vector_norm(v : DbstorecolVector) -> Double { @_common.sqrt(db_store_col_vector_dot(v, v)) }

pub fn db_store_col_vector_normalize(v : DbstorecolVector) -> DbstorecolVector {
  let n = db_store_col_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_col_vector_scale(v, 1.0 / n) }
}

pub fn db_store_col_vector_dist(a : DbstorecolVector, b : DbstorecolVector) -> Double {
  db_store_col_vector_norm(db_store_col_vector_sub(a, b))
}

pub fn db_store_col_vector_to_string(v : DbstorecolVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_col_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_store_col_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_store_col_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_store_col_std(data : Array[Double]) -> Double { @_common.sqrt(db_store_col_var(data)) }

pub fn db_store_col_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_store_col_mean(a); let mb = db_store_col_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_store_col_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_store_col_std(a); let sb = db_store_col_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_store_col_cov(a, b) / (sa * sb) }
}

pub fn db_store_col_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_store_col_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_store_col_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_store_col_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_store_col_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(db_store_col_mse(pred, labels))
}

pub fn db_store_col_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_store_col_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_store_col_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_store_col_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_store_col_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_store_col_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_store_col_precision(pred, labels, pos); let r = db_store_col_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_store_col_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_store_col_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_store_col_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_store_col_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_store_col_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_store_col_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_store_col_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_store_col_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_store_col_fibonacci(n : Int) -> Int {
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

pub fn db_store_col_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_store_col_min(data); let mx = db_store_col_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_store_col_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_store_col_mean(data); let sd = db_store_col_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_store_col_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_store_col_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_store_col_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_store_col_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_store_col_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_store_col_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DbstorecolFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_frame_make(size : Int) -> DbstorecolFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_frame_len(s : DbstorecolFrame) -> Int { s.size }

pub fn db_store_col_frame_get(s : DbstorecolFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_frame_set(s : DbstorecolFrame, i : Int, v : Double) -> DbstorecolFrame {
  let result = db_store_col_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_frame_sum(s : DbstorecolFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_frame_mean(s : DbstorecolFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_frame_sum(s) / s.size.to_double() }
}

pub fn db_store_col_frame_scale(s : DbstorecolFrame, f : Double) -> DbstorecolFrame {
  let result = db_store_col_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_frame_add(a : DbstorecolFrame, b : DbstorecolFrame) -> DbstorecolFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_frame_copy(s : DbstorecolFrame) -> DbstorecolFrame {
  let result = db_store_col_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_frame_fill(s : DbstorecolFrame, v : Double) -> DbstorecolFrame {
  let result = db_store_col_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_frame_min(s : DbstorecolFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_frame_max(s : DbstorecolFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_frame_to_string(s : DbstorecolFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_table_make(size : Int) -> DbstorecolTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_table_len(s : DbstorecolTable) -> Int { s.size }

pub fn db_store_col_table_get(s : DbstorecolTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_table_set(s : DbstorecolTable, i : Int, v : Double) -> DbstorecolTable {
  let result = db_store_col_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_table_sum(s : DbstorecolTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_table_mean(s : DbstorecolTable) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_table_sum(s) / s.size.to_double() }
}

pub fn db_store_col_table_scale(s : DbstorecolTable, f : Double) -> DbstorecolTable {
  let result = db_store_col_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_table_add(a : DbstorecolTable, b : DbstorecolTable) -> DbstorecolTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_table_copy(s : DbstorecolTable) -> DbstorecolTable {
  let result = db_store_col_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_table_fill(s : DbstorecolTable, v : Double) -> DbstorecolTable {
  let result = db_store_col_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_table_min(s : DbstorecolTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_table_max(s : DbstorecolTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_table_to_string(s : DbstorecolTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_graphn_make(size : Int) -> DbstorecolGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_graphn_len(s : DbstorecolGraphN) -> Int { s.size }

pub fn db_store_col_graphn_get(s : DbstorecolGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_graphn_set(s : DbstorecolGraphN, i : Int, v : Double) -> DbstorecolGraphN {
  let result = db_store_col_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_graphn_sum(s : DbstorecolGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_graphn_mean(s : DbstorecolGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_graphn_sum(s) / s.size.to_double() }
}

pub fn db_store_col_graphn_scale(s : DbstorecolGraphN, f : Double) -> DbstorecolGraphN {
  let result = db_store_col_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_graphn_add(a : DbstorecolGraphN, b : DbstorecolGraphN) -> DbstorecolGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_graphn_copy(s : DbstorecolGraphN) -> DbstorecolGraphN {
  let result = db_store_col_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_graphn_fill(s : DbstorecolGraphN, v : Double) -> DbstorecolGraphN {
  let result = db_store_col_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_graphn_min(s : DbstorecolGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_graphn_max(s : DbstorecolGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_graphn_to_string(s : DbstorecolGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_node_make(size : Int) -> DbstorecolNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_node_len(s : DbstorecolNode) -> Int { s.size }

pub fn db_store_col_node_get(s : DbstorecolNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_node_set(s : DbstorecolNode, i : Int, v : Double) -> DbstorecolNode {
  let result = db_store_col_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_node_sum(s : DbstorecolNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_node_mean(s : DbstorecolNode) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_node_sum(s) / s.size.to_double() }
}

pub fn db_store_col_node_scale(s : DbstorecolNode, f : Double) -> DbstorecolNode {
  let result = db_store_col_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_node_add(a : DbstorecolNode, b : DbstorecolNode) -> DbstorecolNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_node_copy(s : DbstorecolNode) -> DbstorecolNode {
  let result = db_store_col_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_node_fill(s : DbstorecolNode, v : Double) -> DbstorecolNode {
  let result = db_store_col_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_node_min(s : DbstorecolNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_node_max(s : DbstorecolNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_node_to_string(s : DbstorecolNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_edge_make(size : Int) -> DbstorecolEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_edge_len(s : DbstorecolEdge) -> Int { s.size }

pub fn db_store_col_edge_get(s : DbstorecolEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_edge_set(s : DbstorecolEdge, i : Int, v : Double) -> DbstorecolEdge {
  let result = db_store_col_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_edge_sum(s : DbstorecolEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_edge_mean(s : DbstorecolEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_edge_sum(s) / s.size.to_double() }
}

pub fn db_store_col_edge_scale(s : DbstorecolEdge, f : Double) -> DbstorecolEdge {
  let result = db_store_col_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_edge_add(a : DbstorecolEdge, b : DbstorecolEdge) -> DbstorecolEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_edge_copy(s : DbstorecolEdge) -> DbstorecolEdge {
  let result = db_store_col_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_edge_fill(s : DbstorecolEdge, v : Double) -> DbstorecolEdge {
  let result = db_store_col_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_edge_min(s : DbstorecolEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_edge_max(s : DbstorecolEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_edge_to_string(s : DbstorecolEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_path_make(size : Int) -> DbstorecolPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_path_len(s : DbstorecolPath) -> Int { s.size }

pub fn db_store_col_path_get(s : DbstorecolPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_path_set(s : DbstorecolPath, i : Int, v : Double) -> DbstorecolPath {
  let result = db_store_col_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_path_sum(s : DbstorecolPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_path_mean(s : DbstorecolPath) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_path_sum(s) / s.size.to_double() }
}

pub fn db_store_col_path_scale(s : DbstorecolPath, f : Double) -> DbstorecolPath {
  let result = db_store_col_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_path_add(a : DbstorecolPath, b : DbstorecolPath) -> DbstorecolPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_path_copy(s : DbstorecolPath) -> DbstorecolPath {
  let result = db_store_col_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_path_fill(s : DbstorecolPath, v : Double) -> DbstorecolPath {
  let result = db_store_col_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_path_min(s : DbstorecolPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_path_max(s : DbstorecolPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_path_to_string(s : DbstorecolPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_cluster_make(size : Int) -> DbstorecolCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_cluster_len(s : DbstorecolCluster) -> Int { s.size }

pub fn db_store_col_cluster_get(s : DbstorecolCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_cluster_set(s : DbstorecolCluster, i : Int, v : Double) -> DbstorecolCluster {
  let result = db_store_col_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_cluster_sum(s : DbstorecolCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_cluster_mean(s : DbstorecolCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_cluster_sum(s) / s.size.to_double() }
}

pub fn db_store_col_cluster_scale(s : DbstorecolCluster, f : Double) -> DbstorecolCluster {
  let result = db_store_col_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_cluster_add(a : DbstorecolCluster, b : DbstorecolCluster) -> DbstorecolCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_cluster_copy(s : DbstorecolCluster) -> DbstorecolCluster {
  let result = db_store_col_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_cluster_fill(s : DbstorecolCluster, v : Double) -> DbstorecolCluster {
  let result = db_store_col_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_cluster_min(s : DbstorecolCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_cluster_max(s : DbstorecolCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_cluster_to_string(s : DbstorecolCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_model_make(size : Int) -> DbstorecolModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_model_len(s : DbstorecolModel) -> Int { s.size }

pub fn db_store_col_model_get(s : DbstorecolModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_model_set(s : DbstorecolModel, i : Int, v : Double) -> DbstorecolModel {
  let result = db_store_col_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_model_sum(s : DbstorecolModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_model_mean(s : DbstorecolModel) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_model_sum(s) / s.size.to_double() }
}

pub fn db_store_col_model_scale(s : DbstorecolModel, f : Double) -> DbstorecolModel {
  let result = db_store_col_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_model_add(a : DbstorecolModel, b : DbstorecolModel) -> DbstorecolModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_model_copy(s : DbstorecolModel) -> DbstorecolModel {
  let result = db_store_col_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_model_fill(s : DbstorecolModel, v : Double) -> DbstorecolModel {
  let result = db_store_col_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_model_min(s : DbstorecolModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_model_max(s : DbstorecolModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_model_to_string(s : DbstorecolModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_layer_make(size : Int) -> DbstorecolLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_layer_len(s : DbstorecolLayer) -> Int { s.size }

pub fn db_store_col_layer_get(s : DbstorecolLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_layer_set(s : DbstorecolLayer, i : Int, v : Double) -> DbstorecolLayer {
  let result = db_store_col_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_layer_sum(s : DbstorecolLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_layer_mean(s : DbstorecolLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_layer_sum(s) / s.size.to_double() }
}

pub fn db_store_col_layer_scale(s : DbstorecolLayer, f : Double) -> DbstorecolLayer {
  let result = db_store_col_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_layer_add(a : DbstorecolLayer, b : DbstorecolLayer) -> DbstorecolLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_layer_copy(s : DbstorecolLayer) -> DbstorecolLayer {
  let result = db_store_col_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_layer_fill(s : DbstorecolLayer, v : Double) -> DbstorecolLayer {
  let result = db_store_col_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_layer_min(s : DbstorecolLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_layer_max(s : DbstorecolLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_layer_to_string(s : DbstorecolLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_buffer_make(size : Int) -> DbstorecolBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_buffer_len(s : DbstorecolBuffer) -> Int { s.size }

pub fn db_store_col_buffer_get(s : DbstorecolBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_buffer_set(s : DbstorecolBuffer, i : Int, v : Double) -> DbstorecolBuffer {
  let result = db_store_col_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_buffer_sum(s : DbstorecolBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_buffer_mean(s : DbstorecolBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_buffer_sum(s) / s.size.to_double() }
}

pub fn db_store_col_buffer_scale(s : DbstorecolBuffer, f : Double) -> DbstorecolBuffer {
  let result = db_store_col_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_buffer_add(a : DbstorecolBuffer, b : DbstorecolBuffer) -> DbstorecolBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_buffer_copy(s : DbstorecolBuffer) -> DbstorecolBuffer {
  let result = db_store_col_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_buffer_fill(s : DbstorecolBuffer, v : Double) -> DbstorecolBuffer {
  let result = db_store_col_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_buffer_min(s : DbstorecolBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_buffer_max(s : DbstorecolBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_buffer_to_string(s : DbstorecolBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_cursor_make(size : Int) -> DbstorecolCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_cursor_len(s : DbstorecolCursor) -> Int { s.size }

pub fn db_store_col_cursor_get(s : DbstorecolCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_cursor_set(s : DbstorecolCursor, i : Int, v : Double) -> DbstorecolCursor {
  let result = db_store_col_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_cursor_sum(s : DbstorecolCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_cursor_mean(s : DbstorecolCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_cursor_sum(s) / s.size.to_double() }
}

pub fn db_store_col_cursor_scale(s : DbstorecolCursor, f : Double) -> DbstorecolCursor {
  let result = db_store_col_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_cursor_add(a : DbstorecolCursor, b : DbstorecolCursor) -> DbstorecolCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_cursor_copy(s : DbstorecolCursor) -> DbstorecolCursor {
  let result = db_store_col_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_cursor_fill(s : DbstorecolCursor, v : Double) -> DbstorecolCursor {
  let result = db_store_col_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_cursor_min(s : DbstorecolCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_cursor_max(s : DbstorecolCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_cursor_to_string(s : DbstorecolCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_view_make(size : Int) -> DbstorecolView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_view_len(s : DbstorecolView) -> Int { s.size }

pub fn db_store_col_view_get(s : DbstorecolView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_view_set(s : DbstorecolView, i : Int, v : Double) -> DbstorecolView {
  let result = db_store_col_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_view_sum(s : DbstorecolView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_view_mean(s : DbstorecolView) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_view_sum(s) / s.size.to_double() }
}

pub fn db_store_col_view_scale(s : DbstorecolView, f : Double) -> DbstorecolView {
  let result = db_store_col_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_view_add(a : DbstorecolView, b : DbstorecolView) -> DbstorecolView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_view_copy(s : DbstorecolView) -> DbstorecolView {
  let result = db_store_col_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_view_fill(s : DbstorecolView, v : Double) -> DbstorecolView {
  let result = db_store_col_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_view_min(s : DbstorecolView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_view_max(s : DbstorecolView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_view_to_string(s : DbstorecolView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_range_make(size : Int) -> DbstorecolRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_range_len(s : DbstorecolRange) -> Int { s.size }

pub fn db_store_col_range_get(s : DbstorecolRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_range_set(s : DbstorecolRange, i : Int, v : Double) -> DbstorecolRange {
  let result = db_store_col_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_range_sum(s : DbstorecolRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_range_mean(s : DbstorecolRange) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_range_sum(s) / s.size.to_double() }
}

pub fn db_store_col_range_scale(s : DbstorecolRange, f : Double) -> DbstorecolRange {
  let result = db_store_col_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_range_add(a : DbstorecolRange, b : DbstorecolRange) -> DbstorecolRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_range_copy(s : DbstorecolRange) -> DbstorecolRange {
  let result = db_store_col_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_range_fill(s : DbstorecolRange, v : Double) -> DbstorecolRange {
  let result = db_store_col_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_range_min(s : DbstorecolRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_range_max(s : DbstorecolRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_range_to_string(s : DbstorecolRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorecolSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_col_slice_make(size : Int) -> DbstorecolSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_col_slice_len(s : DbstorecolSlice) -> Int { s.size }

pub fn db_store_col_slice_get(s : DbstorecolSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_col_slice_set(s : DbstorecolSlice, i : Int, v : Double) -> DbstorecolSlice {
  let result = db_store_col_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_col_slice_sum(s : DbstorecolSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_col_slice_mean(s : DbstorecolSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_store_col_slice_sum(s) / s.size.to_double() }
}

pub fn db_store_col_slice_scale(s : DbstorecolSlice, f : Double) -> DbstorecolSlice {
  let result = db_store_col_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_col_slice_add(a : DbstorecolSlice, b : DbstorecolSlice) -> DbstorecolSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_col_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_col_slice_copy(s : DbstorecolSlice) -> DbstorecolSlice {
  let result = db_store_col_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_col_slice_fill(s : DbstorecolSlice, v : Double) -> DbstorecolSlice {
  let result = db_store_col_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_col_slice_min(s : DbstorecolSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_slice_max(s : DbstorecolSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_col_slice_to_string(s : DbstorecolSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

