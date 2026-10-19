///===
/// extcore/db_index_bitmap

pub(all) struct DbindexbitmapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_bitmap_make_point(x : Double, y : Double) -> DbindexbitmapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_bitmap_make_point3(x : Double, y : Double, z : Double) -> DbindexbitmapPoint {
  { x, y, z, label: 0 }
}

pub fn db_index_bitmap_point_x(pt : DbindexbitmapPoint) -> Double { pt.x }

pub fn db_index_bitmap_point_y(pt : DbindexbitmapPoint) -> Double { pt.y }

pub fn db_index_bitmap_point_z(pt : DbindexbitmapPoint) -> Double { pt.z }

pub fn db_index_bitmap_point_label(pt : DbindexbitmapPoint) -> Int { pt.label }

pub fn db_index_bitmap_point_dist(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_index_bitmap_point_add(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_index_bitmap_point_sub(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_index_bitmap_point_scale(pt : DbindexbitmapPoint, s : Double) -> DbindexbitmapPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_index_bitmap_point_dot(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_index_bitmap_point_cross(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_index_bitmap_point_norm(pt : DbindexbitmapPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_index_bitmap_point_normalize(pt : DbindexbitmapPoint) -> DbindexbitmapPoint {
  let n = db_index_bitmap_point_norm(pt)
  if n < 0.0000001 { pt } else { db_index_bitmap_point_scale(pt, 1.0 / n) }
}

pub fn db_index_bitmap_point_negate(pt : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_index_bitmap_point_mid(a : DbindexbitmapPoint, b : DbindexbitmapPoint) -> DbindexbitmapPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_index_bitmap_point_lerp(a : DbindexbitmapPoint, b : DbindexbitmapPoint, t : Double) -> DbindexbitmapPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_index_bitmap_point_to_string(pt : DbindexbitmapPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbindexbitmapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_bitmap_make_series(vals : Array[Double], name : String) -> DbindexbitmapSeries {
  { vals, name, meta: 0 }
}

pub fn db_index_bitmap_series_len(s : DbindexbitmapSeries) -> Int { s.vals.length() }

pub fn db_index_bitmap_series_sum(s : DbindexbitmapSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_index_bitmap_series_mean(s : DbindexbitmapSeries) -> Double {
  let n = db_index_bitmap_series_len(s)
  if n == 0 { 0.0 } else { db_index_bitmap_series_sum(s) / n.to_double() }
}

pub fn db_index_bitmap_series_min(s : DbindexbitmapSeries) -> Double {
  let n = db_index_bitmap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_bitmap_series_max(s : DbindexbitmapSeries) -> Double {
  let n = db_index_bitmap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_bitmap_series_range(s : DbindexbitmapSeries) -> Double {
  db_index_bitmap_series_max(s) - db_index_bitmap_series_min(s)
}

pub fn db_index_bitmap_series_var(s : DbindexbitmapSeries) -> Double {
  let n = db_index_bitmap_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_index_bitmap_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_index_bitmap_series_std(s : DbindexbitmapSeries) -> Double { @_common.sqrt(db_index_bitmap_series_var(s)) }

pub fn db_index_bitmap_series_median(s : DbindexbitmapSeries) -> Double {
  let n = db_index_bitmap_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_index_bitmap_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_bitmap_series_scale(s : DbindexbitmapSeries, f : Double) -> DbindexbitmapSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_index_bitmap_series_add(a : DbindexbitmapSeries, b : DbindexbitmapSeries) -> DbindexbitmapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_index_bitmap_series_sub(a : DbindexbitmapSeries, b : DbindexbitmapSeries) -> DbindexbitmapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_index_bitmap_series_normalize(s : DbindexbitmapSeries) -> DbindexbitmapSeries {
  let mn = db_index_bitmap_series_min(s)
  let mx = db_index_bitmap_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_index_bitmap_series_cumsum(s : DbindexbitmapSeries) -> DbindexbitmapSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_index_bitmap_series_to_string(s : DbindexbitmapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexbitmapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_bitmap_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexbitmapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_bitmap_matrix_identity(n : Int) -> DbindexbitmapMatrix {
  let m = db_index_bitmap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_index_bitmap_matrix_get(m : DbindexbitmapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_index_bitmap_matrix_transpose(m : DbindexbitmapMatrix) -> DbindexbitmapMatrix {
  let result = db_index_bitmap_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_index_bitmap_matrix_add(a : DbindexbitmapMatrix, b : DbindexbitmapMatrix) -> DbindexbitmapMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_index_bitmap_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_index_bitmap_matrix_scale(m : DbindexbitmapMatrix, s : Double) -> DbindexbitmapMatrix {
  let result = db_index_bitmap_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_index_bitmap_matrix_multiply(a : DbindexbitmapMatrix, b : DbindexbitmapMatrix) -> DbindexbitmapMatrix {
  if a.cols != b.rows { return db_index_bitmap_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_index_bitmap_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_index_bitmap_matrix_trace(m : DbindexbitmapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_index_bitmap_matrix_det(m : DbindexbitmapMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_index_bitmap_matrix_norm(m : DbindexbitmapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_index_bitmap_matrix_to_string(m : DbindexbitmapMatrix) -> String {
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

pub(all) struct DbindexbitmapVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_bitmap_make_vector(comps : Array[Double]) -> DbindexbitmapVector {
  { comps, dim: comps.length() }
}

pub fn db_index_bitmap_vector_zero(dim : Int) -> DbindexbitmapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_index_bitmap_vector_add(a : DbindexbitmapVector, b : DbindexbitmapVector) -> DbindexbitmapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_bitmap_vector_sub(a : DbindexbitmapVector, b : DbindexbitmapVector) -> DbindexbitmapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_bitmap_vector_scale(v : DbindexbitmapVector, s : Double) -> DbindexbitmapVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_index_bitmap_vector_dot(a : DbindexbitmapVector, b : DbindexbitmapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_index_bitmap_vector_norm(v : DbindexbitmapVector) -> Double { @_common.sqrt(db_index_bitmap_vector_dot(v, v)) }

pub fn db_index_bitmap_vector_normalize(v : DbindexbitmapVector) -> DbindexbitmapVector {
  let n = db_index_bitmap_vector_norm(v)
  if n < 0.0000001 { v } else { db_index_bitmap_vector_scale(v, 1.0 / n) }
}

pub fn db_index_bitmap_vector_dist(a : DbindexbitmapVector, b : DbindexbitmapVector) -> Double {
  db_index_bitmap_vector_norm(db_index_bitmap_vector_sub(a, b))
}

pub fn db_index_bitmap_vector_to_string(v : DbindexbitmapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_bitmap_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_index_bitmap_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_index_bitmap_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_index_bitmap_std(data : Array[Double]) -> Double { @_common.sqrt(db_index_bitmap_var(data)) }

pub fn db_index_bitmap_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_index_bitmap_mean(a); let mb = db_index_bitmap_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_index_bitmap_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_index_bitmap_std(a); let sb = db_index_bitmap_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_index_bitmap_cov(a, b) / (sa * sb) }
}

pub fn db_index_bitmap_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_index_bitmap_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_bitmap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_index_bitmap_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_index_bitmap_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(db_index_bitmap_mse(pred, labels))
}

pub fn db_index_bitmap_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_index_bitmap_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_index_bitmap_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_index_bitmap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_index_bitmap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_index_bitmap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_index_bitmap_precision(pred, labels, pos); let r = db_index_bitmap_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_index_bitmap_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_index_bitmap_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_index_bitmap_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_index_bitmap_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_index_bitmap_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_index_bitmap_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_index_bitmap_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_index_bitmap_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_index_bitmap_fibonacci(n : Int) -> Int {
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

pub fn db_index_bitmap_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_index_bitmap_min(data); let mx = db_index_bitmap_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_index_bitmap_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_index_bitmap_mean(data); let sd = db_index_bitmap_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_index_bitmap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_index_bitmap_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_index_bitmap_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_index_bitmap_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_index_bitmap_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_index_bitmap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DbindexbitmapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_frame_make(size : Int) -> DbindexbitmapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_frame_len(s : DbindexbitmapFrame) -> Int { s.size }

pub fn db_index_bitmap_frame_get(s : DbindexbitmapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_frame_set(s : DbindexbitmapFrame, i : Int, v : Double) -> DbindexbitmapFrame {
  let result = db_index_bitmap_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_frame_sum(s : DbindexbitmapFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_frame_mean(s : DbindexbitmapFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_frame_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_frame_scale(s : DbindexbitmapFrame, f : Double) -> DbindexbitmapFrame {
  let result = db_index_bitmap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_frame_add(a : DbindexbitmapFrame, b : DbindexbitmapFrame) -> DbindexbitmapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_frame_copy(s : DbindexbitmapFrame) -> DbindexbitmapFrame {
  let result = db_index_bitmap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_frame_fill(s : DbindexbitmapFrame, v : Double) -> DbindexbitmapFrame {
  let result = db_index_bitmap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_frame_min(s : DbindexbitmapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_frame_max(s : DbindexbitmapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_frame_to_string(s : DbindexbitmapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_table_make(size : Int) -> DbindexbitmapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_table_len(s : DbindexbitmapTable) -> Int { s.size }

pub fn db_index_bitmap_table_get(s : DbindexbitmapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_table_set(s : DbindexbitmapTable, i : Int, v : Double) -> DbindexbitmapTable {
  let result = db_index_bitmap_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_table_sum(s : DbindexbitmapTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_table_mean(s : DbindexbitmapTable) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_table_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_table_scale(s : DbindexbitmapTable, f : Double) -> DbindexbitmapTable {
  let result = db_index_bitmap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_table_add(a : DbindexbitmapTable, b : DbindexbitmapTable) -> DbindexbitmapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_table_copy(s : DbindexbitmapTable) -> DbindexbitmapTable {
  let result = db_index_bitmap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_table_fill(s : DbindexbitmapTable, v : Double) -> DbindexbitmapTable {
  let result = db_index_bitmap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_table_min(s : DbindexbitmapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_table_max(s : DbindexbitmapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_table_to_string(s : DbindexbitmapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_graphn_make(size : Int) -> DbindexbitmapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_graphn_len(s : DbindexbitmapGraphN) -> Int { s.size }

pub fn db_index_bitmap_graphn_get(s : DbindexbitmapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_graphn_set(s : DbindexbitmapGraphN, i : Int, v : Double) -> DbindexbitmapGraphN {
  let result = db_index_bitmap_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_graphn_sum(s : DbindexbitmapGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_graphn_mean(s : DbindexbitmapGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_graphn_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_graphn_scale(s : DbindexbitmapGraphN, f : Double) -> DbindexbitmapGraphN {
  let result = db_index_bitmap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_graphn_add(a : DbindexbitmapGraphN, b : DbindexbitmapGraphN) -> DbindexbitmapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_graphn_copy(s : DbindexbitmapGraphN) -> DbindexbitmapGraphN {
  let result = db_index_bitmap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_graphn_fill(s : DbindexbitmapGraphN, v : Double) -> DbindexbitmapGraphN {
  let result = db_index_bitmap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_graphn_min(s : DbindexbitmapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_graphn_max(s : DbindexbitmapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_graphn_to_string(s : DbindexbitmapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_node_make(size : Int) -> DbindexbitmapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_node_len(s : DbindexbitmapNode) -> Int { s.size }

pub fn db_index_bitmap_node_get(s : DbindexbitmapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_node_set(s : DbindexbitmapNode, i : Int, v : Double) -> DbindexbitmapNode {
  let result = db_index_bitmap_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_node_sum(s : DbindexbitmapNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_node_mean(s : DbindexbitmapNode) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_node_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_node_scale(s : DbindexbitmapNode, f : Double) -> DbindexbitmapNode {
  let result = db_index_bitmap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_node_add(a : DbindexbitmapNode, b : DbindexbitmapNode) -> DbindexbitmapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_node_copy(s : DbindexbitmapNode) -> DbindexbitmapNode {
  let result = db_index_bitmap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_node_fill(s : DbindexbitmapNode, v : Double) -> DbindexbitmapNode {
  let result = db_index_bitmap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_node_min(s : DbindexbitmapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_node_max(s : DbindexbitmapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_node_to_string(s : DbindexbitmapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_edge_make(size : Int) -> DbindexbitmapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_edge_len(s : DbindexbitmapEdge) -> Int { s.size }

pub fn db_index_bitmap_edge_get(s : DbindexbitmapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_edge_set(s : DbindexbitmapEdge, i : Int, v : Double) -> DbindexbitmapEdge {
  let result = db_index_bitmap_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_edge_sum(s : DbindexbitmapEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_edge_mean(s : DbindexbitmapEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_edge_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_edge_scale(s : DbindexbitmapEdge, f : Double) -> DbindexbitmapEdge {
  let result = db_index_bitmap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_edge_add(a : DbindexbitmapEdge, b : DbindexbitmapEdge) -> DbindexbitmapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_edge_copy(s : DbindexbitmapEdge) -> DbindexbitmapEdge {
  let result = db_index_bitmap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_edge_fill(s : DbindexbitmapEdge, v : Double) -> DbindexbitmapEdge {
  let result = db_index_bitmap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_edge_min(s : DbindexbitmapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_edge_max(s : DbindexbitmapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_edge_to_string(s : DbindexbitmapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_path_make(size : Int) -> DbindexbitmapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_path_len(s : DbindexbitmapPath) -> Int { s.size }

pub fn db_index_bitmap_path_get(s : DbindexbitmapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_path_set(s : DbindexbitmapPath, i : Int, v : Double) -> DbindexbitmapPath {
  let result = db_index_bitmap_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_path_sum(s : DbindexbitmapPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_path_mean(s : DbindexbitmapPath) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_path_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_path_scale(s : DbindexbitmapPath, f : Double) -> DbindexbitmapPath {
  let result = db_index_bitmap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_path_add(a : DbindexbitmapPath, b : DbindexbitmapPath) -> DbindexbitmapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_path_copy(s : DbindexbitmapPath) -> DbindexbitmapPath {
  let result = db_index_bitmap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_path_fill(s : DbindexbitmapPath, v : Double) -> DbindexbitmapPath {
  let result = db_index_bitmap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_path_min(s : DbindexbitmapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_path_max(s : DbindexbitmapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_path_to_string(s : DbindexbitmapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_cluster_make(size : Int) -> DbindexbitmapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_cluster_len(s : DbindexbitmapCluster) -> Int { s.size }

pub fn db_index_bitmap_cluster_get(s : DbindexbitmapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_cluster_set(s : DbindexbitmapCluster, i : Int, v : Double) -> DbindexbitmapCluster {
  let result = db_index_bitmap_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_cluster_sum(s : DbindexbitmapCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_cluster_mean(s : DbindexbitmapCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_cluster_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_cluster_scale(s : DbindexbitmapCluster, f : Double) -> DbindexbitmapCluster {
  let result = db_index_bitmap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_cluster_add(a : DbindexbitmapCluster, b : DbindexbitmapCluster) -> DbindexbitmapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_cluster_copy(s : DbindexbitmapCluster) -> DbindexbitmapCluster {
  let result = db_index_bitmap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_cluster_fill(s : DbindexbitmapCluster, v : Double) -> DbindexbitmapCluster {
  let result = db_index_bitmap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_cluster_min(s : DbindexbitmapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_cluster_max(s : DbindexbitmapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_cluster_to_string(s : DbindexbitmapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_model_make(size : Int) -> DbindexbitmapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_model_len(s : DbindexbitmapModel) -> Int { s.size }

pub fn db_index_bitmap_model_get(s : DbindexbitmapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_model_set(s : DbindexbitmapModel, i : Int, v : Double) -> DbindexbitmapModel {
  let result = db_index_bitmap_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_model_sum(s : DbindexbitmapModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_model_mean(s : DbindexbitmapModel) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_model_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_model_scale(s : DbindexbitmapModel, f : Double) -> DbindexbitmapModel {
  let result = db_index_bitmap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_model_add(a : DbindexbitmapModel, b : DbindexbitmapModel) -> DbindexbitmapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_model_copy(s : DbindexbitmapModel) -> DbindexbitmapModel {
  let result = db_index_bitmap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_model_fill(s : DbindexbitmapModel, v : Double) -> DbindexbitmapModel {
  let result = db_index_bitmap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_model_min(s : DbindexbitmapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_model_max(s : DbindexbitmapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_model_to_string(s : DbindexbitmapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_layer_make(size : Int) -> DbindexbitmapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_layer_len(s : DbindexbitmapLayer) -> Int { s.size }

pub fn db_index_bitmap_layer_get(s : DbindexbitmapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_layer_set(s : DbindexbitmapLayer, i : Int, v : Double) -> DbindexbitmapLayer {
  let result = db_index_bitmap_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_layer_sum(s : DbindexbitmapLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_layer_mean(s : DbindexbitmapLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_layer_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_layer_scale(s : DbindexbitmapLayer, f : Double) -> DbindexbitmapLayer {
  let result = db_index_bitmap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_layer_add(a : DbindexbitmapLayer, b : DbindexbitmapLayer) -> DbindexbitmapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_layer_copy(s : DbindexbitmapLayer) -> DbindexbitmapLayer {
  let result = db_index_bitmap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_layer_fill(s : DbindexbitmapLayer, v : Double) -> DbindexbitmapLayer {
  let result = db_index_bitmap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_layer_min(s : DbindexbitmapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_layer_max(s : DbindexbitmapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_layer_to_string(s : DbindexbitmapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_buffer_make(size : Int) -> DbindexbitmapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_buffer_len(s : DbindexbitmapBuffer) -> Int { s.size }

pub fn db_index_bitmap_buffer_get(s : DbindexbitmapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_buffer_set(s : DbindexbitmapBuffer, i : Int, v : Double) -> DbindexbitmapBuffer {
  let result = db_index_bitmap_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_buffer_sum(s : DbindexbitmapBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_buffer_mean(s : DbindexbitmapBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_buffer_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_buffer_scale(s : DbindexbitmapBuffer, f : Double) -> DbindexbitmapBuffer {
  let result = db_index_bitmap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_buffer_add(a : DbindexbitmapBuffer, b : DbindexbitmapBuffer) -> DbindexbitmapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_buffer_copy(s : DbindexbitmapBuffer) -> DbindexbitmapBuffer {
  let result = db_index_bitmap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_buffer_fill(s : DbindexbitmapBuffer, v : Double) -> DbindexbitmapBuffer {
  let result = db_index_bitmap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_buffer_min(s : DbindexbitmapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_buffer_max(s : DbindexbitmapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_buffer_to_string(s : DbindexbitmapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_cursor_make(size : Int) -> DbindexbitmapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_cursor_len(s : DbindexbitmapCursor) -> Int { s.size }

pub fn db_index_bitmap_cursor_get(s : DbindexbitmapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_cursor_set(s : DbindexbitmapCursor, i : Int, v : Double) -> DbindexbitmapCursor {
  let result = db_index_bitmap_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_cursor_sum(s : DbindexbitmapCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_cursor_mean(s : DbindexbitmapCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_cursor_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_cursor_scale(s : DbindexbitmapCursor, f : Double) -> DbindexbitmapCursor {
  let result = db_index_bitmap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_cursor_add(a : DbindexbitmapCursor, b : DbindexbitmapCursor) -> DbindexbitmapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_cursor_copy(s : DbindexbitmapCursor) -> DbindexbitmapCursor {
  let result = db_index_bitmap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_cursor_fill(s : DbindexbitmapCursor, v : Double) -> DbindexbitmapCursor {
  let result = db_index_bitmap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_cursor_min(s : DbindexbitmapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_cursor_max(s : DbindexbitmapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_cursor_to_string(s : DbindexbitmapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_view_make(size : Int) -> DbindexbitmapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_view_len(s : DbindexbitmapView) -> Int { s.size }

pub fn db_index_bitmap_view_get(s : DbindexbitmapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_view_set(s : DbindexbitmapView, i : Int, v : Double) -> DbindexbitmapView {
  let result = db_index_bitmap_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_view_sum(s : DbindexbitmapView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_view_mean(s : DbindexbitmapView) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_view_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_view_scale(s : DbindexbitmapView, f : Double) -> DbindexbitmapView {
  let result = db_index_bitmap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_view_add(a : DbindexbitmapView, b : DbindexbitmapView) -> DbindexbitmapView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_view_copy(s : DbindexbitmapView) -> DbindexbitmapView {
  let result = db_index_bitmap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_view_fill(s : DbindexbitmapView, v : Double) -> DbindexbitmapView {
  let result = db_index_bitmap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_view_min(s : DbindexbitmapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_view_max(s : DbindexbitmapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_view_to_string(s : DbindexbitmapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_range_make(size : Int) -> DbindexbitmapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_range_len(s : DbindexbitmapRange) -> Int { s.size }

pub fn db_index_bitmap_range_get(s : DbindexbitmapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_range_set(s : DbindexbitmapRange, i : Int, v : Double) -> DbindexbitmapRange {
  let result = db_index_bitmap_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_range_sum(s : DbindexbitmapRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_range_mean(s : DbindexbitmapRange) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_range_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_range_scale(s : DbindexbitmapRange, f : Double) -> DbindexbitmapRange {
  let result = db_index_bitmap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_range_add(a : DbindexbitmapRange, b : DbindexbitmapRange) -> DbindexbitmapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_range_copy(s : DbindexbitmapRange) -> DbindexbitmapRange {
  let result = db_index_bitmap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_range_fill(s : DbindexbitmapRange, v : Double) -> DbindexbitmapRange {
  let result = db_index_bitmap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_range_min(s : DbindexbitmapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_range_max(s : DbindexbitmapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_range_to_string(s : DbindexbitmapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbitmapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_bitmap_slice_make(size : Int) -> DbindexbitmapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_bitmap_slice_len(s : DbindexbitmapSlice) -> Int { s.size }

pub fn db_index_bitmap_slice_get(s : DbindexbitmapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_bitmap_slice_set(s : DbindexbitmapSlice, i : Int, v : Double) -> DbindexbitmapSlice {
  let result = db_index_bitmap_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_slice_sum(s : DbindexbitmapSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_bitmap_slice_mean(s : DbindexbitmapSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_index_bitmap_slice_sum(s) / s.size.to_double() }
}

pub fn db_index_bitmap_slice_scale(s : DbindexbitmapSlice, f : Double) -> DbindexbitmapSlice {
  let result = db_index_bitmap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_bitmap_slice_add(a : DbindexbitmapSlice, b : DbindexbitmapSlice) -> DbindexbitmapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_bitmap_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_bitmap_slice_copy(s : DbindexbitmapSlice) -> DbindexbitmapSlice {
  let result = db_index_bitmap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_bitmap_slice_fill(s : DbindexbitmapSlice, v : Double) -> DbindexbitmapSlice {
  let result = db_index_bitmap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_bitmap_slice_min(s : DbindexbitmapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_slice_max(s : DbindexbitmapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_bitmap_slice_to_string(s : DbindexbitmapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

