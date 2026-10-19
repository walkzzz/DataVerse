///===
/// extcore/db_tx_compensating

pub(all) struct DbtxcompensatingPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_compensating_make_point(x : Double, y : Double) -> DbtxcompensatingPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_compensating_make_point3(x : Double, y : Double, z : Double) -> DbtxcompensatingPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_compensating_point_x(pt : DbtxcompensatingPoint) -> Double { pt.x }

pub fn db_tx_compensating_point_y(pt : DbtxcompensatingPoint) -> Double { pt.y }

pub fn db_tx_compensating_point_z(pt : DbtxcompensatingPoint) -> Double { pt.z }

pub fn db_tx_compensating_point_label(pt : DbtxcompensatingPoint) -> Int { pt.label }

pub fn db_tx_compensating_point_dist(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_tx_compensating_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_compensating_point_add(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_compensating_point_sub(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_compensating_point_scale(pt : DbtxcompensatingPoint, s : Double) -> DbtxcompensatingPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_compensating_point_dot(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_compensating_point_cross(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_compensating_point_norm(pt : DbtxcompensatingPoint) -> Double {
  db_tx_compensating_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_compensating_point_normalize(pt : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  let n = db_tx_compensating_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_compensating_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_compensating_point_negate(pt : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_compensating_point_mid(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint) -> DbtxcompensatingPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_compensating_point_lerp(a : DbtxcompensatingPoint, b : DbtxcompensatingPoint, t : Double) -> DbtxcompensatingPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_compensating_point_to_string(pt : DbtxcompensatingPoint) -> String {
  "(" + db_tx_compensating_dbl(pt.x) + ", " + db_tx_compensating_dbl(pt.y) + ", " + db_tx_compensating_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxcompensatingSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_compensating_make_series(vals : Array[Double], name : String) -> DbtxcompensatingSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_compensating_series_len(s : DbtxcompensatingSeries) -> Int { s.vals.length() }

pub fn db_tx_compensating_series_sum(s : DbtxcompensatingSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_tx_compensating_series_mean(s : DbtxcompensatingSeries) -> Double {
  let n = db_tx_compensating_series_len(s)
  if n == 0 { 0.0 } else { db_tx_compensating_series_sum(s) / n.to_double() }
}

pub fn db_tx_compensating_series_min(s : DbtxcompensatingSeries) -> Double {
  let n = db_tx_compensating_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_compensating_series_max(s : DbtxcompensatingSeries) -> Double {
  let n = db_tx_compensating_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_compensating_series_range(s : DbtxcompensatingSeries) -> Double {
  db_tx_compensating_series_max(s) - db_tx_compensating_series_min(s)
}

pub fn db_tx_compensating_series_var(s : DbtxcompensatingSeries) -> Double {
  let n = db_tx_compensating_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_tx_compensating_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_tx_compensating_series_std(s : DbtxcompensatingSeries) -> Double { db_tx_compensating_sqrt(db_tx_compensating_series_var(s)) }

pub fn db_tx_compensating_series_median(s : DbtxcompensatingSeries) -> Double {
  let n = db_tx_compensating_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_tx_compensating_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_compensating_series_scale(s : DbtxcompensatingSeries, f : Double) -> DbtxcompensatingSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_tx_compensating_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_compensating_series_add(a : DbtxcompensatingSeries, b : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_compensating_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_compensating_series_sub(a : DbtxcompensatingSeries, b : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_compensating_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_compensating_series_normalize(s : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  let mn = db_tx_compensating_series_min(s)
  let mx = db_tx_compensating_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_tx_compensating_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_compensating_series_cumsum(s : DbtxcompensatingSeries) -> DbtxcompensatingSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_tx_compensating_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_compensating_series_to_string(s : DbtxcompensatingSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_compensating_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxcompensatingMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_compensating_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxcompensatingMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_compensating_matrix_identity(n : Int) -> DbtxcompensatingMatrix {
  let m = db_tx_compensating_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_compensating_matrix_get(m : DbtxcompensatingMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_compensating_matrix_transpose(m : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  let result = db_tx_compensating_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_compensating_matrix_add(a : DbtxcompensatingMatrix, b : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_compensating_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_compensating_matrix_scale(m : DbtxcompensatingMatrix, s : Double) -> DbtxcompensatingMatrix {
  let result = db_tx_compensating_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_compensating_matrix_multiply(a : DbtxcompensatingMatrix, b : DbtxcompensatingMatrix) -> DbtxcompensatingMatrix {
  if a.cols != b.rows { return db_tx_compensating_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_compensating_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_compensating_matrix_trace(m : DbtxcompensatingMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_compensating_matrix_det(m : DbtxcompensatingMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_compensating_matrix_norm(m : DbtxcompensatingMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_tx_compensating_sqrt(sum)
}

pub fn db_tx_compensating_matrix_to_string(m : DbtxcompensatingMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_tx_compensating_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbtxcompensatingVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_compensating_make_vector(comps : Array[Double]) -> DbtxcompensatingVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_compensating_vector_zero(dim : Int) -> DbtxcompensatingVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_compensating_vector_add(a : DbtxcompensatingVector, b : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_compensating_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_compensating_vector_sub(a : DbtxcompensatingVector, b : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_compensating_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_compensating_vector_scale(v : DbtxcompensatingVector, s : Double) -> DbtxcompensatingVector {
  let mut result = []
  for i in 0..<v.dim { result = db_tx_compensating_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_compensating_vector_dot(a : DbtxcompensatingVector, b : DbtxcompensatingVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_compensating_vector_norm(v : DbtxcompensatingVector) -> Double { db_tx_compensating_sqrt(db_tx_compensating_vector_dot(v, v)) }

pub fn db_tx_compensating_vector_normalize(v : DbtxcompensatingVector) -> DbtxcompensatingVector {
  let n = db_tx_compensating_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_compensating_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_compensating_vector_dist(a : DbtxcompensatingVector, b : DbtxcompensatingVector) -> Double {
  db_tx_compensating_vector_norm(db_tx_compensating_vector_sub(a, b))
}

pub fn db_tx_compensating_vector_to_string(v : DbtxcompensatingVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_compensating_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_compensating_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_tx_compensating_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_tx_compensating_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_compensating_std(data : Array[Double]) -> Double { db_tx_compensating_sqrt(db_tx_compensating_var(data)) }

pub fn db_tx_compensating_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_tx_compensating_mean(a); let mb = db_tx_compensating_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_tx_compensating_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_tx_compensating_std(a); let sb = db_tx_compensating_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_tx_compensating_cov(a, b) / (sa * sb) }
}

pub fn db_tx_compensating_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_tx_compensating_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_compensating_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_tx_compensating_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_compensating_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_tx_compensating_sqrt(db_tx_compensating_mse(pred, labels))
}

pub fn db_tx_compensating_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_tx_compensating_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_tx_compensating_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_tx_compensating_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_tx_compensating_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_tx_compensating_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_tx_compensating_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_tx_compensating_precision(pred, labels, pos); let r = db_tx_compensating_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_tx_compensating_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_tx_compensating_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_tx_compensating_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_tx_compensating_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_tx_compensating_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_tx_compensating_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_tx_compensating_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_tx_compensating_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_tx_compensating_fibonacci(n : Int) -> Int {
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

pub fn db_tx_compensating_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_tx_compensating_min(data); let mx = db_tx_compensating_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_tx_compensating_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_tx_compensating_mean(data); let sd = db_tx_compensating_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_tx_compensating_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_tx_compensating_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_tx_compensating_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_tx_compensating_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_tx_compensating_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_tx_compensating_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_tx_compensating_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_tx_compensating_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_tx_compensating_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_tx_compensating_int(x) } else { -db_tx_compensating_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_tx_compensating_int(f * 1000000.0) } else { db_tx_compensating_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_tx_compensating_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_tx_compensating_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbtxcompensatingFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_frame_make(size : Int) -> DbtxcompensatingFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_frame_len(s : DbtxcompensatingFrame) -> Int { s.size }

pub fn db_tx_compensating_frame_get(s : DbtxcompensatingFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_frame_set(s : DbtxcompensatingFrame, i : Int, v : Double) -> DbtxcompensatingFrame {
  let result = db_tx_compensating_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_frame_sum(s : DbtxcompensatingFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_frame_mean(s : DbtxcompensatingFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_frame_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_frame_scale(s : DbtxcompensatingFrame, f : Double) -> DbtxcompensatingFrame {
  let result = db_tx_compensating_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_frame_add(a : DbtxcompensatingFrame, b : DbtxcompensatingFrame) -> DbtxcompensatingFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_frame_copy(s : DbtxcompensatingFrame) -> DbtxcompensatingFrame {
  let result = db_tx_compensating_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_frame_fill(s : DbtxcompensatingFrame, v : Double) -> DbtxcompensatingFrame {
  let result = db_tx_compensating_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_frame_min(s : DbtxcompensatingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_frame_max(s : DbtxcompensatingFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_frame_to_string(s : DbtxcompensatingFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_table_make(size : Int) -> DbtxcompensatingTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_table_len(s : DbtxcompensatingTable) -> Int { s.size }

pub fn db_tx_compensating_table_get(s : DbtxcompensatingTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_table_set(s : DbtxcompensatingTable, i : Int, v : Double) -> DbtxcompensatingTable {
  let result = db_tx_compensating_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_table_sum(s : DbtxcompensatingTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_table_mean(s : DbtxcompensatingTable) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_table_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_table_scale(s : DbtxcompensatingTable, f : Double) -> DbtxcompensatingTable {
  let result = db_tx_compensating_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_table_add(a : DbtxcompensatingTable, b : DbtxcompensatingTable) -> DbtxcompensatingTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_table_copy(s : DbtxcompensatingTable) -> DbtxcompensatingTable {
  let result = db_tx_compensating_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_table_fill(s : DbtxcompensatingTable, v : Double) -> DbtxcompensatingTable {
  let result = db_tx_compensating_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_table_min(s : DbtxcompensatingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_table_max(s : DbtxcompensatingTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_table_to_string(s : DbtxcompensatingTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_graphn_make(size : Int) -> DbtxcompensatingGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_graphn_len(s : DbtxcompensatingGraphN) -> Int { s.size }

pub fn db_tx_compensating_graphn_get(s : DbtxcompensatingGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_graphn_set(s : DbtxcompensatingGraphN, i : Int, v : Double) -> DbtxcompensatingGraphN {
  let result = db_tx_compensating_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_graphn_sum(s : DbtxcompensatingGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_graphn_mean(s : DbtxcompensatingGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_graphn_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_graphn_scale(s : DbtxcompensatingGraphN, f : Double) -> DbtxcompensatingGraphN {
  let result = db_tx_compensating_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_graphn_add(a : DbtxcompensatingGraphN, b : DbtxcompensatingGraphN) -> DbtxcompensatingGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_graphn_copy(s : DbtxcompensatingGraphN) -> DbtxcompensatingGraphN {
  let result = db_tx_compensating_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_graphn_fill(s : DbtxcompensatingGraphN, v : Double) -> DbtxcompensatingGraphN {
  let result = db_tx_compensating_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_graphn_min(s : DbtxcompensatingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_graphn_max(s : DbtxcompensatingGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_graphn_to_string(s : DbtxcompensatingGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_node_make(size : Int) -> DbtxcompensatingNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_node_len(s : DbtxcompensatingNode) -> Int { s.size }

pub fn db_tx_compensating_node_get(s : DbtxcompensatingNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_node_set(s : DbtxcompensatingNode, i : Int, v : Double) -> DbtxcompensatingNode {
  let result = db_tx_compensating_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_node_sum(s : DbtxcompensatingNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_node_mean(s : DbtxcompensatingNode) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_node_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_node_scale(s : DbtxcompensatingNode, f : Double) -> DbtxcompensatingNode {
  let result = db_tx_compensating_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_node_add(a : DbtxcompensatingNode, b : DbtxcompensatingNode) -> DbtxcompensatingNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_node_copy(s : DbtxcompensatingNode) -> DbtxcompensatingNode {
  let result = db_tx_compensating_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_node_fill(s : DbtxcompensatingNode, v : Double) -> DbtxcompensatingNode {
  let result = db_tx_compensating_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_node_min(s : DbtxcompensatingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_node_max(s : DbtxcompensatingNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_node_to_string(s : DbtxcompensatingNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_edge_make(size : Int) -> DbtxcompensatingEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_edge_len(s : DbtxcompensatingEdge) -> Int { s.size }

pub fn db_tx_compensating_edge_get(s : DbtxcompensatingEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_edge_set(s : DbtxcompensatingEdge, i : Int, v : Double) -> DbtxcompensatingEdge {
  let result = db_tx_compensating_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_edge_sum(s : DbtxcompensatingEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_edge_mean(s : DbtxcompensatingEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_edge_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_edge_scale(s : DbtxcompensatingEdge, f : Double) -> DbtxcompensatingEdge {
  let result = db_tx_compensating_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_edge_add(a : DbtxcompensatingEdge, b : DbtxcompensatingEdge) -> DbtxcompensatingEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_edge_copy(s : DbtxcompensatingEdge) -> DbtxcompensatingEdge {
  let result = db_tx_compensating_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_edge_fill(s : DbtxcompensatingEdge, v : Double) -> DbtxcompensatingEdge {
  let result = db_tx_compensating_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_edge_min(s : DbtxcompensatingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_edge_max(s : DbtxcompensatingEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_edge_to_string(s : DbtxcompensatingEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_path_make(size : Int) -> DbtxcompensatingPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_path_len(s : DbtxcompensatingPath) -> Int { s.size }

pub fn db_tx_compensating_path_get(s : DbtxcompensatingPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_path_set(s : DbtxcompensatingPath, i : Int, v : Double) -> DbtxcompensatingPath {
  let result = db_tx_compensating_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_path_sum(s : DbtxcompensatingPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_path_mean(s : DbtxcompensatingPath) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_path_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_path_scale(s : DbtxcompensatingPath, f : Double) -> DbtxcompensatingPath {
  let result = db_tx_compensating_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_path_add(a : DbtxcompensatingPath, b : DbtxcompensatingPath) -> DbtxcompensatingPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_path_copy(s : DbtxcompensatingPath) -> DbtxcompensatingPath {
  let result = db_tx_compensating_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_path_fill(s : DbtxcompensatingPath, v : Double) -> DbtxcompensatingPath {
  let result = db_tx_compensating_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_path_min(s : DbtxcompensatingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_path_max(s : DbtxcompensatingPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_path_to_string(s : DbtxcompensatingPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_cluster_make(size : Int) -> DbtxcompensatingCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_cluster_len(s : DbtxcompensatingCluster) -> Int { s.size }

pub fn db_tx_compensating_cluster_get(s : DbtxcompensatingCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_cluster_set(s : DbtxcompensatingCluster, i : Int, v : Double) -> DbtxcompensatingCluster {
  let result = db_tx_compensating_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_cluster_sum(s : DbtxcompensatingCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_cluster_mean(s : DbtxcompensatingCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_cluster_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_cluster_scale(s : DbtxcompensatingCluster, f : Double) -> DbtxcompensatingCluster {
  let result = db_tx_compensating_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_cluster_add(a : DbtxcompensatingCluster, b : DbtxcompensatingCluster) -> DbtxcompensatingCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_cluster_copy(s : DbtxcompensatingCluster) -> DbtxcompensatingCluster {
  let result = db_tx_compensating_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_cluster_fill(s : DbtxcompensatingCluster, v : Double) -> DbtxcompensatingCluster {
  let result = db_tx_compensating_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_cluster_min(s : DbtxcompensatingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_cluster_max(s : DbtxcompensatingCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_cluster_to_string(s : DbtxcompensatingCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_model_make(size : Int) -> DbtxcompensatingModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_model_len(s : DbtxcompensatingModel) -> Int { s.size }

pub fn db_tx_compensating_model_get(s : DbtxcompensatingModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_model_set(s : DbtxcompensatingModel, i : Int, v : Double) -> DbtxcompensatingModel {
  let result = db_tx_compensating_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_model_sum(s : DbtxcompensatingModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_model_mean(s : DbtxcompensatingModel) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_model_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_model_scale(s : DbtxcompensatingModel, f : Double) -> DbtxcompensatingModel {
  let result = db_tx_compensating_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_model_add(a : DbtxcompensatingModel, b : DbtxcompensatingModel) -> DbtxcompensatingModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_model_copy(s : DbtxcompensatingModel) -> DbtxcompensatingModel {
  let result = db_tx_compensating_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_model_fill(s : DbtxcompensatingModel, v : Double) -> DbtxcompensatingModel {
  let result = db_tx_compensating_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_model_min(s : DbtxcompensatingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_model_max(s : DbtxcompensatingModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_model_to_string(s : DbtxcompensatingModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_layer_make(size : Int) -> DbtxcompensatingLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_layer_len(s : DbtxcompensatingLayer) -> Int { s.size }

pub fn db_tx_compensating_layer_get(s : DbtxcompensatingLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_layer_set(s : DbtxcompensatingLayer, i : Int, v : Double) -> DbtxcompensatingLayer {
  let result = db_tx_compensating_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_layer_sum(s : DbtxcompensatingLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_layer_mean(s : DbtxcompensatingLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_layer_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_layer_scale(s : DbtxcompensatingLayer, f : Double) -> DbtxcompensatingLayer {
  let result = db_tx_compensating_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_layer_add(a : DbtxcompensatingLayer, b : DbtxcompensatingLayer) -> DbtxcompensatingLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_layer_copy(s : DbtxcompensatingLayer) -> DbtxcompensatingLayer {
  let result = db_tx_compensating_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_layer_fill(s : DbtxcompensatingLayer, v : Double) -> DbtxcompensatingLayer {
  let result = db_tx_compensating_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_layer_min(s : DbtxcompensatingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_layer_max(s : DbtxcompensatingLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_layer_to_string(s : DbtxcompensatingLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_buffer_make(size : Int) -> DbtxcompensatingBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_buffer_len(s : DbtxcompensatingBuffer) -> Int { s.size }

pub fn db_tx_compensating_buffer_get(s : DbtxcompensatingBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_buffer_set(s : DbtxcompensatingBuffer, i : Int, v : Double) -> DbtxcompensatingBuffer {
  let result = db_tx_compensating_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_buffer_sum(s : DbtxcompensatingBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_buffer_mean(s : DbtxcompensatingBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_buffer_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_buffer_scale(s : DbtxcompensatingBuffer, f : Double) -> DbtxcompensatingBuffer {
  let result = db_tx_compensating_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_buffer_add(a : DbtxcompensatingBuffer, b : DbtxcompensatingBuffer) -> DbtxcompensatingBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_buffer_copy(s : DbtxcompensatingBuffer) -> DbtxcompensatingBuffer {
  let result = db_tx_compensating_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_buffer_fill(s : DbtxcompensatingBuffer, v : Double) -> DbtxcompensatingBuffer {
  let result = db_tx_compensating_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_buffer_min(s : DbtxcompensatingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_buffer_max(s : DbtxcompensatingBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_buffer_to_string(s : DbtxcompensatingBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_cursor_make(size : Int) -> DbtxcompensatingCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_cursor_len(s : DbtxcompensatingCursor) -> Int { s.size }

pub fn db_tx_compensating_cursor_get(s : DbtxcompensatingCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_cursor_set(s : DbtxcompensatingCursor, i : Int, v : Double) -> DbtxcompensatingCursor {
  let result = db_tx_compensating_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_cursor_sum(s : DbtxcompensatingCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_cursor_mean(s : DbtxcompensatingCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_cursor_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_cursor_scale(s : DbtxcompensatingCursor, f : Double) -> DbtxcompensatingCursor {
  let result = db_tx_compensating_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_cursor_add(a : DbtxcompensatingCursor, b : DbtxcompensatingCursor) -> DbtxcompensatingCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_cursor_copy(s : DbtxcompensatingCursor) -> DbtxcompensatingCursor {
  let result = db_tx_compensating_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_cursor_fill(s : DbtxcompensatingCursor, v : Double) -> DbtxcompensatingCursor {
  let result = db_tx_compensating_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_cursor_min(s : DbtxcompensatingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_cursor_max(s : DbtxcompensatingCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_cursor_to_string(s : DbtxcompensatingCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_view_make(size : Int) -> DbtxcompensatingView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_view_len(s : DbtxcompensatingView) -> Int { s.size }

pub fn db_tx_compensating_view_get(s : DbtxcompensatingView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_view_set(s : DbtxcompensatingView, i : Int, v : Double) -> DbtxcompensatingView {
  let result = db_tx_compensating_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_view_sum(s : DbtxcompensatingView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_view_mean(s : DbtxcompensatingView) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_view_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_view_scale(s : DbtxcompensatingView, f : Double) -> DbtxcompensatingView {
  let result = db_tx_compensating_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_view_add(a : DbtxcompensatingView, b : DbtxcompensatingView) -> DbtxcompensatingView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_view_copy(s : DbtxcompensatingView) -> DbtxcompensatingView {
  let result = db_tx_compensating_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_view_fill(s : DbtxcompensatingView, v : Double) -> DbtxcompensatingView {
  let result = db_tx_compensating_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_view_min(s : DbtxcompensatingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_view_max(s : DbtxcompensatingView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_view_to_string(s : DbtxcompensatingView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_range_make(size : Int) -> DbtxcompensatingRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_range_len(s : DbtxcompensatingRange) -> Int { s.size }

pub fn db_tx_compensating_range_get(s : DbtxcompensatingRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_range_set(s : DbtxcompensatingRange, i : Int, v : Double) -> DbtxcompensatingRange {
  let result = db_tx_compensating_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_range_sum(s : DbtxcompensatingRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_range_mean(s : DbtxcompensatingRange) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_range_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_range_scale(s : DbtxcompensatingRange, f : Double) -> DbtxcompensatingRange {
  let result = db_tx_compensating_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_range_add(a : DbtxcompensatingRange, b : DbtxcompensatingRange) -> DbtxcompensatingRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_range_copy(s : DbtxcompensatingRange) -> DbtxcompensatingRange {
  let result = db_tx_compensating_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_range_fill(s : DbtxcompensatingRange, v : Double) -> DbtxcompensatingRange {
  let result = db_tx_compensating_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_range_min(s : DbtxcompensatingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_range_max(s : DbtxcompensatingRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_range_to_string(s : DbtxcompensatingRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxcompensatingSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_compensating_slice_make(size : Int) -> DbtxcompensatingSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_compensating_slice_len(s : DbtxcompensatingSlice) -> Int { s.size }

pub fn db_tx_compensating_slice_get(s : DbtxcompensatingSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_compensating_slice_set(s : DbtxcompensatingSlice, i : Int, v : Double) -> DbtxcompensatingSlice {
  let result = db_tx_compensating_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_slice_sum(s : DbtxcompensatingSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_compensating_slice_mean(s : DbtxcompensatingSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_compensating_slice_sum(s) / s.size.to_double() }
}

pub fn db_tx_compensating_slice_scale(s : DbtxcompensatingSlice, f : Double) -> DbtxcompensatingSlice {
  let result = db_tx_compensating_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_compensating_slice_add(a : DbtxcompensatingSlice, b : DbtxcompensatingSlice) -> DbtxcompensatingSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_compensating_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_compensating_slice_copy(s : DbtxcompensatingSlice) -> DbtxcompensatingSlice {
  let result = db_tx_compensating_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_compensating_slice_fill(s : DbtxcompensatingSlice, v : Double) -> DbtxcompensatingSlice {
  let result = db_tx_compensating_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_compensating_slice_min(s : DbtxcompensatingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_slice_max(s : DbtxcompensatingSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_compensating_slice_to_string(s : DbtxcompensatingSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_tx_compensating_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_compensating_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

