///===
/// extcore/db_query_sort

pub(all) struct DbquerysortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_sort_make_point(x : Double, y : Double) -> DbquerysortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_sort_make_point3(x : Double, y : Double, z : Double) -> DbquerysortPoint {
  { x, y, z, label: 0 }
}

pub fn db_query_sort_point_x(pt : DbquerysortPoint) -> Double { pt.x }

pub fn db_query_sort_point_y(pt : DbquerysortPoint) -> Double { pt.y }

pub fn db_query_sort_point_z(pt : DbquerysortPoint) -> Double { pt.z }

pub fn db_query_sort_point_label(pt : DbquerysortPoint) -> Int { pt.label }

pub fn db_query_sort_point_dist(a : DbquerysortPoint, b : DbquerysortPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_query_sort_point_add(a : DbquerysortPoint, b : DbquerysortPoint) -> DbquerysortPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_query_sort_point_sub(a : DbquerysortPoint, b : DbquerysortPoint) -> DbquerysortPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_query_sort_point_scale(pt : DbquerysortPoint, s : Double) -> DbquerysortPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_query_sort_point_dot(a : DbquerysortPoint, b : DbquerysortPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_query_sort_point_cross(a : DbquerysortPoint, b : DbquerysortPoint) -> DbquerysortPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_query_sort_point_norm(pt : DbquerysortPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_query_sort_point_normalize(pt : DbquerysortPoint) -> DbquerysortPoint {
  let n = db_query_sort_point_norm(pt)
  if n < 0.0000001 { pt } else { db_query_sort_point_scale(pt, 1.0 / n) }
}

pub fn db_query_sort_point_negate(pt : DbquerysortPoint) -> DbquerysortPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_query_sort_point_mid(a : DbquerysortPoint, b : DbquerysortPoint) -> DbquerysortPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_query_sort_point_lerp(a : DbquerysortPoint, b : DbquerysortPoint, t : Double) -> DbquerysortPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_query_sort_point_to_string(pt : DbquerysortPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbquerysortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_sort_make_series(vals : Array[Double], name : String) -> DbquerysortSeries {
  { vals, name, meta: 0 }
}

pub fn db_query_sort_series_len(s : DbquerysortSeries) -> Int { s.vals.length() }

pub fn db_query_sort_series_sum(s : DbquerysortSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_query_sort_series_mean(s : DbquerysortSeries) -> Double {
  let n = db_query_sort_series_len(s)
  if n == 0 { 0.0 } else { db_query_sort_series_sum(s) / n.to_double() }
}

pub fn db_query_sort_series_min(s : DbquerysortSeries) -> Double {
  let n = db_query_sort_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_sort_series_max(s : DbquerysortSeries) -> Double {
  let n = db_query_sort_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_sort_series_range(s : DbquerysortSeries) -> Double {
  db_query_sort_series_max(s) - db_query_sort_series_min(s)
}

pub fn db_query_sort_series_var(s : DbquerysortSeries) -> Double {
  let n = db_query_sort_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_query_sort_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_query_sort_series_std(s : DbquerysortSeries) -> Double { @_common.sqrt(db_query_sort_series_var(s)) }

pub fn db_query_sort_series_median(s : DbquerysortSeries) -> Double {
  let n = db_query_sort_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_query_sort_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_sort_series_scale(s : DbquerysortSeries, f : Double) -> DbquerysortSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_query_sort_series_add(a : DbquerysortSeries, b : DbquerysortSeries) -> DbquerysortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_query_sort_series_sub(a : DbquerysortSeries, b : DbquerysortSeries) -> DbquerysortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_query_sort_series_normalize(s : DbquerysortSeries) -> DbquerysortSeries {
  let mn = db_query_sort_series_min(s)
  let mx = db_query_sort_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_query_sort_series_cumsum(s : DbquerysortSeries) -> DbquerysortSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_query_sort_series_to_string(s : DbquerysortSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerysortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_sort_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerysortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_sort_matrix_identity(n : Int) -> DbquerysortMatrix {
  let m = db_query_sort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_query_sort_matrix_get(m : DbquerysortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_query_sort_matrix_transpose(m : DbquerysortMatrix) -> DbquerysortMatrix {
  let result = db_query_sort_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_query_sort_matrix_add(a : DbquerysortMatrix, b : DbquerysortMatrix) -> DbquerysortMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_query_sort_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_query_sort_matrix_scale(m : DbquerysortMatrix, s : Double) -> DbquerysortMatrix {
  let result = db_query_sort_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_query_sort_matrix_multiply(a : DbquerysortMatrix, b : DbquerysortMatrix) -> DbquerysortMatrix {
  if a.cols != b.rows { return db_query_sort_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_query_sort_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_query_sort_matrix_trace(m : DbquerysortMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_query_sort_matrix_det(m : DbquerysortMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_query_sort_matrix_norm(m : DbquerysortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_query_sort_matrix_to_string(m : DbquerysortMatrix) -> String {
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

pub(all) struct DbquerysortVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_sort_make_vector(comps : Array[Double]) -> DbquerysortVector {
  { comps, dim: comps.length() }
}

pub fn db_query_sort_vector_zero(dim : Int) -> DbquerysortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_query_sort_vector_add(a : DbquerysortVector, b : DbquerysortVector) -> DbquerysortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_sort_vector_sub(a : DbquerysortVector, b : DbquerysortVector) -> DbquerysortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_sort_vector_scale(v : DbquerysortVector, s : Double) -> DbquerysortVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_query_sort_vector_dot(a : DbquerysortVector, b : DbquerysortVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_query_sort_vector_norm(v : DbquerysortVector) -> Double { @_common.sqrt(db_query_sort_vector_dot(v, v)) }

pub fn db_query_sort_vector_normalize(v : DbquerysortVector) -> DbquerysortVector {
  let n = db_query_sort_vector_norm(v)
  if n < 0.0000001 { v } else { db_query_sort_vector_scale(v, 1.0 / n) }
}

pub fn db_query_sort_vector_dist(a : DbquerysortVector, b : DbquerysortVector) -> Double {
  db_query_sort_vector_norm(db_query_sort_vector_sub(a, b))
}

pub fn db_query_sort_vector_to_string(v : DbquerysortVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_sort_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_query_sort_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_query_sort_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_query_sort_std(data : Array[Double]) -> Double { @_common.sqrt(db_query_sort_var(data)) }

pub fn db_query_sort_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_query_sort_mean(a); let mb = db_query_sort_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_query_sort_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_query_sort_std(a); let sb = db_query_sort_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_query_sort_cov(a, b) / (sa * sb) }
}

pub fn db_query_sort_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_query_sort_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_sort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_query_sort_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_query_sort_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(db_query_sort_mse(pred, labels))
}

pub fn db_query_sort_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_query_sort_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_query_sort_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_query_sort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_query_sort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_query_sort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_query_sort_precision(pred, labels, pos); let r = db_query_sort_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_query_sort_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_query_sort_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_query_sort_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_query_sort_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_query_sort_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_query_sort_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_query_sort_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_query_sort_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_query_sort_fibonacci(n : Int) -> Int {
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

pub fn db_query_sort_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_query_sort_min(data); let mx = db_query_sort_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_query_sort_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_query_sort_mean(data); let sd = db_query_sort_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_query_sort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_query_sort_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_query_sort_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_query_sort_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_query_sort_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_query_sort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DbquerysortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_frame_make(size : Int) -> DbquerysortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_frame_len(s : DbquerysortFrame) -> Int { s.size }

pub fn db_query_sort_frame_get(s : DbquerysortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_frame_set(s : DbquerysortFrame, i : Int, v : Double) -> DbquerysortFrame {
  let result = db_query_sort_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_frame_sum(s : DbquerysortFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_frame_mean(s : DbquerysortFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_frame_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_frame_scale(s : DbquerysortFrame, f : Double) -> DbquerysortFrame {
  let result = db_query_sort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_frame_add(a : DbquerysortFrame, b : DbquerysortFrame) -> DbquerysortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_frame_copy(s : DbquerysortFrame) -> DbquerysortFrame {
  let result = db_query_sort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_frame_fill(s : DbquerysortFrame, v : Double) -> DbquerysortFrame {
  let result = db_query_sort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_frame_min(s : DbquerysortFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_frame_max(s : DbquerysortFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_frame_to_string(s : DbquerysortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_table_make(size : Int) -> DbquerysortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_table_len(s : DbquerysortTable) -> Int { s.size }

pub fn db_query_sort_table_get(s : DbquerysortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_table_set(s : DbquerysortTable, i : Int, v : Double) -> DbquerysortTable {
  let result = db_query_sort_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_table_sum(s : DbquerysortTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_table_mean(s : DbquerysortTable) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_table_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_table_scale(s : DbquerysortTable, f : Double) -> DbquerysortTable {
  let result = db_query_sort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_table_add(a : DbquerysortTable, b : DbquerysortTable) -> DbquerysortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_table_copy(s : DbquerysortTable) -> DbquerysortTable {
  let result = db_query_sort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_table_fill(s : DbquerysortTable, v : Double) -> DbquerysortTable {
  let result = db_query_sort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_table_min(s : DbquerysortTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_table_max(s : DbquerysortTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_table_to_string(s : DbquerysortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_graphn_make(size : Int) -> DbquerysortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_graphn_len(s : DbquerysortGraphN) -> Int { s.size }

pub fn db_query_sort_graphn_get(s : DbquerysortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_graphn_set(s : DbquerysortGraphN, i : Int, v : Double) -> DbquerysortGraphN {
  let result = db_query_sort_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_graphn_sum(s : DbquerysortGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_graphn_mean(s : DbquerysortGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_graphn_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_graphn_scale(s : DbquerysortGraphN, f : Double) -> DbquerysortGraphN {
  let result = db_query_sort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_graphn_add(a : DbquerysortGraphN, b : DbquerysortGraphN) -> DbquerysortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_graphn_copy(s : DbquerysortGraphN) -> DbquerysortGraphN {
  let result = db_query_sort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_graphn_fill(s : DbquerysortGraphN, v : Double) -> DbquerysortGraphN {
  let result = db_query_sort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_graphn_min(s : DbquerysortGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_graphn_max(s : DbquerysortGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_graphn_to_string(s : DbquerysortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_node_make(size : Int) -> DbquerysortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_node_len(s : DbquerysortNode) -> Int { s.size }

pub fn db_query_sort_node_get(s : DbquerysortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_node_set(s : DbquerysortNode, i : Int, v : Double) -> DbquerysortNode {
  let result = db_query_sort_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_node_sum(s : DbquerysortNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_node_mean(s : DbquerysortNode) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_node_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_node_scale(s : DbquerysortNode, f : Double) -> DbquerysortNode {
  let result = db_query_sort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_node_add(a : DbquerysortNode, b : DbquerysortNode) -> DbquerysortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_node_copy(s : DbquerysortNode) -> DbquerysortNode {
  let result = db_query_sort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_node_fill(s : DbquerysortNode, v : Double) -> DbquerysortNode {
  let result = db_query_sort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_node_min(s : DbquerysortNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_node_max(s : DbquerysortNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_node_to_string(s : DbquerysortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_edge_make(size : Int) -> DbquerysortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_edge_len(s : DbquerysortEdge) -> Int { s.size }

pub fn db_query_sort_edge_get(s : DbquerysortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_edge_set(s : DbquerysortEdge, i : Int, v : Double) -> DbquerysortEdge {
  let result = db_query_sort_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_edge_sum(s : DbquerysortEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_edge_mean(s : DbquerysortEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_edge_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_edge_scale(s : DbquerysortEdge, f : Double) -> DbquerysortEdge {
  let result = db_query_sort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_edge_add(a : DbquerysortEdge, b : DbquerysortEdge) -> DbquerysortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_edge_copy(s : DbquerysortEdge) -> DbquerysortEdge {
  let result = db_query_sort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_edge_fill(s : DbquerysortEdge, v : Double) -> DbquerysortEdge {
  let result = db_query_sort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_edge_min(s : DbquerysortEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_edge_max(s : DbquerysortEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_edge_to_string(s : DbquerysortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_path_make(size : Int) -> DbquerysortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_path_len(s : DbquerysortPath) -> Int { s.size }

pub fn db_query_sort_path_get(s : DbquerysortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_path_set(s : DbquerysortPath, i : Int, v : Double) -> DbquerysortPath {
  let result = db_query_sort_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_path_sum(s : DbquerysortPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_path_mean(s : DbquerysortPath) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_path_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_path_scale(s : DbquerysortPath, f : Double) -> DbquerysortPath {
  let result = db_query_sort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_path_add(a : DbquerysortPath, b : DbquerysortPath) -> DbquerysortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_path_copy(s : DbquerysortPath) -> DbquerysortPath {
  let result = db_query_sort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_path_fill(s : DbquerysortPath, v : Double) -> DbquerysortPath {
  let result = db_query_sort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_path_min(s : DbquerysortPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_path_max(s : DbquerysortPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_path_to_string(s : DbquerysortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_cluster_make(size : Int) -> DbquerysortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_cluster_len(s : DbquerysortCluster) -> Int { s.size }

pub fn db_query_sort_cluster_get(s : DbquerysortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_cluster_set(s : DbquerysortCluster, i : Int, v : Double) -> DbquerysortCluster {
  let result = db_query_sort_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_cluster_sum(s : DbquerysortCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_cluster_mean(s : DbquerysortCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_cluster_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_cluster_scale(s : DbquerysortCluster, f : Double) -> DbquerysortCluster {
  let result = db_query_sort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_cluster_add(a : DbquerysortCluster, b : DbquerysortCluster) -> DbquerysortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_cluster_copy(s : DbquerysortCluster) -> DbquerysortCluster {
  let result = db_query_sort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_cluster_fill(s : DbquerysortCluster, v : Double) -> DbquerysortCluster {
  let result = db_query_sort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_cluster_min(s : DbquerysortCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_cluster_max(s : DbquerysortCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_cluster_to_string(s : DbquerysortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_model_make(size : Int) -> DbquerysortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_model_len(s : DbquerysortModel) -> Int { s.size }

pub fn db_query_sort_model_get(s : DbquerysortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_model_set(s : DbquerysortModel, i : Int, v : Double) -> DbquerysortModel {
  let result = db_query_sort_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_model_sum(s : DbquerysortModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_model_mean(s : DbquerysortModel) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_model_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_model_scale(s : DbquerysortModel, f : Double) -> DbquerysortModel {
  let result = db_query_sort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_model_add(a : DbquerysortModel, b : DbquerysortModel) -> DbquerysortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_model_copy(s : DbquerysortModel) -> DbquerysortModel {
  let result = db_query_sort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_model_fill(s : DbquerysortModel, v : Double) -> DbquerysortModel {
  let result = db_query_sort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_model_min(s : DbquerysortModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_model_max(s : DbquerysortModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_model_to_string(s : DbquerysortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_layer_make(size : Int) -> DbquerysortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_layer_len(s : DbquerysortLayer) -> Int { s.size }

pub fn db_query_sort_layer_get(s : DbquerysortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_layer_set(s : DbquerysortLayer, i : Int, v : Double) -> DbquerysortLayer {
  let result = db_query_sort_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_layer_sum(s : DbquerysortLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_layer_mean(s : DbquerysortLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_layer_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_layer_scale(s : DbquerysortLayer, f : Double) -> DbquerysortLayer {
  let result = db_query_sort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_layer_add(a : DbquerysortLayer, b : DbquerysortLayer) -> DbquerysortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_layer_copy(s : DbquerysortLayer) -> DbquerysortLayer {
  let result = db_query_sort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_layer_fill(s : DbquerysortLayer, v : Double) -> DbquerysortLayer {
  let result = db_query_sort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_layer_min(s : DbquerysortLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_layer_max(s : DbquerysortLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_layer_to_string(s : DbquerysortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_buffer_make(size : Int) -> DbquerysortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_buffer_len(s : DbquerysortBuffer) -> Int { s.size }

pub fn db_query_sort_buffer_get(s : DbquerysortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_buffer_set(s : DbquerysortBuffer, i : Int, v : Double) -> DbquerysortBuffer {
  let result = db_query_sort_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_buffer_sum(s : DbquerysortBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_buffer_mean(s : DbquerysortBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_buffer_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_buffer_scale(s : DbquerysortBuffer, f : Double) -> DbquerysortBuffer {
  let result = db_query_sort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_buffer_add(a : DbquerysortBuffer, b : DbquerysortBuffer) -> DbquerysortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_buffer_copy(s : DbquerysortBuffer) -> DbquerysortBuffer {
  let result = db_query_sort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_buffer_fill(s : DbquerysortBuffer, v : Double) -> DbquerysortBuffer {
  let result = db_query_sort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_buffer_min(s : DbquerysortBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_buffer_max(s : DbquerysortBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_buffer_to_string(s : DbquerysortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_cursor_make(size : Int) -> DbquerysortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_cursor_len(s : DbquerysortCursor) -> Int { s.size }

pub fn db_query_sort_cursor_get(s : DbquerysortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_cursor_set(s : DbquerysortCursor, i : Int, v : Double) -> DbquerysortCursor {
  let result = db_query_sort_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_cursor_sum(s : DbquerysortCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_cursor_mean(s : DbquerysortCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_cursor_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_cursor_scale(s : DbquerysortCursor, f : Double) -> DbquerysortCursor {
  let result = db_query_sort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_cursor_add(a : DbquerysortCursor, b : DbquerysortCursor) -> DbquerysortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_cursor_copy(s : DbquerysortCursor) -> DbquerysortCursor {
  let result = db_query_sort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_cursor_fill(s : DbquerysortCursor, v : Double) -> DbquerysortCursor {
  let result = db_query_sort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_cursor_min(s : DbquerysortCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_cursor_max(s : DbquerysortCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_cursor_to_string(s : DbquerysortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_view_make(size : Int) -> DbquerysortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_view_len(s : DbquerysortView) -> Int { s.size }

pub fn db_query_sort_view_get(s : DbquerysortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_view_set(s : DbquerysortView, i : Int, v : Double) -> DbquerysortView {
  let result = db_query_sort_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_view_sum(s : DbquerysortView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_view_mean(s : DbquerysortView) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_view_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_view_scale(s : DbquerysortView, f : Double) -> DbquerysortView {
  let result = db_query_sort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_view_add(a : DbquerysortView, b : DbquerysortView) -> DbquerysortView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_view_copy(s : DbquerysortView) -> DbquerysortView {
  let result = db_query_sort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_view_fill(s : DbquerysortView, v : Double) -> DbquerysortView {
  let result = db_query_sort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_view_min(s : DbquerysortView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_view_max(s : DbquerysortView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_view_to_string(s : DbquerysortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_range_make(size : Int) -> DbquerysortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_range_len(s : DbquerysortRange) -> Int { s.size }

pub fn db_query_sort_range_get(s : DbquerysortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_range_set(s : DbquerysortRange, i : Int, v : Double) -> DbquerysortRange {
  let result = db_query_sort_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_range_sum(s : DbquerysortRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_range_mean(s : DbquerysortRange) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_range_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_range_scale(s : DbquerysortRange, f : Double) -> DbquerysortRange {
  let result = db_query_sort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_range_add(a : DbquerysortRange, b : DbquerysortRange) -> DbquerysortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_range_copy(s : DbquerysortRange) -> DbquerysortRange {
  let result = db_query_sort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_range_fill(s : DbquerysortRange, v : Double) -> DbquerysortRange {
  let result = db_query_sort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_range_min(s : DbquerysortRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_range_max(s : DbquerysortRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_range_to_string(s : DbquerysortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerysortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_sort_slice_make(size : Int) -> DbquerysortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_sort_slice_len(s : DbquerysortSlice) -> Int { s.size }

pub fn db_query_sort_slice_get(s : DbquerysortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_sort_slice_set(s : DbquerysortSlice, i : Int, v : Double) -> DbquerysortSlice {
  let result = db_query_sort_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_slice_sum(s : DbquerysortSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_sort_slice_mean(s : DbquerysortSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_query_sort_slice_sum(s) / s.size.to_double() }
}

pub fn db_query_sort_slice_scale(s : DbquerysortSlice, f : Double) -> DbquerysortSlice {
  let result = db_query_sort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_sort_slice_add(a : DbquerysortSlice, b : DbquerysortSlice) -> DbquerysortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_sort_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_sort_slice_copy(s : DbquerysortSlice) -> DbquerysortSlice {
  let result = db_query_sort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_sort_slice_fill(s : DbquerysortSlice, v : Double) -> DbquerysortSlice {
  let result = db_query_sort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_sort_slice_min(s : DbquerysortSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_slice_max(s : DbquerysortSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_sort_slice_to_string(s : DbquerysortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

