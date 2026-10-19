///===
/// extcore/db_store_kv

pub(all) struct DbstorekvPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_store_kv_make_point(x : Double, y : Double) -> DbstorekvPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_store_kv_make_point3(x : Double, y : Double, z : Double) -> DbstorekvPoint {
  { x, y, z, label: 0 }
}

pub fn db_store_kv_point_x(pt : DbstorekvPoint) -> Double { pt.x }

pub fn db_store_kv_point_y(pt : DbstorekvPoint) -> Double { pt.y }

pub fn db_store_kv_point_z(pt : DbstorekvPoint) -> Double { pt.z }

pub fn db_store_kv_point_label(pt : DbstorekvPoint) -> Int { pt.label }

pub fn db_store_kv_point_dist(a : DbstorekvPoint, b : DbstorekvPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_store_kv_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_store_kv_point_add(a : DbstorekvPoint, b : DbstorekvPoint) -> DbstorekvPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_store_kv_point_sub(a : DbstorekvPoint, b : DbstorekvPoint) -> DbstorekvPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_store_kv_point_scale(pt : DbstorekvPoint, s : Double) -> DbstorekvPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_store_kv_point_dot(a : DbstorekvPoint, b : DbstorekvPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_store_kv_point_cross(a : DbstorekvPoint, b : DbstorekvPoint) -> DbstorekvPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_store_kv_point_norm(pt : DbstorekvPoint) -> Double {
  db_store_kv_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_store_kv_point_normalize(pt : DbstorekvPoint) -> DbstorekvPoint {
  let n = db_store_kv_point_norm(pt)
  if n < 0.0000001 { pt } else { db_store_kv_point_scale(pt, 1.0 / n) }
}

pub fn db_store_kv_point_negate(pt : DbstorekvPoint) -> DbstorekvPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_store_kv_point_mid(a : DbstorekvPoint, b : DbstorekvPoint) -> DbstorekvPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_store_kv_point_lerp(a : DbstorekvPoint, b : DbstorekvPoint, t : Double) -> DbstorekvPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_store_kv_point_to_string(pt : DbstorekvPoint) -> String {
  "(" + db_store_kv_dbl(pt.x) + ", " + db_store_kv_dbl(pt.y) + ", " + db_store_kv_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbstorekvSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_store_kv_make_series(vals : Array[Double], name : String) -> DbstorekvSeries {
  { vals, name, meta: 0 }
}

pub fn db_store_kv_series_len(s : DbstorekvSeries) -> Int { s.vals.length() }

pub fn db_store_kv_series_sum(s : DbstorekvSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_store_kv_series_mean(s : DbstorekvSeries) -> Double {
  let n = db_store_kv_series_len(s)
  if n == 0 { 0.0 } else { db_store_kv_series_sum(s) / n.to_double() }
}

pub fn db_store_kv_series_min(s : DbstorekvSeries) -> Double {
  let n = db_store_kv_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_kv_series_max(s : DbstorekvSeries) -> Double {
  let n = db_store_kv_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_store_kv_series_range(s : DbstorekvSeries) -> Double {
  db_store_kv_series_max(s) - db_store_kv_series_min(s)
}

pub fn db_store_kv_series_var(s : DbstorekvSeries) -> Double {
  let n = db_store_kv_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_store_kv_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_store_kv_series_std(s : DbstorekvSeries) -> Double { db_store_kv_sqrt(db_store_kv_series_var(s)) }

pub fn db_store_kv_series_median(s : DbstorekvSeries) -> Double {
  let n = db_store_kv_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_store_kv_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_store_kv_series_scale(s : DbstorekvSeries, f : Double) -> DbstorekvSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_store_kv_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_store_kv_series_add(a : DbstorekvSeries, b : DbstorekvSeries) -> DbstorekvSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_store_kv_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_store_kv_series_sub(a : DbstorekvSeries, b : DbstorekvSeries) -> DbstorekvSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_store_kv_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_store_kv_series_normalize(s : DbstorekvSeries) -> DbstorekvSeries {
  let mn = db_store_kv_series_min(s)
  let mx = db_store_kv_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_store_kv_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_store_kv_series_cumsum(s : DbstorekvSeries) -> DbstorekvSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_store_kv_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_store_kv_series_to_string(s : DbstorekvSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_store_kv_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbstorekvMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_store_kv_make_matrix(rows : Int, cols : Int, val : Double) -> DbstorekvMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_store_kv_matrix_identity(n : Int) -> DbstorekvMatrix {
  let m = db_store_kv_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_store_kv_matrix_get(m : DbstorekvMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_store_kv_matrix_transpose(m : DbstorekvMatrix) -> DbstorekvMatrix {
  let result = db_store_kv_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_store_kv_matrix_add(a : DbstorekvMatrix, b : DbstorekvMatrix) -> DbstorekvMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_store_kv_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_store_kv_matrix_scale(m : DbstorekvMatrix, s : Double) -> DbstorekvMatrix {
  let result = db_store_kv_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_store_kv_matrix_multiply(a : DbstorekvMatrix, b : DbstorekvMatrix) -> DbstorekvMatrix {
  if a.cols != b.rows { return db_store_kv_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_store_kv_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_store_kv_matrix_trace(m : DbstorekvMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_store_kv_matrix_det(m : DbstorekvMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_store_kv_matrix_norm(m : DbstorekvMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_store_kv_sqrt(sum)
}

pub fn db_store_kv_matrix_to_string(m : DbstorekvMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_store_kv_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbstorekvVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_store_kv_make_vector(comps : Array[Double]) -> DbstorekvVector {
  { comps, dim: comps.length() }
}

pub fn db_store_kv_vector_zero(dim : Int) -> DbstorekvVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_store_kv_vector_add(a : DbstorekvVector, b : DbstorekvVector) -> DbstorekvVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_store_kv_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_kv_vector_sub(a : DbstorekvVector, b : DbstorekvVector) -> DbstorekvVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_store_kv_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_store_kv_vector_scale(v : DbstorekvVector, s : Double) -> DbstorekvVector {
  let mut result = []
  for i in 0..<v.dim { result = db_store_kv_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_store_kv_vector_dot(a : DbstorekvVector, b : DbstorekvVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_store_kv_vector_norm(v : DbstorekvVector) -> Double { db_store_kv_sqrt(db_store_kv_vector_dot(v, v)) }

pub fn db_store_kv_vector_normalize(v : DbstorekvVector) -> DbstorekvVector {
  let n = db_store_kv_vector_norm(v)
  if n < 0.0000001 { v } else { db_store_kv_vector_scale(v, 1.0 / n) }
}

pub fn db_store_kv_vector_dist(a : DbstorekvVector, b : DbstorekvVector) -> Double {
  db_store_kv_vector_norm(db_store_kv_vector_sub(a, b))
}

pub fn db_store_kv_vector_to_string(v : DbstorekvVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_store_kv_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_store_kv_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_store_kv_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_store_kv_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_store_kv_std(data : Array[Double]) -> Double { db_store_kv_sqrt(db_store_kv_var(data)) }

pub fn db_store_kv_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_store_kv_mean(a); let mb = db_store_kv_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_store_kv_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_store_kv_std(a); let sb = db_store_kv_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_store_kv_cov(a, b) / (sa * sb) }
}

pub fn db_store_kv_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_store_kv_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_store_kv_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_store_kv_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_store_kv_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_store_kv_sqrt(db_store_kv_mse(pred, labels))
}

pub fn db_store_kv_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_store_kv_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_store_kv_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_store_kv_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_store_kv_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_store_kv_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_store_kv_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_store_kv_precision(pred, labels, pos); let r = db_store_kv_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_store_kv_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_store_kv_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_store_kv_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_store_kv_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_store_kv_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_store_kv_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_store_kv_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_store_kv_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_store_kv_fibonacci(n : Int) -> Int {
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

pub fn db_store_kv_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_store_kv_min(data); let mx = db_store_kv_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_store_kv_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_store_kv_mean(data); let sd = db_store_kv_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_store_kv_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_store_kv_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_store_kv_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_store_kv_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_store_kv_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_store_kv_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_store_kv_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_store_kv_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_store_kv_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_store_kv_int(x) } else { -db_store_kv_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_store_kv_int(f * 1000000.0) } else { db_store_kv_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_store_kv_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_store_kv_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbstorekvFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_frame_make(size : Int) -> DbstorekvFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_frame_len(s : DbstorekvFrame) -> Int { s.size }

pub fn db_store_kv_frame_get(s : DbstorekvFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_frame_set(s : DbstorekvFrame, i : Int, v : Double) -> DbstorekvFrame {
  let result = db_store_kv_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_frame_sum(s : DbstorekvFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_frame_mean(s : DbstorekvFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_frame_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_frame_scale(s : DbstorekvFrame, f : Double) -> DbstorekvFrame {
  let result = db_store_kv_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_frame_add(a : DbstorekvFrame, b : DbstorekvFrame) -> DbstorekvFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_frame_copy(s : DbstorekvFrame) -> DbstorekvFrame {
  let result = db_store_kv_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_frame_fill(s : DbstorekvFrame, v : Double) -> DbstorekvFrame {
  let result = db_store_kv_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_frame_min(s : DbstorekvFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_frame_max(s : DbstorekvFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_frame_to_string(s : DbstorekvFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_table_make(size : Int) -> DbstorekvTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_table_len(s : DbstorekvTable) -> Int { s.size }

pub fn db_store_kv_table_get(s : DbstorekvTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_table_set(s : DbstorekvTable, i : Int, v : Double) -> DbstorekvTable {
  let result = db_store_kv_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_table_sum(s : DbstorekvTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_table_mean(s : DbstorekvTable) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_table_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_table_scale(s : DbstorekvTable, f : Double) -> DbstorekvTable {
  let result = db_store_kv_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_table_add(a : DbstorekvTable, b : DbstorekvTable) -> DbstorekvTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_table_copy(s : DbstorekvTable) -> DbstorekvTable {
  let result = db_store_kv_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_table_fill(s : DbstorekvTable, v : Double) -> DbstorekvTable {
  let result = db_store_kv_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_table_min(s : DbstorekvTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_table_max(s : DbstorekvTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_table_to_string(s : DbstorekvTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_graphn_make(size : Int) -> DbstorekvGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_graphn_len(s : DbstorekvGraphN) -> Int { s.size }

pub fn db_store_kv_graphn_get(s : DbstorekvGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_graphn_set(s : DbstorekvGraphN, i : Int, v : Double) -> DbstorekvGraphN {
  let result = db_store_kv_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_graphn_sum(s : DbstorekvGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_graphn_mean(s : DbstorekvGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_graphn_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_graphn_scale(s : DbstorekvGraphN, f : Double) -> DbstorekvGraphN {
  let result = db_store_kv_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_graphn_add(a : DbstorekvGraphN, b : DbstorekvGraphN) -> DbstorekvGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_graphn_copy(s : DbstorekvGraphN) -> DbstorekvGraphN {
  let result = db_store_kv_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_graphn_fill(s : DbstorekvGraphN, v : Double) -> DbstorekvGraphN {
  let result = db_store_kv_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_graphn_min(s : DbstorekvGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_graphn_max(s : DbstorekvGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_graphn_to_string(s : DbstorekvGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_node_make(size : Int) -> DbstorekvNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_node_len(s : DbstorekvNode) -> Int { s.size }

pub fn db_store_kv_node_get(s : DbstorekvNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_node_set(s : DbstorekvNode, i : Int, v : Double) -> DbstorekvNode {
  let result = db_store_kv_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_node_sum(s : DbstorekvNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_node_mean(s : DbstorekvNode) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_node_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_node_scale(s : DbstorekvNode, f : Double) -> DbstorekvNode {
  let result = db_store_kv_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_node_add(a : DbstorekvNode, b : DbstorekvNode) -> DbstorekvNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_node_copy(s : DbstorekvNode) -> DbstorekvNode {
  let result = db_store_kv_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_node_fill(s : DbstorekvNode, v : Double) -> DbstorekvNode {
  let result = db_store_kv_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_node_min(s : DbstorekvNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_node_max(s : DbstorekvNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_node_to_string(s : DbstorekvNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_edge_make(size : Int) -> DbstorekvEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_edge_len(s : DbstorekvEdge) -> Int { s.size }

pub fn db_store_kv_edge_get(s : DbstorekvEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_edge_set(s : DbstorekvEdge, i : Int, v : Double) -> DbstorekvEdge {
  let result = db_store_kv_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_edge_sum(s : DbstorekvEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_edge_mean(s : DbstorekvEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_edge_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_edge_scale(s : DbstorekvEdge, f : Double) -> DbstorekvEdge {
  let result = db_store_kv_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_edge_add(a : DbstorekvEdge, b : DbstorekvEdge) -> DbstorekvEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_edge_copy(s : DbstorekvEdge) -> DbstorekvEdge {
  let result = db_store_kv_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_edge_fill(s : DbstorekvEdge, v : Double) -> DbstorekvEdge {
  let result = db_store_kv_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_edge_min(s : DbstorekvEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_edge_max(s : DbstorekvEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_edge_to_string(s : DbstorekvEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_path_make(size : Int) -> DbstorekvPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_path_len(s : DbstorekvPath) -> Int { s.size }

pub fn db_store_kv_path_get(s : DbstorekvPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_path_set(s : DbstorekvPath, i : Int, v : Double) -> DbstorekvPath {
  let result = db_store_kv_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_path_sum(s : DbstorekvPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_path_mean(s : DbstorekvPath) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_path_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_path_scale(s : DbstorekvPath, f : Double) -> DbstorekvPath {
  let result = db_store_kv_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_path_add(a : DbstorekvPath, b : DbstorekvPath) -> DbstorekvPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_path_copy(s : DbstorekvPath) -> DbstorekvPath {
  let result = db_store_kv_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_path_fill(s : DbstorekvPath, v : Double) -> DbstorekvPath {
  let result = db_store_kv_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_path_min(s : DbstorekvPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_path_max(s : DbstorekvPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_path_to_string(s : DbstorekvPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_cluster_make(size : Int) -> DbstorekvCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_cluster_len(s : DbstorekvCluster) -> Int { s.size }

pub fn db_store_kv_cluster_get(s : DbstorekvCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_cluster_set(s : DbstorekvCluster, i : Int, v : Double) -> DbstorekvCluster {
  let result = db_store_kv_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_cluster_sum(s : DbstorekvCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_cluster_mean(s : DbstorekvCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_cluster_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_cluster_scale(s : DbstorekvCluster, f : Double) -> DbstorekvCluster {
  let result = db_store_kv_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_cluster_add(a : DbstorekvCluster, b : DbstorekvCluster) -> DbstorekvCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_cluster_copy(s : DbstorekvCluster) -> DbstorekvCluster {
  let result = db_store_kv_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_cluster_fill(s : DbstorekvCluster, v : Double) -> DbstorekvCluster {
  let result = db_store_kv_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_cluster_min(s : DbstorekvCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_cluster_max(s : DbstorekvCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_cluster_to_string(s : DbstorekvCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_model_make(size : Int) -> DbstorekvModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_model_len(s : DbstorekvModel) -> Int { s.size }

pub fn db_store_kv_model_get(s : DbstorekvModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_model_set(s : DbstorekvModel, i : Int, v : Double) -> DbstorekvModel {
  let result = db_store_kv_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_model_sum(s : DbstorekvModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_model_mean(s : DbstorekvModel) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_model_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_model_scale(s : DbstorekvModel, f : Double) -> DbstorekvModel {
  let result = db_store_kv_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_model_add(a : DbstorekvModel, b : DbstorekvModel) -> DbstorekvModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_model_copy(s : DbstorekvModel) -> DbstorekvModel {
  let result = db_store_kv_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_model_fill(s : DbstorekvModel, v : Double) -> DbstorekvModel {
  let result = db_store_kv_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_model_min(s : DbstorekvModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_model_max(s : DbstorekvModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_model_to_string(s : DbstorekvModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_layer_make(size : Int) -> DbstorekvLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_layer_len(s : DbstorekvLayer) -> Int { s.size }

pub fn db_store_kv_layer_get(s : DbstorekvLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_layer_set(s : DbstorekvLayer, i : Int, v : Double) -> DbstorekvLayer {
  let result = db_store_kv_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_layer_sum(s : DbstorekvLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_layer_mean(s : DbstorekvLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_layer_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_layer_scale(s : DbstorekvLayer, f : Double) -> DbstorekvLayer {
  let result = db_store_kv_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_layer_add(a : DbstorekvLayer, b : DbstorekvLayer) -> DbstorekvLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_layer_copy(s : DbstorekvLayer) -> DbstorekvLayer {
  let result = db_store_kv_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_layer_fill(s : DbstorekvLayer, v : Double) -> DbstorekvLayer {
  let result = db_store_kv_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_layer_min(s : DbstorekvLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_layer_max(s : DbstorekvLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_layer_to_string(s : DbstorekvLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_buffer_make(size : Int) -> DbstorekvBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_buffer_len(s : DbstorekvBuffer) -> Int { s.size }

pub fn db_store_kv_buffer_get(s : DbstorekvBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_buffer_set(s : DbstorekvBuffer, i : Int, v : Double) -> DbstorekvBuffer {
  let result = db_store_kv_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_buffer_sum(s : DbstorekvBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_buffer_mean(s : DbstorekvBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_buffer_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_buffer_scale(s : DbstorekvBuffer, f : Double) -> DbstorekvBuffer {
  let result = db_store_kv_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_buffer_add(a : DbstorekvBuffer, b : DbstorekvBuffer) -> DbstorekvBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_buffer_copy(s : DbstorekvBuffer) -> DbstorekvBuffer {
  let result = db_store_kv_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_buffer_fill(s : DbstorekvBuffer, v : Double) -> DbstorekvBuffer {
  let result = db_store_kv_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_buffer_min(s : DbstorekvBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_buffer_max(s : DbstorekvBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_buffer_to_string(s : DbstorekvBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_cursor_make(size : Int) -> DbstorekvCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_cursor_len(s : DbstorekvCursor) -> Int { s.size }

pub fn db_store_kv_cursor_get(s : DbstorekvCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_cursor_set(s : DbstorekvCursor, i : Int, v : Double) -> DbstorekvCursor {
  let result = db_store_kv_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_cursor_sum(s : DbstorekvCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_cursor_mean(s : DbstorekvCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_cursor_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_cursor_scale(s : DbstorekvCursor, f : Double) -> DbstorekvCursor {
  let result = db_store_kv_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_cursor_add(a : DbstorekvCursor, b : DbstorekvCursor) -> DbstorekvCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_cursor_copy(s : DbstorekvCursor) -> DbstorekvCursor {
  let result = db_store_kv_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_cursor_fill(s : DbstorekvCursor, v : Double) -> DbstorekvCursor {
  let result = db_store_kv_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_cursor_min(s : DbstorekvCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_cursor_max(s : DbstorekvCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_cursor_to_string(s : DbstorekvCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_view_make(size : Int) -> DbstorekvView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_view_len(s : DbstorekvView) -> Int { s.size }

pub fn db_store_kv_view_get(s : DbstorekvView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_view_set(s : DbstorekvView, i : Int, v : Double) -> DbstorekvView {
  let result = db_store_kv_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_view_sum(s : DbstorekvView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_view_mean(s : DbstorekvView) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_view_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_view_scale(s : DbstorekvView, f : Double) -> DbstorekvView {
  let result = db_store_kv_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_view_add(a : DbstorekvView, b : DbstorekvView) -> DbstorekvView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_view_copy(s : DbstorekvView) -> DbstorekvView {
  let result = db_store_kv_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_view_fill(s : DbstorekvView, v : Double) -> DbstorekvView {
  let result = db_store_kv_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_view_min(s : DbstorekvView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_view_max(s : DbstorekvView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_view_to_string(s : DbstorekvView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_range_make(size : Int) -> DbstorekvRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_range_len(s : DbstorekvRange) -> Int { s.size }

pub fn db_store_kv_range_get(s : DbstorekvRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_range_set(s : DbstorekvRange, i : Int, v : Double) -> DbstorekvRange {
  let result = db_store_kv_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_range_sum(s : DbstorekvRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_range_mean(s : DbstorekvRange) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_range_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_range_scale(s : DbstorekvRange, f : Double) -> DbstorekvRange {
  let result = db_store_kv_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_range_add(a : DbstorekvRange, b : DbstorekvRange) -> DbstorekvRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_range_copy(s : DbstorekvRange) -> DbstorekvRange {
  let result = db_store_kv_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_range_fill(s : DbstorekvRange, v : Double) -> DbstorekvRange {
  let result = db_store_kv_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_range_min(s : DbstorekvRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_range_max(s : DbstorekvRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_range_to_string(s : DbstorekvRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbstorekvSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_store_kv_slice_make(size : Int) -> DbstorekvSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_store_kv_slice_len(s : DbstorekvSlice) -> Int { s.size }

pub fn db_store_kv_slice_get(s : DbstorekvSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_store_kv_slice_set(s : DbstorekvSlice, i : Int, v : Double) -> DbstorekvSlice {
  let result = db_store_kv_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_slice_sum(s : DbstorekvSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_store_kv_slice_mean(s : DbstorekvSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_store_kv_slice_sum(s) / s.size.to_double() }
}

pub fn db_store_kv_slice_scale(s : DbstorekvSlice, f : Double) -> DbstorekvSlice {
  let result = db_store_kv_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_store_kv_slice_add(a : DbstorekvSlice, b : DbstorekvSlice) -> DbstorekvSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_store_kv_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_store_kv_slice_copy(s : DbstorekvSlice) -> DbstorekvSlice {
  let result = db_store_kv_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_store_kv_slice_fill(s : DbstorekvSlice, v : Double) -> DbstorekvSlice {
  let result = db_store_kv_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_store_kv_slice_min(s : DbstorekvSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_slice_max(s : DbstorekvSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_store_kv_slice_to_string(s : DbstorekvSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_store_kv_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_store_kv_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

