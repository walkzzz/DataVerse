///===
/// extcore/db_tx_acid

pub(all) struct DbtxacidPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_tx_acid_make_point(x : Double, y : Double) -> DbtxacidPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_tx_acid_make_point3(x : Double, y : Double, z : Double) -> DbtxacidPoint {
  { x, y, z, label: 0 }
}

pub fn db_tx_acid_point_x(pt : DbtxacidPoint) -> Double { pt.x }

pub fn db_tx_acid_point_y(pt : DbtxacidPoint) -> Double { pt.y }

pub fn db_tx_acid_point_z(pt : DbtxacidPoint) -> Double { pt.z }

pub fn db_tx_acid_point_label(pt : DbtxacidPoint) -> Int { pt.label }

pub fn db_tx_acid_point_dist(a : DbtxacidPoint, b : DbtxacidPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_tx_acid_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_tx_acid_point_add(a : DbtxacidPoint, b : DbtxacidPoint) -> DbtxacidPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_tx_acid_point_sub(a : DbtxacidPoint, b : DbtxacidPoint) -> DbtxacidPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_tx_acid_point_scale(pt : DbtxacidPoint, s : Double) -> DbtxacidPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_tx_acid_point_dot(a : DbtxacidPoint, b : DbtxacidPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_tx_acid_point_cross(a : DbtxacidPoint, b : DbtxacidPoint) -> DbtxacidPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_tx_acid_point_norm(pt : DbtxacidPoint) -> Double {
  db_tx_acid_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_tx_acid_point_normalize(pt : DbtxacidPoint) -> DbtxacidPoint {
  let n = db_tx_acid_point_norm(pt)
  if n < 0.0000001 { pt } else { db_tx_acid_point_scale(pt, 1.0 / n) }
}

pub fn db_tx_acid_point_negate(pt : DbtxacidPoint) -> DbtxacidPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_tx_acid_point_mid(a : DbtxacidPoint, b : DbtxacidPoint) -> DbtxacidPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_tx_acid_point_lerp(a : DbtxacidPoint, b : DbtxacidPoint, t : Double) -> DbtxacidPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_tx_acid_point_to_string(pt : DbtxacidPoint) -> String {
  "(" + db_tx_acid_dbl(pt.x) + ", " + db_tx_acid_dbl(pt.y) + ", " + db_tx_acid_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbtxacidSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_tx_acid_make_series(vals : Array[Double], name : String) -> DbtxacidSeries {
  { vals, name, meta: 0 }
}

pub fn db_tx_acid_series_len(s : DbtxacidSeries) -> Int { s.vals.length() }

pub fn db_tx_acid_series_sum(s : DbtxacidSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_tx_acid_series_mean(s : DbtxacidSeries) -> Double {
  let n = db_tx_acid_series_len(s)
  if n == 0 { 0.0 } else { db_tx_acid_series_sum(s) / n.to_double() }
}

pub fn db_tx_acid_series_min(s : DbtxacidSeries) -> Double {
  let n = db_tx_acid_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_acid_series_max(s : DbtxacidSeries) -> Double {
  let n = db_tx_acid_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_tx_acid_series_range(s : DbtxacidSeries) -> Double {
  db_tx_acid_series_max(s) - db_tx_acid_series_min(s)
}

pub fn db_tx_acid_series_var(s : DbtxacidSeries) -> Double {
  let n = db_tx_acid_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_tx_acid_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_tx_acid_series_std(s : DbtxacidSeries) -> Double { db_tx_acid_sqrt(db_tx_acid_series_var(s)) }

pub fn db_tx_acid_series_median(s : DbtxacidSeries) -> Double {
  let n = db_tx_acid_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_tx_acid_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_acid_series_scale(s : DbtxacidSeries, f : Double) -> DbtxacidSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_tx_acid_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_tx_acid_series_add(a : DbtxacidSeries, b : DbtxacidSeries) -> DbtxacidSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_acid_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_tx_acid_series_sub(a : DbtxacidSeries, b : DbtxacidSeries) -> DbtxacidSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_tx_acid_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_tx_acid_series_normalize(s : DbtxacidSeries) -> DbtxacidSeries {
  let mn = db_tx_acid_series_min(s)
  let mx = db_tx_acid_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_tx_acid_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_tx_acid_series_cumsum(s : DbtxacidSeries) -> DbtxacidSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_tx_acid_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_tx_acid_series_to_string(s : DbtxacidSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_acid_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbtxacidMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_tx_acid_make_matrix(rows : Int, cols : Int, val : Double) -> DbtxacidMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_tx_acid_matrix_identity(n : Int) -> DbtxacidMatrix {
  let m = db_tx_acid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_tx_acid_matrix_get(m : DbtxacidMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_tx_acid_matrix_transpose(m : DbtxacidMatrix) -> DbtxacidMatrix {
  let result = db_tx_acid_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_tx_acid_matrix_add(a : DbtxacidMatrix, b : DbtxacidMatrix) -> DbtxacidMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_tx_acid_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_tx_acid_matrix_scale(m : DbtxacidMatrix, s : Double) -> DbtxacidMatrix {
  let result = db_tx_acid_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_tx_acid_matrix_multiply(a : DbtxacidMatrix, b : DbtxacidMatrix) -> DbtxacidMatrix {
  if a.cols != b.rows { return db_tx_acid_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_tx_acid_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_tx_acid_matrix_trace(m : DbtxacidMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_tx_acid_matrix_det(m : DbtxacidMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_tx_acid_matrix_norm(m : DbtxacidMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_tx_acid_sqrt(sum)
}

pub fn db_tx_acid_matrix_to_string(m : DbtxacidMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_tx_acid_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbtxacidVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_tx_acid_make_vector(comps : Array[Double]) -> DbtxacidVector {
  { comps, dim: comps.length() }
}

pub fn db_tx_acid_vector_zero(dim : Int) -> DbtxacidVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_tx_acid_vector_add(a : DbtxacidVector, b : DbtxacidVector) -> DbtxacidVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_acid_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_acid_vector_sub(a : DbtxacidVector, b : DbtxacidVector) -> DbtxacidVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_tx_acid_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_tx_acid_vector_scale(v : DbtxacidVector, s : Double) -> DbtxacidVector {
  let mut result = []
  for i in 0..<v.dim { result = db_tx_acid_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_tx_acid_vector_dot(a : DbtxacidVector, b : DbtxacidVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_tx_acid_vector_norm(v : DbtxacidVector) -> Double { db_tx_acid_sqrt(db_tx_acid_vector_dot(v, v)) }

pub fn db_tx_acid_vector_normalize(v : DbtxacidVector) -> DbtxacidVector {
  let n = db_tx_acid_vector_norm(v)
  if n < 0.0000001 { v } else { db_tx_acid_vector_scale(v, 1.0 / n) }
}

pub fn db_tx_acid_vector_dist(a : DbtxacidVector, b : DbtxacidVector) -> Double {
  db_tx_acid_vector_norm(db_tx_acid_vector_sub(a, b))
}

pub fn db_tx_acid_vector_to_string(v : DbtxacidVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_tx_acid_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_tx_acid_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_tx_acid_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_tx_acid_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_acid_std(data : Array[Double]) -> Double { db_tx_acid_sqrt(db_tx_acid_var(data)) }

pub fn db_tx_acid_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_tx_acid_mean(a); let mb = db_tx_acid_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_tx_acid_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_tx_acid_std(a); let sb = db_tx_acid_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_tx_acid_cov(a, b) / (sa * sb) }
}

pub fn db_tx_acid_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_tx_acid_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_tx_acid_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_tx_acid_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_tx_acid_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_tx_acid_sqrt(db_tx_acid_mse(pred, labels))
}

pub fn db_tx_acid_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_tx_acid_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_tx_acid_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_tx_acid_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_tx_acid_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_tx_acid_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_tx_acid_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_tx_acid_precision(pred, labels, pos); let r = db_tx_acid_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_tx_acid_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_tx_acid_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_tx_acid_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_tx_acid_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_tx_acid_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_tx_acid_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_tx_acid_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_tx_acid_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_tx_acid_fibonacci(n : Int) -> Int {
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

pub fn db_tx_acid_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_tx_acid_min(data); let mx = db_tx_acid_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_tx_acid_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_tx_acid_mean(data); let sd = db_tx_acid_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_tx_acid_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_tx_acid_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_tx_acid_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_tx_acid_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_tx_acid_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_tx_acid_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_tx_acid_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_tx_acid_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_tx_acid_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_tx_acid_int(x) } else { -db_tx_acid_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_tx_acid_int(f * 1000000.0) } else { db_tx_acid_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_tx_acid_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_tx_acid_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbtxacidFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_frame_make(size : Int) -> DbtxacidFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_frame_len(s : DbtxacidFrame) -> Int { s.size }

pub fn db_tx_acid_frame_get(s : DbtxacidFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_frame_set(s : DbtxacidFrame, i : Int, v : Double) -> DbtxacidFrame {
  let result = db_tx_acid_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_frame_sum(s : DbtxacidFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_frame_mean(s : DbtxacidFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_frame_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_frame_scale(s : DbtxacidFrame, f : Double) -> DbtxacidFrame {
  let result = db_tx_acid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_frame_add(a : DbtxacidFrame, b : DbtxacidFrame) -> DbtxacidFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_frame_copy(s : DbtxacidFrame) -> DbtxacidFrame {
  let result = db_tx_acid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_frame_fill(s : DbtxacidFrame, v : Double) -> DbtxacidFrame {
  let result = db_tx_acid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_frame_min(s : DbtxacidFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_frame_max(s : DbtxacidFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_frame_to_string(s : DbtxacidFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_table_make(size : Int) -> DbtxacidTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_table_len(s : DbtxacidTable) -> Int { s.size }

pub fn db_tx_acid_table_get(s : DbtxacidTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_table_set(s : DbtxacidTable, i : Int, v : Double) -> DbtxacidTable {
  let result = db_tx_acid_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_table_sum(s : DbtxacidTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_table_mean(s : DbtxacidTable) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_table_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_table_scale(s : DbtxacidTable, f : Double) -> DbtxacidTable {
  let result = db_tx_acid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_table_add(a : DbtxacidTable, b : DbtxacidTable) -> DbtxacidTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_table_copy(s : DbtxacidTable) -> DbtxacidTable {
  let result = db_tx_acid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_table_fill(s : DbtxacidTable, v : Double) -> DbtxacidTable {
  let result = db_tx_acid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_table_min(s : DbtxacidTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_table_max(s : DbtxacidTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_table_to_string(s : DbtxacidTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_graphn_make(size : Int) -> DbtxacidGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_graphn_len(s : DbtxacidGraphN) -> Int { s.size }

pub fn db_tx_acid_graphn_get(s : DbtxacidGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_graphn_set(s : DbtxacidGraphN, i : Int, v : Double) -> DbtxacidGraphN {
  let result = db_tx_acid_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_graphn_sum(s : DbtxacidGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_graphn_mean(s : DbtxacidGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_graphn_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_graphn_scale(s : DbtxacidGraphN, f : Double) -> DbtxacidGraphN {
  let result = db_tx_acid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_graphn_add(a : DbtxacidGraphN, b : DbtxacidGraphN) -> DbtxacidGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_graphn_copy(s : DbtxacidGraphN) -> DbtxacidGraphN {
  let result = db_tx_acid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_graphn_fill(s : DbtxacidGraphN, v : Double) -> DbtxacidGraphN {
  let result = db_tx_acid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_graphn_min(s : DbtxacidGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_graphn_max(s : DbtxacidGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_graphn_to_string(s : DbtxacidGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_node_make(size : Int) -> DbtxacidNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_node_len(s : DbtxacidNode) -> Int { s.size }

pub fn db_tx_acid_node_get(s : DbtxacidNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_node_set(s : DbtxacidNode, i : Int, v : Double) -> DbtxacidNode {
  let result = db_tx_acid_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_node_sum(s : DbtxacidNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_node_mean(s : DbtxacidNode) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_node_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_node_scale(s : DbtxacidNode, f : Double) -> DbtxacidNode {
  let result = db_tx_acid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_node_add(a : DbtxacidNode, b : DbtxacidNode) -> DbtxacidNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_node_copy(s : DbtxacidNode) -> DbtxacidNode {
  let result = db_tx_acid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_node_fill(s : DbtxacidNode, v : Double) -> DbtxacidNode {
  let result = db_tx_acid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_node_min(s : DbtxacidNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_node_max(s : DbtxacidNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_node_to_string(s : DbtxacidNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_edge_make(size : Int) -> DbtxacidEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_edge_len(s : DbtxacidEdge) -> Int { s.size }

pub fn db_tx_acid_edge_get(s : DbtxacidEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_edge_set(s : DbtxacidEdge, i : Int, v : Double) -> DbtxacidEdge {
  let result = db_tx_acid_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_edge_sum(s : DbtxacidEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_edge_mean(s : DbtxacidEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_edge_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_edge_scale(s : DbtxacidEdge, f : Double) -> DbtxacidEdge {
  let result = db_tx_acid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_edge_add(a : DbtxacidEdge, b : DbtxacidEdge) -> DbtxacidEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_edge_copy(s : DbtxacidEdge) -> DbtxacidEdge {
  let result = db_tx_acid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_edge_fill(s : DbtxacidEdge, v : Double) -> DbtxacidEdge {
  let result = db_tx_acid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_edge_min(s : DbtxacidEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_edge_max(s : DbtxacidEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_edge_to_string(s : DbtxacidEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_path_make(size : Int) -> DbtxacidPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_path_len(s : DbtxacidPath) -> Int { s.size }

pub fn db_tx_acid_path_get(s : DbtxacidPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_path_set(s : DbtxacidPath, i : Int, v : Double) -> DbtxacidPath {
  let result = db_tx_acid_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_path_sum(s : DbtxacidPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_path_mean(s : DbtxacidPath) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_path_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_path_scale(s : DbtxacidPath, f : Double) -> DbtxacidPath {
  let result = db_tx_acid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_path_add(a : DbtxacidPath, b : DbtxacidPath) -> DbtxacidPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_path_copy(s : DbtxacidPath) -> DbtxacidPath {
  let result = db_tx_acid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_path_fill(s : DbtxacidPath, v : Double) -> DbtxacidPath {
  let result = db_tx_acid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_path_min(s : DbtxacidPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_path_max(s : DbtxacidPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_path_to_string(s : DbtxacidPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_cluster_make(size : Int) -> DbtxacidCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_cluster_len(s : DbtxacidCluster) -> Int { s.size }

pub fn db_tx_acid_cluster_get(s : DbtxacidCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_cluster_set(s : DbtxacidCluster, i : Int, v : Double) -> DbtxacidCluster {
  let result = db_tx_acid_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_cluster_sum(s : DbtxacidCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_cluster_mean(s : DbtxacidCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_cluster_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_cluster_scale(s : DbtxacidCluster, f : Double) -> DbtxacidCluster {
  let result = db_tx_acid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_cluster_add(a : DbtxacidCluster, b : DbtxacidCluster) -> DbtxacidCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_cluster_copy(s : DbtxacidCluster) -> DbtxacidCluster {
  let result = db_tx_acid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_cluster_fill(s : DbtxacidCluster, v : Double) -> DbtxacidCluster {
  let result = db_tx_acid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_cluster_min(s : DbtxacidCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_cluster_max(s : DbtxacidCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_cluster_to_string(s : DbtxacidCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_model_make(size : Int) -> DbtxacidModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_model_len(s : DbtxacidModel) -> Int { s.size }

pub fn db_tx_acid_model_get(s : DbtxacidModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_model_set(s : DbtxacidModel, i : Int, v : Double) -> DbtxacidModel {
  let result = db_tx_acid_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_model_sum(s : DbtxacidModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_model_mean(s : DbtxacidModel) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_model_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_model_scale(s : DbtxacidModel, f : Double) -> DbtxacidModel {
  let result = db_tx_acid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_model_add(a : DbtxacidModel, b : DbtxacidModel) -> DbtxacidModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_model_copy(s : DbtxacidModel) -> DbtxacidModel {
  let result = db_tx_acid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_model_fill(s : DbtxacidModel, v : Double) -> DbtxacidModel {
  let result = db_tx_acid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_model_min(s : DbtxacidModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_model_max(s : DbtxacidModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_model_to_string(s : DbtxacidModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_layer_make(size : Int) -> DbtxacidLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_layer_len(s : DbtxacidLayer) -> Int { s.size }

pub fn db_tx_acid_layer_get(s : DbtxacidLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_layer_set(s : DbtxacidLayer, i : Int, v : Double) -> DbtxacidLayer {
  let result = db_tx_acid_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_layer_sum(s : DbtxacidLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_layer_mean(s : DbtxacidLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_layer_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_layer_scale(s : DbtxacidLayer, f : Double) -> DbtxacidLayer {
  let result = db_tx_acid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_layer_add(a : DbtxacidLayer, b : DbtxacidLayer) -> DbtxacidLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_layer_copy(s : DbtxacidLayer) -> DbtxacidLayer {
  let result = db_tx_acid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_layer_fill(s : DbtxacidLayer, v : Double) -> DbtxacidLayer {
  let result = db_tx_acid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_layer_min(s : DbtxacidLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_layer_max(s : DbtxacidLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_layer_to_string(s : DbtxacidLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_buffer_make(size : Int) -> DbtxacidBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_buffer_len(s : DbtxacidBuffer) -> Int { s.size }

pub fn db_tx_acid_buffer_get(s : DbtxacidBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_buffer_set(s : DbtxacidBuffer, i : Int, v : Double) -> DbtxacidBuffer {
  let result = db_tx_acid_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_buffer_sum(s : DbtxacidBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_buffer_mean(s : DbtxacidBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_buffer_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_buffer_scale(s : DbtxacidBuffer, f : Double) -> DbtxacidBuffer {
  let result = db_tx_acid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_buffer_add(a : DbtxacidBuffer, b : DbtxacidBuffer) -> DbtxacidBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_buffer_copy(s : DbtxacidBuffer) -> DbtxacidBuffer {
  let result = db_tx_acid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_buffer_fill(s : DbtxacidBuffer, v : Double) -> DbtxacidBuffer {
  let result = db_tx_acid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_buffer_min(s : DbtxacidBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_buffer_max(s : DbtxacidBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_buffer_to_string(s : DbtxacidBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_cursor_make(size : Int) -> DbtxacidCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_cursor_len(s : DbtxacidCursor) -> Int { s.size }

pub fn db_tx_acid_cursor_get(s : DbtxacidCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_cursor_set(s : DbtxacidCursor, i : Int, v : Double) -> DbtxacidCursor {
  let result = db_tx_acid_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_cursor_sum(s : DbtxacidCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_cursor_mean(s : DbtxacidCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_cursor_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_cursor_scale(s : DbtxacidCursor, f : Double) -> DbtxacidCursor {
  let result = db_tx_acid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_cursor_add(a : DbtxacidCursor, b : DbtxacidCursor) -> DbtxacidCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_cursor_copy(s : DbtxacidCursor) -> DbtxacidCursor {
  let result = db_tx_acid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_cursor_fill(s : DbtxacidCursor, v : Double) -> DbtxacidCursor {
  let result = db_tx_acid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_cursor_min(s : DbtxacidCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_cursor_max(s : DbtxacidCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_cursor_to_string(s : DbtxacidCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_view_make(size : Int) -> DbtxacidView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_view_len(s : DbtxacidView) -> Int { s.size }

pub fn db_tx_acid_view_get(s : DbtxacidView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_view_set(s : DbtxacidView, i : Int, v : Double) -> DbtxacidView {
  let result = db_tx_acid_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_view_sum(s : DbtxacidView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_view_mean(s : DbtxacidView) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_view_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_view_scale(s : DbtxacidView, f : Double) -> DbtxacidView {
  let result = db_tx_acid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_view_add(a : DbtxacidView, b : DbtxacidView) -> DbtxacidView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_view_copy(s : DbtxacidView) -> DbtxacidView {
  let result = db_tx_acid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_view_fill(s : DbtxacidView, v : Double) -> DbtxacidView {
  let result = db_tx_acid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_view_min(s : DbtxacidView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_view_max(s : DbtxacidView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_view_to_string(s : DbtxacidView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_range_make(size : Int) -> DbtxacidRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_range_len(s : DbtxacidRange) -> Int { s.size }

pub fn db_tx_acid_range_get(s : DbtxacidRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_range_set(s : DbtxacidRange, i : Int, v : Double) -> DbtxacidRange {
  let result = db_tx_acid_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_range_sum(s : DbtxacidRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_range_mean(s : DbtxacidRange) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_range_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_range_scale(s : DbtxacidRange, f : Double) -> DbtxacidRange {
  let result = db_tx_acid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_range_add(a : DbtxacidRange, b : DbtxacidRange) -> DbtxacidRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_range_copy(s : DbtxacidRange) -> DbtxacidRange {
  let result = db_tx_acid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_range_fill(s : DbtxacidRange, v : Double) -> DbtxacidRange {
  let result = db_tx_acid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_range_min(s : DbtxacidRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_range_max(s : DbtxacidRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_range_to_string(s : DbtxacidRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbtxacidSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_tx_acid_slice_make(size : Int) -> DbtxacidSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_tx_acid_slice_len(s : DbtxacidSlice) -> Int { s.size }

pub fn db_tx_acid_slice_get(s : DbtxacidSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_tx_acid_slice_set(s : DbtxacidSlice, i : Int, v : Double) -> DbtxacidSlice {
  let result = db_tx_acid_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_slice_sum(s : DbtxacidSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_tx_acid_slice_mean(s : DbtxacidSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_tx_acid_slice_sum(s) / s.size.to_double() }
}

pub fn db_tx_acid_slice_scale(s : DbtxacidSlice, f : Double) -> DbtxacidSlice {
  let result = db_tx_acid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_tx_acid_slice_add(a : DbtxacidSlice, b : DbtxacidSlice) -> DbtxacidSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_tx_acid_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_tx_acid_slice_copy(s : DbtxacidSlice) -> DbtxacidSlice {
  let result = db_tx_acid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_tx_acid_slice_fill(s : DbtxacidSlice, v : Double) -> DbtxacidSlice {
  let result = db_tx_acid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_tx_acid_slice_min(s : DbtxacidSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_slice_max(s : DbtxacidSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_tx_acid_slice_to_string(s : DbtxacidSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_tx_acid_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_tx_acid_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

