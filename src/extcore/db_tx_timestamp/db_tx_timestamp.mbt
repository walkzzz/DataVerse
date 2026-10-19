///===
/// extcore/db_tx_timestamp

pub(all) struct DbtxtimestampPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_timestamp_make_point(x : Double, y : Double) -> DbtxtimestampPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_timestamp_make_point3(x : Double, y : Double, z : Double) -> DbtxtimestampPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_timestamp_point_x(pt : DbtxtimestampPoint) -> Double { pt.x }

pub fn db_tx_timestamp_point_y(pt : DbtxtimestampPoint) -> Double { pt.y }

pub fn db_tx_timestamp_point_z(pt : DbtxtimestampPoint) -> Double { pt.z }

pub fn db_tx_timestamp_point_label(pt : DbtxtimestampPoint) -> Int { pt.label }

pub fn db_tx_timestamp_point_dist(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_tx_timestamp_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_timestamp_point_add(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_timestamp_point_sub(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_timestamp_point_scale(pt : DbtxtimestampPoint, s : Double) -> DbtxtimestampPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_timestamp_point_dot(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_timestamp_point_cross(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_timestamp_point_norm(pt : DbtxtimestampPoint) -> Double {
  db_tx_timestamp_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_timestamp_point_normalize(pt : DbtxtimestampPoint) -> DbtxtimestampPoint {
  let n = db_tx_timestamp_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_timestamp_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_timestamp_point_negate(pt : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_timestamp_point_mid(a : DbtxtimestampPoint, b : DbtxtimestampPoint) -> DbtxtimestampPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_timestamp_point_lerp(a : DbtxtimestampPoint, b : DbtxtimestampPoint, t : Double) -> DbtxtimestampPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_timestamp_point_to_string(pt : DbtxtimestampPoint) -> String {
  "(" + db_tx_timestamp_dbl(pt.x) + ", " + db_tx_timestamp_dbl(pt.y) + ", " + db_tx_timestamp_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxtimestampSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_timestamp_make_series(vals : Array[Double], name : String) -> DbtxtimestampSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_timestamp_series_len(s : DbtxtimestampSeries) -> Int { s.vals.length() }

pub fn db_tx_timestamp_series_sum(s : DbtxtimestampSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_tx_timestamp_series_mean(s : DbtxtimestampSeries) -> Double {
  let n = db_tx_timestamp_series_len(s)
  if n == 0 { 0.0 } else { db_tx_timestamp_series_sum(s) / n.to_double() }
}

pub fn db_tx_timestamp_series_min(s : DbtxtimestampSeries) -> Double {
  let n = db_tx_timestamp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_timestamp_series_max(s : DbtxtimestampSeries) -> Double {
  let n = db_tx_timestamp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_timestamp_series_range(s : DbtxtimestampSeries) -> Double {
  db_tx_timestamp_series_max(s) - db_tx_timestamp_series_min(s)
}

pub fn db_tx_timestamp_series_var(s : DbtxtimestampSeries) -> Double {
  let n = db_tx_timestamp_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_tx_timestamp_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_tx_timestamp_series_std(s : DbtxtimestampSeries) -> Double { db_tx_timestamp_sqrt(db_tx_timestamp_series_var(s)) }

pub fn db_tx_timestamp_series_median(s : DbtxtimestampSeries) -> Double {
  let n = db_tx_timestamp_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_tx_timestamp_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_timestamp_series_scale(s : DbtxtimestampSeries, f : Double) -> DbtxtimestampSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_tx_timestamp_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_timestamp_series_add(a : DbtxtimestampSeries, b : DbtxtimestampSeries) -> DbtxtimestampSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_timestamp_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_timestamp_series_sub(a : DbtxtimestampSeries, b : DbtxtimestampSeries) -> DbtxtimestampSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_timestamp_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_timestamp_series_normalize(s : DbtxtimestampSeries) -> DbtxtimestampSeries {
  let mn = db_tx_timestamp_series_min(s)
  let mx = db_tx_timestamp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_tx_timestamp_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_timestamp_series_cumsum(s : DbtxtimestampSeries) -> DbtxtimestampSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_tx_timestamp_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_timestamp_series_to_string(s : DbtxtimestampSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_timestamp_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxtimestampMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_timestamp_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxtimestampMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_timestamp_matrix_identity(n : Int) -> DbtxtimestampMatrix {
  let m = db_tx_timestamp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_timestamp_matrix_get(m : DbtxtimestampMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_timestamp_matrix_transpose(m : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  let result = db_tx_timestamp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_timestamp_matrix_add(a : DbtxtimestampMatrix, b : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_timestamp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_timestamp_matrix_scale(m : DbtxtimestampMatrix, s : Double) -> DbtxtimestampMatrix {
  let result = db_tx_timestamp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_timestamp_matrix_multiply(a : DbtxtimestampMatrix, b : DbtxtimestampMatrix) -> DbtxtimestampMatrix {
  if a.cols != b.rows { return db_tx_timestamp_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_timestamp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_timestamp_matrix_trace(m : DbtxtimestampMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_timestamp_matrix_det(m : DbtxtimestampMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_timestamp_matrix_norm(m : DbtxtimestampMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_tx_timestamp_sqrt(sum)
}

pub fn db_tx_timestamp_matrix_to_string(m : DbtxtimestampMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_tx_timestamp_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbtxtimestampVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_timestamp_make_vector(comps : Array[Double]) -> DbtxtimestampVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_timestamp_vector_zero(dim : Int) -> DbtxtimestampVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_timestamp_vector_add(a : DbtxtimestampVector, b : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_timestamp_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_timestamp_vector_sub(a : DbtxtimestampVector, b : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_timestamp_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_timestamp_vector_scale(v : DbtxtimestampVector, s : Double) -> DbtxtimestampVector {
  let mut result = []
  for i in 0..<v.dim { result = db_tx_timestamp_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_timestamp_vector_dot(a : DbtxtimestampVector, b : DbtxtimestampVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_timestamp_vector_norm(v : DbtxtimestampVector) -> Double { db_tx_timestamp_sqrt(db_tx_timestamp_vector_dot(v, v)) }

pub fn db_tx_timestamp_vector_normalize(v : DbtxtimestampVector) -> DbtxtimestampVector {
  let n = db_tx_timestamp_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_timestamp_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_timestamp_vector_dist(a : DbtxtimestampVector, b : DbtxtimestampVector) -> Double {
  db_tx_timestamp_vector_norm(db_tx_timestamp_vector_sub(a, b))
}

pub fn db_tx_timestamp_vector_to_string(v : DbtxtimestampVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_timestamp_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_timestamp_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_tx_timestamp_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_tx_timestamp_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_timestamp_std(data : Array[Double]) -> Double { db_tx_timestamp_sqrt(db_tx_timestamp_var(data)) }

pub fn db_tx_timestamp_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_tx_timestamp_mean(a); let mb = db_tx_timestamp_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_tx_timestamp_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_tx_timestamp_std(a); let sb = db_tx_timestamp_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_tx_timestamp_cov(a, b) / (sa * sb) }
}

pub fn db_tx_timestamp_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_tx_timestamp_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_timestamp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_tx_timestamp_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_timestamp_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_tx_timestamp_sqrt(db_tx_timestamp_mse(pred, labels))
}

pub fn db_tx_timestamp_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_tx_timestamp_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_tx_timestamp_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_tx_timestamp_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_tx_timestamp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_tx_timestamp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_tx_timestamp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_tx_timestamp_precision(pred, labels, pos); let r = db_tx_timestamp_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_tx_timestamp_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_tx_timestamp_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_tx_timestamp_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_tx_timestamp_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_tx_timestamp_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_tx_timestamp_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_tx_timestamp_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_tx_timestamp_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_tx_timestamp_fibonacci(n : Int) -> Int {
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

pub fn db_tx_timestamp_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_tx_timestamp_min(data); let mx = db_tx_timestamp_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_tx_timestamp_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_tx_timestamp_mean(data); let sd = db_tx_timestamp_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_tx_timestamp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_tx_timestamp_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_tx_timestamp_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_tx_timestamp_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_tx_timestamp_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_tx_timestamp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_tx_timestamp_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_tx_timestamp_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_tx_timestamp_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_tx_timestamp_int(x) } else { -db_tx_timestamp_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_tx_timestamp_int(f * 1000000.0) } else { db_tx_timestamp_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_tx_timestamp_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_tx_timestamp_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbtxtimestampFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_frame_make(size : Int) -> DbtxtimestampFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_frame_len(s : DbtxtimestampFrame) -> Int { s.size }

pub fn db_tx_timestamp_frame_get(s : DbtxtimestampFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_frame_set(s : DbtxtimestampFrame, i : Int, v : Double) -> DbtxtimestampFrame {
  let result = db_tx_timestamp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_frame_sum(s : DbtxtimestampFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_frame_mean(s : DbtxtimestampFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_frame_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_frame_scale(s : DbtxtimestampFrame, f : Double) -> DbtxtimestampFrame {
  let result = db_tx_timestamp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_frame_add(a : DbtxtimestampFrame, b : DbtxtimestampFrame) -> DbtxtimestampFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_frame_copy(s : DbtxtimestampFrame) -> DbtxtimestampFrame {
  let result = db_tx_timestamp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_frame_fill(s : DbtxtimestampFrame, v : Double) -> DbtxtimestampFrame {
  let result = db_tx_timestamp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_frame_min(s : DbtxtimestampFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_frame_max(s : DbtxtimestampFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_frame_to_string(s : DbtxtimestampFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_table_make(size : Int) -> DbtxtimestampTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_table_len(s : DbtxtimestampTable) -> Int { s.size }

pub fn db_tx_timestamp_table_get(s : DbtxtimestampTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_table_set(s : DbtxtimestampTable, i : Int, v : Double) -> DbtxtimestampTable {
  let result = db_tx_timestamp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_table_sum(s : DbtxtimestampTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_table_mean(s : DbtxtimestampTable) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_table_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_table_scale(s : DbtxtimestampTable, f : Double) -> DbtxtimestampTable {
  let result = db_tx_timestamp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_table_add(a : DbtxtimestampTable, b : DbtxtimestampTable) -> DbtxtimestampTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_table_copy(s : DbtxtimestampTable) -> DbtxtimestampTable {
  let result = db_tx_timestamp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_table_fill(s : DbtxtimestampTable, v : Double) -> DbtxtimestampTable {
  let result = db_tx_timestamp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_table_min(s : DbtxtimestampTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_table_max(s : DbtxtimestampTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_table_to_string(s : DbtxtimestampTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_graphn_make(size : Int) -> DbtxtimestampGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_graphn_len(s : DbtxtimestampGraphN) -> Int { s.size }

pub fn db_tx_timestamp_graphn_get(s : DbtxtimestampGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_graphn_set(s : DbtxtimestampGraphN, i : Int, v : Double) -> DbtxtimestampGraphN {
  let result = db_tx_timestamp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_graphn_sum(s : DbtxtimestampGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_graphn_mean(s : DbtxtimestampGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_graphn_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_graphn_scale(s : DbtxtimestampGraphN, f : Double) -> DbtxtimestampGraphN {
  let result = db_tx_timestamp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_graphn_add(a : DbtxtimestampGraphN, b : DbtxtimestampGraphN) -> DbtxtimestampGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_graphn_copy(s : DbtxtimestampGraphN) -> DbtxtimestampGraphN {
  let result = db_tx_timestamp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_graphn_fill(s : DbtxtimestampGraphN, v : Double) -> DbtxtimestampGraphN {
  let result = db_tx_timestamp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_graphn_min(s : DbtxtimestampGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_graphn_max(s : DbtxtimestampGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_graphn_to_string(s : DbtxtimestampGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_node_make(size : Int) -> DbtxtimestampNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_node_len(s : DbtxtimestampNode) -> Int { s.size }

pub fn db_tx_timestamp_node_get(s : DbtxtimestampNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_node_set(s : DbtxtimestampNode, i : Int, v : Double) -> DbtxtimestampNode {
  let result = db_tx_timestamp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_node_sum(s : DbtxtimestampNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_node_mean(s : DbtxtimestampNode) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_node_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_node_scale(s : DbtxtimestampNode, f : Double) -> DbtxtimestampNode {
  let result = db_tx_timestamp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_node_add(a : DbtxtimestampNode, b : DbtxtimestampNode) -> DbtxtimestampNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_node_copy(s : DbtxtimestampNode) -> DbtxtimestampNode {
  let result = db_tx_timestamp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_node_fill(s : DbtxtimestampNode, v : Double) -> DbtxtimestampNode {
  let result = db_tx_timestamp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_node_min(s : DbtxtimestampNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_node_max(s : DbtxtimestampNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_node_to_string(s : DbtxtimestampNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_edge_make(size : Int) -> DbtxtimestampEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_edge_len(s : DbtxtimestampEdge) -> Int { s.size }

pub fn db_tx_timestamp_edge_get(s : DbtxtimestampEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_edge_set(s : DbtxtimestampEdge, i : Int, v : Double) -> DbtxtimestampEdge {
  let result = db_tx_timestamp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_edge_sum(s : DbtxtimestampEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_edge_mean(s : DbtxtimestampEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_edge_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_edge_scale(s : DbtxtimestampEdge, f : Double) -> DbtxtimestampEdge {
  let result = db_tx_timestamp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_edge_add(a : DbtxtimestampEdge, b : DbtxtimestampEdge) -> DbtxtimestampEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_edge_copy(s : DbtxtimestampEdge) -> DbtxtimestampEdge {
  let result = db_tx_timestamp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_edge_fill(s : DbtxtimestampEdge, v : Double) -> DbtxtimestampEdge {
  let result = db_tx_timestamp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_edge_min(s : DbtxtimestampEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_edge_max(s : DbtxtimestampEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_edge_to_string(s : DbtxtimestampEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_path_make(size : Int) -> DbtxtimestampPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_path_len(s : DbtxtimestampPath) -> Int { s.size }

pub fn db_tx_timestamp_path_get(s : DbtxtimestampPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_path_set(s : DbtxtimestampPath, i : Int, v : Double) -> DbtxtimestampPath {
  let result = db_tx_timestamp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_path_sum(s : DbtxtimestampPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_path_mean(s : DbtxtimestampPath) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_path_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_path_scale(s : DbtxtimestampPath, f : Double) -> DbtxtimestampPath {
  let result = db_tx_timestamp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_path_add(a : DbtxtimestampPath, b : DbtxtimestampPath) -> DbtxtimestampPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_path_copy(s : DbtxtimestampPath) -> DbtxtimestampPath {
  let result = db_tx_timestamp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_path_fill(s : DbtxtimestampPath, v : Double) -> DbtxtimestampPath {
  let result = db_tx_timestamp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_path_min(s : DbtxtimestampPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_path_max(s : DbtxtimestampPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_path_to_string(s : DbtxtimestampPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_cluster_make(size : Int) -> DbtxtimestampCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_cluster_len(s : DbtxtimestampCluster) -> Int { s.size }

pub fn db_tx_timestamp_cluster_get(s : DbtxtimestampCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_cluster_set(s : DbtxtimestampCluster, i : Int, v : Double) -> DbtxtimestampCluster {
  let result = db_tx_timestamp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_cluster_sum(s : DbtxtimestampCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_cluster_mean(s : DbtxtimestampCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_cluster_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_cluster_scale(s : DbtxtimestampCluster, f : Double) -> DbtxtimestampCluster {
  let result = db_tx_timestamp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_cluster_add(a : DbtxtimestampCluster, b : DbtxtimestampCluster) -> DbtxtimestampCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_cluster_copy(s : DbtxtimestampCluster) -> DbtxtimestampCluster {
  let result = db_tx_timestamp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_cluster_fill(s : DbtxtimestampCluster, v : Double) -> DbtxtimestampCluster {
  let result = db_tx_timestamp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_cluster_min(s : DbtxtimestampCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_cluster_max(s : DbtxtimestampCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_cluster_to_string(s : DbtxtimestampCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_model_make(size : Int) -> DbtxtimestampModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_model_len(s : DbtxtimestampModel) -> Int { s.size }

pub fn db_tx_timestamp_model_get(s : DbtxtimestampModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_model_set(s : DbtxtimestampModel, i : Int, v : Double) -> DbtxtimestampModel {
  let result = db_tx_timestamp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_model_sum(s : DbtxtimestampModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_model_mean(s : DbtxtimestampModel) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_model_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_model_scale(s : DbtxtimestampModel, f : Double) -> DbtxtimestampModel {
  let result = db_tx_timestamp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_model_add(a : DbtxtimestampModel, b : DbtxtimestampModel) -> DbtxtimestampModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_model_copy(s : DbtxtimestampModel) -> DbtxtimestampModel {
  let result = db_tx_timestamp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_model_fill(s : DbtxtimestampModel, v : Double) -> DbtxtimestampModel {
  let result = db_tx_timestamp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_model_min(s : DbtxtimestampModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_model_max(s : DbtxtimestampModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_model_to_string(s : DbtxtimestampModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_layer_make(size : Int) -> DbtxtimestampLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_layer_len(s : DbtxtimestampLayer) -> Int { s.size }

pub fn db_tx_timestamp_layer_get(s : DbtxtimestampLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_layer_set(s : DbtxtimestampLayer, i : Int, v : Double) -> DbtxtimestampLayer {
  let result = db_tx_timestamp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_layer_sum(s : DbtxtimestampLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_layer_mean(s : DbtxtimestampLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_layer_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_layer_scale(s : DbtxtimestampLayer, f : Double) -> DbtxtimestampLayer {
  let result = db_tx_timestamp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_layer_add(a : DbtxtimestampLayer, b : DbtxtimestampLayer) -> DbtxtimestampLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_layer_copy(s : DbtxtimestampLayer) -> DbtxtimestampLayer {
  let result = db_tx_timestamp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_layer_fill(s : DbtxtimestampLayer, v : Double) -> DbtxtimestampLayer {
  let result = db_tx_timestamp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_layer_min(s : DbtxtimestampLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_layer_max(s : DbtxtimestampLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_layer_to_string(s : DbtxtimestampLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_buffer_make(size : Int) -> DbtxtimestampBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_buffer_len(s : DbtxtimestampBuffer) -> Int { s.size }

pub fn db_tx_timestamp_buffer_get(s : DbtxtimestampBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_buffer_set(s : DbtxtimestampBuffer, i : Int, v : Double) -> DbtxtimestampBuffer {
  let result = db_tx_timestamp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_buffer_sum(s : DbtxtimestampBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_buffer_mean(s : DbtxtimestampBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_buffer_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_buffer_scale(s : DbtxtimestampBuffer, f : Double) -> DbtxtimestampBuffer {
  let result = db_tx_timestamp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_buffer_add(a : DbtxtimestampBuffer, b : DbtxtimestampBuffer) -> DbtxtimestampBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_buffer_copy(s : DbtxtimestampBuffer) -> DbtxtimestampBuffer {
  let result = db_tx_timestamp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_buffer_fill(s : DbtxtimestampBuffer, v : Double) -> DbtxtimestampBuffer {
  let result = db_tx_timestamp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_buffer_min(s : DbtxtimestampBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_buffer_max(s : DbtxtimestampBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_buffer_to_string(s : DbtxtimestampBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_cursor_make(size : Int) -> DbtxtimestampCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_cursor_len(s : DbtxtimestampCursor) -> Int { s.size }

pub fn db_tx_timestamp_cursor_get(s : DbtxtimestampCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_cursor_set(s : DbtxtimestampCursor, i : Int, v : Double) -> DbtxtimestampCursor {
  let result = db_tx_timestamp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_cursor_sum(s : DbtxtimestampCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_cursor_mean(s : DbtxtimestampCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_cursor_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_cursor_scale(s : DbtxtimestampCursor, f : Double) -> DbtxtimestampCursor {
  let result = db_tx_timestamp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_cursor_add(a : DbtxtimestampCursor, b : DbtxtimestampCursor) -> DbtxtimestampCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_cursor_copy(s : DbtxtimestampCursor) -> DbtxtimestampCursor {
  let result = db_tx_timestamp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_cursor_fill(s : DbtxtimestampCursor, v : Double) -> DbtxtimestampCursor {
  let result = db_tx_timestamp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_cursor_min(s : DbtxtimestampCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_cursor_max(s : DbtxtimestampCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_cursor_to_string(s : DbtxtimestampCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_view_make(size : Int) -> DbtxtimestampView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_view_len(s : DbtxtimestampView) -> Int { s.size }

pub fn db_tx_timestamp_view_get(s : DbtxtimestampView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_view_set(s : DbtxtimestampView, i : Int, v : Double) -> DbtxtimestampView {
  let result = db_tx_timestamp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_view_sum(s : DbtxtimestampView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_view_mean(s : DbtxtimestampView) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_view_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_view_scale(s : DbtxtimestampView, f : Double) -> DbtxtimestampView {
  let result = db_tx_timestamp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_view_add(a : DbtxtimestampView, b : DbtxtimestampView) -> DbtxtimestampView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_view_copy(s : DbtxtimestampView) -> DbtxtimestampView {
  let result = db_tx_timestamp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_view_fill(s : DbtxtimestampView, v : Double) -> DbtxtimestampView {
  let result = db_tx_timestamp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_view_min(s : DbtxtimestampView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_view_max(s : DbtxtimestampView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_view_to_string(s : DbtxtimestampView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_range_make(size : Int) -> DbtxtimestampRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_range_len(s : DbtxtimestampRange) -> Int { s.size }

pub fn db_tx_timestamp_range_get(s : DbtxtimestampRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_range_set(s : DbtxtimestampRange, i : Int, v : Double) -> DbtxtimestampRange {
  let result = db_tx_timestamp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_range_sum(s : DbtxtimestampRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_range_mean(s : DbtxtimestampRange) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_range_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_range_scale(s : DbtxtimestampRange, f : Double) -> DbtxtimestampRange {
  let result = db_tx_timestamp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_range_add(a : DbtxtimestampRange, b : DbtxtimestampRange) -> DbtxtimestampRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_range_copy(s : DbtxtimestampRange) -> DbtxtimestampRange {
  let result = db_tx_timestamp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_range_fill(s : DbtxtimestampRange, v : Double) -> DbtxtimestampRange {
  let result = db_tx_timestamp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_range_min(s : DbtxtimestampRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_range_max(s : DbtxtimestampRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_range_to_string(s : DbtxtimestampRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxtimestampSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_timestamp_slice_make(size : Int) -> DbtxtimestampSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_timestamp_slice_len(s : DbtxtimestampSlice) -> Int { s.size }

pub fn db_tx_timestamp_slice_get(s : DbtxtimestampSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_timestamp_slice_set(s : DbtxtimestampSlice, i : Int, v : Double) -> DbtxtimestampSlice {
  let result = db_tx_timestamp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_slice_sum(s : DbtxtimestampSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_timestamp_slice_mean(s : DbtxtimestampSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_timestamp_slice_sum(s) / s.size.to_double() }
}

pub fn db_tx_timestamp_slice_scale(s : DbtxtimestampSlice, f : Double) -> DbtxtimestampSlice {
  let result = db_tx_timestamp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_timestamp_slice_add(a : DbtxtimestampSlice, b : DbtxtimestampSlice) -> DbtxtimestampSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_timestamp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_timestamp_slice_copy(s : DbtxtimestampSlice) -> DbtxtimestampSlice {
  let result = db_tx_timestamp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_timestamp_slice_fill(s : DbtxtimestampSlice, v : Double) -> DbtxtimestampSlice {
  let result = db_tx_timestamp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_timestamp_slice_min(s : DbtxtimestampSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_slice_max(s : DbtxtimestampSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_timestamp_slice_to_string(s : DbtxtimestampSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_tx_timestamp_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_timestamp_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

