///===
/// extcore/db_tx_lock

pub(all) struct DbtxlockPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_lock_make_point(x : Double, y : Double) -> DbtxlockPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_lock_make_point3(x : Double, y : Double, z : Double) -> DbtxlockPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_lock_point_x(pt : DbtxlockPoint) -> Double { pt.x }

pub fn db_tx_lock_point_y(pt : DbtxlockPoint) -> Double { pt.y }

pub fn db_tx_lock_point_z(pt : DbtxlockPoint) -> Double { pt.z }

pub fn db_tx_lock_point_label(pt : DbtxlockPoint) -> Int { pt.label }

pub fn db_tx_lock_point_dist(a : DbtxlockPoint, b : DbtxlockPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_lock_point_add(a : DbtxlockPoint, b : DbtxlockPoint) -> DbtxlockPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_lock_point_sub(a : DbtxlockPoint, b : DbtxlockPoint) -> DbtxlockPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_lock_point_scale(pt : DbtxlockPoint, s : Double) -> DbtxlockPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_lock_point_dot(a : DbtxlockPoint, b : DbtxlockPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_lock_point_cross(a : DbtxlockPoint, b : DbtxlockPoint) -> DbtxlockPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_lock_point_norm(pt : DbtxlockPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_lock_point_normalize(pt : DbtxlockPoint) -> DbtxlockPoint {
  let n = db_tx_lock_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_lock_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_lock_point_negate(pt : DbtxlockPoint) -> DbtxlockPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_lock_point_mid(a : DbtxlockPoint, b : DbtxlockPoint) -> DbtxlockPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_lock_point_lerp(a : DbtxlockPoint, b : DbtxlockPoint, t : Double) -> DbtxlockPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_lock_point_to_string(pt : DbtxlockPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxlockSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_lock_make_series(vals : Array[Double], name : String) -> DbtxlockSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_lock_series_len(s : DbtxlockSeries) -> Int { s.vals.length() }

pub fn db_tx_lock_series_sum(s : DbtxlockSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_tx_lock_series_mean(s : DbtxlockSeries) -> Double {
  let n = db_tx_lock_series_len(s)
  if n == 0 { 0.0 } else { db_tx_lock_series_sum(s) / n.to_double() }
}

pub fn db_tx_lock_series_min(s : DbtxlockSeries) -> Double {
  let n = db_tx_lock_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_lock_series_max(s : DbtxlockSeries) -> Double {
  let n = db_tx_lock_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_lock_series_range(s : DbtxlockSeries) -> Double {
  db_tx_lock_series_max(s) - db_tx_lock_series_min(s)
}

pub fn db_tx_lock_series_var(s : DbtxlockSeries) -> Double {
  let n = db_tx_lock_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_tx_lock_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_tx_lock_series_std(s : DbtxlockSeries) -> Double { @_common.sqrt(db_tx_lock_series_var(s)) }

pub fn db_tx_lock_series_median(s : DbtxlockSeries) -> Double {
  let n = db_tx_lock_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_tx_lock_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_lock_series_scale(s : DbtxlockSeries, f : Double) -> DbtxlockSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_lock_series_add(a : DbtxlockSeries, b : DbtxlockSeries) -> DbtxlockSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_lock_series_sub(a : DbtxlockSeries, b : DbtxlockSeries) -> DbtxlockSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_lock_series_normalize(s : DbtxlockSeries) -> DbtxlockSeries {
  let mn = db_tx_lock_series_min(s)
  let mx = db_tx_lock_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_lock_series_cumsum(s : DbtxlockSeries) -> DbtxlockSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_lock_series_to_string(s : DbtxlockSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxlockMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_lock_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxlockMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_lock_matrix_identity(n : Int) -> DbtxlockMatrix {
  let m = db_tx_lock_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_lock_matrix_get(m : DbtxlockMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_lock_matrix_transpose(m : DbtxlockMatrix) -> DbtxlockMatrix {
  let result = db_tx_lock_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_lock_matrix_add(a : DbtxlockMatrix, b : DbtxlockMatrix) -> DbtxlockMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_lock_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_lock_matrix_scale(m : DbtxlockMatrix, s : Double) -> DbtxlockMatrix {
  let result = db_tx_lock_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_lock_matrix_multiply(a : DbtxlockMatrix, b : DbtxlockMatrix) -> DbtxlockMatrix {
  if a.cols != b.rows { return db_tx_lock_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_lock_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_lock_matrix_trace(m : DbtxlockMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_lock_matrix_det(m : DbtxlockMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_lock_matrix_norm(m : DbtxlockMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn db_tx_lock_matrix_to_string(m : DbtxlockMatrix) -> String {
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

pub(all) struct DbtxlockVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_lock_make_vector(comps : Array[Double]) -> DbtxlockVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_lock_vector_zero(dim : Int) -> DbtxlockVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_lock_vector_add(a : DbtxlockVector, b : DbtxlockVector) -> DbtxlockVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_lock_vector_sub(a : DbtxlockVector, b : DbtxlockVector) -> DbtxlockVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_lock_vector_scale(v : DbtxlockVector, s : Double) -> DbtxlockVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_lock_vector_dot(a : DbtxlockVector, b : DbtxlockVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_lock_vector_norm(v : DbtxlockVector) -> Double { @_common.sqrt(db_tx_lock_vector_dot(v, v)) }

pub fn db_tx_lock_vector_normalize(v : DbtxlockVector) -> DbtxlockVector {
  let n = db_tx_lock_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_lock_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_lock_vector_dist(a : DbtxlockVector, b : DbtxlockVector) -> Double {
  db_tx_lock_vector_norm(db_tx_lock_vector_sub(a, b))
}

pub fn db_tx_lock_vector_to_string(v : DbtxlockVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_lock_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_tx_lock_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_tx_lock_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_lock_std(data : Array[Double]) -> Double { @_common.sqrt(db_tx_lock_var(data)) }

pub fn db_tx_lock_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_tx_lock_mean(a); let mb = db_tx_lock_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_tx_lock_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_tx_lock_std(a); let sb = db_tx_lock_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_tx_lock_cov(a, b) / (sa * sb) }
}

pub fn db_tx_lock_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_tx_lock_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_lock_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_tx_lock_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_lock_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(db_tx_lock_mse(pred, labels))
}

pub fn db_tx_lock_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_tx_lock_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_tx_lock_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_tx_lock_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_tx_lock_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_tx_lock_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_tx_lock_precision(pred, labels, pos); let r = db_tx_lock_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_tx_lock_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_tx_lock_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_tx_lock_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_tx_lock_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_tx_lock_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_tx_lock_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_tx_lock_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_tx_lock_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_tx_lock_fibonacci(n : Int) -> Int {
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

pub fn db_tx_lock_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_tx_lock_min(data); let mx = db_tx_lock_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_tx_lock_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_tx_lock_mean(data); let sd = db_tx_lock_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_tx_lock_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_tx_lock_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_tx_lock_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_tx_lock_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_tx_lock_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_tx_lock_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DbtxlockFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_frame_make(size : Int) -> DbtxlockFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_frame_len(s : DbtxlockFrame) -> Int { s.size }

pub fn db_tx_lock_frame_get(s : DbtxlockFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_frame_set(s : DbtxlockFrame, i : Int, v : Double) -> DbtxlockFrame {
  let result = db_tx_lock_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_frame_sum(s : DbtxlockFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_frame_mean(s : DbtxlockFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_frame_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_frame_scale(s : DbtxlockFrame, f : Double) -> DbtxlockFrame {
  let result = db_tx_lock_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_frame_add(a : DbtxlockFrame, b : DbtxlockFrame) -> DbtxlockFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_frame_copy(s : DbtxlockFrame) -> DbtxlockFrame {
  let result = db_tx_lock_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_frame_fill(s : DbtxlockFrame, v : Double) -> DbtxlockFrame {
  let result = db_tx_lock_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_frame_min(s : DbtxlockFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_frame_max(s : DbtxlockFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_frame_to_string(s : DbtxlockFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_table_make(size : Int) -> DbtxlockTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_table_len(s : DbtxlockTable) -> Int { s.size }

pub fn db_tx_lock_table_get(s : DbtxlockTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_table_set(s : DbtxlockTable, i : Int, v : Double) -> DbtxlockTable {
  let result = db_tx_lock_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_table_sum(s : DbtxlockTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_table_mean(s : DbtxlockTable) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_table_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_table_scale(s : DbtxlockTable, f : Double) -> DbtxlockTable {
  let result = db_tx_lock_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_table_add(a : DbtxlockTable, b : DbtxlockTable) -> DbtxlockTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_table_copy(s : DbtxlockTable) -> DbtxlockTable {
  let result = db_tx_lock_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_table_fill(s : DbtxlockTable, v : Double) -> DbtxlockTable {
  let result = db_tx_lock_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_table_min(s : DbtxlockTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_table_max(s : DbtxlockTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_table_to_string(s : DbtxlockTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_graphn_make(size : Int) -> DbtxlockGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_graphn_len(s : DbtxlockGraphN) -> Int { s.size }

pub fn db_tx_lock_graphn_get(s : DbtxlockGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_graphn_set(s : DbtxlockGraphN, i : Int, v : Double) -> DbtxlockGraphN {
  let result = db_tx_lock_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_graphn_sum(s : DbtxlockGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_graphn_mean(s : DbtxlockGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_graphn_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_graphn_scale(s : DbtxlockGraphN, f : Double) -> DbtxlockGraphN {
  let result = db_tx_lock_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_graphn_add(a : DbtxlockGraphN, b : DbtxlockGraphN) -> DbtxlockGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_graphn_copy(s : DbtxlockGraphN) -> DbtxlockGraphN {
  let result = db_tx_lock_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_graphn_fill(s : DbtxlockGraphN, v : Double) -> DbtxlockGraphN {
  let result = db_tx_lock_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_graphn_min(s : DbtxlockGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_graphn_max(s : DbtxlockGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_graphn_to_string(s : DbtxlockGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_node_make(size : Int) -> DbtxlockNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_node_len(s : DbtxlockNode) -> Int { s.size }

pub fn db_tx_lock_node_get(s : DbtxlockNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_node_set(s : DbtxlockNode, i : Int, v : Double) -> DbtxlockNode {
  let result = db_tx_lock_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_node_sum(s : DbtxlockNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_node_mean(s : DbtxlockNode) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_node_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_node_scale(s : DbtxlockNode, f : Double) -> DbtxlockNode {
  let result = db_tx_lock_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_node_add(a : DbtxlockNode, b : DbtxlockNode) -> DbtxlockNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_node_copy(s : DbtxlockNode) -> DbtxlockNode {
  let result = db_tx_lock_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_node_fill(s : DbtxlockNode, v : Double) -> DbtxlockNode {
  let result = db_tx_lock_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_node_min(s : DbtxlockNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_node_max(s : DbtxlockNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_node_to_string(s : DbtxlockNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_edge_make(size : Int) -> DbtxlockEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_edge_len(s : DbtxlockEdge) -> Int { s.size }

pub fn db_tx_lock_edge_get(s : DbtxlockEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_edge_set(s : DbtxlockEdge, i : Int, v : Double) -> DbtxlockEdge {
  let result = db_tx_lock_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_edge_sum(s : DbtxlockEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_edge_mean(s : DbtxlockEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_edge_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_edge_scale(s : DbtxlockEdge, f : Double) -> DbtxlockEdge {
  let result = db_tx_lock_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_edge_add(a : DbtxlockEdge, b : DbtxlockEdge) -> DbtxlockEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_edge_copy(s : DbtxlockEdge) -> DbtxlockEdge {
  let result = db_tx_lock_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_edge_fill(s : DbtxlockEdge, v : Double) -> DbtxlockEdge {
  let result = db_tx_lock_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_edge_min(s : DbtxlockEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_edge_max(s : DbtxlockEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_edge_to_string(s : DbtxlockEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_path_make(size : Int) -> DbtxlockPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_path_len(s : DbtxlockPath) -> Int { s.size }

pub fn db_tx_lock_path_get(s : DbtxlockPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_path_set(s : DbtxlockPath, i : Int, v : Double) -> DbtxlockPath {
  let result = db_tx_lock_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_path_sum(s : DbtxlockPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_path_mean(s : DbtxlockPath) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_path_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_path_scale(s : DbtxlockPath, f : Double) -> DbtxlockPath {
  let result = db_tx_lock_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_path_add(a : DbtxlockPath, b : DbtxlockPath) -> DbtxlockPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_path_copy(s : DbtxlockPath) -> DbtxlockPath {
  let result = db_tx_lock_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_path_fill(s : DbtxlockPath, v : Double) -> DbtxlockPath {
  let result = db_tx_lock_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_path_min(s : DbtxlockPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_path_max(s : DbtxlockPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_path_to_string(s : DbtxlockPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_cluster_make(size : Int) -> DbtxlockCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_cluster_len(s : DbtxlockCluster) -> Int { s.size }

pub fn db_tx_lock_cluster_get(s : DbtxlockCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_cluster_set(s : DbtxlockCluster, i : Int, v : Double) -> DbtxlockCluster {
  let result = db_tx_lock_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_cluster_sum(s : DbtxlockCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_cluster_mean(s : DbtxlockCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_cluster_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_cluster_scale(s : DbtxlockCluster, f : Double) -> DbtxlockCluster {
  let result = db_tx_lock_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_cluster_add(a : DbtxlockCluster, b : DbtxlockCluster) -> DbtxlockCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_cluster_copy(s : DbtxlockCluster) -> DbtxlockCluster {
  let result = db_tx_lock_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_cluster_fill(s : DbtxlockCluster, v : Double) -> DbtxlockCluster {
  let result = db_tx_lock_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_cluster_min(s : DbtxlockCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_cluster_max(s : DbtxlockCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_cluster_to_string(s : DbtxlockCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_model_make(size : Int) -> DbtxlockModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_model_len(s : DbtxlockModel) -> Int { s.size }

pub fn db_tx_lock_model_get(s : DbtxlockModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_model_set(s : DbtxlockModel, i : Int, v : Double) -> DbtxlockModel {
  let result = db_tx_lock_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_model_sum(s : DbtxlockModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_model_mean(s : DbtxlockModel) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_model_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_model_scale(s : DbtxlockModel, f : Double) -> DbtxlockModel {
  let result = db_tx_lock_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_model_add(a : DbtxlockModel, b : DbtxlockModel) -> DbtxlockModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_model_copy(s : DbtxlockModel) -> DbtxlockModel {
  let result = db_tx_lock_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_model_fill(s : DbtxlockModel, v : Double) -> DbtxlockModel {
  let result = db_tx_lock_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_model_min(s : DbtxlockModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_model_max(s : DbtxlockModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_model_to_string(s : DbtxlockModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_layer_make(size : Int) -> DbtxlockLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_layer_len(s : DbtxlockLayer) -> Int { s.size }

pub fn db_tx_lock_layer_get(s : DbtxlockLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_layer_set(s : DbtxlockLayer, i : Int, v : Double) -> DbtxlockLayer {
  let result = db_tx_lock_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_layer_sum(s : DbtxlockLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_layer_mean(s : DbtxlockLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_layer_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_layer_scale(s : DbtxlockLayer, f : Double) -> DbtxlockLayer {
  let result = db_tx_lock_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_layer_add(a : DbtxlockLayer, b : DbtxlockLayer) -> DbtxlockLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_layer_copy(s : DbtxlockLayer) -> DbtxlockLayer {
  let result = db_tx_lock_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_layer_fill(s : DbtxlockLayer, v : Double) -> DbtxlockLayer {
  let result = db_tx_lock_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_layer_min(s : DbtxlockLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_layer_max(s : DbtxlockLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_layer_to_string(s : DbtxlockLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_buffer_make(size : Int) -> DbtxlockBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_buffer_len(s : DbtxlockBuffer) -> Int { s.size }

pub fn db_tx_lock_buffer_get(s : DbtxlockBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_buffer_set(s : DbtxlockBuffer, i : Int, v : Double) -> DbtxlockBuffer {
  let result = db_tx_lock_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_buffer_sum(s : DbtxlockBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_buffer_mean(s : DbtxlockBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_buffer_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_buffer_scale(s : DbtxlockBuffer, f : Double) -> DbtxlockBuffer {
  let result = db_tx_lock_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_buffer_add(a : DbtxlockBuffer, b : DbtxlockBuffer) -> DbtxlockBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_buffer_copy(s : DbtxlockBuffer) -> DbtxlockBuffer {
  let result = db_tx_lock_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_buffer_fill(s : DbtxlockBuffer, v : Double) -> DbtxlockBuffer {
  let result = db_tx_lock_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_buffer_min(s : DbtxlockBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_buffer_max(s : DbtxlockBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_buffer_to_string(s : DbtxlockBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_cursor_make(size : Int) -> DbtxlockCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_cursor_len(s : DbtxlockCursor) -> Int { s.size }

pub fn db_tx_lock_cursor_get(s : DbtxlockCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_cursor_set(s : DbtxlockCursor, i : Int, v : Double) -> DbtxlockCursor {
  let result = db_tx_lock_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_cursor_sum(s : DbtxlockCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_cursor_mean(s : DbtxlockCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_cursor_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_cursor_scale(s : DbtxlockCursor, f : Double) -> DbtxlockCursor {
  let result = db_tx_lock_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_cursor_add(a : DbtxlockCursor, b : DbtxlockCursor) -> DbtxlockCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_cursor_copy(s : DbtxlockCursor) -> DbtxlockCursor {
  let result = db_tx_lock_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_cursor_fill(s : DbtxlockCursor, v : Double) -> DbtxlockCursor {
  let result = db_tx_lock_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_cursor_min(s : DbtxlockCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_cursor_max(s : DbtxlockCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_cursor_to_string(s : DbtxlockCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_view_make(size : Int) -> DbtxlockView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_view_len(s : DbtxlockView) -> Int { s.size }

pub fn db_tx_lock_view_get(s : DbtxlockView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_view_set(s : DbtxlockView, i : Int, v : Double) -> DbtxlockView {
  let result = db_tx_lock_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_view_sum(s : DbtxlockView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_view_mean(s : DbtxlockView) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_view_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_view_scale(s : DbtxlockView, f : Double) -> DbtxlockView {
  let result = db_tx_lock_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_view_add(a : DbtxlockView, b : DbtxlockView) -> DbtxlockView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_view_copy(s : DbtxlockView) -> DbtxlockView {
  let result = db_tx_lock_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_view_fill(s : DbtxlockView, v : Double) -> DbtxlockView {
  let result = db_tx_lock_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_view_min(s : DbtxlockView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_view_max(s : DbtxlockView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_view_to_string(s : DbtxlockView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_range_make(size : Int) -> DbtxlockRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_range_len(s : DbtxlockRange) -> Int { s.size }

pub fn db_tx_lock_range_get(s : DbtxlockRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_range_set(s : DbtxlockRange, i : Int, v : Double) -> DbtxlockRange {
  let result = db_tx_lock_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_range_sum(s : DbtxlockRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_range_mean(s : DbtxlockRange) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_range_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_range_scale(s : DbtxlockRange, f : Double) -> DbtxlockRange {
  let result = db_tx_lock_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_range_add(a : DbtxlockRange, b : DbtxlockRange) -> DbtxlockRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_range_copy(s : DbtxlockRange) -> DbtxlockRange {
  let result = db_tx_lock_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_range_fill(s : DbtxlockRange, v : Double) -> DbtxlockRange {
  let result = db_tx_lock_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_range_min(s : DbtxlockRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_range_max(s : DbtxlockRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_range_to_string(s : DbtxlockRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxlockSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_lock_slice_make(size : Int) -> DbtxlockSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_lock_slice_len(s : DbtxlockSlice) -> Int { s.size }

pub fn db_tx_lock_slice_get(s : DbtxlockSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_lock_slice_set(s : DbtxlockSlice, i : Int, v : Double) -> DbtxlockSlice {
  let result = db_tx_lock_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_slice_sum(s : DbtxlockSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_lock_slice_mean(s : DbtxlockSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_lock_slice_sum(s) / s.size.to_double() }
}

pub fn db_tx_lock_slice_scale(s : DbtxlockSlice, f : Double) -> DbtxlockSlice {
  let result = db_tx_lock_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_lock_slice_add(a : DbtxlockSlice, b : DbtxlockSlice) -> DbtxlockSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_lock_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_lock_slice_copy(s : DbtxlockSlice) -> DbtxlockSlice {
  let result = db_tx_lock_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_lock_slice_fill(s : DbtxlockSlice, v : Double) -> DbtxlockSlice {
  let result = db_tx_lock_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_lock_slice_min(s : DbtxlockSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_slice_max(s : DbtxlockSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_lock_slice_to_string(s : DbtxlockSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

