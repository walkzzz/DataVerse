///===
/// extcore/db_index_btree

pub(all) struct DbindexbtreePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn db_index_btree_make_point(x : Double, y : Double) -> DbindexbtreePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn db_index_btree_make_point3(x : Double, y : Double, z : Double) -> DbindexbtreePoint {
  { x, y, z, label: 0 }
}

pub fn db_index_btree_point_x(pt : DbindexbtreePoint) -> Double { pt.x }

pub fn db_index_btree_point_y(pt : DbindexbtreePoint) -> Double { pt.y }

pub fn db_index_btree_point_z(pt : DbindexbtreePoint) -> Double { pt.z }

pub fn db_index_btree_point_label(pt : DbindexbtreePoint) -> Int { pt.label }

pub fn db_index_btree_point_dist(a : DbindexbtreePoint, b : DbindexbtreePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  db_index_btree_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn db_index_btree_point_add(a : DbindexbtreePoint, b : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn db_index_btree_point_sub(a : DbindexbtreePoint, b : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn db_index_btree_point_scale(pt : DbindexbtreePoint, s : Double) -> DbindexbtreePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn db_index_btree_point_dot(a : DbindexbtreePoint, b : DbindexbtreePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn db_index_btree_point_cross(a : DbindexbtreePoint, b : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn db_index_btree_point_norm(pt : DbindexbtreePoint) -> Double {
  db_index_btree_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn db_index_btree_point_normalize(pt : DbindexbtreePoint) -> DbindexbtreePoint {
  let n = db_index_btree_point_norm(pt)
  if n < 0.0000001 { pt } else { db_index_btree_point_scale(pt, 1.0 / n) }
}

pub fn db_index_btree_point_negate(pt : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn db_index_btree_point_mid(a : DbindexbtreePoint, b : DbindexbtreePoint) -> DbindexbtreePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn db_index_btree_point_lerp(a : DbindexbtreePoint, b : DbindexbtreePoint, t : Double) -> DbindexbtreePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn db_index_btree_point_to_string(pt : DbindexbtreePoint) -> String {
  "(" + db_index_btree_dbl(pt.x) + ", " + db_index_btree_dbl(pt.y) + ", " + db_index_btree_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DbindexbtreeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn db_index_btree_make_series(vals : Array[Double], name : String) -> DbindexbtreeSeries {
  { vals, name, meta: 0 }
}

pub fn db_index_btree_series_len(s : DbindexbtreeSeries) -> Int { s.vals.length() }

pub fn db_index_btree_series_sum(s : DbindexbtreeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn db_index_btree_series_mean(s : DbindexbtreeSeries) -> Double {
  let n = db_index_btree_series_len(s)
  if n == 0 { 0.0 } else { db_index_btree_series_sum(s) / n.to_double() }
}

pub fn db_index_btree_series_min(s : DbindexbtreeSeries) -> Double {
  let n = db_index_btree_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_btree_series_max(s : DbindexbtreeSeries) -> Double {
  let n = db_index_btree_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn db_index_btree_series_range(s : DbindexbtreeSeries) -> Double {
  db_index_btree_series_max(s) - db_index_btree_series_min(s)
}

pub fn db_index_btree_series_var(s : DbindexbtreeSeries) -> Double {
  let n = db_index_btree_series_len(s)
  if n == 0 { 0.0 } else {
    let m = db_index_btree_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn db_index_btree_series_std(s : DbindexbtreeSeries) -> Double { db_index_btree_sqrt(db_index_btree_series_var(s)) }

pub fn db_index_btree_series_median(s : DbindexbtreeSeries) -> Double {
  let n = db_index_btree_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = db_index_btree_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_btree_series_scale(s : DbindexbtreeSeries, f : Double) -> DbindexbtreeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = db_index_btree_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn db_index_btree_series_add(a : DbindexbtreeSeries, b : DbindexbtreeSeries) -> DbindexbtreeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_index_btree_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn db_index_btree_series_sub(a : DbindexbtreeSeries, b : DbindexbtreeSeries) -> DbindexbtreeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = db_index_btree_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn db_index_btree_series_normalize(s : DbindexbtreeSeries) -> DbindexbtreeSeries {
  let mn = db_index_btree_series_min(s)
  let mx = db_index_btree_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = db_index_btree_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn db_index_btree_series_cumsum(s : DbindexbtreeSeries) -> DbindexbtreeSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = db_index_btree_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn db_index_btree_series_to_string(s : DbindexbtreeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_index_btree_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DbindexbtreeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn db_index_btree_make_matrix(rows : Int, cols : Int, val : Double) -> DbindexbtreeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn db_index_btree_matrix_identity(n : Int) -> DbindexbtreeMatrix {
  let m = db_index_btree_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn db_index_btree_matrix_get(m : DbindexbtreeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn db_index_btree_matrix_transpose(m : DbindexbtreeMatrix) -> DbindexbtreeMatrix {
  let result = db_index_btree_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn db_index_btree_matrix_add(a : DbindexbtreeMatrix, b : DbindexbtreeMatrix) -> DbindexbtreeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = db_index_btree_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn db_index_btree_matrix_scale(m : DbindexbtreeMatrix, s : Double) -> DbindexbtreeMatrix {
  let result = db_index_btree_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn db_index_btree_matrix_multiply(a : DbindexbtreeMatrix, b : DbindexbtreeMatrix) -> DbindexbtreeMatrix {
  if a.cols != b.rows { return db_index_btree_make_matrix(a.rows, b.cols, 0.0) }
  let result = db_index_btree_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn db_index_btree_matrix_trace(m : DbindexbtreeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn db_index_btree_matrix_det(m : DbindexbtreeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn db_index_btree_matrix_norm(m : DbindexbtreeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  db_index_btree_sqrt(sum)
}

pub fn db_index_btree_matrix_to_string(m : DbindexbtreeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + db_index_btree_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct DbindexbtreeVector {
  comps : Array[Double]
  dim : Int
}

pub fn db_index_btree_make_vector(comps : Array[Double]) -> DbindexbtreeVector {
  { comps, dim: comps.length() }
}

pub fn db_index_btree_vector_zero(dim : Int) -> DbindexbtreeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn db_index_btree_vector_add(a : DbindexbtreeVector, b : DbindexbtreeVector) -> DbindexbtreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_index_btree_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_btree_vector_sub(a : DbindexbtreeVector, b : DbindexbtreeVector) -> DbindexbtreeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = db_index_btree_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn db_index_btree_vector_scale(v : DbindexbtreeVector, s : Double) -> DbindexbtreeVector {
  let mut result = []
  for i in 0..<v.dim { result = db_index_btree_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn db_index_btree_vector_dot(a : DbindexbtreeVector, b : DbindexbtreeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn db_index_btree_vector_norm(v : DbindexbtreeVector) -> Double { db_index_btree_sqrt(db_index_btree_vector_dot(v, v)) }

pub fn db_index_btree_vector_normalize(v : DbindexbtreeVector) -> DbindexbtreeVector {
  let n = db_index_btree_vector_norm(v)
  if n < 0.0000001 { v } else { db_index_btree_vector_scale(v, 1.0 / n) }
}

pub fn db_index_btree_vector_dist(a : DbindexbtreeVector, b : DbindexbtreeVector) -> Double {
  db_index_btree_vector_norm(db_index_btree_vector_sub(a, b))
}

pub fn db_index_btree_vector_to_string(v : DbindexbtreeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + db_index_btree_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn db_index_btree_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn db_index_btree_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = db_index_btree_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_index_btree_std(data : Array[Double]) -> Double { db_index_btree_sqrt(db_index_btree_var(data)) }

pub fn db_index_btree_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = db_index_btree_mean(a); let mb = db_index_btree_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn db_index_btree_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = db_index_btree_std(a); let sb = db_index_btree_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { db_index_btree_cov(a, b) / (sa * sb) }
}

pub fn db_index_btree_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = db_index_btree_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn db_index_btree_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn db_index_btree_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn db_index_btree_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  db_index_btree_sqrt(db_index_btree_mse(pred, labels))
}

pub fn db_index_btree_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + db_index_btree_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn db_index_btree_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = db_index_btree_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn db_index_btree_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn db_index_btree_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn db_index_btree_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = db_index_btree_precision(pred, labels, pos); let r = db_index_btree_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn db_index_btree_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn db_index_btree_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = db_index_btree_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn db_index_btree_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn db_index_btree_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn db_index_btree_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = db_index_btree_gcd(a, b)
    (a / g) * b
  }
}

pub fn db_index_btree_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn db_index_btree_fibonacci(n : Int) -> Int {
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

pub fn db_index_btree_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = db_index_btree_min(data); let mx = db_index_btree_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn db_index_btree_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = db_index_btree_mean(data); let sd = db_index_btree_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn db_index_btree_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn db_index_btree_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn db_index_btree_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn db_index_btree_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn db_index_btree_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn db_index_btree_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn db_index_btree_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn db_index_btree_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn db_index_btree_dbl(x : Double) -> String {
  let i = if x >= 0.0 { db_index_btree_int(x) } else { -db_index_btree_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { db_index_btree_int(f * 1000000.0) } else { db_index_btree_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn db_index_btree_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn db_index_btree_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct DbindexbtreeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_frame_make(size : Int) -> DbindexbtreeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_frame_len(s : DbindexbtreeFrame) -> Int { s.size }

pub fn db_index_btree_frame_get(s : DbindexbtreeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_frame_set(s : DbindexbtreeFrame, i : Int, v : Double) -> DbindexbtreeFrame {
  let result = db_index_btree_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_frame_sum(s : DbindexbtreeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_frame_mean(s : DbindexbtreeFrame) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_frame_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_frame_scale(s : DbindexbtreeFrame, f : Double) -> DbindexbtreeFrame {
  let result = db_index_btree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_frame_add(a : DbindexbtreeFrame, b : DbindexbtreeFrame) -> DbindexbtreeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_frame_copy(s : DbindexbtreeFrame) -> DbindexbtreeFrame {
  let result = db_index_btree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_frame_fill(s : DbindexbtreeFrame, v : Double) -> DbindexbtreeFrame {
  let result = db_index_btree_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_frame_min(s : DbindexbtreeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_frame_max(s : DbindexbtreeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_frame_to_string(s : DbindexbtreeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_table_make(size : Int) -> DbindexbtreeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_table_len(s : DbindexbtreeTable) -> Int { s.size }

pub fn db_index_btree_table_get(s : DbindexbtreeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_table_set(s : DbindexbtreeTable, i : Int, v : Double) -> DbindexbtreeTable {
  let result = db_index_btree_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_table_sum(s : DbindexbtreeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_table_mean(s : DbindexbtreeTable) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_table_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_table_scale(s : DbindexbtreeTable, f : Double) -> DbindexbtreeTable {
  let result = db_index_btree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_table_add(a : DbindexbtreeTable, b : DbindexbtreeTable) -> DbindexbtreeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_table_copy(s : DbindexbtreeTable) -> DbindexbtreeTable {
  let result = db_index_btree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_table_fill(s : DbindexbtreeTable, v : Double) -> DbindexbtreeTable {
  let result = db_index_btree_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_table_min(s : DbindexbtreeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_table_max(s : DbindexbtreeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_table_to_string(s : DbindexbtreeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_graphn_make(size : Int) -> DbindexbtreeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_graphn_len(s : DbindexbtreeGraphN) -> Int { s.size }

pub fn db_index_btree_graphn_get(s : DbindexbtreeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_graphn_set(s : DbindexbtreeGraphN, i : Int, v : Double) -> DbindexbtreeGraphN {
  let result = db_index_btree_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_graphn_sum(s : DbindexbtreeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_graphn_mean(s : DbindexbtreeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_graphn_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_graphn_scale(s : DbindexbtreeGraphN, f : Double) -> DbindexbtreeGraphN {
  let result = db_index_btree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_graphn_add(a : DbindexbtreeGraphN, b : DbindexbtreeGraphN) -> DbindexbtreeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_graphn_copy(s : DbindexbtreeGraphN) -> DbindexbtreeGraphN {
  let result = db_index_btree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_graphn_fill(s : DbindexbtreeGraphN, v : Double) -> DbindexbtreeGraphN {
  let result = db_index_btree_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_graphn_min(s : DbindexbtreeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_graphn_max(s : DbindexbtreeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_graphn_to_string(s : DbindexbtreeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_node_make(size : Int) -> DbindexbtreeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_node_len(s : DbindexbtreeNode) -> Int { s.size }

pub fn db_index_btree_node_get(s : DbindexbtreeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_node_set(s : DbindexbtreeNode, i : Int, v : Double) -> DbindexbtreeNode {
  let result = db_index_btree_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_node_sum(s : DbindexbtreeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_node_mean(s : DbindexbtreeNode) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_node_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_node_scale(s : DbindexbtreeNode, f : Double) -> DbindexbtreeNode {
  let result = db_index_btree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_node_add(a : DbindexbtreeNode, b : DbindexbtreeNode) -> DbindexbtreeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_node_copy(s : DbindexbtreeNode) -> DbindexbtreeNode {
  let result = db_index_btree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_node_fill(s : DbindexbtreeNode, v : Double) -> DbindexbtreeNode {
  let result = db_index_btree_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_node_min(s : DbindexbtreeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_node_max(s : DbindexbtreeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_node_to_string(s : DbindexbtreeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_edge_make(size : Int) -> DbindexbtreeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_edge_len(s : DbindexbtreeEdge) -> Int { s.size }

pub fn db_index_btree_edge_get(s : DbindexbtreeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_edge_set(s : DbindexbtreeEdge, i : Int, v : Double) -> DbindexbtreeEdge {
  let result = db_index_btree_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_edge_sum(s : DbindexbtreeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_edge_mean(s : DbindexbtreeEdge) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_edge_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_edge_scale(s : DbindexbtreeEdge, f : Double) -> DbindexbtreeEdge {
  let result = db_index_btree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_edge_add(a : DbindexbtreeEdge, b : DbindexbtreeEdge) -> DbindexbtreeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_edge_copy(s : DbindexbtreeEdge) -> DbindexbtreeEdge {
  let result = db_index_btree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_edge_fill(s : DbindexbtreeEdge, v : Double) -> DbindexbtreeEdge {
  let result = db_index_btree_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_edge_min(s : DbindexbtreeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_edge_max(s : DbindexbtreeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_edge_to_string(s : DbindexbtreeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_path_make(size : Int) -> DbindexbtreePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_path_len(s : DbindexbtreePath) -> Int { s.size }

pub fn db_index_btree_path_get(s : DbindexbtreePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_path_set(s : DbindexbtreePath, i : Int, v : Double) -> DbindexbtreePath {
  let result = db_index_btree_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_path_sum(s : DbindexbtreePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_path_mean(s : DbindexbtreePath) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_path_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_path_scale(s : DbindexbtreePath, f : Double) -> DbindexbtreePath {
  let result = db_index_btree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_path_add(a : DbindexbtreePath, b : DbindexbtreePath) -> DbindexbtreePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_path_copy(s : DbindexbtreePath) -> DbindexbtreePath {
  let result = db_index_btree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_path_fill(s : DbindexbtreePath, v : Double) -> DbindexbtreePath {
  let result = db_index_btree_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_path_min(s : DbindexbtreePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_path_max(s : DbindexbtreePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_path_to_string(s : DbindexbtreePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_cluster_make(size : Int) -> DbindexbtreeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_cluster_len(s : DbindexbtreeCluster) -> Int { s.size }

pub fn db_index_btree_cluster_get(s : DbindexbtreeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_cluster_set(s : DbindexbtreeCluster, i : Int, v : Double) -> DbindexbtreeCluster {
  let result = db_index_btree_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_cluster_sum(s : DbindexbtreeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_cluster_mean(s : DbindexbtreeCluster) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_cluster_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_cluster_scale(s : DbindexbtreeCluster, f : Double) -> DbindexbtreeCluster {
  let result = db_index_btree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_cluster_add(a : DbindexbtreeCluster, b : DbindexbtreeCluster) -> DbindexbtreeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_cluster_copy(s : DbindexbtreeCluster) -> DbindexbtreeCluster {
  let result = db_index_btree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_cluster_fill(s : DbindexbtreeCluster, v : Double) -> DbindexbtreeCluster {
  let result = db_index_btree_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_cluster_min(s : DbindexbtreeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_cluster_max(s : DbindexbtreeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_cluster_to_string(s : DbindexbtreeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_model_make(size : Int) -> DbindexbtreeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_model_len(s : DbindexbtreeModel) -> Int { s.size }

pub fn db_index_btree_model_get(s : DbindexbtreeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_model_set(s : DbindexbtreeModel, i : Int, v : Double) -> DbindexbtreeModel {
  let result = db_index_btree_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_model_sum(s : DbindexbtreeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_model_mean(s : DbindexbtreeModel) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_model_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_model_scale(s : DbindexbtreeModel, f : Double) -> DbindexbtreeModel {
  let result = db_index_btree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_model_add(a : DbindexbtreeModel, b : DbindexbtreeModel) -> DbindexbtreeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_model_copy(s : DbindexbtreeModel) -> DbindexbtreeModel {
  let result = db_index_btree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_model_fill(s : DbindexbtreeModel, v : Double) -> DbindexbtreeModel {
  let result = db_index_btree_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_model_min(s : DbindexbtreeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_model_max(s : DbindexbtreeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_model_to_string(s : DbindexbtreeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_layer_make(size : Int) -> DbindexbtreeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_layer_len(s : DbindexbtreeLayer) -> Int { s.size }

pub fn db_index_btree_layer_get(s : DbindexbtreeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_layer_set(s : DbindexbtreeLayer, i : Int, v : Double) -> DbindexbtreeLayer {
  let result = db_index_btree_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_layer_sum(s : DbindexbtreeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_layer_mean(s : DbindexbtreeLayer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_layer_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_layer_scale(s : DbindexbtreeLayer, f : Double) -> DbindexbtreeLayer {
  let result = db_index_btree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_layer_add(a : DbindexbtreeLayer, b : DbindexbtreeLayer) -> DbindexbtreeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_layer_copy(s : DbindexbtreeLayer) -> DbindexbtreeLayer {
  let result = db_index_btree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_layer_fill(s : DbindexbtreeLayer, v : Double) -> DbindexbtreeLayer {
  let result = db_index_btree_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_layer_min(s : DbindexbtreeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_layer_max(s : DbindexbtreeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_layer_to_string(s : DbindexbtreeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_buffer_make(size : Int) -> DbindexbtreeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_buffer_len(s : DbindexbtreeBuffer) -> Int { s.size }

pub fn db_index_btree_buffer_get(s : DbindexbtreeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_buffer_set(s : DbindexbtreeBuffer, i : Int, v : Double) -> DbindexbtreeBuffer {
  let result = db_index_btree_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_buffer_sum(s : DbindexbtreeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_buffer_mean(s : DbindexbtreeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_buffer_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_buffer_scale(s : DbindexbtreeBuffer, f : Double) -> DbindexbtreeBuffer {
  let result = db_index_btree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_buffer_add(a : DbindexbtreeBuffer, b : DbindexbtreeBuffer) -> DbindexbtreeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_buffer_copy(s : DbindexbtreeBuffer) -> DbindexbtreeBuffer {
  let result = db_index_btree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_buffer_fill(s : DbindexbtreeBuffer, v : Double) -> DbindexbtreeBuffer {
  let result = db_index_btree_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_buffer_min(s : DbindexbtreeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_buffer_max(s : DbindexbtreeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_buffer_to_string(s : DbindexbtreeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_cursor_make(size : Int) -> DbindexbtreeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_cursor_len(s : DbindexbtreeCursor) -> Int { s.size }

pub fn db_index_btree_cursor_get(s : DbindexbtreeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_cursor_set(s : DbindexbtreeCursor, i : Int, v : Double) -> DbindexbtreeCursor {
  let result = db_index_btree_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_cursor_sum(s : DbindexbtreeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_cursor_mean(s : DbindexbtreeCursor) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_cursor_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_cursor_scale(s : DbindexbtreeCursor, f : Double) -> DbindexbtreeCursor {
  let result = db_index_btree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_cursor_add(a : DbindexbtreeCursor, b : DbindexbtreeCursor) -> DbindexbtreeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_cursor_copy(s : DbindexbtreeCursor) -> DbindexbtreeCursor {
  let result = db_index_btree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_cursor_fill(s : DbindexbtreeCursor, v : Double) -> DbindexbtreeCursor {
  let result = db_index_btree_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_cursor_min(s : DbindexbtreeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_cursor_max(s : DbindexbtreeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_cursor_to_string(s : DbindexbtreeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_view_make(size : Int) -> DbindexbtreeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_view_len(s : DbindexbtreeView) -> Int { s.size }

pub fn db_index_btree_view_get(s : DbindexbtreeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_view_set(s : DbindexbtreeView, i : Int, v : Double) -> DbindexbtreeView {
  let result = db_index_btree_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_view_sum(s : DbindexbtreeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_view_mean(s : DbindexbtreeView) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_view_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_view_scale(s : DbindexbtreeView, f : Double) -> DbindexbtreeView {
  let result = db_index_btree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_view_add(a : DbindexbtreeView, b : DbindexbtreeView) -> DbindexbtreeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_view_copy(s : DbindexbtreeView) -> DbindexbtreeView {
  let result = db_index_btree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_view_fill(s : DbindexbtreeView, v : Double) -> DbindexbtreeView {
  let result = db_index_btree_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_view_min(s : DbindexbtreeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_view_max(s : DbindexbtreeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_view_to_string(s : DbindexbtreeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_range_make(size : Int) -> DbindexbtreeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_range_len(s : DbindexbtreeRange) -> Int { s.size }

pub fn db_index_btree_range_get(s : DbindexbtreeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_range_set(s : DbindexbtreeRange, i : Int, v : Double) -> DbindexbtreeRange {
  let result = db_index_btree_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_range_sum(s : DbindexbtreeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_range_mean(s : DbindexbtreeRange) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_range_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_range_scale(s : DbindexbtreeRange, f : Double) -> DbindexbtreeRange {
  let result = db_index_btree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_range_add(a : DbindexbtreeRange, b : DbindexbtreeRange) -> DbindexbtreeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_range_copy(s : DbindexbtreeRange) -> DbindexbtreeRange {
  let result = db_index_btree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_range_fill(s : DbindexbtreeRange, v : Double) -> DbindexbtreeRange {
  let result = db_index_btree_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_range_min(s : DbindexbtreeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_range_max(s : DbindexbtreeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_range_to_string(s : DbindexbtreeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DbindexbtreeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn db_index_btree_slice_make(size : Int) -> DbindexbtreeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn db_index_btree_slice_len(s : DbindexbtreeSlice) -> Int { s.size }

pub fn db_index_btree_slice_get(s : DbindexbtreeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn db_index_btree_slice_set(s : DbindexbtreeSlice, i : Int, v : Double) -> DbindexbtreeSlice {
  let result = db_index_btree_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_slice_sum(s : DbindexbtreeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn db_index_btree_slice_mean(s : DbindexbtreeSlice) -> Double {
  if s.size == 0 { 0.0 } else { db_index_btree_slice_sum(s) / s.size.to_double() }
}

pub fn db_index_btree_slice_scale(s : DbindexbtreeSlice, f : Double) -> DbindexbtreeSlice {
  let result = db_index_btree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn db_index_btree_slice_add(a : DbindexbtreeSlice, b : DbindexbtreeSlice) -> DbindexbtreeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = db_index_btree_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn db_index_btree_slice_copy(s : DbindexbtreeSlice) -> DbindexbtreeSlice {
  let result = db_index_btree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn db_index_btree_slice_fill(s : DbindexbtreeSlice, v : Double) -> DbindexbtreeSlice {
  let result = db_index_btree_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn db_index_btree_slice_min(s : DbindexbtreeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_slice_max(s : DbindexbtreeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn db_index_btree_slice_to_string(s : DbindexbtreeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn db_index_btree_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn db_index_btree_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

