///===
/// extcore/db_index_rtree

pub(all) struct DbindexrtreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_rtree_make_point(x : Double, y : Double) -> DbindexrtreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_rtree_make_point3(x : Double, y : Double, z : Double) -> DbindexrtreePoint {
  { x, y, z, label: 0 }
}

pub fn db_index_rtree_point_x(pt : DbindexrtreePoint) -> Double { pt.x }

pub fn db_index_rtree_point_y(pt : DbindexrtreePoint) -> Double { pt.y }

pub fn db_index_rtree_point_z(pt : DbindexrtreePoint) -> Double { pt.z }

pub fn db_index_rtree_point_label(pt : DbindexrtreePoint) -> Int { pt.label }

pub fn db_index_rtree_point_dist(a : DbindexrtreePoint, b : DbindexrtreePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_index_rtree_point_add(a : DbindexrtreePoint, b : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_index_rtree_point_sub(a : DbindexrtreePoint, b : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_index_rtree_point_scale(pt : DbindexrtreePoint, s : Double) -> DbindexrtreePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_index_rtree_point_dot(a : DbindexrtreePoint, b : DbindexrtreePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_index_rtree_point_cross(a : DbindexrtreePoint, b : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_index_rtree_point_norm(pt : DbindexrtreePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_index_rtree_point_normalize(pt : DbindexrtreePoint) -> DbindexrtreePoint {
  let n = db_index_rtree_point_norm(pt)
  if n < 0.0000001 { pt } else { db_index_rtree_point_scale(pt, 1.0 / n) }
}

pub fn db_index_rtree_point_negate(pt : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_index_rtree_point_mid(a : DbindexrtreePoint, b : DbindexrtreePoint) -> DbindexrtreePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_index_rtree_point_lerp(a : DbindexrtreePoint, b : DbindexrtreePoint, t : Double) -> DbindexrtreePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_index_rtree_point_to_string(pt : DbindexrtreePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbindexrtreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_rtree_make_series(vals : Array[Double], name : String) -> DbindexrtreeSeries {
  { vals, name, meta: 0 }
}

pub fn db_index_rtree_series_len(s : DbindexrtreeSeries) -> Int { s.vals.length() }

pub fn db_index_rtree_series_sum(s : DbindexrtreeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_index_rtree_series_mean(s : DbindexrtreeSeries) -> Double {
  let n = db_index_rtree_series_len(s)
  if n == 0 { 0.0 } else { db_index_rtree_series_sum(s) / n.to_double() }
}

pub fn db_index_rtree_series_min(s : DbindexrtreeSeries) -> Double {
  let n = db_index_rtree_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_rtree_series_max(s : DbindexrtreeSeries) -> Double {
  let n = db_index_rtree_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_rtree_series_range(s : DbindexrtreeSeries) -> Double {
  db_index_rtree_series_max(s) - db_index_rtree_series_min(s)
}

pub fn db_index_rtree_series_var(s : DbindexrtreeSeries) -> Double {
  let n = db_index_rtree_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_index_rtree_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_index_rtree_series_std(s : DbindexrtreeSeries) -> Double { @_common.sqrt(db_index_rtree_series_var(s)) }

pub fn db_index_rtree_series_median(s : DbindexrtreeSeries) -> Double {
  let n = db_index_rtree_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_index_rtree_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_rtree_series_scale(s : DbindexrtreeSeries, f : Double) -> DbindexrtreeSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_index_rtree_series_add(a : DbindexrtreeSeries, b : DbindexrtreeSeries) -> DbindexrtreeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_index_rtree_series_sub(a : DbindexrtreeSeries, b : DbindexrtreeSeries) -> DbindexrtreeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_index_rtree_series_normalize(s : DbindexrtreeSeries) -> DbindexrtreeSeries {
  let mn = db_index_rtree_series_min(s)
  let mx = db_index_rtree_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_index_rtree_series_cumsum(s : DbindexrtreeSeries) -> DbindexrtreeSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_index_rtree_series_to_string(s : DbindexrtreeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexrtreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_rtree_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexrtreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_rtree_matrix_identity(n : Int) -> DbindexrtreeMatrix {
  let m = db_index_rtree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_index_rtree_matrix_get(m : DbindexrtreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_index_rtree_matrix_transpose(m : DbindexrtreeMatrix) -> DbindexrtreeMatrix {
  let result = db_index_rtree_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_index_rtree_matrix_add(a : DbindexrtreeMatrix, b : DbindexrtreeMatrix) -> DbindexrtreeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_index_rtree_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_index_rtree_matrix_scale(m : DbindexrtreeMatrix, s : Double) -> DbindexrtreeMatrix {
  let result = db_index_rtree_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_index_rtree_matrix_multiply(a : DbindexrtreeMatrix, b : DbindexrtreeMatrix) -> DbindexrtreeMatrix {
  if a.cols != b.rows { return db_index_rtree_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_index_rtree_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_index_rtree_matrix_trace(m : DbindexrtreeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_index_rtree_matrix_det(m : DbindexrtreeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_index_rtree_matrix_norm(m : DbindexrtreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_index_rtree_matrix_to_string(m : DbindexrtreeMatrix) -> String {
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

pub(all) struct DbindexrtreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_rtree_make_vector(comps : Array[Double]) -> DbindexrtreeVector {
  { comps, dim: comps.length() }
}

pub fn db_index_rtree_vector_zero(dim : Int) -> DbindexrtreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_index_rtree_vector_add(a : DbindexrtreeVector, b : DbindexrtreeVector) -> DbindexrtreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_rtree_vector_sub(a : DbindexrtreeVector, b : DbindexrtreeVector) -> DbindexrtreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_rtree_vector_scale(v : DbindexrtreeVector, s : Double) -> DbindexrtreeVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_index_rtree_vector_dot(a : DbindexrtreeVector, b : DbindexrtreeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_index_rtree_vector_norm(v : DbindexrtreeVector) -> Double { @_common.sqrt(db_index_rtree_vector_dot(v, v)) }

pub fn db_index_rtree_vector_normalize(v : DbindexrtreeVector) -> DbindexrtreeVector {
  let n = db_index_rtree_vector_norm(v)
  if n < 0.0000001 { v } else { db_index_rtree_vector_scale(v, 1.0 / n) }
}

pub fn db_index_rtree_vector_dist(a : DbindexrtreeVector, b : DbindexrtreeVector) -> Double {
  db_index_rtree_vector_norm(db_index_rtree_vector_sub(a, b))
}

pub fn db_index_rtree_vector_to_string(v : DbindexrtreeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_rtree_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_index_rtree_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_index_rtree_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_index_rtree_std(data : Array[Double]) -> Double { @_common.sqrt(db_index_rtree_var(data)) }

pub fn db_index_rtree_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_index_rtree_mean(a); let mb = db_index_rtree_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_index_rtree_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_index_rtree_std(a); let sb = db_index_rtree_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_index_rtree_cov(a, b) / (sa * sb) }
}

pub fn db_index_rtree_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_index_rtree_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_rtree_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_index_rtree_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_index_rtree_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(db_index_rtree_mse(pred, labels))
}

pub fn db_index_rtree_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_index_rtree_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_index_rtree_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_index_rtree_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_index_rtree_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_index_rtree_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_index_rtree_precision(pred, labels, pos); let r = db_index_rtree_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_index_rtree_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_index_rtree_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_index_rtree_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_index_rtree_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_index_rtree_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_index_rtree_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_index_rtree_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_index_rtree_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_index_rtree_fibonacci(n : Int) -> Int {
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

pub fn db_index_rtree_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_index_rtree_min(data); let mx = db_index_rtree_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_index_rtree_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_index_rtree_mean(data); let sd = db_index_rtree_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_index_rtree_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_index_rtree_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_index_rtree_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_index_rtree_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_index_rtree_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_index_rtree_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DbindexrtreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_frame_make(size : Int) -> DbindexrtreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_frame_len(s : DbindexrtreeFrame) -> Int { s.size }

pub fn db_index_rtree_frame_get(s : DbindexrtreeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_frame_set(s : DbindexrtreeFrame, i : Int, v : Double) -> DbindexrtreeFrame {
  let result = db_index_rtree_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_frame_sum(s : DbindexrtreeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_frame_mean(s : DbindexrtreeFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_frame_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_frame_scale(s : DbindexrtreeFrame, f : Double) -> DbindexrtreeFrame {
  let result = db_index_rtree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_frame_add(a : DbindexrtreeFrame, b : DbindexrtreeFrame) -> DbindexrtreeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_frame_copy(s : DbindexrtreeFrame) -> DbindexrtreeFrame {
  let result = db_index_rtree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_frame_fill(s : DbindexrtreeFrame, v : Double) -> DbindexrtreeFrame {
  let result = db_index_rtree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_frame_min(s : DbindexrtreeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_frame_max(s : DbindexrtreeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_frame_to_string(s : DbindexrtreeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_table_make(size : Int) -> DbindexrtreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_table_len(s : DbindexrtreeTable) -> Int { s.size }

pub fn db_index_rtree_table_get(s : DbindexrtreeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_table_set(s : DbindexrtreeTable, i : Int, v : Double) -> DbindexrtreeTable {
  let result = db_index_rtree_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_table_sum(s : DbindexrtreeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_table_mean(s : DbindexrtreeTable) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_table_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_table_scale(s : DbindexrtreeTable, f : Double) -> DbindexrtreeTable {
  let result = db_index_rtree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_table_add(a : DbindexrtreeTable, b : DbindexrtreeTable) -> DbindexrtreeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_table_copy(s : DbindexrtreeTable) -> DbindexrtreeTable {
  let result = db_index_rtree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_table_fill(s : DbindexrtreeTable, v : Double) -> DbindexrtreeTable {
  let result = db_index_rtree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_table_min(s : DbindexrtreeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_table_max(s : DbindexrtreeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_table_to_string(s : DbindexrtreeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_graphn_make(size : Int) -> DbindexrtreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_graphn_len(s : DbindexrtreeGraphN) -> Int { s.size }

pub fn db_index_rtree_graphn_get(s : DbindexrtreeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_graphn_set(s : DbindexrtreeGraphN, i : Int, v : Double) -> DbindexrtreeGraphN {
  let result = db_index_rtree_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_graphn_sum(s : DbindexrtreeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_graphn_mean(s : DbindexrtreeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_graphn_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_graphn_scale(s : DbindexrtreeGraphN, f : Double) -> DbindexrtreeGraphN {
  let result = db_index_rtree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_graphn_add(a : DbindexrtreeGraphN, b : DbindexrtreeGraphN) -> DbindexrtreeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_graphn_copy(s : DbindexrtreeGraphN) -> DbindexrtreeGraphN {
  let result = db_index_rtree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_graphn_fill(s : DbindexrtreeGraphN, v : Double) -> DbindexrtreeGraphN {
  let result = db_index_rtree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_graphn_min(s : DbindexrtreeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_graphn_max(s : DbindexrtreeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_graphn_to_string(s : DbindexrtreeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_node_make(size : Int) -> DbindexrtreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_node_len(s : DbindexrtreeNode) -> Int { s.size }

pub fn db_index_rtree_node_get(s : DbindexrtreeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_node_set(s : DbindexrtreeNode, i : Int, v : Double) -> DbindexrtreeNode {
  let result = db_index_rtree_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_node_sum(s : DbindexrtreeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_node_mean(s : DbindexrtreeNode) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_node_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_node_scale(s : DbindexrtreeNode, f : Double) -> DbindexrtreeNode {
  let result = db_index_rtree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_node_add(a : DbindexrtreeNode, b : DbindexrtreeNode) -> DbindexrtreeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_node_copy(s : DbindexrtreeNode) -> DbindexrtreeNode {
  let result = db_index_rtree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_node_fill(s : DbindexrtreeNode, v : Double) -> DbindexrtreeNode {
  let result = db_index_rtree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_node_min(s : DbindexrtreeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_node_max(s : DbindexrtreeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_node_to_string(s : DbindexrtreeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_edge_make(size : Int) -> DbindexrtreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_edge_len(s : DbindexrtreeEdge) -> Int { s.size }

pub fn db_index_rtree_edge_get(s : DbindexrtreeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_edge_set(s : DbindexrtreeEdge, i : Int, v : Double) -> DbindexrtreeEdge {
  let result = db_index_rtree_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_edge_sum(s : DbindexrtreeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_edge_mean(s : DbindexrtreeEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_edge_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_edge_scale(s : DbindexrtreeEdge, f : Double) -> DbindexrtreeEdge {
  let result = db_index_rtree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_edge_add(a : DbindexrtreeEdge, b : DbindexrtreeEdge) -> DbindexrtreeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_edge_copy(s : DbindexrtreeEdge) -> DbindexrtreeEdge {
  let result = db_index_rtree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_edge_fill(s : DbindexrtreeEdge, v : Double) -> DbindexrtreeEdge {
  let result = db_index_rtree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_edge_min(s : DbindexrtreeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_edge_max(s : DbindexrtreeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_edge_to_string(s : DbindexrtreeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_path_make(size : Int) -> DbindexrtreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_path_len(s : DbindexrtreePath) -> Int { s.size }

pub fn db_index_rtree_path_get(s : DbindexrtreePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_path_set(s : DbindexrtreePath, i : Int, v : Double) -> DbindexrtreePath {
  let result = db_index_rtree_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_path_sum(s : DbindexrtreePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_path_mean(s : DbindexrtreePath) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_path_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_path_scale(s : DbindexrtreePath, f : Double) -> DbindexrtreePath {
  let result = db_index_rtree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_path_add(a : DbindexrtreePath, b : DbindexrtreePath) -> DbindexrtreePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_path_copy(s : DbindexrtreePath) -> DbindexrtreePath {
  let result = db_index_rtree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_path_fill(s : DbindexrtreePath, v : Double) -> DbindexrtreePath {
  let result = db_index_rtree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_path_min(s : DbindexrtreePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_path_max(s : DbindexrtreePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_path_to_string(s : DbindexrtreePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_cluster_make(size : Int) -> DbindexrtreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_cluster_len(s : DbindexrtreeCluster) -> Int { s.size }

pub fn db_index_rtree_cluster_get(s : DbindexrtreeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_cluster_set(s : DbindexrtreeCluster, i : Int, v : Double) -> DbindexrtreeCluster {
  let result = db_index_rtree_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_cluster_sum(s : DbindexrtreeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_cluster_mean(s : DbindexrtreeCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_cluster_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_cluster_scale(s : DbindexrtreeCluster, f : Double) -> DbindexrtreeCluster {
  let result = db_index_rtree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_cluster_add(a : DbindexrtreeCluster, b : DbindexrtreeCluster) -> DbindexrtreeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_cluster_copy(s : DbindexrtreeCluster) -> DbindexrtreeCluster {
  let result = db_index_rtree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_cluster_fill(s : DbindexrtreeCluster, v : Double) -> DbindexrtreeCluster {
  let result = db_index_rtree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_cluster_min(s : DbindexrtreeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_cluster_max(s : DbindexrtreeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_cluster_to_string(s : DbindexrtreeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_model_make(size : Int) -> DbindexrtreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_model_len(s : DbindexrtreeModel) -> Int { s.size }

pub fn db_index_rtree_model_get(s : DbindexrtreeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_model_set(s : DbindexrtreeModel, i : Int, v : Double) -> DbindexrtreeModel {
  let result = db_index_rtree_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_model_sum(s : DbindexrtreeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_model_mean(s : DbindexrtreeModel) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_model_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_model_scale(s : DbindexrtreeModel, f : Double) -> DbindexrtreeModel {
  let result = db_index_rtree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_model_add(a : DbindexrtreeModel, b : DbindexrtreeModel) -> DbindexrtreeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_model_copy(s : DbindexrtreeModel) -> DbindexrtreeModel {
  let result = db_index_rtree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_model_fill(s : DbindexrtreeModel, v : Double) -> DbindexrtreeModel {
  let result = db_index_rtree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_model_min(s : DbindexrtreeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_model_max(s : DbindexrtreeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_model_to_string(s : DbindexrtreeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_layer_make(size : Int) -> DbindexrtreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_layer_len(s : DbindexrtreeLayer) -> Int { s.size }

pub fn db_index_rtree_layer_get(s : DbindexrtreeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_layer_set(s : DbindexrtreeLayer, i : Int, v : Double) -> DbindexrtreeLayer {
  let result = db_index_rtree_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_layer_sum(s : DbindexrtreeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_layer_mean(s : DbindexrtreeLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_layer_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_layer_scale(s : DbindexrtreeLayer, f : Double) -> DbindexrtreeLayer {
  let result = db_index_rtree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_layer_add(a : DbindexrtreeLayer, b : DbindexrtreeLayer) -> DbindexrtreeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_layer_copy(s : DbindexrtreeLayer) -> DbindexrtreeLayer {
  let result = db_index_rtree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_layer_fill(s : DbindexrtreeLayer, v : Double) -> DbindexrtreeLayer {
  let result = db_index_rtree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_layer_min(s : DbindexrtreeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_layer_max(s : DbindexrtreeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_layer_to_string(s : DbindexrtreeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_buffer_make(size : Int) -> DbindexrtreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_buffer_len(s : DbindexrtreeBuffer) -> Int { s.size }

pub fn db_index_rtree_buffer_get(s : DbindexrtreeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_buffer_set(s : DbindexrtreeBuffer, i : Int, v : Double) -> DbindexrtreeBuffer {
  let result = db_index_rtree_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_buffer_sum(s : DbindexrtreeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_buffer_mean(s : DbindexrtreeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_buffer_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_buffer_scale(s : DbindexrtreeBuffer, f : Double) -> DbindexrtreeBuffer {
  let result = db_index_rtree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_buffer_add(a : DbindexrtreeBuffer, b : DbindexrtreeBuffer) -> DbindexrtreeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_buffer_copy(s : DbindexrtreeBuffer) -> DbindexrtreeBuffer {
  let result = db_index_rtree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_buffer_fill(s : DbindexrtreeBuffer, v : Double) -> DbindexrtreeBuffer {
  let result = db_index_rtree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_buffer_min(s : DbindexrtreeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_buffer_max(s : DbindexrtreeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_buffer_to_string(s : DbindexrtreeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_cursor_make(size : Int) -> DbindexrtreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_cursor_len(s : DbindexrtreeCursor) -> Int { s.size }

pub fn db_index_rtree_cursor_get(s : DbindexrtreeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_cursor_set(s : DbindexrtreeCursor, i : Int, v : Double) -> DbindexrtreeCursor {
  let result = db_index_rtree_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_cursor_sum(s : DbindexrtreeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_cursor_mean(s : DbindexrtreeCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_cursor_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_cursor_scale(s : DbindexrtreeCursor, f : Double) -> DbindexrtreeCursor {
  let result = db_index_rtree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_cursor_add(a : DbindexrtreeCursor, b : DbindexrtreeCursor) -> DbindexrtreeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_cursor_copy(s : DbindexrtreeCursor) -> DbindexrtreeCursor {
  let result = db_index_rtree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_cursor_fill(s : DbindexrtreeCursor, v : Double) -> DbindexrtreeCursor {
  let result = db_index_rtree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_cursor_min(s : DbindexrtreeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_cursor_max(s : DbindexrtreeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_cursor_to_string(s : DbindexrtreeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_view_make(size : Int) -> DbindexrtreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_view_len(s : DbindexrtreeView) -> Int { s.size }

pub fn db_index_rtree_view_get(s : DbindexrtreeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_view_set(s : DbindexrtreeView, i : Int, v : Double) -> DbindexrtreeView {
  let result = db_index_rtree_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_view_sum(s : DbindexrtreeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_view_mean(s : DbindexrtreeView) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_view_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_view_scale(s : DbindexrtreeView, f : Double) -> DbindexrtreeView {
  let result = db_index_rtree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_view_add(a : DbindexrtreeView, b : DbindexrtreeView) -> DbindexrtreeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_view_copy(s : DbindexrtreeView) -> DbindexrtreeView {
  let result = db_index_rtree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_view_fill(s : DbindexrtreeView, v : Double) -> DbindexrtreeView {
  let result = db_index_rtree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_view_min(s : DbindexrtreeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_view_max(s : DbindexrtreeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_view_to_string(s : DbindexrtreeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_range_make(size : Int) -> DbindexrtreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_range_len(s : DbindexrtreeRange) -> Int { s.size }

pub fn db_index_rtree_range_get(s : DbindexrtreeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_range_set(s : DbindexrtreeRange, i : Int, v : Double) -> DbindexrtreeRange {
  let result = db_index_rtree_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_range_sum(s : DbindexrtreeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_range_mean(s : DbindexrtreeRange) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_range_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_range_scale(s : DbindexrtreeRange, f : Double) -> DbindexrtreeRange {
  let result = db_index_rtree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_range_add(a : DbindexrtreeRange, b : DbindexrtreeRange) -> DbindexrtreeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_range_copy(s : DbindexrtreeRange) -> DbindexrtreeRange {
  let result = db_index_rtree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_range_fill(s : DbindexrtreeRange, v : Double) -> DbindexrtreeRange {
  let result = db_index_rtree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_range_min(s : DbindexrtreeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_range_max(s : DbindexrtreeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_range_to_string(s : DbindexrtreeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexrtreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_rtree_slice_make(size : Int) -> DbindexrtreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_rtree_slice_len(s : DbindexrtreeSlice) -> Int { s.size }

pub fn db_index_rtree_slice_get(s : DbindexrtreeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_rtree_slice_set(s : DbindexrtreeSlice, i : Int, v : Double) -> DbindexrtreeSlice {
  let result = db_index_rtree_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_slice_sum(s : DbindexrtreeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_rtree_slice_mean(s : DbindexrtreeSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_index_rtree_slice_sum(s) / s.size.to_double() }
}

pub fn db_index_rtree_slice_scale(s : DbindexrtreeSlice, f : Double) -> DbindexrtreeSlice {
  let result = db_index_rtree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_rtree_slice_add(a : DbindexrtreeSlice, b : DbindexrtreeSlice) -> DbindexrtreeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_rtree_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_rtree_slice_copy(s : DbindexrtreeSlice) -> DbindexrtreeSlice {
  let result = db_index_rtree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_rtree_slice_fill(s : DbindexrtreeSlice, v : Double) -> DbindexrtreeSlice {
  let result = db_index_rtree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_rtree_slice_min(s : DbindexrtreeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_slice_max(s : DbindexrtreeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_rtree_slice_to_string(s : DbindexrtreeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

