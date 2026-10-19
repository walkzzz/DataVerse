///===
/// extcore/db_index_gist

pub(all) struct DbindexgistPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_gist_make_point(x : Double, y : Double) -> DbindexgistPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_gist_make_point3(x : Double, y : Double, z : Double) -> DbindexgistPoint {
  { x, y, z, label: 0 }
}

pub fn db_index_gist_point_x(pt : DbindexgistPoint) -> Double { pt.x }

pub fn db_index_gist_point_y(pt : DbindexgistPoint) -> Double { pt.y }

pub fn db_index_gist_point_z(pt : DbindexgistPoint) -> Double { pt.z }

pub fn db_index_gist_point_label(pt : DbindexgistPoint) -> Int { pt.label }

pub fn db_index_gist_point_dist(a : DbindexgistPoint, b : DbindexgistPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_index_gist_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_index_gist_point_add(a : DbindexgistPoint, b : DbindexgistPoint) -> DbindexgistPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_index_gist_point_sub(a : DbindexgistPoint, b : DbindexgistPoint) -> DbindexgistPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_index_gist_point_scale(pt : DbindexgistPoint, s : Double) -> DbindexgistPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_index_gist_point_dot(a : DbindexgistPoint, b : DbindexgistPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_index_gist_point_cross(a : DbindexgistPoint, b : DbindexgistPoint) -> DbindexgistPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_index_gist_point_norm(pt : DbindexgistPoint) -> Double {
  db_index_gist_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_index_gist_point_normalize(pt : DbindexgistPoint) -> DbindexgistPoint {
  let n = db_index_gist_point_norm(pt)
  if n < 0.0000001 { pt } else { db_index_gist_point_scale(pt, 1.0 / n) }
}

pub fn db_index_gist_point_negate(pt : DbindexgistPoint) -> DbindexgistPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_index_gist_point_mid(a : DbindexgistPoint, b : DbindexgistPoint) -> DbindexgistPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_index_gist_point_lerp(a : DbindexgistPoint, b : DbindexgistPoint, t : Double) -> DbindexgistPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_index_gist_point_to_string(pt : DbindexgistPoint) -> String {
  "(" + db_index_gist_dbl(pt.x) + ", " + db_index_gist_dbl(pt.y) + ", " + db_index_gist_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbindexgistSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_gist_make_series(vals : Array[Double], name : String) -> DbindexgistSeries {
  { vals, name, meta: 0 }
}

pub fn db_index_gist_series_len(s : DbindexgistSeries) -> Int { s.vals.length() }

pub fn db_index_gist_series_sum(s : DbindexgistSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_index_gist_series_mean(s : DbindexgistSeries) -> Double {
  let n = db_index_gist_series_len(s)
  if n == 0 { 0.0 } else { db_index_gist_series_sum(s) / n.to_double() }
}

pub fn db_index_gist_series_min(s : DbindexgistSeries) -> Double {
  let n = db_index_gist_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_gist_series_max(s : DbindexgistSeries) -> Double {
  let n = db_index_gist_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_gist_series_range(s : DbindexgistSeries) -> Double {
  db_index_gist_series_max(s) - db_index_gist_series_min(s)
}

pub fn db_index_gist_series_var(s : DbindexgistSeries) -> Double {
  let n = db_index_gist_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_index_gist_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_index_gist_series_std(s : DbindexgistSeries) -> Double { db_index_gist_sqrt(db_index_gist_series_var(s)) }

pub fn db_index_gist_series_median(s : DbindexgistSeries) -> Double {
  let n = db_index_gist_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_index_gist_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_gist_series_scale(s : DbindexgistSeries, f : Double) -> DbindexgistSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_index_gist_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_index_gist_series_add(a : DbindexgistSeries, b : DbindexgistSeries) -> DbindexgistSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_index_gist_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_index_gist_series_sub(a : DbindexgistSeries, b : DbindexgistSeries) -> DbindexgistSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_index_gist_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_index_gist_series_normalize(s : DbindexgistSeries) -> DbindexgistSeries {
  let mn = db_index_gist_series_min(s)
  let mx = db_index_gist_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_index_gist_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_index_gist_series_cumsum(s : DbindexgistSeries) -> DbindexgistSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_index_gist_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_index_gist_series_to_string(s : DbindexgistSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_index_gist_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexgistMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_gist_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexgistMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_gist_matrix_identity(n : Int) -> DbindexgistMatrix {
  let m = db_index_gist_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_index_gist_matrix_get(m : DbindexgistMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_index_gist_matrix_transpose(m : DbindexgistMatrix) -> DbindexgistMatrix {
  let result = db_index_gist_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_index_gist_matrix_add(a : DbindexgistMatrix, b : DbindexgistMatrix) -> DbindexgistMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_index_gist_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_index_gist_matrix_scale(m : DbindexgistMatrix, s : Double) -> DbindexgistMatrix {
  let result = db_index_gist_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_index_gist_matrix_multiply(a : DbindexgistMatrix, b : DbindexgistMatrix) -> DbindexgistMatrix {
  if a.cols != b.rows { return db_index_gist_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_index_gist_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_index_gist_matrix_trace(m : DbindexgistMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_index_gist_matrix_det(m : DbindexgistMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_index_gist_matrix_norm(m : DbindexgistMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_index_gist_sqrt(sum)
}

pub fn db_index_gist_matrix_to_string(m : DbindexgistMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_index_gist_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbindexgistVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_gist_make_vector(comps : Array[Double]) -> DbindexgistVector {
  { comps, dim: comps.length() }
}

pub fn db_index_gist_vector_zero(dim : Int) -> DbindexgistVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_index_gist_vector_add(a : DbindexgistVector, b : DbindexgistVector) -> DbindexgistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_index_gist_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_gist_vector_sub(a : DbindexgistVector, b : DbindexgistVector) -> DbindexgistVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_index_gist_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_gist_vector_scale(v : DbindexgistVector, s : Double) -> DbindexgistVector {
  let mut result = []
  for i in 0..<v.dim { result = db_index_gist_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_index_gist_vector_dot(a : DbindexgistVector, b : DbindexgistVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_index_gist_vector_norm(v : DbindexgistVector) -> Double { db_index_gist_sqrt(db_index_gist_vector_dot(v, v)) }

pub fn db_index_gist_vector_normalize(v : DbindexgistVector) -> DbindexgistVector {
  let n = db_index_gist_vector_norm(v)
  if n < 0.0000001 { v } else { db_index_gist_vector_scale(v, 1.0 / n) }
}

pub fn db_index_gist_vector_dist(a : DbindexgistVector, b : DbindexgistVector) -> Double {
  db_index_gist_vector_norm(db_index_gist_vector_sub(a, b))
}

pub fn db_index_gist_vector_to_string(v : DbindexgistVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_index_gist_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_gist_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_index_gist_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_index_gist_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_index_gist_std(data : Array[Double]) -> Double { db_index_gist_sqrt(db_index_gist_var(data)) }

pub fn db_index_gist_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_index_gist_mean(a); let mb = db_index_gist_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_index_gist_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_index_gist_std(a); let sb = db_index_gist_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_index_gist_cov(a, b) / (sa * sb) }
}

pub fn db_index_gist_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_index_gist_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_gist_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_index_gist_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_index_gist_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_index_gist_sqrt(db_index_gist_mse(pred, labels))
}

pub fn db_index_gist_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_index_gist_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_index_gist_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_index_gist_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_index_gist_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_index_gist_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_index_gist_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_index_gist_precision(pred, labels, pos); let r = db_index_gist_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_index_gist_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_index_gist_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_index_gist_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_index_gist_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_index_gist_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_index_gist_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_index_gist_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_index_gist_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_index_gist_fibonacci(n : Int) -> Int {
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

pub fn db_index_gist_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_index_gist_min(data); let mx = db_index_gist_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_index_gist_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_index_gist_mean(data); let sd = db_index_gist_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_index_gist_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_index_gist_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_index_gist_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_index_gist_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_index_gist_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_index_gist_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_index_gist_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_index_gist_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_index_gist_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_index_gist_int(x) } else { -db_index_gist_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_index_gist_int(f * 1000000.0) } else { db_index_gist_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_index_gist_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_index_gist_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbindexgistFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_frame_make(size : Int) -> DbindexgistFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_frame_len(s : DbindexgistFrame) -> Int { s.size }

pub fn db_index_gist_frame_get(s : DbindexgistFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_frame_set(s : DbindexgistFrame, i : Int, v : Double) -> DbindexgistFrame {
  let result = db_index_gist_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_frame_sum(s : DbindexgistFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_frame_mean(s : DbindexgistFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_frame_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_frame_scale(s : DbindexgistFrame, f : Double) -> DbindexgistFrame {
  let result = db_index_gist_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_frame_add(a : DbindexgistFrame, b : DbindexgistFrame) -> DbindexgistFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_frame_copy(s : DbindexgistFrame) -> DbindexgistFrame {
  let result = db_index_gist_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_frame_fill(s : DbindexgistFrame, v : Double) -> DbindexgistFrame {
  let result = db_index_gist_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_frame_min(s : DbindexgistFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_frame_max(s : DbindexgistFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_frame_to_string(s : DbindexgistFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_table_make(size : Int) -> DbindexgistTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_table_len(s : DbindexgistTable) -> Int { s.size }

pub fn db_index_gist_table_get(s : DbindexgistTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_table_set(s : DbindexgistTable, i : Int, v : Double) -> DbindexgistTable {
  let result = db_index_gist_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_table_sum(s : DbindexgistTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_table_mean(s : DbindexgistTable) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_table_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_table_scale(s : DbindexgistTable, f : Double) -> DbindexgistTable {
  let result = db_index_gist_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_table_add(a : DbindexgistTable, b : DbindexgistTable) -> DbindexgistTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_table_copy(s : DbindexgistTable) -> DbindexgistTable {
  let result = db_index_gist_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_table_fill(s : DbindexgistTable, v : Double) -> DbindexgistTable {
  let result = db_index_gist_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_table_min(s : DbindexgistTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_table_max(s : DbindexgistTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_table_to_string(s : DbindexgistTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_graphn_make(size : Int) -> DbindexgistGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_graphn_len(s : DbindexgistGraphN) -> Int { s.size }

pub fn db_index_gist_graphn_get(s : DbindexgistGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_graphn_set(s : DbindexgistGraphN, i : Int, v : Double) -> DbindexgistGraphN {
  let result = db_index_gist_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_graphn_sum(s : DbindexgistGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_graphn_mean(s : DbindexgistGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_graphn_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_graphn_scale(s : DbindexgistGraphN, f : Double) -> DbindexgistGraphN {
  let result = db_index_gist_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_graphn_add(a : DbindexgistGraphN, b : DbindexgistGraphN) -> DbindexgistGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_graphn_copy(s : DbindexgistGraphN) -> DbindexgistGraphN {
  let result = db_index_gist_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_graphn_fill(s : DbindexgistGraphN, v : Double) -> DbindexgistGraphN {
  let result = db_index_gist_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_graphn_min(s : DbindexgistGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_graphn_max(s : DbindexgistGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_graphn_to_string(s : DbindexgistGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_node_make(size : Int) -> DbindexgistNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_node_len(s : DbindexgistNode) -> Int { s.size }

pub fn db_index_gist_node_get(s : DbindexgistNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_node_set(s : DbindexgistNode, i : Int, v : Double) -> DbindexgistNode {
  let result = db_index_gist_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_node_sum(s : DbindexgistNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_node_mean(s : DbindexgistNode) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_node_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_node_scale(s : DbindexgistNode, f : Double) -> DbindexgistNode {
  let result = db_index_gist_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_node_add(a : DbindexgistNode, b : DbindexgistNode) -> DbindexgistNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_node_copy(s : DbindexgistNode) -> DbindexgistNode {
  let result = db_index_gist_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_node_fill(s : DbindexgistNode, v : Double) -> DbindexgistNode {
  let result = db_index_gist_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_node_min(s : DbindexgistNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_node_max(s : DbindexgistNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_node_to_string(s : DbindexgistNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_edge_make(size : Int) -> DbindexgistEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_edge_len(s : DbindexgistEdge) -> Int { s.size }

pub fn db_index_gist_edge_get(s : DbindexgistEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_edge_set(s : DbindexgistEdge, i : Int, v : Double) -> DbindexgistEdge {
  let result = db_index_gist_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_edge_sum(s : DbindexgistEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_edge_mean(s : DbindexgistEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_edge_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_edge_scale(s : DbindexgistEdge, f : Double) -> DbindexgistEdge {
  let result = db_index_gist_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_edge_add(a : DbindexgistEdge, b : DbindexgistEdge) -> DbindexgistEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_edge_copy(s : DbindexgistEdge) -> DbindexgistEdge {
  let result = db_index_gist_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_edge_fill(s : DbindexgistEdge, v : Double) -> DbindexgistEdge {
  let result = db_index_gist_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_edge_min(s : DbindexgistEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_edge_max(s : DbindexgistEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_edge_to_string(s : DbindexgistEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_path_make(size : Int) -> DbindexgistPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_path_len(s : DbindexgistPath) -> Int { s.size }

pub fn db_index_gist_path_get(s : DbindexgistPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_path_set(s : DbindexgistPath, i : Int, v : Double) -> DbindexgistPath {
  let result = db_index_gist_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_path_sum(s : DbindexgistPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_path_mean(s : DbindexgistPath) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_path_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_path_scale(s : DbindexgistPath, f : Double) -> DbindexgistPath {
  let result = db_index_gist_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_path_add(a : DbindexgistPath, b : DbindexgistPath) -> DbindexgistPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_path_copy(s : DbindexgistPath) -> DbindexgistPath {
  let result = db_index_gist_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_path_fill(s : DbindexgistPath, v : Double) -> DbindexgistPath {
  let result = db_index_gist_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_path_min(s : DbindexgistPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_path_max(s : DbindexgistPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_path_to_string(s : DbindexgistPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_cluster_make(size : Int) -> DbindexgistCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_cluster_len(s : DbindexgistCluster) -> Int { s.size }

pub fn db_index_gist_cluster_get(s : DbindexgistCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_cluster_set(s : DbindexgistCluster, i : Int, v : Double) -> DbindexgistCluster {
  let result = db_index_gist_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_cluster_sum(s : DbindexgistCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_cluster_mean(s : DbindexgistCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_cluster_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_cluster_scale(s : DbindexgistCluster, f : Double) -> DbindexgistCluster {
  let result = db_index_gist_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_cluster_add(a : DbindexgistCluster, b : DbindexgistCluster) -> DbindexgistCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_cluster_copy(s : DbindexgistCluster) -> DbindexgistCluster {
  let result = db_index_gist_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_cluster_fill(s : DbindexgistCluster, v : Double) -> DbindexgistCluster {
  let result = db_index_gist_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_cluster_min(s : DbindexgistCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_cluster_max(s : DbindexgistCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_cluster_to_string(s : DbindexgistCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_model_make(size : Int) -> DbindexgistModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_model_len(s : DbindexgistModel) -> Int { s.size }

pub fn db_index_gist_model_get(s : DbindexgistModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_model_set(s : DbindexgistModel, i : Int, v : Double) -> DbindexgistModel {
  let result = db_index_gist_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_model_sum(s : DbindexgistModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_model_mean(s : DbindexgistModel) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_model_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_model_scale(s : DbindexgistModel, f : Double) -> DbindexgistModel {
  let result = db_index_gist_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_model_add(a : DbindexgistModel, b : DbindexgistModel) -> DbindexgistModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_model_copy(s : DbindexgistModel) -> DbindexgistModel {
  let result = db_index_gist_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_model_fill(s : DbindexgistModel, v : Double) -> DbindexgistModel {
  let result = db_index_gist_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_model_min(s : DbindexgistModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_model_max(s : DbindexgistModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_model_to_string(s : DbindexgistModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_layer_make(size : Int) -> DbindexgistLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_layer_len(s : DbindexgistLayer) -> Int { s.size }

pub fn db_index_gist_layer_get(s : DbindexgistLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_layer_set(s : DbindexgistLayer, i : Int, v : Double) -> DbindexgistLayer {
  let result = db_index_gist_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_layer_sum(s : DbindexgistLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_layer_mean(s : DbindexgistLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_layer_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_layer_scale(s : DbindexgistLayer, f : Double) -> DbindexgistLayer {
  let result = db_index_gist_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_layer_add(a : DbindexgistLayer, b : DbindexgistLayer) -> DbindexgistLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_layer_copy(s : DbindexgistLayer) -> DbindexgistLayer {
  let result = db_index_gist_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_layer_fill(s : DbindexgistLayer, v : Double) -> DbindexgistLayer {
  let result = db_index_gist_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_layer_min(s : DbindexgistLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_layer_max(s : DbindexgistLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_layer_to_string(s : DbindexgistLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_buffer_make(size : Int) -> DbindexgistBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_buffer_len(s : DbindexgistBuffer) -> Int { s.size }

pub fn db_index_gist_buffer_get(s : DbindexgistBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_buffer_set(s : DbindexgistBuffer, i : Int, v : Double) -> DbindexgistBuffer {
  let result = db_index_gist_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_buffer_sum(s : DbindexgistBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_buffer_mean(s : DbindexgistBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_buffer_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_buffer_scale(s : DbindexgistBuffer, f : Double) -> DbindexgistBuffer {
  let result = db_index_gist_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_buffer_add(a : DbindexgistBuffer, b : DbindexgistBuffer) -> DbindexgistBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_buffer_copy(s : DbindexgistBuffer) -> DbindexgistBuffer {
  let result = db_index_gist_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_buffer_fill(s : DbindexgistBuffer, v : Double) -> DbindexgistBuffer {
  let result = db_index_gist_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_buffer_min(s : DbindexgistBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_buffer_max(s : DbindexgistBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_buffer_to_string(s : DbindexgistBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_cursor_make(size : Int) -> DbindexgistCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_cursor_len(s : DbindexgistCursor) -> Int { s.size }

pub fn db_index_gist_cursor_get(s : DbindexgistCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_cursor_set(s : DbindexgistCursor, i : Int, v : Double) -> DbindexgistCursor {
  let result = db_index_gist_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_cursor_sum(s : DbindexgistCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_cursor_mean(s : DbindexgistCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_cursor_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_cursor_scale(s : DbindexgistCursor, f : Double) -> DbindexgistCursor {
  let result = db_index_gist_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_cursor_add(a : DbindexgistCursor, b : DbindexgistCursor) -> DbindexgistCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_cursor_copy(s : DbindexgistCursor) -> DbindexgistCursor {
  let result = db_index_gist_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_cursor_fill(s : DbindexgistCursor, v : Double) -> DbindexgistCursor {
  let result = db_index_gist_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_cursor_min(s : DbindexgistCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_cursor_max(s : DbindexgistCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_cursor_to_string(s : DbindexgistCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_view_make(size : Int) -> DbindexgistView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_view_len(s : DbindexgistView) -> Int { s.size }

pub fn db_index_gist_view_get(s : DbindexgistView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_view_set(s : DbindexgistView, i : Int, v : Double) -> DbindexgistView {
  let result = db_index_gist_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_view_sum(s : DbindexgistView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_view_mean(s : DbindexgistView) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_view_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_view_scale(s : DbindexgistView, f : Double) -> DbindexgistView {
  let result = db_index_gist_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_view_add(a : DbindexgistView, b : DbindexgistView) -> DbindexgistView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_view_copy(s : DbindexgistView) -> DbindexgistView {
  let result = db_index_gist_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_view_fill(s : DbindexgistView, v : Double) -> DbindexgistView {
  let result = db_index_gist_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_view_min(s : DbindexgistView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_view_max(s : DbindexgistView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_view_to_string(s : DbindexgistView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_range_make(size : Int) -> DbindexgistRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_range_len(s : DbindexgistRange) -> Int { s.size }

pub fn db_index_gist_range_get(s : DbindexgistRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_range_set(s : DbindexgistRange, i : Int, v : Double) -> DbindexgistRange {
  let result = db_index_gist_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_range_sum(s : DbindexgistRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_range_mean(s : DbindexgistRange) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_range_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_range_scale(s : DbindexgistRange, f : Double) -> DbindexgistRange {
  let result = db_index_gist_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_range_add(a : DbindexgistRange, b : DbindexgistRange) -> DbindexgistRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_range_copy(s : DbindexgistRange) -> DbindexgistRange {
  let result = db_index_gist_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_range_fill(s : DbindexgistRange, v : Double) -> DbindexgistRange {
  let result = db_index_gist_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_range_min(s : DbindexgistRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_range_max(s : DbindexgistRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_range_to_string(s : DbindexgistRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexgistSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_gist_slice_make(size : Int) -> DbindexgistSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_gist_slice_len(s : DbindexgistSlice) -> Int { s.size }

pub fn db_index_gist_slice_get(s : DbindexgistSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_gist_slice_set(s : DbindexgistSlice, i : Int, v : Double) -> DbindexgistSlice {
  let result = db_index_gist_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_slice_sum(s : DbindexgistSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_gist_slice_mean(s : DbindexgistSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_index_gist_slice_sum(s) / s.size.to_double() }
}

pub fn db_index_gist_slice_scale(s : DbindexgistSlice, f : Double) -> DbindexgistSlice {
  let result = db_index_gist_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_gist_slice_add(a : DbindexgistSlice, b : DbindexgistSlice) -> DbindexgistSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_gist_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_gist_slice_copy(s : DbindexgistSlice) -> DbindexgistSlice {
  let result = db_index_gist_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_gist_slice_fill(s : DbindexgistSlice, v : Double) -> DbindexgistSlice {
  let result = db_index_gist_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_gist_slice_min(s : DbindexgistSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_slice_max(s : DbindexgistSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_gist_slice_to_string(s : DbindexgistSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_index_gist_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_gist_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

