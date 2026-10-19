///===
/// extcore/db_tx_3pc

pub(all) struct Dbtx3pcPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_3pc_make_point(x : Double, y : Double) -> Dbtx3pcPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_3pc_make_point3(x : Double, y : Double, z : Double) -> Dbtx3pcPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_3pc_point_x(pt : Dbtx3pcPoint) -> Double { pt.x }

pub fn db_tx_3pc_point_y(pt : Dbtx3pcPoint) -> Double { pt.y }

pub fn db_tx_3pc_point_z(pt : Dbtx3pcPoint) -> Double { pt.z }

pub fn db_tx_3pc_point_label(pt : Dbtx3pcPoint) -> Int { pt.label }

pub fn db_tx_3pc_point_dist(a : Dbtx3pcPoint, b : Dbtx3pcPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_tx_3pc_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_3pc_point_add(a : Dbtx3pcPoint, b : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_3pc_point_sub(a : Dbtx3pcPoint, b : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_3pc_point_scale(pt : Dbtx3pcPoint, s : Double) -> Dbtx3pcPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_3pc_point_dot(a : Dbtx3pcPoint, b : Dbtx3pcPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_3pc_point_cross(a : Dbtx3pcPoint, b : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_3pc_point_norm(pt : Dbtx3pcPoint) -> Double {
  db_tx_3pc_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_3pc_point_normalize(pt : Dbtx3pcPoint) -> Dbtx3pcPoint {
  let n = db_tx_3pc_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_3pc_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_3pc_point_negate(pt : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_3pc_point_mid(a : Dbtx3pcPoint, b : Dbtx3pcPoint) -> Dbtx3pcPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_3pc_point_lerp(a : Dbtx3pcPoint, b : Dbtx3pcPoint, t : Double) -> Dbtx3pcPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_3pc_point_to_string(pt : Dbtx3pcPoint) -> String {
  "(" + db_tx_3pc_dbl(pt.x) + ", " + db_tx_3pc_dbl(pt.y) + ", " + db_tx_3pc_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct Dbtx3pcSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_3pc_make_series(vals : Array[Double], name : String) -> Dbtx3pcSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_3pc_series_len(s : Dbtx3pcSeries) -> Int { s.vals.length() }

pub fn db_tx_3pc_series_sum(s : Dbtx3pcSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_tx_3pc_series_mean(s : Dbtx3pcSeries) -> Double {
  let n = db_tx_3pc_series_len(s)
  if n == 0 { 0.0 } else { db_tx_3pc_series_sum(s) / n.to_double() }
}

pub fn db_tx_3pc_series_min(s : Dbtx3pcSeries) -> Double {
  let n = db_tx_3pc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_3pc_series_max(s : Dbtx3pcSeries) -> Double {
  let n = db_tx_3pc_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_3pc_series_range(s : Dbtx3pcSeries) -> Double {
  db_tx_3pc_series_max(s) - db_tx_3pc_series_min(s)
}

pub fn db_tx_3pc_series_var(s : Dbtx3pcSeries) -> Double {
  let n = db_tx_3pc_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_tx_3pc_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_tx_3pc_series_std(s : Dbtx3pcSeries) -> Double { db_tx_3pc_sqrt(db_tx_3pc_series_var(s)) }

pub fn db_tx_3pc_series_median(s : Dbtx3pcSeries) -> Double {
  let n = db_tx_3pc_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_tx_3pc_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_3pc_series_scale(s : Dbtx3pcSeries, f : Double) -> Dbtx3pcSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_tx_3pc_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_3pc_series_add(a : Dbtx3pcSeries, b : Dbtx3pcSeries) -> Dbtx3pcSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_3pc_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_3pc_series_sub(a : Dbtx3pcSeries, b : Dbtx3pcSeries) -> Dbtx3pcSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_3pc_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_3pc_series_normalize(s : Dbtx3pcSeries) -> Dbtx3pcSeries {
  let mn = db_tx_3pc_series_min(s)
  let mx = db_tx_3pc_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_tx_3pc_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_3pc_series_cumsum(s : Dbtx3pcSeries) -> Dbtx3pcSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_tx_3pc_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_3pc_series_to_string(s : Dbtx3pcSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_3pc_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct Dbtx3pcMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_3pc_make_matrix(rows : Int, cols : Int, val : Double) -> Dbtx3pcMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_3pc_matrix_identity(n : Int) -> Dbtx3pcMatrix {
  let m = db_tx_3pc_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_3pc_matrix_get(m : Dbtx3pcMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_3pc_matrix_transpose(m : Dbtx3pcMatrix) -> Dbtx3pcMatrix {
  let result = db_tx_3pc_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_3pc_matrix_add(a : Dbtx3pcMatrix, b : Dbtx3pcMatrix) -> Dbtx3pcMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_3pc_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_3pc_matrix_scale(m : Dbtx3pcMatrix, s : Double) -> Dbtx3pcMatrix {
  let result = db_tx_3pc_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_3pc_matrix_multiply(a : Dbtx3pcMatrix, b : Dbtx3pcMatrix) -> Dbtx3pcMatrix {
  if a.cols != b.rows { return db_tx_3pc_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_3pc_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_3pc_matrix_trace(m : Dbtx3pcMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_3pc_matrix_det(m : Dbtx3pcMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_3pc_matrix_norm(m : Dbtx3pcMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_tx_3pc_sqrt(sum)
}

pub fn db_tx_3pc_matrix_to_string(m : Dbtx3pcMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_tx_3pc_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct Dbtx3pcVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_3pc_make_vector(comps : Array[Double]) -> Dbtx3pcVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_3pc_vector_zero(dim : Int) -> Dbtx3pcVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_3pc_vector_add(a : Dbtx3pcVector, b : Dbtx3pcVector) -> Dbtx3pcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_3pc_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_3pc_vector_sub(a : Dbtx3pcVector, b : Dbtx3pcVector) -> Dbtx3pcVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_3pc_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_3pc_vector_scale(v : Dbtx3pcVector, s : Double) -> Dbtx3pcVector {
  let mut result = []
  for i in 0..<v.dim { result = db_tx_3pc_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_3pc_vector_dot(a : Dbtx3pcVector, b : Dbtx3pcVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_3pc_vector_norm(v : Dbtx3pcVector) -> Double { db_tx_3pc_sqrt(db_tx_3pc_vector_dot(v, v)) }

pub fn db_tx_3pc_vector_normalize(v : Dbtx3pcVector) -> Dbtx3pcVector {
  let n = db_tx_3pc_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_3pc_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_3pc_vector_dist(a : Dbtx3pcVector, b : Dbtx3pcVector) -> Double {
  db_tx_3pc_vector_norm(db_tx_3pc_vector_sub(a, b))
}

pub fn db_tx_3pc_vector_to_string(v : Dbtx3pcVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_3pc_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_3pc_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_tx_3pc_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_tx_3pc_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_3pc_std(data : Array[Double]) -> Double { db_tx_3pc_sqrt(db_tx_3pc_var(data)) }

pub fn db_tx_3pc_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_tx_3pc_mean(a); let mb = db_tx_3pc_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_tx_3pc_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_tx_3pc_std(a); let sb = db_tx_3pc_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_tx_3pc_cov(a, b) / (sa * sb) }
}

pub fn db_tx_3pc_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_tx_3pc_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_3pc_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_tx_3pc_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_3pc_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_tx_3pc_sqrt(db_tx_3pc_mse(pred, labels))
}

pub fn db_tx_3pc_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_tx_3pc_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_tx_3pc_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_tx_3pc_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_tx_3pc_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_tx_3pc_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_tx_3pc_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_tx_3pc_precision(pred, labels, pos); let r = db_tx_3pc_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_tx_3pc_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_tx_3pc_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_tx_3pc_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_tx_3pc_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_tx_3pc_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_tx_3pc_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_tx_3pc_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_tx_3pc_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_tx_3pc_fibonacci(n : Int) -> Int {
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

pub fn db_tx_3pc_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_tx_3pc_min(data); let mx = db_tx_3pc_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_tx_3pc_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_tx_3pc_mean(data); let sd = db_tx_3pc_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_tx_3pc_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_tx_3pc_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_tx_3pc_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_tx_3pc_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_tx_3pc_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_tx_3pc_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_tx_3pc_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_tx_3pc_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_tx_3pc_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_tx_3pc_int(x) } else { -db_tx_3pc_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_tx_3pc_int(f * 1000000.0) } else { db_tx_3pc_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_tx_3pc_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_tx_3pc_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct Dbtx3pcFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_frame_make(size : Int) -> Dbtx3pcFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_frame_len(s : Dbtx3pcFrame) -> Int { s.size }

pub fn db_tx_3pc_frame_get(s : Dbtx3pcFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_frame_set(s : Dbtx3pcFrame, i : Int, v : Double) -> Dbtx3pcFrame {
  let result = db_tx_3pc_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_frame_sum(s : Dbtx3pcFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_frame_mean(s : Dbtx3pcFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_frame_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_frame_scale(s : Dbtx3pcFrame, f : Double) -> Dbtx3pcFrame {
  let result = db_tx_3pc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_frame_add(a : Dbtx3pcFrame, b : Dbtx3pcFrame) -> Dbtx3pcFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_frame_copy(s : Dbtx3pcFrame) -> Dbtx3pcFrame {
  let result = db_tx_3pc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_frame_fill(s : Dbtx3pcFrame, v : Double) -> Dbtx3pcFrame {
  let result = db_tx_3pc_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_frame_min(s : Dbtx3pcFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_frame_max(s : Dbtx3pcFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_frame_to_string(s : Dbtx3pcFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_table_make(size : Int) -> Dbtx3pcTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_table_len(s : Dbtx3pcTable) -> Int { s.size }

pub fn db_tx_3pc_table_get(s : Dbtx3pcTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_table_set(s : Dbtx3pcTable, i : Int, v : Double) -> Dbtx3pcTable {
  let result = db_tx_3pc_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_table_sum(s : Dbtx3pcTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_table_mean(s : Dbtx3pcTable) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_table_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_table_scale(s : Dbtx3pcTable, f : Double) -> Dbtx3pcTable {
  let result = db_tx_3pc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_table_add(a : Dbtx3pcTable, b : Dbtx3pcTable) -> Dbtx3pcTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_table_copy(s : Dbtx3pcTable) -> Dbtx3pcTable {
  let result = db_tx_3pc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_table_fill(s : Dbtx3pcTable, v : Double) -> Dbtx3pcTable {
  let result = db_tx_3pc_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_table_min(s : Dbtx3pcTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_table_max(s : Dbtx3pcTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_table_to_string(s : Dbtx3pcTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_graphn_make(size : Int) -> Dbtx3pcGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_graphn_len(s : Dbtx3pcGraphN) -> Int { s.size }

pub fn db_tx_3pc_graphn_get(s : Dbtx3pcGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_graphn_set(s : Dbtx3pcGraphN, i : Int, v : Double) -> Dbtx3pcGraphN {
  let result = db_tx_3pc_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_graphn_sum(s : Dbtx3pcGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_graphn_mean(s : Dbtx3pcGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_graphn_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_graphn_scale(s : Dbtx3pcGraphN, f : Double) -> Dbtx3pcGraphN {
  let result = db_tx_3pc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_graphn_add(a : Dbtx3pcGraphN, b : Dbtx3pcGraphN) -> Dbtx3pcGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_graphn_copy(s : Dbtx3pcGraphN) -> Dbtx3pcGraphN {
  let result = db_tx_3pc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_graphn_fill(s : Dbtx3pcGraphN, v : Double) -> Dbtx3pcGraphN {
  let result = db_tx_3pc_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_graphn_min(s : Dbtx3pcGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_graphn_max(s : Dbtx3pcGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_graphn_to_string(s : Dbtx3pcGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_node_make(size : Int) -> Dbtx3pcNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_node_len(s : Dbtx3pcNode) -> Int { s.size }

pub fn db_tx_3pc_node_get(s : Dbtx3pcNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_node_set(s : Dbtx3pcNode, i : Int, v : Double) -> Dbtx3pcNode {
  let result = db_tx_3pc_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_node_sum(s : Dbtx3pcNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_node_mean(s : Dbtx3pcNode) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_node_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_node_scale(s : Dbtx3pcNode, f : Double) -> Dbtx3pcNode {
  let result = db_tx_3pc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_node_add(a : Dbtx3pcNode, b : Dbtx3pcNode) -> Dbtx3pcNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_node_copy(s : Dbtx3pcNode) -> Dbtx3pcNode {
  let result = db_tx_3pc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_node_fill(s : Dbtx3pcNode, v : Double) -> Dbtx3pcNode {
  let result = db_tx_3pc_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_node_min(s : Dbtx3pcNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_node_max(s : Dbtx3pcNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_node_to_string(s : Dbtx3pcNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_edge_make(size : Int) -> Dbtx3pcEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_edge_len(s : Dbtx3pcEdge) -> Int { s.size }

pub fn db_tx_3pc_edge_get(s : Dbtx3pcEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_edge_set(s : Dbtx3pcEdge, i : Int, v : Double) -> Dbtx3pcEdge {
  let result = db_tx_3pc_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_edge_sum(s : Dbtx3pcEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_edge_mean(s : Dbtx3pcEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_edge_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_edge_scale(s : Dbtx3pcEdge, f : Double) -> Dbtx3pcEdge {
  let result = db_tx_3pc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_edge_add(a : Dbtx3pcEdge, b : Dbtx3pcEdge) -> Dbtx3pcEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_edge_copy(s : Dbtx3pcEdge) -> Dbtx3pcEdge {
  let result = db_tx_3pc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_edge_fill(s : Dbtx3pcEdge, v : Double) -> Dbtx3pcEdge {
  let result = db_tx_3pc_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_edge_min(s : Dbtx3pcEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_edge_max(s : Dbtx3pcEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_edge_to_string(s : Dbtx3pcEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_path_make(size : Int) -> Dbtx3pcPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_path_len(s : Dbtx3pcPath) -> Int { s.size }

pub fn db_tx_3pc_path_get(s : Dbtx3pcPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_path_set(s : Dbtx3pcPath, i : Int, v : Double) -> Dbtx3pcPath {
  let result = db_tx_3pc_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_path_sum(s : Dbtx3pcPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_path_mean(s : Dbtx3pcPath) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_path_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_path_scale(s : Dbtx3pcPath, f : Double) -> Dbtx3pcPath {
  let result = db_tx_3pc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_path_add(a : Dbtx3pcPath, b : Dbtx3pcPath) -> Dbtx3pcPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_path_copy(s : Dbtx3pcPath) -> Dbtx3pcPath {
  let result = db_tx_3pc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_path_fill(s : Dbtx3pcPath, v : Double) -> Dbtx3pcPath {
  let result = db_tx_3pc_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_path_min(s : Dbtx3pcPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_path_max(s : Dbtx3pcPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_path_to_string(s : Dbtx3pcPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_cluster_make(size : Int) -> Dbtx3pcCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_cluster_len(s : Dbtx3pcCluster) -> Int { s.size }

pub fn db_tx_3pc_cluster_get(s : Dbtx3pcCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_cluster_set(s : Dbtx3pcCluster, i : Int, v : Double) -> Dbtx3pcCluster {
  let result = db_tx_3pc_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_cluster_sum(s : Dbtx3pcCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_cluster_mean(s : Dbtx3pcCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_cluster_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_cluster_scale(s : Dbtx3pcCluster, f : Double) -> Dbtx3pcCluster {
  let result = db_tx_3pc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_cluster_add(a : Dbtx3pcCluster, b : Dbtx3pcCluster) -> Dbtx3pcCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_cluster_copy(s : Dbtx3pcCluster) -> Dbtx3pcCluster {
  let result = db_tx_3pc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_cluster_fill(s : Dbtx3pcCluster, v : Double) -> Dbtx3pcCluster {
  let result = db_tx_3pc_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_cluster_min(s : Dbtx3pcCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_cluster_max(s : Dbtx3pcCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_cluster_to_string(s : Dbtx3pcCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_model_make(size : Int) -> Dbtx3pcModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_model_len(s : Dbtx3pcModel) -> Int { s.size }

pub fn db_tx_3pc_model_get(s : Dbtx3pcModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_model_set(s : Dbtx3pcModel, i : Int, v : Double) -> Dbtx3pcModel {
  let result = db_tx_3pc_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_model_sum(s : Dbtx3pcModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_model_mean(s : Dbtx3pcModel) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_model_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_model_scale(s : Dbtx3pcModel, f : Double) -> Dbtx3pcModel {
  let result = db_tx_3pc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_model_add(a : Dbtx3pcModel, b : Dbtx3pcModel) -> Dbtx3pcModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_model_copy(s : Dbtx3pcModel) -> Dbtx3pcModel {
  let result = db_tx_3pc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_model_fill(s : Dbtx3pcModel, v : Double) -> Dbtx3pcModel {
  let result = db_tx_3pc_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_model_min(s : Dbtx3pcModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_model_max(s : Dbtx3pcModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_model_to_string(s : Dbtx3pcModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_layer_make(size : Int) -> Dbtx3pcLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_layer_len(s : Dbtx3pcLayer) -> Int { s.size }

pub fn db_tx_3pc_layer_get(s : Dbtx3pcLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_layer_set(s : Dbtx3pcLayer, i : Int, v : Double) -> Dbtx3pcLayer {
  let result = db_tx_3pc_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_layer_sum(s : Dbtx3pcLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_layer_mean(s : Dbtx3pcLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_layer_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_layer_scale(s : Dbtx3pcLayer, f : Double) -> Dbtx3pcLayer {
  let result = db_tx_3pc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_layer_add(a : Dbtx3pcLayer, b : Dbtx3pcLayer) -> Dbtx3pcLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_layer_copy(s : Dbtx3pcLayer) -> Dbtx3pcLayer {
  let result = db_tx_3pc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_layer_fill(s : Dbtx3pcLayer, v : Double) -> Dbtx3pcLayer {
  let result = db_tx_3pc_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_layer_min(s : Dbtx3pcLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_layer_max(s : Dbtx3pcLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_layer_to_string(s : Dbtx3pcLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_buffer_make(size : Int) -> Dbtx3pcBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_buffer_len(s : Dbtx3pcBuffer) -> Int { s.size }

pub fn db_tx_3pc_buffer_get(s : Dbtx3pcBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_buffer_set(s : Dbtx3pcBuffer, i : Int, v : Double) -> Dbtx3pcBuffer {
  let result = db_tx_3pc_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_buffer_sum(s : Dbtx3pcBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_buffer_mean(s : Dbtx3pcBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_buffer_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_buffer_scale(s : Dbtx3pcBuffer, f : Double) -> Dbtx3pcBuffer {
  let result = db_tx_3pc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_buffer_add(a : Dbtx3pcBuffer, b : Dbtx3pcBuffer) -> Dbtx3pcBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_buffer_copy(s : Dbtx3pcBuffer) -> Dbtx3pcBuffer {
  let result = db_tx_3pc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_buffer_fill(s : Dbtx3pcBuffer, v : Double) -> Dbtx3pcBuffer {
  let result = db_tx_3pc_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_buffer_min(s : Dbtx3pcBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_buffer_max(s : Dbtx3pcBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_buffer_to_string(s : Dbtx3pcBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_cursor_make(size : Int) -> Dbtx3pcCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_cursor_len(s : Dbtx3pcCursor) -> Int { s.size }

pub fn db_tx_3pc_cursor_get(s : Dbtx3pcCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_cursor_set(s : Dbtx3pcCursor, i : Int, v : Double) -> Dbtx3pcCursor {
  let result = db_tx_3pc_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_cursor_sum(s : Dbtx3pcCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_cursor_mean(s : Dbtx3pcCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_cursor_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_cursor_scale(s : Dbtx3pcCursor, f : Double) -> Dbtx3pcCursor {
  let result = db_tx_3pc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_cursor_add(a : Dbtx3pcCursor, b : Dbtx3pcCursor) -> Dbtx3pcCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_cursor_copy(s : Dbtx3pcCursor) -> Dbtx3pcCursor {
  let result = db_tx_3pc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_cursor_fill(s : Dbtx3pcCursor, v : Double) -> Dbtx3pcCursor {
  let result = db_tx_3pc_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_cursor_min(s : Dbtx3pcCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_cursor_max(s : Dbtx3pcCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_cursor_to_string(s : Dbtx3pcCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_view_make(size : Int) -> Dbtx3pcView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_view_len(s : Dbtx3pcView) -> Int { s.size }

pub fn db_tx_3pc_view_get(s : Dbtx3pcView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_view_set(s : Dbtx3pcView, i : Int, v : Double) -> Dbtx3pcView {
  let result = db_tx_3pc_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_view_sum(s : Dbtx3pcView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_view_mean(s : Dbtx3pcView) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_view_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_view_scale(s : Dbtx3pcView, f : Double) -> Dbtx3pcView {
  let result = db_tx_3pc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_view_add(a : Dbtx3pcView, b : Dbtx3pcView) -> Dbtx3pcView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_view_copy(s : Dbtx3pcView) -> Dbtx3pcView {
  let result = db_tx_3pc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_view_fill(s : Dbtx3pcView, v : Double) -> Dbtx3pcView {
  let result = db_tx_3pc_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_view_min(s : Dbtx3pcView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_view_max(s : Dbtx3pcView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_view_to_string(s : Dbtx3pcView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_range_make(size : Int) -> Dbtx3pcRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_range_len(s : Dbtx3pcRange) -> Int { s.size }

pub fn db_tx_3pc_range_get(s : Dbtx3pcRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_range_set(s : Dbtx3pcRange, i : Int, v : Double) -> Dbtx3pcRange {
  let result = db_tx_3pc_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_range_sum(s : Dbtx3pcRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_range_mean(s : Dbtx3pcRange) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_range_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_range_scale(s : Dbtx3pcRange, f : Double) -> Dbtx3pcRange {
  let result = db_tx_3pc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_range_add(a : Dbtx3pcRange, b : Dbtx3pcRange) -> Dbtx3pcRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_range_copy(s : Dbtx3pcRange) -> Dbtx3pcRange {
  let result = db_tx_3pc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_range_fill(s : Dbtx3pcRange, v : Double) -> Dbtx3pcRange {
  let result = db_tx_3pc_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_range_min(s : Dbtx3pcRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_range_max(s : Dbtx3pcRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_range_to_string(s : Dbtx3pcRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct Dbtx3pcSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_3pc_slice_make(size : Int) -> Dbtx3pcSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_3pc_slice_len(s : Dbtx3pcSlice) -> Int { s.size }

pub fn db_tx_3pc_slice_get(s : Dbtx3pcSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_3pc_slice_set(s : Dbtx3pcSlice, i : Int, v : Double) -> Dbtx3pcSlice {
  let result = db_tx_3pc_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_slice_sum(s : Dbtx3pcSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_3pc_slice_mean(s : Dbtx3pcSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_3pc_slice_sum(s) / s.size.to_double() }
}

pub fn db_tx_3pc_slice_scale(s : Dbtx3pcSlice, f : Double) -> Dbtx3pcSlice {
  let result = db_tx_3pc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_3pc_slice_add(a : Dbtx3pcSlice, b : Dbtx3pcSlice) -> Dbtx3pcSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_3pc_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_3pc_slice_copy(s : Dbtx3pcSlice) -> Dbtx3pcSlice {
  let result = db_tx_3pc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_3pc_slice_fill(s : Dbtx3pcSlice, v : Double) -> Dbtx3pcSlice {
  let result = db_tx_3pc_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_3pc_slice_min(s : Dbtx3pcSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_slice_max(s : Dbtx3pcSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_3pc_slice_to_string(s : Dbtx3pcSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_tx_3pc_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_3pc_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

