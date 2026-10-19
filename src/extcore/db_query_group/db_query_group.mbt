///===
/// extcore/db_query_group

pub(all) struct DbquerygroupPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_query_group_make_point(x : Double, y : Double) -> DbquerygroupPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_query_group_make_point3(x : Double, y : Double, z : Double) -> DbquerygroupPoint {
  { x, y, z, label: 0 }
}

pub fn db_query_group_point_x(pt : DbquerygroupPoint) -> Double { pt.x }

pub fn db_query_group_point_y(pt : DbquerygroupPoint) -> Double { pt.y }

pub fn db_query_group_point_z(pt : DbquerygroupPoint) -> Double { pt.z }

pub fn db_query_group_point_label(pt : DbquerygroupPoint) -> Int { pt.label }

pub fn db_query_group_point_dist(a : DbquerygroupPoint, b : DbquerygroupPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_query_group_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_query_group_point_add(a : DbquerygroupPoint, b : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_query_group_point_sub(a : DbquerygroupPoint, b : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_query_group_point_scale(pt : DbquerygroupPoint, s : Double) -> DbquerygroupPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_query_group_point_dot(a : DbquerygroupPoint, b : DbquerygroupPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_query_group_point_cross(a : DbquerygroupPoint, b : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_query_group_point_norm(pt : DbquerygroupPoint) -> Double {
  db_query_group_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_query_group_point_normalize(pt : DbquerygroupPoint) -> DbquerygroupPoint {
  let n = db_query_group_point_norm(pt)
  if n < 0.0000001 { pt } else { db_query_group_point_scale(pt, 1.0 / n) }
}

pub fn db_query_group_point_negate(pt : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_query_group_point_mid(a : DbquerygroupPoint, b : DbquerygroupPoint) -> DbquerygroupPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_query_group_point_lerp(a : DbquerygroupPoint, b : DbquerygroupPoint, t : Double) -> DbquerygroupPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_query_group_point_to_string(pt : DbquerygroupPoint) -> String {
  "(" + db_query_group_dbl(pt.x) + ", " + db_query_group_dbl(pt.y) + ", " + db_query_group_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbquerygroupSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_query_group_make_series(vals : Array[Double], name : String) -> DbquerygroupSeries {
  { vals, name, meta: 0 }
}

pub fn db_query_group_series_len(s : DbquerygroupSeries) -> Int { s.vals.length() }

pub fn db_query_group_series_sum(s : DbquerygroupSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_query_group_series_mean(s : DbquerygroupSeries) -> Double {
  let n = db_query_group_series_len(s)
  if n == 0 { 0.0 } else { db_query_group_series_sum(s) / n.to_double() }
}

pub fn db_query_group_series_min(s : DbquerygroupSeries) -> Double {
  let n = db_query_group_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_group_series_max(s : DbquerygroupSeries) -> Double {
  let n = db_query_group_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_query_group_series_range(s : DbquerygroupSeries) -> Double {
  db_query_group_series_max(s) - db_query_group_series_min(s)
}

pub fn db_query_group_series_var(s : DbquerygroupSeries) -> Double {
  let n = db_query_group_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_query_group_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_query_group_series_std(s : DbquerygroupSeries) -> Double { db_query_group_sqrt(db_query_group_series_var(s)) }

pub fn db_query_group_series_median(s : DbquerygroupSeries) -> Double {
  let n = db_query_group_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_query_group_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_group_series_scale(s : DbquerygroupSeries, f : Double) -> DbquerygroupSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_query_group_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_query_group_series_add(a : DbquerygroupSeries, b : DbquerygroupSeries) -> DbquerygroupSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_query_group_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_query_group_series_sub(a : DbquerygroupSeries, b : DbquerygroupSeries) -> DbquerygroupSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_query_group_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_query_group_series_normalize(s : DbquerygroupSeries) -> DbquerygroupSeries {
  let mn = db_query_group_series_min(s)
  let mx = db_query_group_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_query_group_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_query_group_series_cumsum(s : DbquerygroupSeries) -> DbquerygroupSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_query_group_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_query_group_series_to_string(s : DbquerygroupSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_query_group_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbquerygroupMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_query_group_make_matrix(rows : Int, cols : Int, val : Double) -> DbquerygroupMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_query_group_matrix_identity(n : Int) -> DbquerygroupMatrix {
  let m = db_query_group_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_query_group_matrix_get(m : DbquerygroupMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_query_group_matrix_transpose(m : DbquerygroupMatrix) -> DbquerygroupMatrix {
  let result = db_query_group_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_query_group_matrix_add(a : DbquerygroupMatrix, b : DbquerygroupMatrix) -> DbquerygroupMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_query_group_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_query_group_matrix_scale(m : DbquerygroupMatrix, s : Double) -> DbquerygroupMatrix {
  let result = db_query_group_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_query_group_matrix_multiply(a : DbquerygroupMatrix, b : DbquerygroupMatrix) -> DbquerygroupMatrix {
  if a.cols != b.rows { return db_query_group_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_query_group_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_query_group_matrix_trace(m : DbquerygroupMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_query_group_matrix_det(m : DbquerygroupMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_query_group_matrix_norm(m : DbquerygroupMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_query_group_sqrt(sum)
}

pub fn db_query_group_matrix_to_string(m : DbquerygroupMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_query_group_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbquerygroupVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_query_group_make_vector(comps : Array[Double]) -> DbquerygroupVector {
  { comps, dim: comps.length() }
}

pub fn db_query_group_vector_zero(dim : Int) -> DbquerygroupVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_query_group_vector_add(a : DbquerygroupVector, b : DbquerygroupVector) -> DbquerygroupVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_query_group_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_group_vector_sub(a : DbquerygroupVector, b : DbquerygroupVector) -> DbquerygroupVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_query_group_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_query_group_vector_scale(v : DbquerygroupVector, s : Double) -> DbquerygroupVector {
  let mut result = []
  for i in 0..<v.dim { result = db_query_group_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_query_group_vector_dot(a : DbquerygroupVector, b : DbquerygroupVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_query_group_vector_norm(v : DbquerygroupVector) -> Double { db_query_group_sqrt(db_query_group_vector_dot(v, v)) }

pub fn db_query_group_vector_normalize(v : DbquerygroupVector) -> DbquerygroupVector {
  let n = db_query_group_vector_norm(v)
  if n < 0.0000001 { v } else { db_query_group_vector_scale(v, 1.0 / n) }
}

pub fn db_query_group_vector_dist(a : DbquerygroupVector, b : DbquerygroupVector) -> Double {
  db_query_group_vector_norm(db_query_group_vector_sub(a, b))
}

pub fn db_query_group_vector_to_string(v : DbquerygroupVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_query_group_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_query_group_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_query_group_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_query_group_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_query_group_std(data : Array[Double]) -> Double { db_query_group_sqrt(db_query_group_var(data)) }

pub fn db_query_group_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_query_group_mean(a); let mb = db_query_group_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_query_group_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_query_group_std(a); let sb = db_query_group_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_query_group_cov(a, b) / (sa * sb) }
}

pub fn db_query_group_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_query_group_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_query_group_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_query_group_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_query_group_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_query_group_sqrt(db_query_group_mse(pred, labels))
}

pub fn db_query_group_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_query_group_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_query_group_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_query_group_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_query_group_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_query_group_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_query_group_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_query_group_precision(pred, labels, pos); let r = db_query_group_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_query_group_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_query_group_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_query_group_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_query_group_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_query_group_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_query_group_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_query_group_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_query_group_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_query_group_fibonacci(n : Int) -> Int {
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

pub fn db_query_group_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_query_group_min(data); let mx = db_query_group_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_query_group_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_query_group_mean(data); let sd = db_query_group_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_query_group_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_query_group_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_query_group_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_query_group_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_query_group_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_query_group_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_query_group_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_query_group_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_query_group_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_query_group_int(x) } else { -db_query_group_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_query_group_int(f * 1000000.0) } else { db_query_group_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_query_group_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_query_group_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbquerygroupFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_frame_make(size : Int) -> DbquerygroupFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_frame_len(s : DbquerygroupFrame) -> Int { s.size }

pub fn db_query_group_frame_get(s : DbquerygroupFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_frame_set(s : DbquerygroupFrame, i : Int, v : Double) -> DbquerygroupFrame {
  let result = db_query_group_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_frame_sum(s : DbquerygroupFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_frame_mean(s : DbquerygroupFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_frame_sum(s) / s.size.to_double() }
}

pub fn db_query_group_frame_scale(s : DbquerygroupFrame, f : Double) -> DbquerygroupFrame {
  let result = db_query_group_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_frame_add(a : DbquerygroupFrame, b : DbquerygroupFrame) -> DbquerygroupFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_frame_copy(s : DbquerygroupFrame) -> DbquerygroupFrame {
  let result = db_query_group_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_frame_fill(s : DbquerygroupFrame, v : Double) -> DbquerygroupFrame {
  let result = db_query_group_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_frame_min(s : DbquerygroupFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_frame_max(s : DbquerygroupFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_frame_to_string(s : DbquerygroupFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_table_make(size : Int) -> DbquerygroupTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_table_len(s : DbquerygroupTable) -> Int { s.size }

pub fn db_query_group_table_get(s : DbquerygroupTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_table_set(s : DbquerygroupTable, i : Int, v : Double) -> DbquerygroupTable {
  let result = db_query_group_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_table_sum(s : DbquerygroupTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_table_mean(s : DbquerygroupTable) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_table_sum(s) / s.size.to_double() }
}

pub fn db_query_group_table_scale(s : DbquerygroupTable, f : Double) -> DbquerygroupTable {
  let result = db_query_group_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_table_add(a : DbquerygroupTable, b : DbquerygroupTable) -> DbquerygroupTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_table_copy(s : DbquerygroupTable) -> DbquerygroupTable {
  let result = db_query_group_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_table_fill(s : DbquerygroupTable, v : Double) -> DbquerygroupTable {
  let result = db_query_group_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_table_min(s : DbquerygroupTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_table_max(s : DbquerygroupTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_table_to_string(s : DbquerygroupTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_graphn_make(size : Int) -> DbquerygroupGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_graphn_len(s : DbquerygroupGraphN) -> Int { s.size }

pub fn db_query_group_graphn_get(s : DbquerygroupGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_graphn_set(s : DbquerygroupGraphN, i : Int, v : Double) -> DbquerygroupGraphN {
  let result = db_query_group_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_graphn_sum(s : DbquerygroupGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_graphn_mean(s : DbquerygroupGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_graphn_sum(s) / s.size.to_double() }
}

pub fn db_query_group_graphn_scale(s : DbquerygroupGraphN, f : Double) -> DbquerygroupGraphN {
  let result = db_query_group_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_graphn_add(a : DbquerygroupGraphN, b : DbquerygroupGraphN) -> DbquerygroupGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_graphn_copy(s : DbquerygroupGraphN) -> DbquerygroupGraphN {
  let result = db_query_group_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_graphn_fill(s : DbquerygroupGraphN, v : Double) -> DbquerygroupGraphN {
  let result = db_query_group_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_graphn_min(s : DbquerygroupGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_graphn_max(s : DbquerygroupGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_graphn_to_string(s : DbquerygroupGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_node_make(size : Int) -> DbquerygroupNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_node_len(s : DbquerygroupNode) -> Int { s.size }

pub fn db_query_group_node_get(s : DbquerygroupNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_node_set(s : DbquerygroupNode, i : Int, v : Double) -> DbquerygroupNode {
  let result = db_query_group_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_node_sum(s : DbquerygroupNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_node_mean(s : DbquerygroupNode) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_node_sum(s) / s.size.to_double() }
}

pub fn db_query_group_node_scale(s : DbquerygroupNode, f : Double) -> DbquerygroupNode {
  let result = db_query_group_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_node_add(a : DbquerygroupNode, b : DbquerygroupNode) -> DbquerygroupNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_node_copy(s : DbquerygroupNode) -> DbquerygroupNode {
  let result = db_query_group_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_node_fill(s : DbquerygroupNode, v : Double) -> DbquerygroupNode {
  let result = db_query_group_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_node_min(s : DbquerygroupNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_node_max(s : DbquerygroupNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_node_to_string(s : DbquerygroupNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_edge_make(size : Int) -> DbquerygroupEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_edge_len(s : DbquerygroupEdge) -> Int { s.size }

pub fn db_query_group_edge_get(s : DbquerygroupEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_edge_set(s : DbquerygroupEdge, i : Int, v : Double) -> DbquerygroupEdge {
  let result = db_query_group_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_edge_sum(s : DbquerygroupEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_edge_mean(s : DbquerygroupEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_edge_sum(s) / s.size.to_double() }
}

pub fn db_query_group_edge_scale(s : DbquerygroupEdge, f : Double) -> DbquerygroupEdge {
  let result = db_query_group_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_edge_add(a : DbquerygroupEdge, b : DbquerygroupEdge) -> DbquerygroupEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_edge_copy(s : DbquerygroupEdge) -> DbquerygroupEdge {
  let result = db_query_group_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_edge_fill(s : DbquerygroupEdge, v : Double) -> DbquerygroupEdge {
  let result = db_query_group_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_edge_min(s : DbquerygroupEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_edge_max(s : DbquerygroupEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_edge_to_string(s : DbquerygroupEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_path_make(size : Int) -> DbquerygroupPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_path_len(s : DbquerygroupPath) -> Int { s.size }

pub fn db_query_group_path_get(s : DbquerygroupPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_path_set(s : DbquerygroupPath, i : Int, v : Double) -> DbquerygroupPath {
  let result = db_query_group_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_path_sum(s : DbquerygroupPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_path_mean(s : DbquerygroupPath) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_path_sum(s) / s.size.to_double() }
}

pub fn db_query_group_path_scale(s : DbquerygroupPath, f : Double) -> DbquerygroupPath {
  let result = db_query_group_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_path_add(a : DbquerygroupPath, b : DbquerygroupPath) -> DbquerygroupPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_path_copy(s : DbquerygroupPath) -> DbquerygroupPath {
  let result = db_query_group_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_path_fill(s : DbquerygroupPath, v : Double) -> DbquerygroupPath {
  let result = db_query_group_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_path_min(s : DbquerygroupPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_path_max(s : DbquerygroupPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_path_to_string(s : DbquerygroupPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_cluster_make(size : Int) -> DbquerygroupCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_cluster_len(s : DbquerygroupCluster) -> Int { s.size }

pub fn db_query_group_cluster_get(s : DbquerygroupCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_cluster_set(s : DbquerygroupCluster, i : Int, v : Double) -> DbquerygroupCluster {
  let result = db_query_group_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_cluster_sum(s : DbquerygroupCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_cluster_mean(s : DbquerygroupCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_cluster_sum(s) / s.size.to_double() }
}

pub fn db_query_group_cluster_scale(s : DbquerygroupCluster, f : Double) -> DbquerygroupCluster {
  let result = db_query_group_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_cluster_add(a : DbquerygroupCluster, b : DbquerygroupCluster) -> DbquerygroupCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_cluster_copy(s : DbquerygroupCluster) -> DbquerygroupCluster {
  let result = db_query_group_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_cluster_fill(s : DbquerygroupCluster, v : Double) -> DbquerygroupCluster {
  let result = db_query_group_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_cluster_min(s : DbquerygroupCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_cluster_max(s : DbquerygroupCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_cluster_to_string(s : DbquerygroupCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_model_make(size : Int) -> DbquerygroupModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_model_len(s : DbquerygroupModel) -> Int { s.size }

pub fn db_query_group_model_get(s : DbquerygroupModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_model_set(s : DbquerygroupModel, i : Int, v : Double) -> DbquerygroupModel {
  let result = db_query_group_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_model_sum(s : DbquerygroupModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_model_mean(s : DbquerygroupModel) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_model_sum(s) / s.size.to_double() }
}

pub fn db_query_group_model_scale(s : DbquerygroupModel, f : Double) -> DbquerygroupModel {
  let result = db_query_group_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_model_add(a : DbquerygroupModel, b : DbquerygroupModel) -> DbquerygroupModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_model_copy(s : DbquerygroupModel) -> DbquerygroupModel {
  let result = db_query_group_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_model_fill(s : DbquerygroupModel, v : Double) -> DbquerygroupModel {
  let result = db_query_group_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_model_min(s : DbquerygroupModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_model_max(s : DbquerygroupModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_model_to_string(s : DbquerygroupModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_layer_make(size : Int) -> DbquerygroupLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_layer_len(s : DbquerygroupLayer) -> Int { s.size }

pub fn db_query_group_layer_get(s : DbquerygroupLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_layer_set(s : DbquerygroupLayer, i : Int, v : Double) -> DbquerygroupLayer {
  let result = db_query_group_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_layer_sum(s : DbquerygroupLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_layer_mean(s : DbquerygroupLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_layer_sum(s) / s.size.to_double() }
}

pub fn db_query_group_layer_scale(s : DbquerygroupLayer, f : Double) -> DbquerygroupLayer {
  let result = db_query_group_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_layer_add(a : DbquerygroupLayer, b : DbquerygroupLayer) -> DbquerygroupLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_layer_copy(s : DbquerygroupLayer) -> DbquerygroupLayer {
  let result = db_query_group_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_layer_fill(s : DbquerygroupLayer, v : Double) -> DbquerygroupLayer {
  let result = db_query_group_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_layer_min(s : DbquerygroupLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_layer_max(s : DbquerygroupLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_layer_to_string(s : DbquerygroupLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_buffer_make(size : Int) -> DbquerygroupBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_buffer_len(s : DbquerygroupBuffer) -> Int { s.size }

pub fn db_query_group_buffer_get(s : DbquerygroupBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_buffer_set(s : DbquerygroupBuffer, i : Int, v : Double) -> DbquerygroupBuffer {
  let result = db_query_group_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_buffer_sum(s : DbquerygroupBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_buffer_mean(s : DbquerygroupBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_buffer_sum(s) / s.size.to_double() }
}

pub fn db_query_group_buffer_scale(s : DbquerygroupBuffer, f : Double) -> DbquerygroupBuffer {
  let result = db_query_group_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_buffer_add(a : DbquerygroupBuffer, b : DbquerygroupBuffer) -> DbquerygroupBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_buffer_copy(s : DbquerygroupBuffer) -> DbquerygroupBuffer {
  let result = db_query_group_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_buffer_fill(s : DbquerygroupBuffer, v : Double) -> DbquerygroupBuffer {
  let result = db_query_group_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_buffer_min(s : DbquerygroupBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_buffer_max(s : DbquerygroupBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_buffer_to_string(s : DbquerygroupBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_cursor_make(size : Int) -> DbquerygroupCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_cursor_len(s : DbquerygroupCursor) -> Int { s.size }

pub fn db_query_group_cursor_get(s : DbquerygroupCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_cursor_set(s : DbquerygroupCursor, i : Int, v : Double) -> DbquerygroupCursor {
  let result = db_query_group_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_cursor_sum(s : DbquerygroupCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_cursor_mean(s : DbquerygroupCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_cursor_sum(s) / s.size.to_double() }
}

pub fn db_query_group_cursor_scale(s : DbquerygroupCursor, f : Double) -> DbquerygroupCursor {
  let result = db_query_group_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_cursor_add(a : DbquerygroupCursor, b : DbquerygroupCursor) -> DbquerygroupCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_cursor_copy(s : DbquerygroupCursor) -> DbquerygroupCursor {
  let result = db_query_group_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_cursor_fill(s : DbquerygroupCursor, v : Double) -> DbquerygroupCursor {
  let result = db_query_group_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_cursor_min(s : DbquerygroupCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_cursor_max(s : DbquerygroupCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_cursor_to_string(s : DbquerygroupCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_view_make(size : Int) -> DbquerygroupView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_view_len(s : DbquerygroupView) -> Int { s.size }

pub fn db_query_group_view_get(s : DbquerygroupView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_view_set(s : DbquerygroupView, i : Int, v : Double) -> DbquerygroupView {
  let result = db_query_group_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_view_sum(s : DbquerygroupView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_view_mean(s : DbquerygroupView) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_view_sum(s) / s.size.to_double() }
}

pub fn db_query_group_view_scale(s : DbquerygroupView, f : Double) -> DbquerygroupView {
  let result = db_query_group_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_view_add(a : DbquerygroupView, b : DbquerygroupView) -> DbquerygroupView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_view_copy(s : DbquerygroupView) -> DbquerygroupView {
  let result = db_query_group_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_view_fill(s : DbquerygroupView, v : Double) -> DbquerygroupView {
  let result = db_query_group_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_view_min(s : DbquerygroupView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_view_max(s : DbquerygroupView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_view_to_string(s : DbquerygroupView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_range_make(size : Int) -> DbquerygroupRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_range_len(s : DbquerygroupRange) -> Int { s.size }

pub fn db_query_group_range_get(s : DbquerygroupRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_range_set(s : DbquerygroupRange, i : Int, v : Double) -> DbquerygroupRange {
  let result = db_query_group_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_range_sum(s : DbquerygroupRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_range_mean(s : DbquerygroupRange) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_range_sum(s) / s.size.to_double() }
}

pub fn db_query_group_range_scale(s : DbquerygroupRange, f : Double) -> DbquerygroupRange {
  let result = db_query_group_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_range_add(a : DbquerygroupRange, b : DbquerygroupRange) -> DbquerygroupRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_range_copy(s : DbquerygroupRange) -> DbquerygroupRange {
  let result = db_query_group_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_range_fill(s : DbquerygroupRange, v : Double) -> DbquerygroupRange {
  let result = db_query_group_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_range_min(s : DbquerygroupRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_range_max(s : DbquerygroupRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_range_to_string(s : DbquerygroupRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbquerygroupSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_query_group_slice_make(size : Int) -> DbquerygroupSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_query_group_slice_len(s : DbquerygroupSlice) -> Int { s.size }

pub fn db_query_group_slice_get(s : DbquerygroupSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_query_group_slice_set(s : DbquerygroupSlice, i : Int, v : Double) -> DbquerygroupSlice {
  let result = db_query_group_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_query_group_slice_sum(s : DbquerygroupSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_query_group_slice_mean(s : DbquerygroupSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_query_group_slice_sum(s) / s.size.to_double() }
}

pub fn db_query_group_slice_scale(s : DbquerygroupSlice, f : Double) -> DbquerygroupSlice {
  let result = db_query_group_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_query_group_slice_add(a : DbquerygroupSlice, b : DbquerygroupSlice) -> DbquerygroupSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_query_group_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_query_group_slice_copy(s : DbquerygroupSlice) -> DbquerygroupSlice {
  let result = db_query_group_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_query_group_slice_fill(s : DbquerygroupSlice, v : Double) -> DbquerygroupSlice {
  let result = db_query_group_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_query_group_slice_min(s : DbquerygroupSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_slice_max(s : DbquerygroupSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_query_group_slice_to_string(s : DbquerygroupSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_query_group_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_query_group_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

