///===
/// extcore/db_query_recursive

pub(all) struct DbqueryrecursivePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_recursive_make_point(x : Double, y : Double) -> DbqueryrecursivePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_recursive_make_point3(x : Double, y : Double, z : Double) -> DbqueryrecursivePoint {
  { x, y, z, label: 0 }
}

pub fn db_query_recursive_point_x(pt : DbqueryrecursivePoint) -> Double { pt.x }

pub fn db_query_recursive_point_y(pt : DbqueryrecursivePoint) -> Double { pt.y }

pub fn db_query_recursive_point_z(pt : DbqueryrecursivePoint) -> Double { pt.z }

pub fn db_query_recursive_point_label(pt : DbqueryrecursivePoint) -> Int { pt.label }

pub fn db_query_recursive_point_dist(a : DbqueryrecursivePoint, b : DbqueryrecursivePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_query_recursive_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_query_recursive_point_add(a : DbqueryrecursivePoint, b : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_query_recursive_point_sub(a : DbqueryrecursivePoint, b : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_query_recursive_point_scale(pt : DbqueryrecursivePoint, s : Double) -> DbqueryrecursivePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_query_recursive_point_dot(a : DbqueryrecursivePoint, b : DbqueryrecursivePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_query_recursive_point_cross(a : DbqueryrecursivePoint, b : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_query_recursive_point_norm(pt : DbqueryrecursivePoint) -> Double {
  db_query_recursive_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_query_recursive_point_normalize(pt : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  let n = db_query_recursive_point_norm(pt)
  if n < 0.0000001 { pt } else { db_query_recursive_point_scale(pt, 1.0 / n) }
}

pub fn db_query_recursive_point_negate(pt : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_query_recursive_point_mid(a : DbqueryrecursivePoint, b : DbqueryrecursivePoint) -> DbqueryrecursivePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_query_recursive_point_lerp(a : DbqueryrecursivePoint, b : DbqueryrecursivePoint, t : Double) -> DbqueryrecursivePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_query_recursive_point_to_string(pt : DbqueryrecursivePoint) -> String {
  "(" + db_query_recursive_dbl(pt.x) + ", " + db_query_recursive_dbl(pt.y) + ", " + db_query_recursive_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbqueryrecursiveSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_recursive_make_series(vals : Array[Double], name : String) -> DbqueryrecursiveSeries {
  { vals, name, meta: 0 }
}

pub fn db_query_recursive_series_len(s : DbqueryrecursiveSeries) -> Int { s.vals.length() }

pub fn db_query_recursive_series_sum(s : DbqueryrecursiveSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_query_recursive_series_mean(s : DbqueryrecursiveSeries) -> Double {
  let n = db_query_recursive_series_len(s)
  if n == 0 { 0.0 } else { db_query_recursive_series_sum(s) / n.to_double() }
}

pub fn db_query_recursive_series_min(s : DbqueryrecursiveSeries) -> Double {
  let n = db_query_recursive_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_recursive_series_max(s : DbqueryrecursiveSeries) -> Double {
  let n = db_query_recursive_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_recursive_series_range(s : DbqueryrecursiveSeries) -> Double {
  db_query_recursive_series_max(s) - db_query_recursive_series_min(s)
}

pub fn db_query_recursive_series_var(s : DbqueryrecursiveSeries) -> Double {
  let n = db_query_recursive_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_query_recursive_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_query_recursive_series_std(s : DbqueryrecursiveSeries) -> Double { db_query_recursive_sqrt(db_query_recursive_series_var(s)) }

pub fn db_query_recursive_series_median(s : DbqueryrecursiveSeries) -> Double {
  let n = db_query_recursive_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_query_recursive_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_recursive_series_scale(s : DbqueryrecursiveSeries, f : Double) -> DbqueryrecursiveSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_query_recursive_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_query_recursive_series_add(a : DbqueryrecursiveSeries, b : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_query_recursive_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_query_recursive_series_sub(a : DbqueryrecursiveSeries, b : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_query_recursive_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_query_recursive_series_normalize(s : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  let mn = db_query_recursive_series_min(s)
  let mx = db_query_recursive_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_query_recursive_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_query_recursive_series_cumsum(s : DbqueryrecursiveSeries) -> DbqueryrecursiveSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_query_recursive_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_query_recursive_series_to_string(s : DbqueryrecursiveSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_query_recursive_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryrecursiveMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_recursive_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryrecursiveMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_recursive_matrix_identity(n : Int) -> DbqueryrecursiveMatrix {
  let m = db_query_recursive_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_query_recursive_matrix_get(m : DbqueryrecursiveMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_query_recursive_matrix_transpose(m : DbqueryrecursiveMatrix) -> DbqueryrecursiveMatrix {
  let result = db_query_recursive_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_query_recursive_matrix_add(a : DbqueryrecursiveMatrix, b : DbqueryrecursiveMatrix) -> DbqueryrecursiveMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_query_recursive_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_query_recursive_matrix_scale(m : DbqueryrecursiveMatrix, s : Double) -> DbqueryrecursiveMatrix {
  let result = db_query_recursive_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_query_recursive_matrix_multiply(a : DbqueryrecursiveMatrix, b : DbqueryrecursiveMatrix) -> DbqueryrecursiveMatrix {
  if a.cols != b.rows { return db_query_recursive_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_query_recursive_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_query_recursive_matrix_trace(m : DbqueryrecursiveMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_query_recursive_matrix_det(m : DbqueryrecursiveMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_query_recursive_matrix_norm(m : DbqueryrecursiveMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_query_recursive_sqrt(sum)
}

pub fn db_query_recursive_matrix_to_string(m : DbqueryrecursiveMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_query_recursive_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbqueryrecursiveVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_recursive_make_vector(comps : Array[Double]) -> DbqueryrecursiveVector {
  { comps, dim: comps.length() }
}

pub fn db_query_recursive_vector_zero(dim : Int) -> DbqueryrecursiveVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_query_recursive_vector_add(a : DbqueryrecursiveVector, b : DbqueryrecursiveVector) -> DbqueryrecursiveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_query_recursive_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_recursive_vector_sub(a : DbqueryrecursiveVector, b : DbqueryrecursiveVector) -> DbqueryrecursiveVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_query_recursive_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_recursive_vector_scale(v : DbqueryrecursiveVector, s : Double) -> DbqueryrecursiveVector {
  let mut result = []
  for i in 0..<v.dim { result = db_query_recursive_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_query_recursive_vector_dot(a : DbqueryrecursiveVector, b : DbqueryrecursiveVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_query_recursive_vector_norm(v : DbqueryrecursiveVector) -> Double { db_query_recursive_sqrt(db_query_recursive_vector_dot(v, v)) }

pub fn db_query_recursive_vector_normalize(v : DbqueryrecursiveVector) -> DbqueryrecursiveVector {
  let n = db_query_recursive_vector_norm(v)
  if n < 0.0000001 { v } else { db_query_recursive_vector_scale(v, 1.0 / n) }
}

pub fn db_query_recursive_vector_dist(a : DbqueryrecursiveVector, b : DbqueryrecursiveVector) -> Double {
  db_query_recursive_vector_norm(db_query_recursive_vector_sub(a, b))
}

pub fn db_query_recursive_vector_to_string(v : DbqueryrecursiveVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_query_recursive_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_recursive_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_query_recursive_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_query_recursive_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_query_recursive_std(data : Array[Double]) -> Double { db_query_recursive_sqrt(db_query_recursive_var(data)) }

pub fn db_query_recursive_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_query_recursive_mean(a); let mb = db_query_recursive_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_query_recursive_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_query_recursive_std(a); let sb = db_query_recursive_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_query_recursive_cov(a, b) / (sa * sb) }
}

pub fn db_query_recursive_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_query_recursive_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_recursive_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_query_recursive_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_query_recursive_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_query_recursive_sqrt(db_query_recursive_mse(pred, labels))
}

pub fn db_query_recursive_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_query_recursive_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_query_recursive_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_query_recursive_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_query_recursive_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_query_recursive_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_query_recursive_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_query_recursive_precision(pred, labels, pos); let r = db_query_recursive_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_query_recursive_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_query_recursive_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_query_recursive_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_query_recursive_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_query_recursive_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_query_recursive_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_query_recursive_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_query_recursive_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_query_recursive_fibonacci(n : Int) -> Int {
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

pub fn db_query_recursive_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_query_recursive_min(data); let mx = db_query_recursive_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_query_recursive_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_query_recursive_mean(data); let sd = db_query_recursive_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_query_recursive_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_query_recursive_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_query_recursive_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_query_recursive_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_query_recursive_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_query_recursive_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_query_recursive_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_query_recursive_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_query_recursive_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_query_recursive_int(x) } else { -db_query_recursive_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_query_recursive_int(f * 1000000.0) } else { db_query_recursive_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_query_recursive_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_query_recursive_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbqueryrecursiveFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_frame_make(size : Int) -> DbqueryrecursiveFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_frame_len(s : DbqueryrecursiveFrame) -> Int { s.size }

pub fn db_query_recursive_frame_get(s : DbqueryrecursiveFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_frame_set(s : DbqueryrecursiveFrame, i : Int, v : Double) -> DbqueryrecursiveFrame {
  let result = db_query_recursive_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_frame_sum(s : DbqueryrecursiveFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_frame_mean(s : DbqueryrecursiveFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_frame_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_frame_scale(s : DbqueryrecursiveFrame, f : Double) -> DbqueryrecursiveFrame {
  let result = db_query_recursive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_frame_add(a : DbqueryrecursiveFrame, b : DbqueryrecursiveFrame) -> DbqueryrecursiveFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_frame_copy(s : DbqueryrecursiveFrame) -> DbqueryrecursiveFrame {
  let result = db_query_recursive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_frame_fill(s : DbqueryrecursiveFrame, v : Double) -> DbqueryrecursiveFrame {
  let result = db_query_recursive_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_frame_min(s : DbqueryrecursiveFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_frame_max(s : DbqueryrecursiveFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_frame_to_string(s : DbqueryrecursiveFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_table_make(size : Int) -> DbqueryrecursiveTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_table_len(s : DbqueryrecursiveTable) -> Int { s.size }

pub fn db_query_recursive_table_get(s : DbqueryrecursiveTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_table_set(s : DbqueryrecursiveTable, i : Int, v : Double) -> DbqueryrecursiveTable {
  let result = db_query_recursive_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_table_sum(s : DbqueryrecursiveTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_table_mean(s : DbqueryrecursiveTable) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_table_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_table_scale(s : DbqueryrecursiveTable, f : Double) -> DbqueryrecursiveTable {
  let result = db_query_recursive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_table_add(a : DbqueryrecursiveTable, b : DbqueryrecursiveTable) -> DbqueryrecursiveTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_table_copy(s : DbqueryrecursiveTable) -> DbqueryrecursiveTable {
  let result = db_query_recursive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_table_fill(s : DbqueryrecursiveTable, v : Double) -> DbqueryrecursiveTable {
  let result = db_query_recursive_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_table_min(s : DbqueryrecursiveTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_table_max(s : DbqueryrecursiveTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_table_to_string(s : DbqueryrecursiveTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_graphn_make(size : Int) -> DbqueryrecursiveGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_graphn_len(s : DbqueryrecursiveGraphN) -> Int { s.size }

pub fn db_query_recursive_graphn_get(s : DbqueryrecursiveGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_graphn_set(s : DbqueryrecursiveGraphN, i : Int, v : Double) -> DbqueryrecursiveGraphN {
  let result = db_query_recursive_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_graphn_sum(s : DbqueryrecursiveGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_graphn_mean(s : DbqueryrecursiveGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_graphn_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_graphn_scale(s : DbqueryrecursiveGraphN, f : Double) -> DbqueryrecursiveGraphN {
  let result = db_query_recursive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_graphn_add(a : DbqueryrecursiveGraphN, b : DbqueryrecursiveGraphN) -> DbqueryrecursiveGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_graphn_copy(s : DbqueryrecursiveGraphN) -> DbqueryrecursiveGraphN {
  let result = db_query_recursive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_graphn_fill(s : DbqueryrecursiveGraphN, v : Double) -> DbqueryrecursiveGraphN {
  let result = db_query_recursive_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_graphn_min(s : DbqueryrecursiveGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_graphn_max(s : DbqueryrecursiveGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_graphn_to_string(s : DbqueryrecursiveGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_node_make(size : Int) -> DbqueryrecursiveNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_node_len(s : DbqueryrecursiveNode) -> Int { s.size }

pub fn db_query_recursive_node_get(s : DbqueryrecursiveNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_node_set(s : DbqueryrecursiveNode, i : Int, v : Double) -> DbqueryrecursiveNode {
  let result = db_query_recursive_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_node_sum(s : DbqueryrecursiveNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_node_mean(s : DbqueryrecursiveNode) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_node_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_node_scale(s : DbqueryrecursiveNode, f : Double) -> DbqueryrecursiveNode {
  let result = db_query_recursive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_node_add(a : DbqueryrecursiveNode, b : DbqueryrecursiveNode) -> DbqueryrecursiveNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_node_copy(s : DbqueryrecursiveNode) -> DbqueryrecursiveNode {
  let result = db_query_recursive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_node_fill(s : DbqueryrecursiveNode, v : Double) -> DbqueryrecursiveNode {
  let result = db_query_recursive_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_node_min(s : DbqueryrecursiveNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_node_max(s : DbqueryrecursiveNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_node_to_string(s : DbqueryrecursiveNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_edge_make(size : Int) -> DbqueryrecursiveEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_edge_len(s : DbqueryrecursiveEdge) -> Int { s.size }

pub fn db_query_recursive_edge_get(s : DbqueryrecursiveEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_edge_set(s : DbqueryrecursiveEdge, i : Int, v : Double) -> DbqueryrecursiveEdge {
  let result = db_query_recursive_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_edge_sum(s : DbqueryrecursiveEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_edge_mean(s : DbqueryrecursiveEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_edge_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_edge_scale(s : DbqueryrecursiveEdge, f : Double) -> DbqueryrecursiveEdge {
  let result = db_query_recursive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_edge_add(a : DbqueryrecursiveEdge, b : DbqueryrecursiveEdge) -> DbqueryrecursiveEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_edge_copy(s : DbqueryrecursiveEdge) -> DbqueryrecursiveEdge {
  let result = db_query_recursive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_edge_fill(s : DbqueryrecursiveEdge, v : Double) -> DbqueryrecursiveEdge {
  let result = db_query_recursive_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_edge_min(s : DbqueryrecursiveEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_edge_max(s : DbqueryrecursiveEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_edge_to_string(s : DbqueryrecursiveEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursivePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_path_make(size : Int) -> DbqueryrecursivePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_path_len(s : DbqueryrecursivePath) -> Int { s.size }

pub fn db_query_recursive_path_get(s : DbqueryrecursivePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_path_set(s : DbqueryrecursivePath, i : Int, v : Double) -> DbqueryrecursivePath {
  let result = db_query_recursive_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_path_sum(s : DbqueryrecursivePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_path_mean(s : DbqueryrecursivePath) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_path_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_path_scale(s : DbqueryrecursivePath, f : Double) -> DbqueryrecursivePath {
  let result = db_query_recursive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_path_add(a : DbqueryrecursivePath, b : DbqueryrecursivePath) -> DbqueryrecursivePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_path_copy(s : DbqueryrecursivePath) -> DbqueryrecursivePath {
  let result = db_query_recursive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_path_fill(s : DbqueryrecursivePath, v : Double) -> DbqueryrecursivePath {
  let result = db_query_recursive_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_path_min(s : DbqueryrecursivePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_path_max(s : DbqueryrecursivePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_path_to_string(s : DbqueryrecursivePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_cluster_make(size : Int) -> DbqueryrecursiveCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_cluster_len(s : DbqueryrecursiveCluster) -> Int { s.size }

pub fn db_query_recursive_cluster_get(s : DbqueryrecursiveCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_cluster_set(s : DbqueryrecursiveCluster, i : Int, v : Double) -> DbqueryrecursiveCluster {
  let result = db_query_recursive_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_cluster_sum(s : DbqueryrecursiveCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_cluster_mean(s : DbqueryrecursiveCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_cluster_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_cluster_scale(s : DbqueryrecursiveCluster, f : Double) -> DbqueryrecursiveCluster {
  let result = db_query_recursive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_cluster_add(a : DbqueryrecursiveCluster, b : DbqueryrecursiveCluster) -> DbqueryrecursiveCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_cluster_copy(s : DbqueryrecursiveCluster) -> DbqueryrecursiveCluster {
  let result = db_query_recursive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_cluster_fill(s : DbqueryrecursiveCluster, v : Double) -> DbqueryrecursiveCluster {
  let result = db_query_recursive_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_cluster_min(s : DbqueryrecursiveCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_cluster_max(s : DbqueryrecursiveCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_cluster_to_string(s : DbqueryrecursiveCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_model_make(size : Int) -> DbqueryrecursiveModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_model_len(s : DbqueryrecursiveModel) -> Int { s.size }

pub fn db_query_recursive_model_get(s : DbqueryrecursiveModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_model_set(s : DbqueryrecursiveModel, i : Int, v : Double) -> DbqueryrecursiveModel {
  let result = db_query_recursive_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_model_sum(s : DbqueryrecursiveModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_model_mean(s : DbqueryrecursiveModel) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_model_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_model_scale(s : DbqueryrecursiveModel, f : Double) -> DbqueryrecursiveModel {
  let result = db_query_recursive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_model_add(a : DbqueryrecursiveModel, b : DbqueryrecursiveModel) -> DbqueryrecursiveModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_model_copy(s : DbqueryrecursiveModel) -> DbqueryrecursiveModel {
  let result = db_query_recursive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_model_fill(s : DbqueryrecursiveModel, v : Double) -> DbqueryrecursiveModel {
  let result = db_query_recursive_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_model_min(s : DbqueryrecursiveModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_model_max(s : DbqueryrecursiveModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_model_to_string(s : DbqueryrecursiveModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_layer_make(size : Int) -> DbqueryrecursiveLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_layer_len(s : DbqueryrecursiveLayer) -> Int { s.size }

pub fn db_query_recursive_layer_get(s : DbqueryrecursiveLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_layer_set(s : DbqueryrecursiveLayer, i : Int, v : Double) -> DbqueryrecursiveLayer {
  let result = db_query_recursive_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_layer_sum(s : DbqueryrecursiveLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_layer_mean(s : DbqueryrecursiveLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_layer_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_layer_scale(s : DbqueryrecursiveLayer, f : Double) -> DbqueryrecursiveLayer {
  let result = db_query_recursive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_layer_add(a : DbqueryrecursiveLayer, b : DbqueryrecursiveLayer) -> DbqueryrecursiveLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_layer_copy(s : DbqueryrecursiveLayer) -> DbqueryrecursiveLayer {
  let result = db_query_recursive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_layer_fill(s : DbqueryrecursiveLayer, v : Double) -> DbqueryrecursiveLayer {
  let result = db_query_recursive_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_layer_min(s : DbqueryrecursiveLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_layer_max(s : DbqueryrecursiveLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_layer_to_string(s : DbqueryrecursiveLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_buffer_make(size : Int) -> DbqueryrecursiveBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_buffer_len(s : DbqueryrecursiveBuffer) -> Int { s.size }

pub fn db_query_recursive_buffer_get(s : DbqueryrecursiveBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_buffer_set(s : DbqueryrecursiveBuffer, i : Int, v : Double) -> DbqueryrecursiveBuffer {
  let result = db_query_recursive_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_buffer_sum(s : DbqueryrecursiveBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_buffer_mean(s : DbqueryrecursiveBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_buffer_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_buffer_scale(s : DbqueryrecursiveBuffer, f : Double) -> DbqueryrecursiveBuffer {
  let result = db_query_recursive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_buffer_add(a : DbqueryrecursiveBuffer, b : DbqueryrecursiveBuffer) -> DbqueryrecursiveBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_buffer_copy(s : DbqueryrecursiveBuffer) -> DbqueryrecursiveBuffer {
  let result = db_query_recursive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_buffer_fill(s : DbqueryrecursiveBuffer, v : Double) -> DbqueryrecursiveBuffer {
  let result = db_query_recursive_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_buffer_min(s : DbqueryrecursiveBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_buffer_max(s : DbqueryrecursiveBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_buffer_to_string(s : DbqueryrecursiveBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_cursor_make(size : Int) -> DbqueryrecursiveCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_cursor_len(s : DbqueryrecursiveCursor) -> Int { s.size }

pub fn db_query_recursive_cursor_get(s : DbqueryrecursiveCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_cursor_set(s : DbqueryrecursiveCursor, i : Int, v : Double) -> DbqueryrecursiveCursor {
  let result = db_query_recursive_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_cursor_sum(s : DbqueryrecursiveCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_cursor_mean(s : DbqueryrecursiveCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_cursor_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_cursor_scale(s : DbqueryrecursiveCursor, f : Double) -> DbqueryrecursiveCursor {
  let result = db_query_recursive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_cursor_add(a : DbqueryrecursiveCursor, b : DbqueryrecursiveCursor) -> DbqueryrecursiveCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_cursor_copy(s : DbqueryrecursiveCursor) -> DbqueryrecursiveCursor {
  let result = db_query_recursive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_cursor_fill(s : DbqueryrecursiveCursor, v : Double) -> DbqueryrecursiveCursor {
  let result = db_query_recursive_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_cursor_min(s : DbqueryrecursiveCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_cursor_max(s : DbqueryrecursiveCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_cursor_to_string(s : DbqueryrecursiveCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_view_make(size : Int) -> DbqueryrecursiveView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_view_len(s : DbqueryrecursiveView) -> Int { s.size }

pub fn db_query_recursive_view_get(s : DbqueryrecursiveView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_view_set(s : DbqueryrecursiveView, i : Int, v : Double) -> DbqueryrecursiveView {
  let result = db_query_recursive_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_view_sum(s : DbqueryrecursiveView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_view_mean(s : DbqueryrecursiveView) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_view_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_view_scale(s : DbqueryrecursiveView, f : Double) -> DbqueryrecursiveView {
  let result = db_query_recursive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_view_add(a : DbqueryrecursiveView, b : DbqueryrecursiveView) -> DbqueryrecursiveView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_view_copy(s : DbqueryrecursiveView) -> DbqueryrecursiveView {
  let result = db_query_recursive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_view_fill(s : DbqueryrecursiveView, v : Double) -> DbqueryrecursiveView {
  let result = db_query_recursive_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_view_min(s : DbqueryrecursiveView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_view_max(s : DbqueryrecursiveView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_view_to_string(s : DbqueryrecursiveView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_range_make(size : Int) -> DbqueryrecursiveRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_range_len(s : DbqueryrecursiveRange) -> Int { s.size }

pub fn db_query_recursive_range_get(s : DbqueryrecursiveRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_range_set(s : DbqueryrecursiveRange, i : Int, v : Double) -> DbqueryrecursiveRange {
  let result = db_query_recursive_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_range_sum(s : DbqueryrecursiveRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_range_mean(s : DbqueryrecursiveRange) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_range_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_range_scale(s : DbqueryrecursiveRange, f : Double) -> DbqueryrecursiveRange {
  let result = db_query_recursive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_range_add(a : DbqueryrecursiveRange, b : DbqueryrecursiveRange) -> DbqueryrecursiveRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_range_copy(s : DbqueryrecursiveRange) -> DbqueryrecursiveRange {
  let result = db_query_recursive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_range_fill(s : DbqueryrecursiveRange, v : Double) -> DbqueryrecursiveRange {
  let result = db_query_recursive_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_range_min(s : DbqueryrecursiveRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_range_max(s : DbqueryrecursiveRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_range_to_string(s : DbqueryrecursiveRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryrecursiveSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_recursive_slice_make(size : Int) -> DbqueryrecursiveSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_recursive_slice_len(s : DbqueryrecursiveSlice) -> Int { s.size }

pub fn db_query_recursive_slice_get(s : DbqueryrecursiveSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_recursive_slice_set(s : DbqueryrecursiveSlice, i : Int, v : Double) -> DbqueryrecursiveSlice {
  let result = db_query_recursive_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_slice_sum(s : DbqueryrecursiveSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_recursive_slice_mean(s : DbqueryrecursiveSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_query_recursive_slice_sum(s) / s.size.to_double() }
}

pub fn db_query_recursive_slice_scale(s : DbqueryrecursiveSlice, f : Double) -> DbqueryrecursiveSlice {
  let result = db_query_recursive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_recursive_slice_add(a : DbqueryrecursiveSlice, b : DbqueryrecursiveSlice) -> DbqueryrecursiveSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_recursive_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_recursive_slice_copy(s : DbqueryrecursiveSlice) -> DbqueryrecursiveSlice {
  let result = db_query_recursive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_recursive_slice_fill(s : DbqueryrecursiveSlice, v : Double) -> DbqueryrecursiveSlice {
  let result = db_query_recursive_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_recursive_slice_min(s : DbqueryrecursiveSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_slice_max(s : DbqueryrecursiveSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_recursive_slice_to_string(s : DbqueryrecursiveSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_query_recursive_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_recursive_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

