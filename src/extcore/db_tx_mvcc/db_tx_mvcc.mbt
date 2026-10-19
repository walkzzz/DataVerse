///===
/// extcore/db_tx_mvcc

pub(all) struct DbtxmvccPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_mvcc_make_point(x : Double, y : Double) -> DbtxmvccPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_mvcc_make_point3(x : Double, y : Double, z : Double) -> DbtxmvccPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_mvcc_point_x(pt : DbtxmvccPoint) -> Double { pt.x }

pub fn db_tx_mvcc_point_y(pt : DbtxmvccPoint) -> Double { pt.y }

pub fn db_tx_mvcc_point_z(pt : DbtxmvccPoint) -> Double { pt.z }

pub fn db_tx_mvcc_point_label(pt : DbtxmvccPoint) -> Int { pt.label }

pub fn db_tx_mvcc_point_dist(a : DbtxmvccPoint, b : DbtxmvccPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_tx_mvcc_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_mvcc_point_add(a : DbtxmvccPoint, b : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_mvcc_point_sub(a : DbtxmvccPoint, b : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_mvcc_point_scale(pt : DbtxmvccPoint, s : Double) -> DbtxmvccPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_mvcc_point_dot(a : DbtxmvccPoint, b : DbtxmvccPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_mvcc_point_cross(a : DbtxmvccPoint, b : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_mvcc_point_norm(pt : DbtxmvccPoint) -> Double {
  db_tx_mvcc_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_mvcc_point_normalize(pt : DbtxmvccPoint) -> DbtxmvccPoint {
  let n = db_tx_mvcc_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_mvcc_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_mvcc_point_negate(pt : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_mvcc_point_mid(a : DbtxmvccPoint, b : DbtxmvccPoint) -> DbtxmvccPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_mvcc_point_lerp(a : DbtxmvccPoint, b : DbtxmvccPoint, t : Double) -> DbtxmvccPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_mvcc_point_to_string(pt : DbtxmvccPoint) -> String {
  "(" + db_tx_mvcc_dbl(pt.x) + ", " + db_tx_mvcc_dbl(pt.y) + ", " + db_tx_mvcc_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxmvccSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_mvcc_make_series(vals : Array[Double], name : String) -> DbtxmvccSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_mvcc_series_len(s : DbtxmvccSeries) -> Int { s.vals.length() }

pub fn db_tx_mvcc_series_sum(s : DbtxmvccSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_tx_mvcc_series_mean(s : DbtxmvccSeries) -> Double {
  let n = db_tx_mvcc_series_len(s)
  if n == 0 { 0.0 } else { db_tx_mvcc_series_sum(s) / n.to_double() }
}

pub fn db_tx_mvcc_series_min(s : DbtxmvccSeries) -> Double {
  let n = db_tx_mvcc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_mvcc_series_max(s : DbtxmvccSeries) -> Double {
  let n = db_tx_mvcc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_mvcc_series_range(s : DbtxmvccSeries) -> Double {
  db_tx_mvcc_series_max(s) - db_tx_mvcc_series_min(s)
}

pub fn db_tx_mvcc_series_var(s : DbtxmvccSeries) -> Double {
  let n = db_tx_mvcc_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_tx_mvcc_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_tx_mvcc_series_std(s : DbtxmvccSeries) -> Double { db_tx_mvcc_sqrt(db_tx_mvcc_series_var(s)) }

pub fn db_tx_mvcc_series_median(s : DbtxmvccSeries) -> Double {
  let n = db_tx_mvcc_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_tx_mvcc_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_mvcc_series_scale(s : DbtxmvccSeries, f : Double) -> DbtxmvccSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_tx_mvcc_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_mvcc_series_add(a : DbtxmvccSeries, b : DbtxmvccSeries) -> DbtxmvccSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_mvcc_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_mvcc_series_sub(a : DbtxmvccSeries, b : DbtxmvccSeries) -> DbtxmvccSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_mvcc_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_mvcc_series_normalize(s : DbtxmvccSeries) -> DbtxmvccSeries {
  let mn = db_tx_mvcc_series_min(s)
  let mx = db_tx_mvcc_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_tx_mvcc_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_mvcc_series_cumsum(s : DbtxmvccSeries) -> DbtxmvccSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_tx_mvcc_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_mvcc_series_to_string(s : DbtxmvccSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_mvcc_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxmvccMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_mvcc_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxmvccMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_mvcc_matrix_identity(n : Int) -> DbtxmvccMatrix {
  let m = db_tx_mvcc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_mvcc_matrix_get(m : DbtxmvccMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_mvcc_matrix_transpose(m : DbtxmvccMatrix) -> DbtxmvccMatrix {
  let result = db_tx_mvcc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_mvcc_matrix_add(a : DbtxmvccMatrix, b : DbtxmvccMatrix) -> DbtxmvccMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_mvcc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_mvcc_matrix_scale(m : DbtxmvccMatrix, s : Double) -> DbtxmvccMatrix {
  let result = db_tx_mvcc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_mvcc_matrix_multiply(a : DbtxmvccMatrix, b : DbtxmvccMatrix) -> DbtxmvccMatrix {
  if a.cols != b.rows { return db_tx_mvcc_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_mvcc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_mvcc_matrix_trace(m : DbtxmvccMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_mvcc_matrix_det(m : DbtxmvccMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_mvcc_matrix_norm(m : DbtxmvccMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_tx_mvcc_sqrt(sum)
}

pub fn db_tx_mvcc_matrix_to_string(m : DbtxmvccMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_tx_mvcc_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbtxmvccVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_mvcc_make_vector(comps : Array[Double]) -> DbtxmvccVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_mvcc_vector_zero(dim : Int) -> DbtxmvccVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_mvcc_vector_add(a : DbtxmvccVector, b : DbtxmvccVector) -> DbtxmvccVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_mvcc_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_mvcc_vector_sub(a : DbtxmvccVector, b : DbtxmvccVector) -> DbtxmvccVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_mvcc_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_mvcc_vector_scale(v : DbtxmvccVector, s : Double) -> DbtxmvccVector {
  let mut result = []
  for i in 0..<v.dim { result = db_tx_mvcc_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_mvcc_vector_dot(a : DbtxmvccVector, b : DbtxmvccVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_mvcc_vector_norm(v : DbtxmvccVector) -> Double { db_tx_mvcc_sqrt(db_tx_mvcc_vector_dot(v, v)) }

pub fn db_tx_mvcc_vector_normalize(v : DbtxmvccVector) -> DbtxmvccVector {
  let n = db_tx_mvcc_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_mvcc_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_mvcc_vector_dist(a : DbtxmvccVector, b : DbtxmvccVector) -> Double {
  db_tx_mvcc_vector_norm(db_tx_mvcc_vector_sub(a, b))
}

pub fn db_tx_mvcc_vector_to_string(v : DbtxmvccVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_mvcc_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_mvcc_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_tx_mvcc_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_tx_mvcc_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_mvcc_std(data : Array[Double]) -> Double { db_tx_mvcc_sqrt(db_tx_mvcc_var(data)) }

pub fn db_tx_mvcc_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_tx_mvcc_mean(a); let mb = db_tx_mvcc_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_tx_mvcc_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_tx_mvcc_std(a); let sb = db_tx_mvcc_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_tx_mvcc_cov(a, b) / (sa * sb) }
}

pub fn db_tx_mvcc_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_tx_mvcc_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_mvcc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_tx_mvcc_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_mvcc_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_tx_mvcc_sqrt(db_tx_mvcc_mse(pred, labels))
}

pub fn db_tx_mvcc_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_tx_mvcc_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_tx_mvcc_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_tx_mvcc_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_tx_mvcc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_tx_mvcc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_tx_mvcc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_tx_mvcc_precision(pred, labels, pos); let r = db_tx_mvcc_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_tx_mvcc_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_tx_mvcc_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_tx_mvcc_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_tx_mvcc_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_tx_mvcc_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_tx_mvcc_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_tx_mvcc_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_tx_mvcc_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_tx_mvcc_fibonacci(n : Int) -> Int {
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

pub fn db_tx_mvcc_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_tx_mvcc_min(data); let mx = db_tx_mvcc_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_tx_mvcc_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_tx_mvcc_mean(data); let sd = db_tx_mvcc_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_tx_mvcc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_tx_mvcc_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_tx_mvcc_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_tx_mvcc_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_tx_mvcc_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_tx_mvcc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_tx_mvcc_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_tx_mvcc_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_tx_mvcc_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_tx_mvcc_int(x) } else { -db_tx_mvcc_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_tx_mvcc_int(f * 1000000.0) } else { db_tx_mvcc_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_tx_mvcc_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_tx_mvcc_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbtxmvccFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_frame_make(size : Int) -> DbtxmvccFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_frame_len(s : DbtxmvccFrame) -> Int { s.size }

pub fn db_tx_mvcc_frame_get(s : DbtxmvccFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_frame_set(s : DbtxmvccFrame, i : Int, v : Double) -> DbtxmvccFrame {
  let result = db_tx_mvcc_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_frame_sum(s : DbtxmvccFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_frame_mean(s : DbtxmvccFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_frame_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_frame_scale(s : DbtxmvccFrame, f : Double) -> DbtxmvccFrame {
  let result = db_tx_mvcc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_frame_add(a : DbtxmvccFrame, b : DbtxmvccFrame) -> DbtxmvccFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_frame_copy(s : DbtxmvccFrame) -> DbtxmvccFrame {
  let result = db_tx_mvcc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_frame_fill(s : DbtxmvccFrame, v : Double) -> DbtxmvccFrame {
  let result = db_tx_mvcc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_frame_min(s : DbtxmvccFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_frame_max(s : DbtxmvccFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_frame_to_string(s : DbtxmvccFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_table_make(size : Int) -> DbtxmvccTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_table_len(s : DbtxmvccTable) -> Int { s.size }

pub fn db_tx_mvcc_table_get(s : DbtxmvccTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_table_set(s : DbtxmvccTable, i : Int, v : Double) -> DbtxmvccTable {
  let result = db_tx_mvcc_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_table_sum(s : DbtxmvccTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_table_mean(s : DbtxmvccTable) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_table_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_table_scale(s : DbtxmvccTable, f : Double) -> DbtxmvccTable {
  let result = db_tx_mvcc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_table_add(a : DbtxmvccTable, b : DbtxmvccTable) -> DbtxmvccTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_table_copy(s : DbtxmvccTable) -> DbtxmvccTable {
  let result = db_tx_mvcc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_table_fill(s : DbtxmvccTable, v : Double) -> DbtxmvccTable {
  let result = db_tx_mvcc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_table_min(s : DbtxmvccTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_table_max(s : DbtxmvccTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_table_to_string(s : DbtxmvccTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_graphn_make(size : Int) -> DbtxmvccGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_graphn_len(s : DbtxmvccGraphN) -> Int { s.size }

pub fn db_tx_mvcc_graphn_get(s : DbtxmvccGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_graphn_set(s : DbtxmvccGraphN, i : Int, v : Double) -> DbtxmvccGraphN {
  let result = db_tx_mvcc_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_graphn_sum(s : DbtxmvccGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_graphn_mean(s : DbtxmvccGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_graphn_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_graphn_scale(s : DbtxmvccGraphN, f : Double) -> DbtxmvccGraphN {
  let result = db_tx_mvcc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_graphn_add(a : DbtxmvccGraphN, b : DbtxmvccGraphN) -> DbtxmvccGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_graphn_copy(s : DbtxmvccGraphN) -> DbtxmvccGraphN {
  let result = db_tx_mvcc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_graphn_fill(s : DbtxmvccGraphN, v : Double) -> DbtxmvccGraphN {
  let result = db_tx_mvcc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_graphn_min(s : DbtxmvccGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_graphn_max(s : DbtxmvccGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_graphn_to_string(s : DbtxmvccGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_node_make(size : Int) -> DbtxmvccNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_node_len(s : DbtxmvccNode) -> Int { s.size }

pub fn db_tx_mvcc_node_get(s : DbtxmvccNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_node_set(s : DbtxmvccNode, i : Int, v : Double) -> DbtxmvccNode {
  let result = db_tx_mvcc_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_node_sum(s : DbtxmvccNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_node_mean(s : DbtxmvccNode) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_node_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_node_scale(s : DbtxmvccNode, f : Double) -> DbtxmvccNode {
  let result = db_tx_mvcc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_node_add(a : DbtxmvccNode, b : DbtxmvccNode) -> DbtxmvccNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_node_copy(s : DbtxmvccNode) -> DbtxmvccNode {
  let result = db_tx_mvcc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_node_fill(s : DbtxmvccNode, v : Double) -> DbtxmvccNode {
  let result = db_tx_mvcc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_node_min(s : DbtxmvccNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_node_max(s : DbtxmvccNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_node_to_string(s : DbtxmvccNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_edge_make(size : Int) -> DbtxmvccEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_edge_len(s : DbtxmvccEdge) -> Int { s.size }

pub fn db_tx_mvcc_edge_get(s : DbtxmvccEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_edge_set(s : DbtxmvccEdge, i : Int, v : Double) -> DbtxmvccEdge {
  let result = db_tx_mvcc_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_edge_sum(s : DbtxmvccEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_edge_mean(s : DbtxmvccEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_edge_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_edge_scale(s : DbtxmvccEdge, f : Double) -> DbtxmvccEdge {
  let result = db_tx_mvcc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_edge_add(a : DbtxmvccEdge, b : DbtxmvccEdge) -> DbtxmvccEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_edge_copy(s : DbtxmvccEdge) -> DbtxmvccEdge {
  let result = db_tx_mvcc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_edge_fill(s : DbtxmvccEdge, v : Double) -> DbtxmvccEdge {
  let result = db_tx_mvcc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_edge_min(s : DbtxmvccEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_edge_max(s : DbtxmvccEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_edge_to_string(s : DbtxmvccEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_path_make(size : Int) -> DbtxmvccPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_path_len(s : DbtxmvccPath) -> Int { s.size }

pub fn db_tx_mvcc_path_get(s : DbtxmvccPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_path_set(s : DbtxmvccPath, i : Int, v : Double) -> DbtxmvccPath {
  let result = db_tx_mvcc_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_path_sum(s : DbtxmvccPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_path_mean(s : DbtxmvccPath) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_path_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_path_scale(s : DbtxmvccPath, f : Double) -> DbtxmvccPath {
  let result = db_tx_mvcc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_path_add(a : DbtxmvccPath, b : DbtxmvccPath) -> DbtxmvccPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_path_copy(s : DbtxmvccPath) -> DbtxmvccPath {
  let result = db_tx_mvcc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_path_fill(s : DbtxmvccPath, v : Double) -> DbtxmvccPath {
  let result = db_tx_mvcc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_path_min(s : DbtxmvccPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_path_max(s : DbtxmvccPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_path_to_string(s : DbtxmvccPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_cluster_make(size : Int) -> DbtxmvccCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_cluster_len(s : DbtxmvccCluster) -> Int { s.size }

pub fn db_tx_mvcc_cluster_get(s : DbtxmvccCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_cluster_set(s : DbtxmvccCluster, i : Int, v : Double) -> DbtxmvccCluster {
  let result = db_tx_mvcc_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_cluster_sum(s : DbtxmvccCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_cluster_mean(s : DbtxmvccCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_cluster_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_cluster_scale(s : DbtxmvccCluster, f : Double) -> DbtxmvccCluster {
  let result = db_tx_mvcc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_cluster_add(a : DbtxmvccCluster, b : DbtxmvccCluster) -> DbtxmvccCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_cluster_copy(s : DbtxmvccCluster) -> DbtxmvccCluster {
  let result = db_tx_mvcc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_cluster_fill(s : DbtxmvccCluster, v : Double) -> DbtxmvccCluster {
  let result = db_tx_mvcc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_cluster_min(s : DbtxmvccCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_cluster_max(s : DbtxmvccCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_cluster_to_string(s : DbtxmvccCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_model_make(size : Int) -> DbtxmvccModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_model_len(s : DbtxmvccModel) -> Int { s.size }

pub fn db_tx_mvcc_model_get(s : DbtxmvccModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_model_set(s : DbtxmvccModel, i : Int, v : Double) -> DbtxmvccModel {
  let result = db_tx_mvcc_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_model_sum(s : DbtxmvccModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_model_mean(s : DbtxmvccModel) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_model_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_model_scale(s : DbtxmvccModel, f : Double) -> DbtxmvccModel {
  let result = db_tx_mvcc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_model_add(a : DbtxmvccModel, b : DbtxmvccModel) -> DbtxmvccModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_model_copy(s : DbtxmvccModel) -> DbtxmvccModel {
  let result = db_tx_mvcc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_model_fill(s : DbtxmvccModel, v : Double) -> DbtxmvccModel {
  let result = db_tx_mvcc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_model_min(s : DbtxmvccModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_model_max(s : DbtxmvccModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_model_to_string(s : DbtxmvccModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_layer_make(size : Int) -> DbtxmvccLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_layer_len(s : DbtxmvccLayer) -> Int { s.size }

pub fn db_tx_mvcc_layer_get(s : DbtxmvccLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_layer_set(s : DbtxmvccLayer, i : Int, v : Double) -> DbtxmvccLayer {
  let result = db_tx_mvcc_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_layer_sum(s : DbtxmvccLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_layer_mean(s : DbtxmvccLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_layer_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_layer_scale(s : DbtxmvccLayer, f : Double) -> DbtxmvccLayer {
  let result = db_tx_mvcc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_layer_add(a : DbtxmvccLayer, b : DbtxmvccLayer) -> DbtxmvccLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_layer_copy(s : DbtxmvccLayer) -> DbtxmvccLayer {
  let result = db_tx_mvcc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_layer_fill(s : DbtxmvccLayer, v : Double) -> DbtxmvccLayer {
  let result = db_tx_mvcc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_layer_min(s : DbtxmvccLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_layer_max(s : DbtxmvccLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_layer_to_string(s : DbtxmvccLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_buffer_make(size : Int) -> DbtxmvccBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_buffer_len(s : DbtxmvccBuffer) -> Int { s.size }

pub fn db_tx_mvcc_buffer_get(s : DbtxmvccBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_buffer_set(s : DbtxmvccBuffer, i : Int, v : Double) -> DbtxmvccBuffer {
  let result = db_tx_mvcc_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_buffer_sum(s : DbtxmvccBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_buffer_mean(s : DbtxmvccBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_buffer_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_buffer_scale(s : DbtxmvccBuffer, f : Double) -> DbtxmvccBuffer {
  let result = db_tx_mvcc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_buffer_add(a : DbtxmvccBuffer, b : DbtxmvccBuffer) -> DbtxmvccBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_buffer_copy(s : DbtxmvccBuffer) -> DbtxmvccBuffer {
  let result = db_tx_mvcc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_buffer_fill(s : DbtxmvccBuffer, v : Double) -> DbtxmvccBuffer {
  let result = db_tx_mvcc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_buffer_min(s : DbtxmvccBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_buffer_max(s : DbtxmvccBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_buffer_to_string(s : DbtxmvccBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_cursor_make(size : Int) -> DbtxmvccCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_cursor_len(s : DbtxmvccCursor) -> Int { s.size }

pub fn db_tx_mvcc_cursor_get(s : DbtxmvccCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_cursor_set(s : DbtxmvccCursor, i : Int, v : Double) -> DbtxmvccCursor {
  let result = db_tx_mvcc_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_cursor_sum(s : DbtxmvccCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_cursor_mean(s : DbtxmvccCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_cursor_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_cursor_scale(s : DbtxmvccCursor, f : Double) -> DbtxmvccCursor {
  let result = db_tx_mvcc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_cursor_add(a : DbtxmvccCursor, b : DbtxmvccCursor) -> DbtxmvccCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_cursor_copy(s : DbtxmvccCursor) -> DbtxmvccCursor {
  let result = db_tx_mvcc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_cursor_fill(s : DbtxmvccCursor, v : Double) -> DbtxmvccCursor {
  let result = db_tx_mvcc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_cursor_min(s : DbtxmvccCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_cursor_max(s : DbtxmvccCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_cursor_to_string(s : DbtxmvccCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_view_make(size : Int) -> DbtxmvccView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_view_len(s : DbtxmvccView) -> Int { s.size }

pub fn db_tx_mvcc_view_get(s : DbtxmvccView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_view_set(s : DbtxmvccView, i : Int, v : Double) -> DbtxmvccView {
  let result = db_tx_mvcc_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_view_sum(s : DbtxmvccView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_view_mean(s : DbtxmvccView) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_view_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_view_scale(s : DbtxmvccView, f : Double) -> DbtxmvccView {
  let result = db_tx_mvcc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_view_add(a : DbtxmvccView, b : DbtxmvccView) -> DbtxmvccView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_view_copy(s : DbtxmvccView) -> DbtxmvccView {
  let result = db_tx_mvcc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_view_fill(s : DbtxmvccView, v : Double) -> DbtxmvccView {
  let result = db_tx_mvcc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_view_min(s : DbtxmvccView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_view_max(s : DbtxmvccView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_view_to_string(s : DbtxmvccView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_range_make(size : Int) -> DbtxmvccRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_range_len(s : DbtxmvccRange) -> Int { s.size }

pub fn db_tx_mvcc_range_get(s : DbtxmvccRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_range_set(s : DbtxmvccRange, i : Int, v : Double) -> DbtxmvccRange {
  let result = db_tx_mvcc_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_range_sum(s : DbtxmvccRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_range_mean(s : DbtxmvccRange) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_range_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_range_scale(s : DbtxmvccRange, f : Double) -> DbtxmvccRange {
  let result = db_tx_mvcc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_range_add(a : DbtxmvccRange, b : DbtxmvccRange) -> DbtxmvccRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_range_copy(s : DbtxmvccRange) -> DbtxmvccRange {
  let result = db_tx_mvcc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_range_fill(s : DbtxmvccRange, v : Double) -> DbtxmvccRange {
  let result = db_tx_mvcc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_range_min(s : DbtxmvccRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_range_max(s : DbtxmvccRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_range_to_string(s : DbtxmvccRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxmvccSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_mvcc_slice_make(size : Int) -> DbtxmvccSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_mvcc_slice_len(s : DbtxmvccSlice) -> Int { s.size }

pub fn db_tx_mvcc_slice_get(s : DbtxmvccSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_mvcc_slice_set(s : DbtxmvccSlice, i : Int, v : Double) -> DbtxmvccSlice {
  let result = db_tx_mvcc_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_slice_sum(s : DbtxmvccSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_mvcc_slice_mean(s : DbtxmvccSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_mvcc_slice_sum(s) / s.size.to_double() }
}

pub fn db_tx_mvcc_slice_scale(s : DbtxmvccSlice, f : Double) -> DbtxmvccSlice {
  let result = db_tx_mvcc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_mvcc_slice_add(a : DbtxmvccSlice, b : DbtxmvccSlice) -> DbtxmvccSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_mvcc_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_mvcc_slice_copy(s : DbtxmvccSlice) -> DbtxmvccSlice {
  let result = db_tx_mvcc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_mvcc_slice_fill(s : DbtxmvccSlice, v : Double) -> DbtxmvccSlice {
  let result = db_tx_mvcc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_mvcc_slice_min(s : DbtxmvccSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_slice_max(s : DbtxmvccSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_mvcc_slice_to_string(s : DbtxmvccSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_tx_mvcc_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_mvcc_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

