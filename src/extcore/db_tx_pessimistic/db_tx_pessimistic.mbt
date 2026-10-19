///===
/// extcore/db_tx_pessimistic

pub(all) struct DbtxpessimisticPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_pessimistic_make_point(x : Double, y : Double) -> DbtxpessimisticPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_pessimistic_make_point3(x : Double, y : Double, z : Double) -> DbtxpessimisticPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_pessimistic_point_x(pt : DbtxpessimisticPoint) -> Double { pt.x }

pub fn db_tx_pessimistic_point_y(pt : DbtxpessimisticPoint) -> Double { pt.y }

pub fn db_tx_pessimistic_point_z(pt : DbtxpessimisticPoint) -> Double { pt.z }

pub fn db_tx_pessimistic_point_label(pt : DbtxpessimisticPoint) -> Int { pt.label }

pub fn db_tx_pessimistic_point_dist(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_tx_pessimistic_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_pessimistic_point_add(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_pessimistic_point_sub(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_pessimistic_point_scale(pt : DbtxpessimisticPoint, s : Double) -> DbtxpessimisticPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_pessimistic_point_dot(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_pessimistic_point_cross(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_pessimistic_point_norm(pt : DbtxpessimisticPoint) -> Double {
  db_tx_pessimistic_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_pessimistic_point_normalize(pt : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  let n = db_tx_pessimistic_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_pessimistic_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_pessimistic_point_negate(pt : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_pessimistic_point_mid(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint) -> DbtxpessimisticPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_pessimistic_point_lerp(a : DbtxpessimisticPoint, b : DbtxpessimisticPoint, t : Double) -> DbtxpessimisticPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_pessimistic_point_to_string(pt : DbtxpessimisticPoint) -> String {
  "(" + db_tx_pessimistic_dbl(pt.x) + ", " + db_tx_pessimistic_dbl(pt.y) + ", " + db_tx_pessimistic_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxpessimisticSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_pessimistic_make_series(vals : Array[Double], name : String) -> DbtxpessimisticSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_pessimistic_series_len(s : DbtxpessimisticSeries) -> Int { s.vals.length() }

pub fn db_tx_pessimistic_series_sum(s : DbtxpessimisticSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_tx_pessimistic_series_mean(s : DbtxpessimisticSeries) -> Double {
  let n = db_tx_pessimistic_series_len(s)
  if n == 0 { 0.0 } else { db_tx_pessimistic_series_sum(s) / n.to_double() }
}

pub fn db_tx_pessimistic_series_min(s : DbtxpessimisticSeries) -> Double {
  let n = db_tx_pessimistic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_pessimistic_series_max(s : DbtxpessimisticSeries) -> Double {
  let n = db_tx_pessimistic_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_pessimistic_series_range(s : DbtxpessimisticSeries) -> Double {
  db_tx_pessimistic_series_max(s) - db_tx_pessimistic_series_min(s)
}

pub fn db_tx_pessimistic_series_var(s : DbtxpessimisticSeries) -> Double {
  let n = db_tx_pessimistic_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_tx_pessimistic_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_tx_pessimistic_series_std(s : DbtxpessimisticSeries) -> Double { db_tx_pessimistic_sqrt(db_tx_pessimistic_series_var(s)) }

pub fn db_tx_pessimistic_series_median(s : DbtxpessimisticSeries) -> Double {
  let n = db_tx_pessimistic_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_tx_pessimistic_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_pessimistic_series_scale(s : DbtxpessimisticSeries, f : Double) -> DbtxpessimisticSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_tx_pessimistic_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_pessimistic_series_add(a : DbtxpessimisticSeries, b : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_pessimistic_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_pessimistic_series_sub(a : DbtxpessimisticSeries, b : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_pessimistic_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_pessimistic_series_normalize(s : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  let mn = db_tx_pessimistic_series_min(s)
  let mx = db_tx_pessimistic_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_tx_pessimistic_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_pessimistic_series_cumsum(s : DbtxpessimisticSeries) -> DbtxpessimisticSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_tx_pessimistic_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_pessimistic_series_to_string(s : DbtxpessimisticSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_pessimistic_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxpessimisticMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_pessimistic_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxpessimisticMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_pessimistic_matrix_identity(n : Int) -> DbtxpessimisticMatrix {
  let m = db_tx_pessimistic_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_pessimistic_matrix_get(m : DbtxpessimisticMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_pessimistic_matrix_transpose(m : DbtxpessimisticMatrix) -> DbtxpessimisticMatrix {
  let result = db_tx_pessimistic_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_pessimistic_matrix_add(a : DbtxpessimisticMatrix, b : DbtxpessimisticMatrix) -> DbtxpessimisticMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_pessimistic_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_pessimistic_matrix_scale(m : DbtxpessimisticMatrix, s : Double) -> DbtxpessimisticMatrix {
  let result = db_tx_pessimistic_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_pessimistic_matrix_multiply(a : DbtxpessimisticMatrix, b : DbtxpessimisticMatrix) -> DbtxpessimisticMatrix {
  if a.cols != b.rows { return db_tx_pessimistic_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_pessimistic_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_pessimistic_matrix_trace(m : DbtxpessimisticMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_pessimistic_matrix_det(m : DbtxpessimisticMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_pessimistic_matrix_norm(m : DbtxpessimisticMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_tx_pessimistic_sqrt(sum)
}

pub fn db_tx_pessimistic_matrix_to_string(m : DbtxpessimisticMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_tx_pessimistic_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbtxpessimisticVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_pessimistic_make_vector(comps : Array[Double]) -> DbtxpessimisticVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_pessimistic_vector_zero(dim : Int) -> DbtxpessimisticVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_pessimistic_vector_add(a : DbtxpessimisticVector, b : DbtxpessimisticVector) -> DbtxpessimisticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_pessimistic_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_pessimistic_vector_sub(a : DbtxpessimisticVector, b : DbtxpessimisticVector) -> DbtxpessimisticVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_pessimistic_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_pessimistic_vector_scale(v : DbtxpessimisticVector, s : Double) -> DbtxpessimisticVector {
  let mut result = []
  for i in 0..<v.dim { result = db_tx_pessimistic_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_pessimistic_vector_dot(a : DbtxpessimisticVector, b : DbtxpessimisticVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_pessimistic_vector_norm(v : DbtxpessimisticVector) -> Double { db_tx_pessimistic_sqrt(db_tx_pessimistic_vector_dot(v, v)) }

pub fn db_tx_pessimistic_vector_normalize(v : DbtxpessimisticVector) -> DbtxpessimisticVector {
  let n = db_tx_pessimistic_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_pessimistic_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_pessimistic_vector_dist(a : DbtxpessimisticVector, b : DbtxpessimisticVector) -> Double {
  db_tx_pessimistic_vector_norm(db_tx_pessimistic_vector_sub(a, b))
}

pub fn db_tx_pessimistic_vector_to_string(v : DbtxpessimisticVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_pessimistic_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_pessimistic_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_tx_pessimistic_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_tx_pessimistic_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_pessimistic_std(data : Array[Double]) -> Double { db_tx_pessimistic_sqrt(db_tx_pessimistic_var(data)) }

pub fn db_tx_pessimistic_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_tx_pessimistic_mean(a); let mb = db_tx_pessimistic_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_tx_pessimistic_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_tx_pessimistic_std(a); let sb = db_tx_pessimistic_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_tx_pessimistic_cov(a, b) / (sa * sb) }
}

pub fn db_tx_pessimistic_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_tx_pessimistic_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_pessimistic_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_tx_pessimistic_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_pessimistic_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_tx_pessimistic_sqrt(db_tx_pessimistic_mse(pred, labels))
}

pub fn db_tx_pessimistic_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_tx_pessimistic_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_tx_pessimistic_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_tx_pessimistic_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_tx_pessimistic_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_tx_pessimistic_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_tx_pessimistic_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_tx_pessimistic_precision(pred, labels, pos); let r = db_tx_pessimistic_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_tx_pessimistic_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_tx_pessimistic_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_tx_pessimistic_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_tx_pessimistic_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_tx_pessimistic_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_tx_pessimistic_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_tx_pessimistic_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_tx_pessimistic_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_tx_pessimistic_fibonacci(n : Int) -> Int {
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

pub fn db_tx_pessimistic_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_tx_pessimistic_min(data); let mx = db_tx_pessimistic_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_tx_pessimistic_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_tx_pessimistic_mean(data); let sd = db_tx_pessimistic_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_tx_pessimistic_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_tx_pessimistic_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_tx_pessimistic_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_tx_pessimistic_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_tx_pessimistic_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_tx_pessimistic_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_tx_pessimistic_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_tx_pessimistic_int(x) } else { -db_tx_pessimistic_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_tx_pessimistic_int(f * 1000000.0) } else { db_tx_pessimistic_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_tx_pessimistic_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_tx_pessimistic_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbtxpessimisticFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_frame_make(size : Int) -> DbtxpessimisticFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_frame_len(s : DbtxpessimisticFrame) -> Int { s.size }

pub fn db_tx_pessimistic_frame_get(s : DbtxpessimisticFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_frame_set(s : DbtxpessimisticFrame, i : Int, v : Double) -> DbtxpessimisticFrame {
  let result = db_tx_pessimistic_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_frame_sum(s : DbtxpessimisticFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_frame_mean(s : DbtxpessimisticFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_frame_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_frame_scale(s : DbtxpessimisticFrame, f : Double) -> DbtxpessimisticFrame {
  let result = db_tx_pessimistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_frame_add(a : DbtxpessimisticFrame, b : DbtxpessimisticFrame) -> DbtxpessimisticFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_frame_copy(s : DbtxpessimisticFrame) -> DbtxpessimisticFrame {
  let result = db_tx_pessimistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_frame_fill(s : DbtxpessimisticFrame, v : Double) -> DbtxpessimisticFrame {
  let result = db_tx_pessimistic_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_frame_min(s : DbtxpessimisticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_frame_max(s : DbtxpessimisticFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_frame_to_string(s : DbtxpessimisticFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_table_make(size : Int) -> DbtxpessimisticTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_table_len(s : DbtxpessimisticTable) -> Int { s.size }

pub fn db_tx_pessimistic_table_get(s : DbtxpessimisticTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_table_set(s : DbtxpessimisticTable, i : Int, v : Double) -> DbtxpessimisticTable {
  let result = db_tx_pessimistic_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_table_sum(s : DbtxpessimisticTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_table_mean(s : DbtxpessimisticTable) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_table_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_table_scale(s : DbtxpessimisticTable, f : Double) -> DbtxpessimisticTable {
  let result = db_tx_pessimistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_table_add(a : DbtxpessimisticTable, b : DbtxpessimisticTable) -> DbtxpessimisticTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_table_copy(s : DbtxpessimisticTable) -> DbtxpessimisticTable {
  let result = db_tx_pessimistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_table_fill(s : DbtxpessimisticTable, v : Double) -> DbtxpessimisticTable {
  let result = db_tx_pessimistic_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_table_min(s : DbtxpessimisticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_table_max(s : DbtxpessimisticTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_table_to_string(s : DbtxpessimisticTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_graphn_make(size : Int) -> DbtxpessimisticGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_graphn_len(s : DbtxpessimisticGraphN) -> Int { s.size }

pub fn db_tx_pessimistic_graphn_get(s : DbtxpessimisticGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_graphn_set(s : DbtxpessimisticGraphN, i : Int, v : Double) -> DbtxpessimisticGraphN {
  let result = db_tx_pessimistic_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_graphn_sum(s : DbtxpessimisticGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_graphn_mean(s : DbtxpessimisticGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_graphn_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_graphn_scale(s : DbtxpessimisticGraphN, f : Double) -> DbtxpessimisticGraphN {
  let result = db_tx_pessimistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_graphn_add(a : DbtxpessimisticGraphN, b : DbtxpessimisticGraphN) -> DbtxpessimisticGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_graphn_copy(s : DbtxpessimisticGraphN) -> DbtxpessimisticGraphN {
  let result = db_tx_pessimistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_graphn_fill(s : DbtxpessimisticGraphN, v : Double) -> DbtxpessimisticGraphN {
  let result = db_tx_pessimistic_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_graphn_min(s : DbtxpessimisticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_graphn_max(s : DbtxpessimisticGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_graphn_to_string(s : DbtxpessimisticGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_node_make(size : Int) -> DbtxpessimisticNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_node_len(s : DbtxpessimisticNode) -> Int { s.size }

pub fn db_tx_pessimistic_node_get(s : DbtxpessimisticNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_node_set(s : DbtxpessimisticNode, i : Int, v : Double) -> DbtxpessimisticNode {
  let result = db_tx_pessimistic_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_node_sum(s : DbtxpessimisticNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_node_mean(s : DbtxpessimisticNode) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_node_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_node_scale(s : DbtxpessimisticNode, f : Double) -> DbtxpessimisticNode {
  let result = db_tx_pessimistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_node_add(a : DbtxpessimisticNode, b : DbtxpessimisticNode) -> DbtxpessimisticNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_node_copy(s : DbtxpessimisticNode) -> DbtxpessimisticNode {
  let result = db_tx_pessimistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_node_fill(s : DbtxpessimisticNode, v : Double) -> DbtxpessimisticNode {
  let result = db_tx_pessimistic_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_node_min(s : DbtxpessimisticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_node_max(s : DbtxpessimisticNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_node_to_string(s : DbtxpessimisticNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_edge_make(size : Int) -> DbtxpessimisticEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_edge_len(s : DbtxpessimisticEdge) -> Int { s.size }

pub fn db_tx_pessimistic_edge_get(s : DbtxpessimisticEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_edge_set(s : DbtxpessimisticEdge, i : Int, v : Double) -> DbtxpessimisticEdge {
  let result = db_tx_pessimistic_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_edge_sum(s : DbtxpessimisticEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_edge_mean(s : DbtxpessimisticEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_edge_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_edge_scale(s : DbtxpessimisticEdge, f : Double) -> DbtxpessimisticEdge {
  let result = db_tx_pessimistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_edge_add(a : DbtxpessimisticEdge, b : DbtxpessimisticEdge) -> DbtxpessimisticEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_edge_copy(s : DbtxpessimisticEdge) -> DbtxpessimisticEdge {
  let result = db_tx_pessimistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_edge_fill(s : DbtxpessimisticEdge, v : Double) -> DbtxpessimisticEdge {
  let result = db_tx_pessimistic_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_edge_min(s : DbtxpessimisticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_edge_max(s : DbtxpessimisticEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_edge_to_string(s : DbtxpessimisticEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_path_make(size : Int) -> DbtxpessimisticPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_path_len(s : DbtxpessimisticPath) -> Int { s.size }

pub fn db_tx_pessimistic_path_get(s : DbtxpessimisticPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_path_set(s : DbtxpessimisticPath, i : Int, v : Double) -> DbtxpessimisticPath {
  let result = db_tx_pessimistic_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_path_sum(s : DbtxpessimisticPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_path_mean(s : DbtxpessimisticPath) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_path_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_path_scale(s : DbtxpessimisticPath, f : Double) -> DbtxpessimisticPath {
  let result = db_tx_pessimistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_path_add(a : DbtxpessimisticPath, b : DbtxpessimisticPath) -> DbtxpessimisticPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_path_copy(s : DbtxpessimisticPath) -> DbtxpessimisticPath {
  let result = db_tx_pessimistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_path_fill(s : DbtxpessimisticPath, v : Double) -> DbtxpessimisticPath {
  let result = db_tx_pessimistic_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_path_min(s : DbtxpessimisticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_path_max(s : DbtxpessimisticPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_path_to_string(s : DbtxpessimisticPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_cluster_make(size : Int) -> DbtxpessimisticCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_cluster_len(s : DbtxpessimisticCluster) -> Int { s.size }

pub fn db_tx_pessimistic_cluster_get(s : DbtxpessimisticCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_cluster_set(s : DbtxpessimisticCluster, i : Int, v : Double) -> DbtxpessimisticCluster {
  let result = db_tx_pessimistic_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_cluster_sum(s : DbtxpessimisticCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_cluster_mean(s : DbtxpessimisticCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_cluster_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_cluster_scale(s : DbtxpessimisticCluster, f : Double) -> DbtxpessimisticCluster {
  let result = db_tx_pessimistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_cluster_add(a : DbtxpessimisticCluster, b : DbtxpessimisticCluster) -> DbtxpessimisticCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_cluster_copy(s : DbtxpessimisticCluster) -> DbtxpessimisticCluster {
  let result = db_tx_pessimistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_cluster_fill(s : DbtxpessimisticCluster, v : Double) -> DbtxpessimisticCluster {
  let result = db_tx_pessimistic_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_cluster_min(s : DbtxpessimisticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_cluster_max(s : DbtxpessimisticCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_cluster_to_string(s : DbtxpessimisticCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_model_make(size : Int) -> DbtxpessimisticModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_model_len(s : DbtxpessimisticModel) -> Int { s.size }

pub fn db_tx_pessimistic_model_get(s : DbtxpessimisticModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_model_set(s : DbtxpessimisticModel, i : Int, v : Double) -> DbtxpessimisticModel {
  let result = db_tx_pessimistic_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_model_sum(s : DbtxpessimisticModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_model_mean(s : DbtxpessimisticModel) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_model_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_model_scale(s : DbtxpessimisticModel, f : Double) -> DbtxpessimisticModel {
  let result = db_tx_pessimistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_model_add(a : DbtxpessimisticModel, b : DbtxpessimisticModel) -> DbtxpessimisticModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_model_copy(s : DbtxpessimisticModel) -> DbtxpessimisticModel {
  let result = db_tx_pessimistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_model_fill(s : DbtxpessimisticModel, v : Double) -> DbtxpessimisticModel {
  let result = db_tx_pessimistic_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_model_min(s : DbtxpessimisticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_model_max(s : DbtxpessimisticModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_model_to_string(s : DbtxpessimisticModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_layer_make(size : Int) -> DbtxpessimisticLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_layer_len(s : DbtxpessimisticLayer) -> Int { s.size }

pub fn db_tx_pessimistic_layer_get(s : DbtxpessimisticLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_layer_set(s : DbtxpessimisticLayer, i : Int, v : Double) -> DbtxpessimisticLayer {
  let result = db_tx_pessimistic_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_layer_sum(s : DbtxpessimisticLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_layer_mean(s : DbtxpessimisticLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_layer_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_layer_scale(s : DbtxpessimisticLayer, f : Double) -> DbtxpessimisticLayer {
  let result = db_tx_pessimistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_layer_add(a : DbtxpessimisticLayer, b : DbtxpessimisticLayer) -> DbtxpessimisticLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_layer_copy(s : DbtxpessimisticLayer) -> DbtxpessimisticLayer {
  let result = db_tx_pessimistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_layer_fill(s : DbtxpessimisticLayer, v : Double) -> DbtxpessimisticLayer {
  let result = db_tx_pessimistic_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_layer_min(s : DbtxpessimisticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_layer_max(s : DbtxpessimisticLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_layer_to_string(s : DbtxpessimisticLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_buffer_make(size : Int) -> DbtxpessimisticBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_buffer_len(s : DbtxpessimisticBuffer) -> Int { s.size }

pub fn db_tx_pessimistic_buffer_get(s : DbtxpessimisticBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_buffer_set(s : DbtxpessimisticBuffer, i : Int, v : Double) -> DbtxpessimisticBuffer {
  let result = db_tx_pessimistic_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_buffer_sum(s : DbtxpessimisticBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_buffer_mean(s : DbtxpessimisticBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_buffer_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_buffer_scale(s : DbtxpessimisticBuffer, f : Double) -> DbtxpessimisticBuffer {
  let result = db_tx_pessimistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_buffer_add(a : DbtxpessimisticBuffer, b : DbtxpessimisticBuffer) -> DbtxpessimisticBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_buffer_copy(s : DbtxpessimisticBuffer) -> DbtxpessimisticBuffer {
  let result = db_tx_pessimistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_buffer_fill(s : DbtxpessimisticBuffer, v : Double) -> DbtxpessimisticBuffer {
  let result = db_tx_pessimistic_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_buffer_min(s : DbtxpessimisticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_buffer_max(s : DbtxpessimisticBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_buffer_to_string(s : DbtxpessimisticBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_cursor_make(size : Int) -> DbtxpessimisticCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_cursor_len(s : DbtxpessimisticCursor) -> Int { s.size }

pub fn db_tx_pessimistic_cursor_get(s : DbtxpessimisticCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_cursor_set(s : DbtxpessimisticCursor, i : Int, v : Double) -> DbtxpessimisticCursor {
  let result = db_tx_pessimistic_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_cursor_sum(s : DbtxpessimisticCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_cursor_mean(s : DbtxpessimisticCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_cursor_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_cursor_scale(s : DbtxpessimisticCursor, f : Double) -> DbtxpessimisticCursor {
  let result = db_tx_pessimistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_cursor_add(a : DbtxpessimisticCursor, b : DbtxpessimisticCursor) -> DbtxpessimisticCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_cursor_copy(s : DbtxpessimisticCursor) -> DbtxpessimisticCursor {
  let result = db_tx_pessimistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_cursor_fill(s : DbtxpessimisticCursor, v : Double) -> DbtxpessimisticCursor {
  let result = db_tx_pessimistic_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_cursor_min(s : DbtxpessimisticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_cursor_max(s : DbtxpessimisticCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_cursor_to_string(s : DbtxpessimisticCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_view_make(size : Int) -> DbtxpessimisticView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_view_len(s : DbtxpessimisticView) -> Int { s.size }

pub fn db_tx_pessimistic_view_get(s : DbtxpessimisticView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_view_set(s : DbtxpessimisticView, i : Int, v : Double) -> DbtxpessimisticView {
  let result = db_tx_pessimistic_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_view_sum(s : DbtxpessimisticView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_view_mean(s : DbtxpessimisticView) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_view_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_view_scale(s : DbtxpessimisticView, f : Double) -> DbtxpessimisticView {
  let result = db_tx_pessimistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_view_add(a : DbtxpessimisticView, b : DbtxpessimisticView) -> DbtxpessimisticView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_view_copy(s : DbtxpessimisticView) -> DbtxpessimisticView {
  let result = db_tx_pessimistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_view_fill(s : DbtxpessimisticView, v : Double) -> DbtxpessimisticView {
  let result = db_tx_pessimistic_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_view_min(s : DbtxpessimisticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_view_max(s : DbtxpessimisticView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_view_to_string(s : DbtxpessimisticView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_range_make(size : Int) -> DbtxpessimisticRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_range_len(s : DbtxpessimisticRange) -> Int { s.size }

pub fn db_tx_pessimistic_range_get(s : DbtxpessimisticRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_range_set(s : DbtxpessimisticRange, i : Int, v : Double) -> DbtxpessimisticRange {
  let result = db_tx_pessimistic_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_range_sum(s : DbtxpessimisticRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_range_mean(s : DbtxpessimisticRange) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_range_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_range_scale(s : DbtxpessimisticRange, f : Double) -> DbtxpessimisticRange {
  let result = db_tx_pessimistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_range_add(a : DbtxpessimisticRange, b : DbtxpessimisticRange) -> DbtxpessimisticRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_range_copy(s : DbtxpessimisticRange) -> DbtxpessimisticRange {
  let result = db_tx_pessimistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_range_fill(s : DbtxpessimisticRange, v : Double) -> DbtxpessimisticRange {
  let result = db_tx_pessimistic_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_range_min(s : DbtxpessimisticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_range_max(s : DbtxpessimisticRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_range_to_string(s : DbtxpessimisticRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxpessimisticSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_pessimistic_slice_make(size : Int) -> DbtxpessimisticSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_pessimistic_slice_len(s : DbtxpessimisticSlice) -> Int { s.size }

pub fn db_tx_pessimistic_slice_get(s : DbtxpessimisticSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_pessimistic_slice_set(s : DbtxpessimisticSlice, i : Int, v : Double) -> DbtxpessimisticSlice {
  let result = db_tx_pessimistic_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_slice_sum(s : DbtxpessimisticSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_pessimistic_slice_mean(s : DbtxpessimisticSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_pessimistic_slice_sum(s) / s.size.to_double() }
}

pub fn db_tx_pessimistic_slice_scale(s : DbtxpessimisticSlice, f : Double) -> DbtxpessimisticSlice {
  let result = db_tx_pessimistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_pessimistic_slice_add(a : DbtxpessimisticSlice, b : DbtxpessimisticSlice) -> DbtxpessimisticSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_pessimistic_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_pessimistic_slice_copy(s : DbtxpessimisticSlice) -> DbtxpessimisticSlice {
  let result = db_tx_pessimistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_pessimistic_slice_fill(s : DbtxpessimisticSlice, v : Double) -> DbtxpessimisticSlice {
  let result = db_tx_pessimistic_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_pessimistic_slice_min(s : DbtxpessimisticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_slice_max(s : DbtxpessimisticSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_pessimistic_slice_to_string(s : DbtxpessimisticSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_tx_pessimistic_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_pessimistic_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

