///===
/// extcore/ds_hash_hopscotch

pub(all) struct DshashhopscotchPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_hopscotch_make_point(x : Double, y : Double) -> DshashhopscotchPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_hopscotch_make_point3(x : Double, y : Double, z : Double) -> DshashhopscotchPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_hopscotch_point_x(pt : DshashhopscotchPoint) -> Double { pt.x }

pub fn ds_hash_hopscotch_point_y(pt : DshashhopscotchPoint) -> Double { pt.y }

pub fn ds_hash_hopscotch_point_z(pt : DshashhopscotchPoint) -> Double { pt.z }

pub fn ds_hash_hopscotch_point_label(pt : DshashhopscotchPoint) -> Int { pt.label }

pub fn ds_hash_hopscotch_point_dist(a : DshashhopscotchPoint, b : DshashhopscotchPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_hopscotch_point_add(a : DshashhopscotchPoint, b : DshashhopscotchPoint) -> DshashhopscotchPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_hopscotch_point_sub(a : DshashhopscotchPoint, b : DshashhopscotchPoint) -> DshashhopscotchPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_hopscotch_point_scale(pt : DshashhopscotchPoint, s : Double) -> DshashhopscotchPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_hopscotch_point_dot(a : DshashhopscotchPoint, b : DshashhopscotchPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_hopscotch_point_cross(a : DshashhopscotchPoint, b : DshashhopscotchPoint) -> DshashhopscotchPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_hopscotch_point_norm(pt : DshashhopscotchPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_hopscotch_point_normalize(pt : DshashhopscotchPoint) -> DshashhopscotchPoint {
  let n = ds_hash_hopscotch_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_hopscotch_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_hopscotch_point_negate(pt : DshashhopscotchPoint) -> DshashhopscotchPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_hopscotch_point_mid(a : DshashhopscotchPoint, b : DshashhopscotchPoint) -> DshashhopscotchPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_hopscotch_point_lerp(a : DshashhopscotchPoint, b : DshashhopscotchPoint, t : Double) -> DshashhopscotchPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_hopscotch_point_to_string(pt : DshashhopscotchPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashhopscotchSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_hopscotch_make_series(vals : Array[Double], name : String) -> DshashhopscotchSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_hopscotch_series_len(s : DshashhopscotchSeries) -> Int { s.vals.length() }

pub fn ds_hash_hopscotch_series_sum(s : DshashhopscotchSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_hash_hopscotch_series_mean(s : DshashhopscotchSeries) -> Double {
  let n = ds_hash_hopscotch_series_len(s)
  if n == 0 { 0.0 } else { ds_hash_hopscotch_series_sum(s) / n.to_double() }
}

pub fn ds_hash_hopscotch_series_min(s : DshashhopscotchSeries) -> Double {
  let n = ds_hash_hopscotch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_series_max(s : DshashhopscotchSeries) -> Double {
  let n = ds_hash_hopscotch_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_series_range(s : DshashhopscotchSeries) -> Double {
  ds_hash_hopscotch_series_max(s) - ds_hash_hopscotch_series_min(s)
}

pub fn ds_hash_hopscotch_series_var(s : DshashhopscotchSeries) -> Double {
  let n = ds_hash_hopscotch_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_hash_hopscotch_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_hash_hopscotch_series_std(s : DshashhopscotchSeries) -> Double { @_common.sqrt(ds_hash_hopscotch_series_var(s)) }

pub fn ds_hash_hopscotch_series_median(s : DshashhopscotchSeries) -> Double {
  let n = ds_hash_hopscotch_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_hopscotch_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_hopscotch_series_scale(s : DshashhopscotchSeries, f : Double) -> DshashhopscotchSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_hopscotch_series_add(a : DshashhopscotchSeries, b : DshashhopscotchSeries) -> DshashhopscotchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_hopscotch_series_sub(a : DshashhopscotchSeries, b : DshashhopscotchSeries) -> DshashhopscotchSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_hopscotch_series_normalize(s : DshashhopscotchSeries) -> DshashhopscotchSeries {
  let mn = ds_hash_hopscotch_series_min(s)
  let mx = ds_hash_hopscotch_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_hopscotch_series_cumsum(s : DshashhopscotchSeries) -> DshashhopscotchSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_hopscotch_series_to_string(s : DshashhopscotchSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashhopscotchMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_hopscotch_make_matrix(rows : Int, cols : Int, val : Double) -> DshashhopscotchMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_hopscotch_matrix_identity(n : Int) -> DshashhopscotchMatrix {
  let m = ds_hash_hopscotch_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_hopscotch_matrix_get(m : DshashhopscotchMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_hopscotch_matrix_transpose(m : DshashhopscotchMatrix) -> DshashhopscotchMatrix {
  let result = ds_hash_hopscotch_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_hopscotch_matrix_add(a : DshashhopscotchMatrix, b : DshashhopscotchMatrix) -> DshashhopscotchMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_hopscotch_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_hopscotch_matrix_scale(m : DshashhopscotchMatrix, s : Double) -> DshashhopscotchMatrix {
  let result = ds_hash_hopscotch_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_hopscotch_matrix_multiply(a : DshashhopscotchMatrix, b : DshashhopscotchMatrix) -> DshashhopscotchMatrix {
  if a.cols != b.rows { return ds_hash_hopscotch_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_hopscotch_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_hopscotch_matrix_trace(m : DshashhopscotchMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_hopscotch_matrix_det(m : DshashhopscotchMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_hopscotch_matrix_norm(m : DshashhopscotchMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_hash_hopscotch_matrix_to_string(m : DshashhopscotchMatrix) -> String {
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

pub(all) struct DshashhopscotchVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_hopscotch_make_vector(comps : Array[Double]) -> DshashhopscotchVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_hopscotch_vector_zero(dim : Int) -> DshashhopscotchVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_hopscotch_vector_add(a : DshashhopscotchVector, b : DshashhopscotchVector) -> DshashhopscotchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_hopscotch_vector_sub(a : DshashhopscotchVector, b : DshashhopscotchVector) -> DshashhopscotchVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_hopscotch_vector_scale(v : DshashhopscotchVector, s : Double) -> DshashhopscotchVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_hopscotch_vector_dot(a : DshashhopscotchVector, b : DshashhopscotchVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_hopscotch_vector_norm(v : DshashhopscotchVector) -> Double { @_common.sqrt(ds_hash_hopscotch_vector_dot(v, v)) }

pub fn ds_hash_hopscotch_vector_normalize(v : DshashhopscotchVector) -> DshashhopscotchVector {
  let n = ds_hash_hopscotch_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_hopscotch_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_hopscotch_vector_dist(a : DshashhopscotchVector, b : DshashhopscotchVector) -> Double {
  ds_hash_hopscotch_vector_norm(ds_hash_hopscotch_vector_sub(a, b))
}

pub fn ds_hash_hopscotch_vector_to_string(v : DshashhopscotchVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_hopscotch_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_hash_hopscotch_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_hash_hopscotch_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_hopscotch_std(data : Array[Double]) -> Double { @_common.sqrt(ds_hash_hopscotch_var(data)) }

pub fn ds_hash_hopscotch_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_hash_hopscotch_mean(a); let mb = ds_hash_hopscotch_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_hash_hopscotch_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_hash_hopscotch_std(a); let sb = ds_hash_hopscotch_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_hash_hopscotch_cov(a, b) / (sa * sb) }
}

pub fn ds_hash_hopscotch_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_hopscotch_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_hopscotch_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_hash_hopscotch_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_hopscotch_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ds_hash_hopscotch_mse(pred, labels))
}

pub fn ds_hash_hopscotch_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_hash_hopscotch_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_hash_hopscotch_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_hash_hopscotch_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_hash_hopscotch_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_hash_hopscotch_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_hash_hopscotch_precision(pred, labels, pos); let r = ds_hash_hopscotch_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_hash_hopscotch_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_hash_hopscotch_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_hash_hopscotch_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_hash_hopscotch_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_hash_hopscotch_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_hash_hopscotch_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_hash_hopscotch_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_hash_hopscotch_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_hash_hopscotch_fibonacci(n : Int) -> Int {
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

pub fn ds_hash_hopscotch_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_hash_hopscotch_min(data); let mx = ds_hash_hopscotch_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_hash_hopscotch_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_hash_hopscotch_mean(data); let sd = ds_hash_hopscotch_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_hash_hopscotch_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_hash_hopscotch_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_hash_hopscotch_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_hash_hopscotch_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DshashhopscotchFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_frame_make(size : Int) -> DshashhopscotchFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_frame_len(s : DshashhopscotchFrame) -> Int { s.size }

pub fn ds_hash_hopscotch_frame_get(s : DshashhopscotchFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_frame_set(s : DshashhopscotchFrame, i : Int, v : Double) -> DshashhopscotchFrame {
  let result = ds_hash_hopscotch_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_frame_sum(s : DshashhopscotchFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_frame_mean(s : DshashhopscotchFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_frame_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_frame_scale(s : DshashhopscotchFrame, f : Double) -> DshashhopscotchFrame {
  let result = ds_hash_hopscotch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_frame_add(a : DshashhopscotchFrame, b : DshashhopscotchFrame) -> DshashhopscotchFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_frame_copy(s : DshashhopscotchFrame) -> DshashhopscotchFrame {
  let result = ds_hash_hopscotch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_frame_fill(s : DshashhopscotchFrame, v : Double) -> DshashhopscotchFrame {
  let result = ds_hash_hopscotch_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_frame_min(s : DshashhopscotchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_frame_max(s : DshashhopscotchFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_frame_to_string(s : DshashhopscotchFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_table_make(size : Int) -> DshashhopscotchTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_table_len(s : DshashhopscotchTable) -> Int { s.size }

pub fn ds_hash_hopscotch_table_get(s : DshashhopscotchTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_table_set(s : DshashhopscotchTable, i : Int, v : Double) -> DshashhopscotchTable {
  let result = ds_hash_hopscotch_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_table_sum(s : DshashhopscotchTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_table_mean(s : DshashhopscotchTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_table_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_table_scale(s : DshashhopscotchTable, f : Double) -> DshashhopscotchTable {
  let result = ds_hash_hopscotch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_table_add(a : DshashhopscotchTable, b : DshashhopscotchTable) -> DshashhopscotchTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_table_copy(s : DshashhopscotchTable) -> DshashhopscotchTable {
  let result = ds_hash_hopscotch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_table_fill(s : DshashhopscotchTable, v : Double) -> DshashhopscotchTable {
  let result = ds_hash_hopscotch_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_table_min(s : DshashhopscotchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_table_max(s : DshashhopscotchTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_table_to_string(s : DshashhopscotchTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_graphn_make(size : Int) -> DshashhopscotchGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_graphn_len(s : DshashhopscotchGraphN) -> Int { s.size }

pub fn ds_hash_hopscotch_graphn_get(s : DshashhopscotchGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_graphn_set(s : DshashhopscotchGraphN, i : Int, v : Double) -> DshashhopscotchGraphN {
  let result = ds_hash_hopscotch_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_graphn_sum(s : DshashhopscotchGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_graphn_mean(s : DshashhopscotchGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_graphn_scale(s : DshashhopscotchGraphN, f : Double) -> DshashhopscotchGraphN {
  let result = ds_hash_hopscotch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_graphn_add(a : DshashhopscotchGraphN, b : DshashhopscotchGraphN) -> DshashhopscotchGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_graphn_copy(s : DshashhopscotchGraphN) -> DshashhopscotchGraphN {
  let result = ds_hash_hopscotch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_graphn_fill(s : DshashhopscotchGraphN, v : Double) -> DshashhopscotchGraphN {
  let result = ds_hash_hopscotch_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_graphn_min(s : DshashhopscotchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_graphn_max(s : DshashhopscotchGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_graphn_to_string(s : DshashhopscotchGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_node_make(size : Int) -> DshashhopscotchNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_node_len(s : DshashhopscotchNode) -> Int { s.size }

pub fn ds_hash_hopscotch_node_get(s : DshashhopscotchNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_node_set(s : DshashhopscotchNode, i : Int, v : Double) -> DshashhopscotchNode {
  let result = ds_hash_hopscotch_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_node_sum(s : DshashhopscotchNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_node_mean(s : DshashhopscotchNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_node_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_node_scale(s : DshashhopscotchNode, f : Double) -> DshashhopscotchNode {
  let result = ds_hash_hopscotch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_node_add(a : DshashhopscotchNode, b : DshashhopscotchNode) -> DshashhopscotchNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_node_copy(s : DshashhopscotchNode) -> DshashhopscotchNode {
  let result = ds_hash_hopscotch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_node_fill(s : DshashhopscotchNode, v : Double) -> DshashhopscotchNode {
  let result = ds_hash_hopscotch_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_node_min(s : DshashhopscotchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_node_max(s : DshashhopscotchNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_node_to_string(s : DshashhopscotchNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_edge_make(size : Int) -> DshashhopscotchEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_edge_len(s : DshashhopscotchEdge) -> Int { s.size }

pub fn ds_hash_hopscotch_edge_get(s : DshashhopscotchEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_edge_set(s : DshashhopscotchEdge, i : Int, v : Double) -> DshashhopscotchEdge {
  let result = ds_hash_hopscotch_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_edge_sum(s : DshashhopscotchEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_edge_mean(s : DshashhopscotchEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_edge_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_edge_scale(s : DshashhopscotchEdge, f : Double) -> DshashhopscotchEdge {
  let result = ds_hash_hopscotch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_edge_add(a : DshashhopscotchEdge, b : DshashhopscotchEdge) -> DshashhopscotchEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_edge_copy(s : DshashhopscotchEdge) -> DshashhopscotchEdge {
  let result = ds_hash_hopscotch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_edge_fill(s : DshashhopscotchEdge, v : Double) -> DshashhopscotchEdge {
  let result = ds_hash_hopscotch_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_edge_min(s : DshashhopscotchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_edge_max(s : DshashhopscotchEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_edge_to_string(s : DshashhopscotchEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_path_make(size : Int) -> DshashhopscotchPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_path_len(s : DshashhopscotchPath) -> Int { s.size }

pub fn ds_hash_hopscotch_path_get(s : DshashhopscotchPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_path_set(s : DshashhopscotchPath, i : Int, v : Double) -> DshashhopscotchPath {
  let result = ds_hash_hopscotch_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_path_sum(s : DshashhopscotchPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_path_mean(s : DshashhopscotchPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_path_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_path_scale(s : DshashhopscotchPath, f : Double) -> DshashhopscotchPath {
  let result = ds_hash_hopscotch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_path_add(a : DshashhopscotchPath, b : DshashhopscotchPath) -> DshashhopscotchPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_path_copy(s : DshashhopscotchPath) -> DshashhopscotchPath {
  let result = ds_hash_hopscotch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_path_fill(s : DshashhopscotchPath, v : Double) -> DshashhopscotchPath {
  let result = ds_hash_hopscotch_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_path_min(s : DshashhopscotchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_path_max(s : DshashhopscotchPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_path_to_string(s : DshashhopscotchPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_cluster_make(size : Int) -> DshashhopscotchCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_cluster_len(s : DshashhopscotchCluster) -> Int { s.size }

pub fn ds_hash_hopscotch_cluster_get(s : DshashhopscotchCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_cluster_set(s : DshashhopscotchCluster, i : Int, v : Double) -> DshashhopscotchCluster {
  let result = ds_hash_hopscotch_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_cluster_sum(s : DshashhopscotchCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_cluster_mean(s : DshashhopscotchCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_cluster_scale(s : DshashhopscotchCluster, f : Double) -> DshashhopscotchCluster {
  let result = ds_hash_hopscotch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_cluster_add(a : DshashhopscotchCluster, b : DshashhopscotchCluster) -> DshashhopscotchCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_cluster_copy(s : DshashhopscotchCluster) -> DshashhopscotchCluster {
  let result = ds_hash_hopscotch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_cluster_fill(s : DshashhopscotchCluster, v : Double) -> DshashhopscotchCluster {
  let result = ds_hash_hopscotch_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_cluster_min(s : DshashhopscotchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_cluster_max(s : DshashhopscotchCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_cluster_to_string(s : DshashhopscotchCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_model_make(size : Int) -> DshashhopscotchModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_model_len(s : DshashhopscotchModel) -> Int { s.size }

pub fn ds_hash_hopscotch_model_get(s : DshashhopscotchModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_model_set(s : DshashhopscotchModel, i : Int, v : Double) -> DshashhopscotchModel {
  let result = ds_hash_hopscotch_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_model_sum(s : DshashhopscotchModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_model_mean(s : DshashhopscotchModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_model_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_model_scale(s : DshashhopscotchModel, f : Double) -> DshashhopscotchModel {
  let result = ds_hash_hopscotch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_model_add(a : DshashhopscotchModel, b : DshashhopscotchModel) -> DshashhopscotchModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_model_copy(s : DshashhopscotchModel) -> DshashhopscotchModel {
  let result = ds_hash_hopscotch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_model_fill(s : DshashhopscotchModel, v : Double) -> DshashhopscotchModel {
  let result = ds_hash_hopscotch_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_model_min(s : DshashhopscotchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_model_max(s : DshashhopscotchModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_model_to_string(s : DshashhopscotchModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_layer_make(size : Int) -> DshashhopscotchLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_layer_len(s : DshashhopscotchLayer) -> Int { s.size }

pub fn ds_hash_hopscotch_layer_get(s : DshashhopscotchLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_layer_set(s : DshashhopscotchLayer, i : Int, v : Double) -> DshashhopscotchLayer {
  let result = ds_hash_hopscotch_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_layer_sum(s : DshashhopscotchLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_layer_mean(s : DshashhopscotchLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_layer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_layer_scale(s : DshashhopscotchLayer, f : Double) -> DshashhopscotchLayer {
  let result = ds_hash_hopscotch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_layer_add(a : DshashhopscotchLayer, b : DshashhopscotchLayer) -> DshashhopscotchLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_layer_copy(s : DshashhopscotchLayer) -> DshashhopscotchLayer {
  let result = ds_hash_hopscotch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_layer_fill(s : DshashhopscotchLayer, v : Double) -> DshashhopscotchLayer {
  let result = ds_hash_hopscotch_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_layer_min(s : DshashhopscotchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_layer_max(s : DshashhopscotchLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_layer_to_string(s : DshashhopscotchLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_buffer_make(size : Int) -> DshashhopscotchBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_buffer_len(s : DshashhopscotchBuffer) -> Int { s.size }

pub fn ds_hash_hopscotch_buffer_get(s : DshashhopscotchBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_buffer_set(s : DshashhopscotchBuffer, i : Int, v : Double) -> DshashhopscotchBuffer {
  let result = ds_hash_hopscotch_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_buffer_sum(s : DshashhopscotchBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_buffer_mean(s : DshashhopscotchBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_buffer_scale(s : DshashhopscotchBuffer, f : Double) -> DshashhopscotchBuffer {
  let result = ds_hash_hopscotch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_buffer_add(a : DshashhopscotchBuffer, b : DshashhopscotchBuffer) -> DshashhopscotchBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_buffer_copy(s : DshashhopscotchBuffer) -> DshashhopscotchBuffer {
  let result = ds_hash_hopscotch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_buffer_fill(s : DshashhopscotchBuffer, v : Double) -> DshashhopscotchBuffer {
  let result = ds_hash_hopscotch_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_buffer_min(s : DshashhopscotchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_buffer_max(s : DshashhopscotchBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_buffer_to_string(s : DshashhopscotchBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_cursor_make(size : Int) -> DshashhopscotchCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_cursor_len(s : DshashhopscotchCursor) -> Int { s.size }

pub fn ds_hash_hopscotch_cursor_get(s : DshashhopscotchCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_cursor_set(s : DshashhopscotchCursor, i : Int, v : Double) -> DshashhopscotchCursor {
  let result = ds_hash_hopscotch_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_cursor_sum(s : DshashhopscotchCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_cursor_mean(s : DshashhopscotchCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_cursor_scale(s : DshashhopscotchCursor, f : Double) -> DshashhopscotchCursor {
  let result = ds_hash_hopscotch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_cursor_add(a : DshashhopscotchCursor, b : DshashhopscotchCursor) -> DshashhopscotchCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_cursor_copy(s : DshashhopscotchCursor) -> DshashhopscotchCursor {
  let result = ds_hash_hopscotch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_cursor_fill(s : DshashhopscotchCursor, v : Double) -> DshashhopscotchCursor {
  let result = ds_hash_hopscotch_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_cursor_min(s : DshashhopscotchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_cursor_max(s : DshashhopscotchCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_cursor_to_string(s : DshashhopscotchCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_view_make(size : Int) -> DshashhopscotchView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_view_len(s : DshashhopscotchView) -> Int { s.size }

pub fn ds_hash_hopscotch_view_get(s : DshashhopscotchView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_view_set(s : DshashhopscotchView, i : Int, v : Double) -> DshashhopscotchView {
  let result = ds_hash_hopscotch_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_view_sum(s : DshashhopscotchView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_view_mean(s : DshashhopscotchView) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_view_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_view_scale(s : DshashhopscotchView, f : Double) -> DshashhopscotchView {
  let result = ds_hash_hopscotch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_view_add(a : DshashhopscotchView, b : DshashhopscotchView) -> DshashhopscotchView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_view_copy(s : DshashhopscotchView) -> DshashhopscotchView {
  let result = ds_hash_hopscotch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_view_fill(s : DshashhopscotchView, v : Double) -> DshashhopscotchView {
  let result = ds_hash_hopscotch_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_view_min(s : DshashhopscotchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_view_max(s : DshashhopscotchView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_view_to_string(s : DshashhopscotchView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_range_make(size : Int) -> DshashhopscotchRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_range_len(s : DshashhopscotchRange) -> Int { s.size }

pub fn ds_hash_hopscotch_range_get(s : DshashhopscotchRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_range_set(s : DshashhopscotchRange, i : Int, v : Double) -> DshashhopscotchRange {
  let result = ds_hash_hopscotch_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_range_sum(s : DshashhopscotchRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_range_mean(s : DshashhopscotchRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_range_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_range_scale(s : DshashhopscotchRange, f : Double) -> DshashhopscotchRange {
  let result = ds_hash_hopscotch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_range_add(a : DshashhopscotchRange, b : DshashhopscotchRange) -> DshashhopscotchRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_range_copy(s : DshashhopscotchRange) -> DshashhopscotchRange {
  let result = ds_hash_hopscotch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_range_fill(s : DshashhopscotchRange, v : Double) -> DshashhopscotchRange {
  let result = ds_hash_hopscotch_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_range_min(s : DshashhopscotchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_range_max(s : DshashhopscotchRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_range_to_string(s : DshashhopscotchRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashhopscotchSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_hopscotch_slice_make(size : Int) -> DshashhopscotchSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_hopscotch_slice_len(s : DshashhopscotchSlice) -> Int { s.size }

pub fn ds_hash_hopscotch_slice_get(s : DshashhopscotchSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_hopscotch_slice_set(s : DshashhopscotchSlice, i : Int, v : Double) -> DshashhopscotchSlice {
  let result = ds_hash_hopscotch_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_slice_sum(s : DshashhopscotchSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_hopscotch_slice_mean(s : DshashhopscotchSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_hopscotch_slice_sum(s) / s.size.to_double() }
}

pub fn ds_hash_hopscotch_slice_scale(s : DshashhopscotchSlice, f : Double) -> DshashhopscotchSlice {
  let result = ds_hash_hopscotch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_hopscotch_slice_add(a : DshashhopscotchSlice, b : DshashhopscotchSlice) -> DshashhopscotchSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_hopscotch_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_hopscotch_slice_copy(s : DshashhopscotchSlice) -> DshashhopscotchSlice {
  let result = ds_hash_hopscotch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_hopscotch_slice_fill(s : DshashhopscotchSlice, v : Double) -> DshashhopscotchSlice {
  let result = ds_hash_hopscotch_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_hopscotch_slice_min(s : DshashhopscotchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_slice_max(s : DshashhopscotchSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_hopscotch_slice_to_string(s : DshashhopscotchSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

