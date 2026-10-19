///===
/// extcore/db_query_join

pub(all) struct DbqueryjoinPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_join_make_point(x : Double, y : Double) -> DbqueryjoinPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_join_make_point3(x : Double, y : Double, z : Double) -> DbqueryjoinPoint {
  { x, y, z, label: 0 }
}

pub fn db_query_join_point_x(pt : DbqueryjoinPoint) -> Double { pt.x }

pub fn db_query_join_point_y(pt : DbqueryjoinPoint) -> Double { pt.y }

pub fn db_query_join_point_z(pt : DbqueryjoinPoint) -> Double { pt.z }

pub fn db_query_join_point_label(pt : DbqueryjoinPoint) -> Int { pt.label }

pub fn db_query_join_point_dist(a : DbqueryjoinPoint, b : DbqueryjoinPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_query_join_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_query_join_point_add(a : DbqueryjoinPoint, b : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_query_join_point_sub(a : DbqueryjoinPoint, b : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_query_join_point_scale(pt : DbqueryjoinPoint, s : Double) -> DbqueryjoinPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_query_join_point_dot(a : DbqueryjoinPoint, b : DbqueryjoinPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_query_join_point_cross(a : DbqueryjoinPoint, b : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_query_join_point_norm(pt : DbqueryjoinPoint) -> Double {
  db_query_join_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_query_join_point_normalize(pt : DbqueryjoinPoint) -> DbqueryjoinPoint {
  let n = db_query_join_point_norm(pt)
  if n < 0.0000001 { pt } else { db_query_join_point_scale(pt, 1.0 / n) }
}

pub fn db_query_join_point_negate(pt : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_query_join_point_mid(a : DbqueryjoinPoint, b : DbqueryjoinPoint) -> DbqueryjoinPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_query_join_point_lerp(a : DbqueryjoinPoint, b : DbqueryjoinPoint, t : Double) -> DbqueryjoinPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_query_join_point_to_string(pt : DbqueryjoinPoint) -> String {
  "(" + db_query_join_dbl(pt.x) + ", " + db_query_join_dbl(pt.y) + ", " + db_query_join_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbqueryjoinSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_join_make_series(vals : Array[Double], name : String) -> DbqueryjoinSeries {
  { vals, name, meta: 0 }
}

pub fn db_query_join_series_len(s : DbqueryjoinSeries) -> Int { s.vals.length() }

pub fn db_query_join_series_sum(s : DbqueryjoinSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_query_join_series_mean(s : DbqueryjoinSeries) -> Double {
  let n = db_query_join_series_len(s)
  if n == 0 { 0.0 } else { db_query_join_series_sum(s) / n.to_double() }
}

pub fn db_query_join_series_min(s : DbqueryjoinSeries) -> Double {
  let n = db_query_join_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_join_series_max(s : DbqueryjoinSeries) -> Double {
  let n = db_query_join_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_join_series_range(s : DbqueryjoinSeries) -> Double {
  db_query_join_series_max(s) - db_query_join_series_min(s)
}

pub fn db_query_join_series_var(s : DbqueryjoinSeries) -> Double {
  let n = db_query_join_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_query_join_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_query_join_series_std(s : DbqueryjoinSeries) -> Double { db_query_join_sqrt(db_query_join_series_var(s)) }

pub fn db_query_join_series_median(s : DbqueryjoinSeries) -> Double {
  let n = db_query_join_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_query_join_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_join_series_scale(s : DbqueryjoinSeries, f : Double) -> DbqueryjoinSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_query_join_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_query_join_series_add(a : DbqueryjoinSeries, b : DbqueryjoinSeries) -> DbqueryjoinSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_query_join_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_query_join_series_sub(a : DbqueryjoinSeries, b : DbqueryjoinSeries) -> DbqueryjoinSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_query_join_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_query_join_series_normalize(s : DbqueryjoinSeries) -> DbqueryjoinSeries {
  let mn = db_query_join_series_min(s)
  let mx = db_query_join_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_query_join_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_query_join_series_cumsum(s : DbqueryjoinSeries) -> DbqueryjoinSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_query_join_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_query_join_series_to_string(s : DbqueryjoinSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_query_join_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryjoinMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_join_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryjoinMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_join_matrix_identity(n : Int) -> DbqueryjoinMatrix {
  let m = db_query_join_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_query_join_matrix_get(m : DbqueryjoinMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_query_join_matrix_transpose(m : DbqueryjoinMatrix) -> DbqueryjoinMatrix {
  let result = db_query_join_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_query_join_matrix_add(a : DbqueryjoinMatrix, b : DbqueryjoinMatrix) -> DbqueryjoinMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_query_join_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_query_join_matrix_scale(m : DbqueryjoinMatrix, s : Double) -> DbqueryjoinMatrix {
  let result = db_query_join_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_query_join_matrix_multiply(a : DbqueryjoinMatrix, b : DbqueryjoinMatrix) -> DbqueryjoinMatrix {
  if a.cols != b.rows { return db_query_join_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_query_join_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_query_join_matrix_trace(m : DbqueryjoinMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_query_join_matrix_det(m : DbqueryjoinMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_query_join_matrix_norm(m : DbqueryjoinMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_query_join_sqrt(sum)
}

pub fn db_query_join_matrix_to_string(m : DbqueryjoinMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_query_join_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbqueryjoinVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_join_make_vector(comps : Array[Double]) -> DbqueryjoinVector {
  { comps, dim: comps.length() }
}

pub fn db_query_join_vector_zero(dim : Int) -> DbqueryjoinVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_query_join_vector_add(a : DbqueryjoinVector, b : DbqueryjoinVector) -> DbqueryjoinVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_query_join_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_join_vector_sub(a : DbqueryjoinVector, b : DbqueryjoinVector) -> DbqueryjoinVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_query_join_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_join_vector_scale(v : DbqueryjoinVector, s : Double) -> DbqueryjoinVector {
  let mut result = []
  for i in 0..<v.dim { result = db_query_join_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_query_join_vector_dot(a : DbqueryjoinVector, b : DbqueryjoinVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_query_join_vector_norm(v : DbqueryjoinVector) -> Double { db_query_join_sqrt(db_query_join_vector_dot(v, v)) }

pub fn db_query_join_vector_normalize(v : DbqueryjoinVector) -> DbqueryjoinVector {
  let n = db_query_join_vector_norm(v)
  if n < 0.0000001 { v } else { db_query_join_vector_scale(v, 1.0 / n) }
}

pub fn db_query_join_vector_dist(a : DbqueryjoinVector, b : DbqueryjoinVector) -> Double {
  db_query_join_vector_norm(db_query_join_vector_sub(a, b))
}

pub fn db_query_join_vector_to_string(v : DbqueryjoinVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_query_join_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_join_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_query_join_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_query_join_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_query_join_std(data : Array[Double]) -> Double { db_query_join_sqrt(db_query_join_var(data)) }

pub fn db_query_join_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_query_join_mean(a); let mb = db_query_join_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_query_join_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_query_join_std(a); let sb = db_query_join_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_query_join_cov(a, b) / (sa * sb) }
}

pub fn db_query_join_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_query_join_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_join_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_query_join_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_query_join_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_query_join_sqrt(db_query_join_mse(pred, labels))
}

pub fn db_query_join_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_query_join_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_query_join_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_query_join_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_query_join_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_query_join_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_query_join_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_query_join_precision(pred, labels, pos); let r = db_query_join_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_query_join_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_query_join_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_query_join_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_query_join_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_query_join_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_query_join_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_query_join_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_query_join_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_query_join_fibonacci(n : Int) -> Int {
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

pub fn db_query_join_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_query_join_min(data); let mx = db_query_join_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_query_join_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_query_join_mean(data); let sd = db_query_join_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_query_join_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_query_join_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_query_join_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_query_join_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_query_join_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_query_join_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_query_join_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_query_join_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_query_join_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_query_join_int(x) } else { -db_query_join_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_query_join_int(f * 1000000.0) } else { db_query_join_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_query_join_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_query_join_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbqueryjoinFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_frame_make(size : Int) -> DbqueryjoinFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_frame_len(s : DbqueryjoinFrame) -> Int { s.size }

pub fn db_query_join_frame_get(s : DbqueryjoinFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_frame_set(s : DbqueryjoinFrame, i : Int, v : Double) -> DbqueryjoinFrame {
  let result = db_query_join_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_frame_sum(s : DbqueryjoinFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_frame_mean(s : DbqueryjoinFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_frame_sum(s) / s.size.to_double() }
}

pub fn db_query_join_frame_scale(s : DbqueryjoinFrame, f : Double) -> DbqueryjoinFrame {
  let result = db_query_join_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_frame_add(a : DbqueryjoinFrame, b : DbqueryjoinFrame) -> DbqueryjoinFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_frame_copy(s : DbqueryjoinFrame) -> DbqueryjoinFrame {
  let result = db_query_join_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_frame_fill(s : DbqueryjoinFrame, v : Double) -> DbqueryjoinFrame {
  let result = db_query_join_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_frame_min(s : DbqueryjoinFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_frame_max(s : DbqueryjoinFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_frame_to_string(s : DbqueryjoinFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_table_make(size : Int) -> DbqueryjoinTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_table_len(s : DbqueryjoinTable) -> Int { s.size }

pub fn db_query_join_table_get(s : DbqueryjoinTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_table_set(s : DbqueryjoinTable, i : Int, v : Double) -> DbqueryjoinTable {
  let result = db_query_join_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_table_sum(s : DbqueryjoinTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_table_mean(s : DbqueryjoinTable) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_table_sum(s) / s.size.to_double() }
}

pub fn db_query_join_table_scale(s : DbqueryjoinTable, f : Double) -> DbqueryjoinTable {
  let result = db_query_join_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_table_add(a : DbqueryjoinTable, b : DbqueryjoinTable) -> DbqueryjoinTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_table_copy(s : DbqueryjoinTable) -> DbqueryjoinTable {
  let result = db_query_join_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_table_fill(s : DbqueryjoinTable, v : Double) -> DbqueryjoinTable {
  let result = db_query_join_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_table_min(s : DbqueryjoinTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_table_max(s : DbqueryjoinTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_table_to_string(s : DbqueryjoinTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_graphn_make(size : Int) -> DbqueryjoinGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_graphn_len(s : DbqueryjoinGraphN) -> Int { s.size }

pub fn db_query_join_graphn_get(s : DbqueryjoinGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_graphn_set(s : DbqueryjoinGraphN, i : Int, v : Double) -> DbqueryjoinGraphN {
  let result = db_query_join_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_graphn_sum(s : DbqueryjoinGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_graphn_mean(s : DbqueryjoinGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_graphn_sum(s) / s.size.to_double() }
}

pub fn db_query_join_graphn_scale(s : DbqueryjoinGraphN, f : Double) -> DbqueryjoinGraphN {
  let result = db_query_join_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_graphn_add(a : DbqueryjoinGraphN, b : DbqueryjoinGraphN) -> DbqueryjoinGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_graphn_copy(s : DbqueryjoinGraphN) -> DbqueryjoinGraphN {
  let result = db_query_join_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_graphn_fill(s : DbqueryjoinGraphN, v : Double) -> DbqueryjoinGraphN {
  let result = db_query_join_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_graphn_min(s : DbqueryjoinGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_graphn_max(s : DbqueryjoinGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_graphn_to_string(s : DbqueryjoinGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_node_make(size : Int) -> DbqueryjoinNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_node_len(s : DbqueryjoinNode) -> Int { s.size }

pub fn db_query_join_node_get(s : DbqueryjoinNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_node_set(s : DbqueryjoinNode, i : Int, v : Double) -> DbqueryjoinNode {
  let result = db_query_join_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_node_sum(s : DbqueryjoinNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_node_mean(s : DbqueryjoinNode) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_node_sum(s) / s.size.to_double() }
}

pub fn db_query_join_node_scale(s : DbqueryjoinNode, f : Double) -> DbqueryjoinNode {
  let result = db_query_join_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_node_add(a : DbqueryjoinNode, b : DbqueryjoinNode) -> DbqueryjoinNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_node_copy(s : DbqueryjoinNode) -> DbqueryjoinNode {
  let result = db_query_join_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_node_fill(s : DbqueryjoinNode, v : Double) -> DbqueryjoinNode {
  let result = db_query_join_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_node_min(s : DbqueryjoinNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_node_max(s : DbqueryjoinNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_node_to_string(s : DbqueryjoinNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_edge_make(size : Int) -> DbqueryjoinEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_edge_len(s : DbqueryjoinEdge) -> Int { s.size }

pub fn db_query_join_edge_get(s : DbqueryjoinEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_edge_set(s : DbqueryjoinEdge, i : Int, v : Double) -> DbqueryjoinEdge {
  let result = db_query_join_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_edge_sum(s : DbqueryjoinEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_edge_mean(s : DbqueryjoinEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_edge_sum(s) / s.size.to_double() }
}

pub fn db_query_join_edge_scale(s : DbqueryjoinEdge, f : Double) -> DbqueryjoinEdge {
  let result = db_query_join_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_edge_add(a : DbqueryjoinEdge, b : DbqueryjoinEdge) -> DbqueryjoinEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_edge_copy(s : DbqueryjoinEdge) -> DbqueryjoinEdge {
  let result = db_query_join_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_edge_fill(s : DbqueryjoinEdge, v : Double) -> DbqueryjoinEdge {
  let result = db_query_join_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_edge_min(s : DbqueryjoinEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_edge_max(s : DbqueryjoinEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_edge_to_string(s : DbqueryjoinEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_path_make(size : Int) -> DbqueryjoinPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_path_len(s : DbqueryjoinPath) -> Int { s.size }

pub fn db_query_join_path_get(s : DbqueryjoinPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_path_set(s : DbqueryjoinPath, i : Int, v : Double) -> DbqueryjoinPath {
  let result = db_query_join_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_path_sum(s : DbqueryjoinPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_path_mean(s : DbqueryjoinPath) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_path_sum(s) / s.size.to_double() }
}

pub fn db_query_join_path_scale(s : DbqueryjoinPath, f : Double) -> DbqueryjoinPath {
  let result = db_query_join_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_path_add(a : DbqueryjoinPath, b : DbqueryjoinPath) -> DbqueryjoinPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_path_copy(s : DbqueryjoinPath) -> DbqueryjoinPath {
  let result = db_query_join_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_path_fill(s : DbqueryjoinPath, v : Double) -> DbqueryjoinPath {
  let result = db_query_join_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_path_min(s : DbqueryjoinPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_path_max(s : DbqueryjoinPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_path_to_string(s : DbqueryjoinPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_cluster_make(size : Int) -> DbqueryjoinCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_cluster_len(s : DbqueryjoinCluster) -> Int { s.size }

pub fn db_query_join_cluster_get(s : DbqueryjoinCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_cluster_set(s : DbqueryjoinCluster, i : Int, v : Double) -> DbqueryjoinCluster {
  let result = db_query_join_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_cluster_sum(s : DbqueryjoinCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_cluster_mean(s : DbqueryjoinCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_cluster_sum(s) / s.size.to_double() }
}

pub fn db_query_join_cluster_scale(s : DbqueryjoinCluster, f : Double) -> DbqueryjoinCluster {
  let result = db_query_join_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_cluster_add(a : DbqueryjoinCluster, b : DbqueryjoinCluster) -> DbqueryjoinCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_cluster_copy(s : DbqueryjoinCluster) -> DbqueryjoinCluster {
  let result = db_query_join_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_cluster_fill(s : DbqueryjoinCluster, v : Double) -> DbqueryjoinCluster {
  let result = db_query_join_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_cluster_min(s : DbqueryjoinCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_cluster_max(s : DbqueryjoinCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_cluster_to_string(s : DbqueryjoinCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_model_make(size : Int) -> DbqueryjoinModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_model_len(s : DbqueryjoinModel) -> Int { s.size }

pub fn db_query_join_model_get(s : DbqueryjoinModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_model_set(s : DbqueryjoinModel, i : Int, v : Double) -> DbqueryjoinModel {
  let result = db_query_join_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_model_sum(s : DbqueryjoinModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_model_mean(s : DbqueryjoinModel) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_model_sum(s) / s.size.to_double() }
}

pub fn db_query_join_model_scale(s : DbqueryjoinModel, f : Double) -> DbqueryjoinModel {
  let result = db_query_join_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_model_add(a : DbqueryjoinModel, b : DbqueryjoinModel) -> DbqueryjoinModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_model_copy(s : DbqueryjoinModel) -> DbqueryjoinModel {
  let result = db_query_join_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_model_fill(s : DbqueryjoinModel, v : Double) -> DbqueryjoinModel {
  let result = db_query_join_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_model_min(s : DbqueryjoinModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_model_max(s : DbqueryjoinModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_model_to_string(s : DbqueryjoinModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_layer_make(size : Int) -> DbqueryjoinLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_layer_len(s : DbqueryjoinLayer) -> Int { s.size }

pub fn db_query_join_layer_get(s : DbqueryjoinLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_layer_set(s : DbqueryjoinLayer, i : Int, v : Double) -> DbqueryjoinLayer {
  let result = db_query_join_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_layer_sum(s : DbqueryjoinLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_layer_mean(s : DbqueryjoinLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_layer_sum(s) / s.size.to_double() }
}

pub fn db_query_join_layer_scale(s : DbqueryjoinLayer, f : Double) -> DbqueryjoinLayer {
  let result = db_query_join_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_layer_add(a : DbqueryjoinLayer, b : DbqueryjoinLayer) -> DbqueryjoinLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_layer_copy(s : DbqueryjoinLayer) -> DbqueryjoinLayer {
  let result = db_query_join_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_layer_fill(s : DbqueryjoinLayer, v : Double) -> DbqueryjoinLayer {
  let result = db_query_join_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_layer_min(s : DbqueryjoinLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_layer_max(s : DbqueryjoinLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_layer_to_string(s : DbqueryjoinLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_buffer_make(size : Int) -> DbqueryjoinBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_buffer_len(s : DbqueryjoinBuffer) -> Int { s.size }

pub fn db_query_join_buffer_get(s : DbqueryjoinBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_buffer_set(s : DbqueryjoinBuffer, i : Int, v : Double) -> DbqueryjoinBuffer {
  let result = db_query_join_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_buffer_sum(s : DbqueryjoinBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_buffer_mean(s : DbqueryjoinBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_buffer_sum(s) / s.size.to_double() }
}

pub fn db_query_join_buffer_scale(s : DbqueryjoinBuffer, f : Double) -> DbqueryjoinBuffer {
  let result = db_query_join_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_buffer_add(a : DbqueryjoinBuffer, b : DbqueryjoinBuffer) -> DbqueryjoinBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_buffer_copy(s : DbqueryjoinBuffer) -> DbqueryjoinBuffer {
  let result = db_query_join_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_buffer_fill(s : DbqueryjoinBuffer, v : Double) -> DbqueryjoinBuffer {
  let result = db_query_join_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_buffer_min(s : DbqueryjoinBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_buffer_max(s : DbqueryjoinBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_buffer_to_string(s : DbqueryjoinBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_cursor_make(size : Int) -> DbqueryjoinCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_cursor_len(s : DbqueryjoinCursor) -> Int { s.size }

pub fn db_query_join_cursor_get(s : DbqueryjoinCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_cursor_set(s : DbqueryjoinCursor, i : Int, v : Double) -> DbqueryjoinCursor {
  let result = db_query_join_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_cursor_sum(s : DbqueryjoinCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_cursor_mean(s : DbqueryjoinCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_cursor_sum(s) / s.size.to_double() }
}

pub fn db_query_join_cursor_scale(s : DbqueryjoinCursor, f : Double) -> DbqueryjoinCursor {
  let result = db_query_join_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_cursor_add(a : DbqueryjoinCursor, b : DbqueryjoinCursor) -> DbqueryjoinCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_cursor_copy(s : DbqueryjoinCursor) -> DbqueryjoinCursor {
  let result = db_query_join_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_cursor_fill(s : DbqueryjoinCursor, v : Double) -> DbqueryjoinCursor {
  let result = db_query_join_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_cursor_min(s : DbqueryjoinCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_cursor_max(s : DbqueryjoinCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_cursor_to_string(s : DbqueryjoinCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_view_make(size : Int) -> DbqueryjoinView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_view_len(s : DbqueryjoinView) -> Int { s.size }

pub fn db_query_join_view_get(s : DbqueryjoinView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_view_set(s : DbqueryjoinView, i : Int, v : Double) -> DbqueryjoinView {
  let result = db_query_join_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_view_sum(s : DbqueryjoinView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_view_mean(s : DbqueryjoinView) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_view_sum(s) / s.size.to_double() }
}

pub fn db_query_join_view_scale(s : DbqueryjoinView, f : Double) -> DbqueryjoinView {
  let result = db_query_join_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_view_add(a : DbqueryjoinView, b : DbqueryjoinView) -> DbqueryjoinView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_view_copy(s : DbqueryjoinView) -> DbqueryjoinView {
  let result = db_query_join_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_view_fill(s : DbqueryjoinView, v : Double) -> DbqueryjoinView {
  let result = db_query_join_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_view_min(s : DbqueryjoinView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_view_max(s : DbqueryjoinView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_view_to_string(s : DbqueryjoinView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_range_make(size : Int) -> DbqueryjoinRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_range_len(s : DbqueryjoinRange) -> Int { s.size }

pub fn db_query_join_range_get(s : DbqueryjoinRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_range_set(s : DbqueryjoinRange, i : Int, v : Double) -> DbqueryjoinRange {
  let result = db_query_join_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_range_sum(s : DbqueryjoinRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_range_mean(s : DbqueryjoinRange) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_range_sum(s) / s.size.to_double() }
}

pub fn db_query_join_range_scale(s : DbqueryjoinRange, f : Double) -> DbqueryjoinRange {
  let result = db_query_join_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_range_add(a : DbqueryjoinRange, b : DbqueryjoinRange) -> DbqueryjoinRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_range_copy(s : DbqueryjoinRange) -> DbqueryjoinRange {
  let result = db_query_join_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_range_fill(s : DbqueryjoinRange, v : Double) -> DbqueryjoinRange {
  let result = db_query_join_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_range_min(s : DbqueryjoinRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_range_max(s : DbqueryjoinRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_range_to_string(s : DbqueryjoinRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryjoinSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_join_slice_make(size : Int) -> DbqueryjoinSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_join_slice_len(s : DbqueryjoinSlice) -> Int { s.size }

pub fn db_query_join_slice_get(s : DbqueryjoinSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_join_slice_set(s : DbqueryjoinSlice, i : Int, v : Double) -> DbqueryjoinSlice {
  let result = db_query_join_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_join_slice_sum(s : DbqueryjoinSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_join_slice_mean(s : DbqueryjoinSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_query_join_slice_sum(s) / s.size.to_double() }
}

pub fn db_query_join_slice_scale(s : DbqueryjoinSlice, f : Double) -> DbqueryjoinSlice {
  let result = db_query_join_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_join_slice_add(a : DbqueryjoinSlice, b : DbqueryjoinSlice) -> DbqueryjoinSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_join_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_join_slice_copy(s : DbqueryjoinSlice) -> DbqueryjoinSlice {
  let result = db_query_join_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_join_slice_fill(s : DbqueryjoinSlice, v : Double) -> DbqueryjoinSlice {
  let result = db_query_join_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_join_slice_min(s : DbqueryjoinSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_slice_max(s : DbqueryjoinSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_join_slice_to_string(s : DbqueryjoinSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_query_join_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_join_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

