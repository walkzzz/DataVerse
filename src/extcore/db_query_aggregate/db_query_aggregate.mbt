///===
/// extcore/db_query_aggregate

pub(all) struct DbqueryaggregatePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_aggregate_make_point(x : Double, y : Double) -> DbqueryaggregatePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_aggregate_make_point3(x : Double, y : Double, z : Double) -> DbqueryaggregatePoint {
  { x, y, z, label: 0 }
}

pub fn db_query_aggregate_point_x(pt : DbqueryaggregatePoint) -> Double { pt.x }

pub fn db_query_aggregate_point_y(pt : DbqueryaggregatePoint) -> Double { pt.y }

pub fn db_query_aggregate_point_z(pt : DbqueryaggregatePoint) -> Double { pt.z }

pub fn db_query_aggregate_point_label(pt : DbqueryaggregatePoint) -> Int { pt.label }

pub fn db_query_aggregate_point_dist(a : DbqueryaggregatePoint, b : DbqueryaggregatePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_query_aggregate_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_query_aggregate_point_add(a : DbqueryaggregatePoint, b : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_query_aggregate_point_sub(a : DbqueryaggregatePoint, b : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_query_aggregate_point_scale(pt : DbqueryaggregatePoint, s : Double) -> DbqueryaggregatePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_query_aggregate_point_dot(a : DbqueryaggregatePoint, b : DbqueryaggregatePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_query_aggregate_point_cross(a : DbqueryaggregatePoint, b : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_query_aggregate_point_norm(pt : DbqueryaggregatePoint) -> Double {
  db_query_aggregate_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_query_aggregate_point_normalize(pt : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  let n = db_query_aggregate_point_norm(pt)
  if n < 0.0000001 { pt } else { db_query_aggregate_point_scale(pt, 1.0 / n) }
}

pub fn db_query_aggregate_point_negate(pt : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_query_aggregate_point_mid(a : DbqueryaggregatePoint, b : DbqueryaggregatePoint) -> DbqueryaggregatePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_query_aggregate_point_lerp(a : DbqueryaggregatePoint, b : DbqueryaggregatePoint, t : Double) -> DbqueryaggregatePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_query_aggregate_point_to_string(pt : DbqueryaggregatePoint) -> String {
  "(" + db_query_aggregate_dbl(pt.x) + ", " + db_query_aggregate_dbl(pt.y) + ", " + db_query_aggregate_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbqueryaggregateSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_aggregate_make_series(vals : Array[Double], name : String) -> DbqueryaggregateSeries {
  { vals, name, meta: 0 }
}

pub fn db_query_aggregate_series_len(s : DbqueryaggregateSeries) -> Int { s.vals.length() }

pub fn db_query_aggregate_series_sum(s : DbqueryaggregateSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_query_aggregate_series_mean(s : DbqueryaggregateSeries) -> Double {
  let n = db_query_aggregate_series_len(s)
  if n == 0 { 0.0 } else { db_query_aggregate_series_sum(s) / n.to_double() }
}

pub fn db_query_aggregate_series_min(s : DbqueryaggregateSeries) -> Double {
  let n = db_query_aggregate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_aggregate_series_max(s : DbqueryaggregateSeries) -> Double {
  let n = db_query_aggregate_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_aggregate_series_range(s : DbqueryaggregateSeries) -> Double {
  db_query_aggregate_series_max(s) - db_query_aggregate_series_min(s)
}

pub fn db_query_aggregate_series_var(s : DbqueryaggregateSeries) -> Double {
  let n = db_query_aggregate_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_query_aggregate_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_query_aggregate_series_std(s : DbqueryaggregateSeries) -> Double { db_query_aggregate_sqrt(db_query_aggregate_series_var(s)) }

pub fn db_query_aggregate_series_median(s : DbqueryaggregateSeries) -> Double {
  let n = db_query_aggregate_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_query_aggregate_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_aggregate_series_scale(s : DbqueryaggregateSeries, f : Double) -> DbqueryaggregateSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_query_aggregate_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_query_aggregate_series_add(a : DbqueryaggregateSeries, b : DbqueryaggregateSeries) -> DbqueryaggregateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_query_aggregate_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_query_aggregate_series_sub(a : DbqueryaggregateSeries, b : DbqueryaggregateSeries) -> DbqueryaggregateSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_query_aggregate_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_query_aggregate_series_normalize(s : DbqueryaggregateSeries) -> DbqueryaggregateSeries {
  let mn = db_query_aggregate_series_min(s)
  let mx = db_query_aggregate_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_query_aggregate_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_query_aggregate_series_cumsum(s : DbqueryaggregateSeries) -> DbqueryaggregateSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_query_aggregate_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_query_aggregate_series_to_string(s : DbqueryaggregateSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_query_aggregate_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbqueryaggregateMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_aggregate_make_matrix(rows : Int, cols : Int, val : Double) -> DbqueryaggregateMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_aggregate_matrix_identity(n : Int) -> DbqueryaggregateMatrix {
  let m = db_query_aggregate_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_query_aggregate_matrix_get(m : DbqueryaggregateMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_query_aggregate_matrix_transpose(m : DbqueryaggregateMatrix) -> DbqueryaggregateMatrix {
  let result = db_query_aggregate_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_query_aggregate_matrix_add(a : DbqueryaggregateMatrix, b : DbqueryaggregateMatrix) -> DbqueryaggregateMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_query_aggregate_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_query_aggregate_matrix_scale(m : DbqueryaggregateMatrix, s : Double) -> DbqueryaggregateMatrix {
  let result = db_query_aggregate_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_query_aggregate_matrix_multiply(a : DbqueryaggregateMatrix, b : DbqueryaggregateMatrix) -> DbqueryaggregateMatrix {
  if a.cols != b.rows { return db_query_aggregate_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_query_aggregate_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_query_aggregate_matrix_trace(m : DbqueryaggregateMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_query_aggregate_matrix_det(m : DbqueryaggregateMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_query_aggregate_matrix_norm(m : DbqueryaggregateMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_query_aggregate_sqrt(sum)
}

pub fn db_query_aggregate_matrix_to_string(m : DbqueryaggregateMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_query_aggregate_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbqueryaggregateVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_aggregate_make_vector(comps : Array[Double]) -> DbqueryaggregateVector {
  { comps, dim: comps.length() }
}

pub fn db_query_aggregate_vector_zero(dim : Int) -> DbqueryaggregateVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_query_aggregate_vector_add(a : DbqueryaggregateVector, b : DbqueryaggregateVector) -> DbqueryaggregateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_query_aggregate_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_aggregate_vector_sub(a : DbqueryaggregateVector, b : DbqueryaggregateVector) -> DbqueryaggregateVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_query_aggregate_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_aggregate_vector_scale(v : DbqueryaggregateVector, s : Double) -> DbqueryaggregateVector {
  let mut result = []
  for i in 0..<v.dim { result = db_query_aggregate_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_query_aggregate_vector_dot(a : DbqueryaggregateVector, b : DbqueryaggregateVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_query_aggregate_vector_norm(v : DbqueryaggregateVector) -> Double { db_query_aggregate_sqrt(db_query_aggregate_vector_dot(v, v)) }

pub fn db_query_aggregate_vector_normalize(v : DbqueryaggregateVector) -> DbqueryaggregateVector {
  let n = db_query_aggregate_vector_norm(v)
  if n < 0.0000001 { v } else { db_query_aggregate_vector_scale(v, 1.0 / n) }
}

pub fn db_query_aggregate_vector_dist(a : DbqueryaggregateVector, b : DbqueryaggregateVector) -> Double {
  db_query_aggregate_vector_norm(db_query_aggregate_vector_sub(a, b))
}

pub fn db_query_aggregate_vector_to_string(v : DbqueryaggregateVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_query_aggregate_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_aggregate_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_query_aggregate_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_query_aggregate_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_query_aggregate_std(data : Array[Double]) -> Double { db_query_aggregate_sqrt(db_query_aggregate_var(data)) }

pub fn db_query_aggregate_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_query_aggregate_mean(a); let mb = db_query_aggregate_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_query_aggregate_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_query_aggregate_std(a); let sb = db_query_aggregate_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_query_aggregate_cov(a, b) / (sa * sb) }
}

pub fn db_query_aggregate_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_query_aggregate_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_aggregate_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_query_aggregate_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_query_aggregate_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_query_aggregate_sqrt(db_query_aggregate_mse(pred, labels))
}

pub fn db_query_aggregate_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_query_aggregate_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_query_aggregate_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_query_aggregate_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_query_aggregate_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_query_aggregate_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_query_aggregate_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_query_aggregate_precision(pred, labels, pos); let r = db_query_aggregate_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_query_aggregate_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_query_aggregate_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_query_aggregate_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_query_aggregate_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_query_aggregate_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_query_aggregate_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_query_aggregate_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_query_aggregate_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_query_aggregate_fibonacci(n : Int) -> Int {
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

pub fn db_query_aggregate_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_query_aggregate_min(data); let mx = db_query_aggregate_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_query_aggregate_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_query_aggregate_mean(data); let sd = db_query_aggregate_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_query_aggregate_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_query_aggregate_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_query_aggregate_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_query_aggregate_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_query_aggregate_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_query_aggregate_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_query_aggregate_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_query_aggregate_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_query_aggregate_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_query_aggregate_int(x) } else { -db_query_aggregate_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_query_aggregate_int(f * 1000000.0) } else { db_query_aggregate_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_query_aggregate_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_query_aggregate_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbqueryaggregateFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_frame_make(size : Int) -> DbqueryaggregateFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_frame_len(s : DbqueryaggregateFrame) -> Int { s.size }

pub fn db_query_aggregate_frame_get(s : DbqueryaggregateFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_frame_set(s : DbqueryaggregateFrame, i : Int, v : Double) -> DbqueryaggregateFrame {
  let result = db_query_aggregate_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_frame_sum(s : DbqueryaggregateFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_frame_mean(s : DbqueryaggregateFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_frame_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_frame_scale(s : DbqueryaggregateFrame, f : Double) -> DbqueryaggregateFrame {
  let result = db_query_aggregate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_frame_add(a : DbqueryaggregateFrame, b : DbqueryaggregateFrame) -> DbqueryaggregateFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_frame_copy(s : DbqueryaggregateFrame) -> DbqueryaggregateFrame {
  let result = db_query_aggregate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_frame_fill(s : DbqueryaggregateFrame, v : Double) -> DbqueryaggregateFrame {
  let result = db_query_aggregate_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_frame_min(s : DbqueryaggregateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_frame_max(s : DbqueryaggregateFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_frame_to_string(s : DbqueryaggregateFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_table_make(size : Int) -> DbqueryaggregateTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_table_len(s : DbqueryaggregateTable) -> Int { s.size }

pub fn db_query_aggregate_table_get(s : DbqueryaggregateTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_table_set(s : DbqueryaggregateTable, i : Int, v : Double) -> DbqueryaggregateTable {
  let result = db_query_aggregate_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_table_sum(s : DbqueryaggregateTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_table_mean(s : DbqueryaggregateTable) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_table_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_table_scale(s : DbqueryaggregateTable, f : Double) -> DbqueryaggregateTable {
  let result = db_query_aggregate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_table_add(a : DbqueryaggregateTable, b : DbqueryaggregateTable) -> DbqueryaggregateTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_table_copy(s : DbqueryaggregateTable) -> DbqueryaggregateTable {
  let result = db_query_aggregate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_table_fill(s : DbqueryaggregateTable, v : Double) -> DbqueryaggregateTable {
  let result = db_query_aggregate_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_table_min(s : DbqueryaggregateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_table_max(s : DbqueryaggregateTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_table_to_string(s : DbqueryaggregateTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_graphn_make(size : Int) -> DbqueryaggregateGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_graphn_len(s : DbqueryaggregateGraphN) -> Int { s.size }

pub fn db_query_aggregate_graphn_get(s : DbqueryaggregateGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_graphn_set(s : DbqueryaggregateGraphN, i : Int, v : Double) -> DbqueryaggregateGraphN {
  let result = db_query_aggregate_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_graphn_sum(s : DbqueryaggregateGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_graphn_mean(s : DbqueryaggregateGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_graphn_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_graphn_scale(s : DbqueryaggregateGraphN, f : Double) -> DbqueryaggregateGraphN {
  let result = db_query_aggregate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_graphn_add(a : DbqueryaggregateGraphN, b : DbqueryaggregateGraphN) -> DbqueryaggregateGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_graphn_copy(s : DbqueryaggregateGraphN) -> DbqueryaggregateGraphN {
  let result = db_query_aggregate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_graphn_fill(s : DbqueryaggregateGraphN, v : Double) -> DbqueryaggregateGraphN {
  let result = db_query_aggregate_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_graphn_min(s : DbqueryaggregateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_graphn_max(s : DbqueryaggregateGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_graphn_to_string(s : DbqueryaggregateGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_node_make(size : Int) -> DbqueryaggregateNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_node_len(s : DbqueryaggregateNode) -> Int { s.size }

pub fn db_query_aggregate_node_get(s : DbqueryaggregateNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_node_set(s : DbqueryaggregateNode, i : Int, v : Double) -> DbqueryaggregateNode {
  let result = db_query_aggregate_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_node_sum(s : DbqueryaggregateNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_node_mean(s : DbqueryaggregateNode) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_node_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_node_scale(s : DbqueryaggregateNode, f : Double) -> DbqueryaggregateNode {
  let result = db_query_aggregate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_node_add(a : DbqueryaggregateNode, b : DbqueryaggregateNode) -> DbqueryaggregateNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_node_copy(s : DbqueryaggregateNode) -> DbqueryaggregateNode {
  let result = db_query_aggregate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_node_fill(s : DbqueryaggregateNode, v : Double) -> DbqueryaggregateNode {
  let result = db_query_aggregate_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_node_min(s : DbqueryaggregateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_node_max(s : DbqueryaggregateNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_node_to_string(s : DbqueryaggregateNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_edge_make(size : Int) -> DbqueryaggregateEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_edge_len(s : DbqueryaggregateEdge) -> Int { s.size }

pub fn db_query_aggregate_edge_get(s : DbqueryaggregateEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_edge_set(s : DbqueryaggregateEdge, i : Int, v : Double) -> DbqueryaggregateEdge {
  let result = db_query_aggregate_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_edge_sum(s : DbqueryaggregateEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_edge_mean(s : DbqueryaggregateEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_edge_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_edge_scale(s : DbqueryaggregateEdge, f : Double) -> DbqueryaggregateEdge {
  let result = db_query_aggregate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_edge_add(a : DbqueryaggregateEdge, b : DbqueryaggregateEdge) -> DbqueryaggregateEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_edge_copy(s : DbqueryaggregateEdge) -> DbqueryaggregateEdge {
  let result = db_query_aggregate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_edge_fill(s : DbqueryaggregateEdge, v : Double) -> DbqueryaggregateEdge {
  let result = db_query_aggregate_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_edge_min(s : DbqueryaggregateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_edge_max(s : DbqueryaggregateEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_edge_to_string(s : DbqueryaggregateEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregatePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_path_make(size : Int) -> DbqueryaggregatePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_path_len(s : DbqueryaggregatePath) -> Int { s.size }

pub fn db_query_aggregate_path_get(s : DbqueryaggregatePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_path_set(s : DbqueryaggregatePath, i : Int, v : Double) -> DbqueryaggregatePath {
  let result = db_query_aggregate_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_path_sum(s : DbqueryaggregatePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_path_mean(s : DbqueryaggregatePath) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_path_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_path_scale(s : DbqueryaggregatePath, f : Double) -> DbqueryaggregatePath {
  let result = db_query_aggregate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_path_add(a : DbqueryaggregatePath, b : DbqueryaggregatePath) -> DbqueryaggregatePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_path_copy(s : DbqueryaggregatePath) -> DbqueryaggregatePath {
  let result = db_query_aggregate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_path_fill(s : DbqueryaggregatePath, v : Double) -> DbqueryaggregatePath {
  let result = db_query_aggregate_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_path_min(s : DbqueryaggregatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_path_max(s : DbqueryaggregatePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_path_to_string(s : DbqueryaggregatePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_cluster_make(size : Int) -> DbqueryaggregateCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_cluster_len(s : DbqueryaggregateCluster) -> Int { s.size }

pub fn db_query_aggregate_cluster_get(s : DbqueryaggregateCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_cluster_set(s : DbqueryaggregateCluster, i : Int, v : Double) -> DbqueryaggregateCluster {
  let result = db_query_aggregate_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_cluster_sum(s : DbqueryaggregateCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_cluster_mean(s : DbqueryaggregateCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_cluster_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_cluster_scale(s : DbqueryaggregateCluster, f : Double) -> DbqueryaggregateCluster {
  let result = db_query_aggregate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_cluster_add(a : DbqueryaggregateCluster, b : DbqueryaggregateCluster) -> DbqueryaggregateCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_cluster_copy(s : DbqueryaggregateCluster) -> DbqueryaggregateCluster {
  let result = db_query_aggregate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_cluster_fill(s : DbqueryaggregateCluster, v : Double) -> DbqueryaggregateCluster {
  let result = db_query_aggregate_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_cluster_min(s : DbqueryaggregateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_cluster_max(s : DbqueryaggregateCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_cluster_to_string(s : DbqueryaggregateCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_model_make(size : Int) -> DbqueryaggregateModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_model_len(s : DbqueryaggregateModel) -> Int { s.size }

pub fn db_query_aggregate_model_get(s : DbqueryaggregateModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_model_set(s : DbqueryaggregateModel, i : Int, v : Double) -> DbqueryaggregateModel {
  let result = db_query_aggregate_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_model_sum(s : DbqueryaggregateModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_model_mean(s : DbqueryaggregateModel) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_model_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_model_scale(s : DbqueryaggregateModel, f : Double) -> DbqueryaggregateModel {
  let result = db_query_aggregate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_model_add(a : DbqueryaggregateModel, b : DbqueryaggregateModel) -> DbqueryaggregateModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_model_copy(s : DbqueryaggregateModel) -> DbqueryaggregateModel {
  let result = db_query_aggregate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_model_fill(s : DbqueryaggregateModel, v : Double) -> DbqueryaggregateModel {
  let result = db_query_aggregate_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_model_min(s : DbqueryaggregateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_model_max(s : DbqueryaggregateModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_model_to_string(s : DbqueryaggregateModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_layer_make(size : Int) -> DbqueryaggregateLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_layer_len(s : DbqueryaggregateLayer) -> Int { s.size }

pub fn db_query_aggregate_layer_get(s : DbqueryaggregateLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_layer_set(s : DbqueryaggregateLayer, i : Int, v : Double) -> DbqueryaggregateLayer {
  let result = db_query_aggregate_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_layer_sum(s : DbqueryaggregateLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_layer_mean(s : DbqueryaggregateLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_layer_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_layer_scale(s : DbqueryaggregateLayer, f : Double) -> DbqueryaggregateLayer {
  let result = db_query_aggregate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_layer_add(a : DbqueryaggregateLayer, b : DbqueryaggregateLayer) -> DbqueryaggregateLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_layer_copy(s : DbqueryaggregateLayer) -> DbqueryaggregateLayer {
  let result = db_query_aggregate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_layer_fill(s : DbqueryaggregateLayer, v : Double) -> DbqueryaggregateLayer {
  let result = db_query_aggregate_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_layer_min(s : DbqueryaggregateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_layer_max(s : DbqueryaggregateLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_layer_to_string(s : DbqueryaggregateLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_buffer_make(size : Int) -> DbqueryaggregateBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_buffer_len(s : DbqueryaggregateBuffer) -> Int { s.size }

pub fn db_query_aggregate_buffer_get(s : DbqueryaggregateBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_buffer_set(s : DbqueryaggregateBuffer, i : Int, v : Double) -> DbqueryaggregateBuffer {
  let result = db_query_aggregate_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_buffer_sum(s : DbqueryaggregateBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_buffer_mean(s : DbqueryaggregateBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_buffer_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_buffer_scale(s : DbqueryaggregateBuffer, f : Double) -> DbqueryaggregateBuffer {
  let result = db_query_aggregate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_buffer_add(a : DbqueryaggregateBuffer, b : DbqueryaggregateBuffer) -> DbqueryaggregateBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_buffer_copy(s : DbqueryaggregateBuffer) -> DbqueryaggregateBuffer {
  let result = db_query_aggregate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_buffer_fill(s : DbqueryaggregateBuffer, v : Double) -> DbqueryaggregateBuffer {
  let result = db_query_aggregate_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_buffer_min(s : DbqueryaggregateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_buffer_max(s : DbqueryaggregateBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_buffer_to_string(s : DbqueryaggregateBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_cursor_make(size : Int) -> DbqueryaggregateCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_cursor_len(s : DbqueryaggregateCursor) -> Int { s.size }

pub fn db_query_aggregate_cursor_get(s : DbqueryaggregateCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_cursor_set(s : DbqueryaggregateCursor, i : Int, v : Double) -> DbqueryaggregateCursor {
  let result = db_query_aggregate_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_cursor_sum(s : DbqueryaggregateCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_cursor_mean(s : DbqueryaggregateCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_cursor_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_cursor_scale(s : DbqueryaggregateCursor, f : Double) -> DbqueryaggregateCursor {
  let result = db_query_aggregate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_cursor_add(a : DbqueryaggregateCursor, b : DbqueryaggregateCursor) -> DbqueryaggregateCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_cursor_copy(s : DbqueryaggregateCursor) -> DbqueryaggregateCursor {
  let result = db_query_aggregate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_cursor_fill(s : DbqueryaggregateCursor, v : Double) -> DbqueryaggregateCursor {
  let result = db_query_aggregate_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_cursor_min(s : DbqueryaggregateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_cursor_max(s : DbqueryaggregateCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_cursor_to_string(s : DbqueryaggregateCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_view_make(size : Int) -> DbqueryaggregateView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_view_len(s : DbqueryaggregateView) -> Int { s.size }

pub fn db_query_aggregate_view_get(s : DbqueryaggregateView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_view_set(s : DbqueryaggregateView, i : Int, v : Double) -> DbqueryaggregateView {
  let result = db_query_aggregate_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_view_sum(s : DbqueryaggregateView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_view_mean(s : DbqueryaggregateView) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_view_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_view_scale(s : DbqueryaggregateView, f : Double) -> DbqueryaggregateView {
  let result = db_query_aggregate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_view_add(a : DbqueryaggregateView, b : DbqueryaggregateView) -> DbqueryaggregateView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_view_copy(s : DbqueryaggregateView) -> DbqueryaggregateView {
  let result = db_query_aggregate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_view_fill(s : DbqueryaggregateView, v : Double) -> DbqueryaggregateView {
  let result = db_query_aggregate_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_view_min(s : DbqueryaggregateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_view_max(s : DbqueryaggregateView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_view_to_string(s : DbqueryaggregateView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_range_make(size : Int) -> DbqueryaggregateRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_range_len(s : DbqueryaggregateRange) -> Int { s.size }

pub fn db_query_aggregate_range_get(s : DbqueryaggregateRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_range_set(s : DbqueryaggregateRange, i : Int, v : Double) -> DbqueryaggregateRange {
  let result = db_query_aggregate_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_range_sum(s : DbqueryaggregateRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_range_mean(s : DbqueryaggregateRange) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_range_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_range_scale(s : DbqueryaggregateRange, f : Double) -> DbqueryaggregateRange {
  let result = db_query_aggregate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_range_add(a : DbqueryaggregateRange, b : DbqueryaggregateRange) -> DbqueryaggregateRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_range_copy(s : DbqueryaggregateRange) -> DbqueryaggregateRange {
  let result = db_query_aggregate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_range_fill(s : DbqueryaggregateRange, v : Double) -> DbqueryaggregateRange {
  let result = db_query_aggregate_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_range_min(s : DbqueryaggregateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_range_max(s : DbqueryaggregateRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_range_to_string(s : DbqueryaggregateRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbqueryaggregateSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_aggregate_slice_make(size : Int) -> DbqueryaggregateSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_aggregate_slice_len(s : DbqueryaggregateSlice) -> Int { s.size }

pub fn db_query_aggregate_slice_get(s : DbqueryaggregateSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_aggregate_slice_set(s : DbqueryaggregateSlice, i : Int, v : Double) -> DbqueryaggregateSlice {
  let result = db_query_aggregate_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_slice_sum(s : DbqueryaggregateSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_aggregate_slice_mean(s : DbqueryaggregateSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_query_aggregate_slice_sum(s) / s.size.to_double() }
}

pub fn db_query_aggregate_slice_scale(s : DbqueryaggregateSlice, f : Double) -> DbqueryaggregateSlice {
  let result = db_query_aggregate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_aggregate_slice_add(a : DbqueryaggregateSlice, b : DbqueryaggregateSlice) -> DbqueryaggregateSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_aggregate_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_aggregate_slice_copy(s : DbqueryaggregateSlice) -> DbqueryaggregateSlice {
  let result = db_query_aggregate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_aggregate_slice_fill(s : DbqueryaggregateSlice, v : Double) -> DbqueryaggregateSlice {
  let result = db_query_aggregate_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_aggregate_slice_min(s : DbqueryaggregateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_slice_max(s : DbqueryaggregateSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_aggregate_slice_to_string(s : DbqueryaggregateSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_query_aggregate_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_aggregate_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

