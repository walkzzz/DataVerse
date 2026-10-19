///===
/// extcore/ds_list_doubly

pub(all) struct DslistdoublyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_list_doubly_make_point(x : Double, y : Double) -> DslistdoublyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_list_doubly_make_point3(x : Double, y : Double, z : Double) -> DslistdoublyPoint {
  { x, y, z, label: 0 }
}

pub fn ds_list_doubly_point_x(pt : DslistdoublyPoint) -> Double { pt.x }

pub fn ds_list_doubly_point_y(pt : DslistdoublyPoint) -> Double { pt.y }

pub fn ds_list_doubly_point_z(pt : DslistdoublyPoint) -> Double { pt.z }

pub fn ds_list_doubly_point_label(pt : DslistdoublyPoint) -> Int { pt.label }

pub fn ds_list_doubly_point_dist(a : DslistdoublyPoint, b : DslistdoublyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_list_doubly_point_add(a : DslistdoublyPoint, b : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_list_doubly_point_sub(a : DslistdoublyPoint, b : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_list_doubly_point_scale(pt : DslistdoublyPoint, s : Double) -> DslistdoublyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_list_doubly_point_dot(a : DslistdoublyPoint, b : DslistdoublyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_list_doubly_point_cross(a : DslistdoublyPoint, b : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_list_doubly_point_norm(pt : DslistdoublyPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_list_doubly_point_normalize(pt : DslistdoublyPoint) -> DslistdoublyPoint {
  let n = ds_list_doubly_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_list_doubly_point_scale(pt, 1.0 / n) }
}

pub fn ds_list_doubly_point_negate(pt : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_list_doubly_point_mid(a : DslistdoublyPoint, b : DslistdoublyPoint) -> DslistdoublyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_list_doubly_point_lerp(a : DslistdoublyPoint, b : DslistdoublyPoint, t : Double) -> DslistdoublyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_list_doubly_point_to_string(pt : DslistdoublyPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DslistdoublySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_list_doubly_make_series(vals : Array[Double], name : String) -> DslistdoublySeries {
  { vals, name, meta: 0 }
}

pub fn ds_list_doubly_series_len(s : DslistdoublySeries) -> Int { s.vals.length() }

pub fn ds_list_doubly_series_sum(s : DslistdoublySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_list_doubly_series_mean(s : DslistdoublySeries) -> Double {
  let n = ds_list_doubly_series_len(s)
  if n == 0 { 0.0 } else { ds_list_doubly_series_sum(s) / n.to_double() }
}

pub fn ds_list_doubly_series_min(s : DslistdoublySeries) -> Double {
  let n = ds_list_doubly_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_doubly_series_max(s : DslistdoublySeries) -> Double {
  let n = ds_list_doubly_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_list_doubly_series_range(s : DslistdoublySeries) -> Double {
  ds_list_doubly_series_max(s) - ds_list_doubly_series_min(s)
}

pub fn ds_list_doubly_series_var(s : DslistdoublySeries) -> Double {
  let n = ds_list_doubly_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_list_doubly_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_list_doubly_series_std(s : DslistdoublySeries) -> Double { @_common.sqrt(ds_list_doubly_series_var(s)) }

pub fn ds_list_doubly_series_median(s : DslistdoublySeries) -> Double {
  let n = ds_list_doubly_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_list_doubly_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_doubly_series_scale(s : DslistdoublySeries, f : Double) -> DslistdoublySeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_list_doubly_series_add(a : DslistdoublySeries, b : DslistdoublySeries) -> DslistdoublySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_list_doubly_series_sub(a : DslistdoublySeries, b : DslistdoublySeries) -> DslistdoublySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_list_doubly_series_normalize(s : DslistdoublySeries) -> DslistdoublySeries {
  let mn = ds_list_doubly_series_min(s)
  let mx = ds_list_doubly_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_list_doubly_series_cumsum(s : DslistdoublySeries) -> DslistdoublySeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_list_doubly_series_to_string(s : DslistdoublySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DslistdoublyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_list_doubly_make_matrix(rows : Int, cols : Int, val : Double) -> DslistdoublyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_list_doubly_matrix_identity(n : Int) -> DslistdoublyMatrix {
  let m = ds_list_doubly_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_list_doubly_matrix_get(m : DslistdoublyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_list_doubly_matrix_transpose(m : DslistdoublyMatrix) -> DslistdoublyMatrix {
  let result = ds_list_doubly_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_list_doubly_matrix_add(a : DslistdoublyMatrix, b : DslistdoublyMatrix) -> DslistdoublyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_list_doubly_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_list_doubly_matrix_scale(m : DslistdoublyMatrix, s : Double) -> DslistdoublyMatrix {
  let result = ds_list_doubly_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_list_doubly_matrix_multiply(a : DslistdoublyMatrix, b : DslistdoublyMatrix) -> DslistdoublyMatrix {
  if a.cols != b.rows { return ds_list_doubly_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_list_doubly_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_list_doubly_matrix_trace(m : DslistdoublyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_list_doubly_matrix_det(m : DslistdoublyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_list_doubly_matrix_norm(m : DslistdoublyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_list_doubly_matrix_to_string(m : DslistdoublyMatrix) -> String {
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

pub(all) struct DslistdoublyVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_list_doubly_make_vector(comps : Array[Double]) -> DslistdoublyVector {
  { comps, dim: comps.length() }
}

pub fn ds_list_doubly_vector_zero(dim : Int) -> DslistdoublyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_list_doubly_vector_add(a : DslistdoublyVector, b : DslistdoublyVector) -> DslistdoublyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_doubly_vector_sub(a : DslistdoublyVector, b : DslistdoublyVector) -> DslistdoublyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_list_doubly_vector_scale(v : DslistdoublyVector, s : Double) -> DslistdoublyVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_list_doubly_vector_dot(a : DslistdoublyVector, b : DslistdoublyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_list_doubly_vector_norm(v : DslistdoublyVector) -> Double { @_common.sqrt(ds_list_doubly_vector_dot(v, v)) }

pub fn ds_list_doubly_vector_normalize(v : DslistdoublyVector) -> DslistdoublyVector {
  let n = ds_list_doubly_vector_norm(v)
  if n < 0.0000001 { v } else { ds_list_doubly_vector_scale(v, 1.0 / n) }
}

pub fn ds_list_doubly_vector_dist(a : DslistdoublyVector, b : DslistdoublyVector) -> Double {
  ds_list_doubly_vector_norm(ds_list_doubly_vector_sub(a, b))
}

pub fn ds_list_doubly_vector_to_string(v : DslistdoublyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_list_doubly_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_list_doubly_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_list_doubly_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_doubly_std(data : Array[Double]) -> Double { @_common.sqrt(ds_list_doubly_var(data)) }

pub fn ds_list_doubly_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_list_doubly_mean(a); let mb = ds_list_doubly_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_list_doubly_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_list_doubly_std(a); let sb = ds_list_doubly_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_list_doubly_cov(a, b) / (sa * sb) }
}

pub fn ds_list_doubly_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_list_doubly_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_list_doubly_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_list_doubly_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_list_doubly_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ds_list_doubly_mse(pred, labels))
}

pub fn ds_list_doubly_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_list_doubly_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_list_doubly_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_list_doubly_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_list_doubly_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_list_doubly_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_list_doubly_precision(pred, labels, pos); let r = ds_list_doubly_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_list_doubly_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_list_doubly_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_list_doubly_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_list_doubly_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_list_doubly_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_list_doubly_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_list_doubly_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_list_doubly_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_list_doubly_fibonacci(n : Int) -> Int {
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

pub fn ds_list_doubly_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_list_doubly_min(data); let mx = ds_list_doubly_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_list_doubly_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_list_doubly_mean(data); let sd = ds_list_doubly_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_list_doubly_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_list_doubly_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_list_doubly_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_list_doubly_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_list_doubly_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_list_doubly_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DslistdoublyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_frame_make(size : Int) -> DslistdoublyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_frame_len(s : DslistdoublyFrame) -> Int { s.size }

pub fn ds_list_doubly_frame_get(s : DslistdoublyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_frame_set(s : DslistdoublyFrame, i : Int, v : Double) -> DslistdoublyFrame {
  let result = ds_list_doubly_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_frame_sum(s : DslistdoublyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_frame_mean(s : DslistdoublyFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_frame_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_frame_scale(s : DslistdoublyFrame, f : Double) -> DslistdoublyFrame {
  let result = ds_list_doubly_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_frame_add(a : DslistdoublyFrame, b : DslistdoublyFrame) -> DslistdoublyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_frame_copy(s : DslistdoublyFrame) -> DslistdoublyFrame {
  let result = ds_list_doubly_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_frame_fill(s : DslistdoublyFrame, v : Double) -> DslistdoublyFrame {
  let result = ds_list_doubly_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_frame_min(s : DslistdoublyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_frame_max(s : DslistdoublyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_frame_to_string(s : DslistdoublyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_table_make(size : Int) -> DslistdoublyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_table_len(s : DslistdoublyTable) -> Int { s.size }

pub fn ds_list_doubly_table_get(s : DslistdoublyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_table_set(s : DslistdoublyTable, i : Int, v : Double) -> DslistdoublyTable {
  let result = ds_list_doubly_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_table_sum(s : DslistdoublyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_table_mean(s : DslistdoublyTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_table_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_table_scale(s : DslistdoublyTable, f : Double) -> DslistdoublyTable {
  let result = ds_list_doubly_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_table_add(a : DslistdoublyTable, b : DslistdoublyTable) -> DslistdoublyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_table_copy(s : DslistdoublyTable) -> DslistdoublyTable {
  let result = ds_list_doubly_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_table_fill(s : DslistdoublyTable, v : Double) -> DslistdoublyTable {
  let result = ds_list_doubly_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_table_min(s : DslistdoublyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_table_max(s : DslistdoublyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_table_to_string(s : DslistdoublyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_graphn_make(size : Int) -> DslistdoublyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_graphn_len(s : DslistdoublyGraphN) -> Int { s.size }

pub fn ds_list_doubly_graphn_get(s : DslistdoublyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_graphn_set(s : DslistdoublyGraphN, i : Int, v : Double) -> DslistdoublyGraphN {
  let result = ds_list_doubly_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_graphn_sum(s : DslistdoublyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_graphn_mean(s : DslistdoublyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_graphn_scale(s : DslistdoublyGraphN, f : Double) -> DslistdoublyGraphN {
  let result = ds_list_doubly_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_graphn_add(a : DslistdoublyGraphN, b : DslistdoublyGraphN) -> DslistdoublyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_graphn_copy(s : DslistdoublyGraphN) -> DslistdoublyGraphN {
  let result = ds_list_doubly_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_graphn_fill(s : DslistdoublyGraphN, v : Double) -> DslistdoublyGraphN {
  let result = ds_list_doubly_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_graphn_min(s : DslistdoublyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_graphn_max(s : DslistdoublyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_graphn_to_string(s : DslistdoublyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_node_make(size : Int) -> DslistdoublyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_node_len(s : DslistdoublyNode) -> Int { s.size }

pub fn ds_list_doubly_node_get(s : DslistdoublyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_node_set(s : DslistdoublyNode, i : Int, v : Double) -> DslistdoublyNode {
  let result = ds_list_doubly_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_node_sum(s : DslistdoublyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_node_mean(s : DslistdoublyNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_node_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_node_scale(s : DslistdoublyNode, f : Double) -> DslistdoublyNode {
  let result = ds_list_doubly_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_node_add(a : DslistdoublyNode, b : DslistdoublyNode) -> DslistdoublyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_node_copy(s : DslistdoublyNode) -> DslistdoublyNode {
  let result = ds_list_doubly_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_node_fill(s : DslistdoublyNode, v : Double) -> DslistdoublyNode {
  let result = ds_list_doubly_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_node_min(s : DslistdoublyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_node_max(s : DslistdoublyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_node_to_string(s : DslistdoublyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_edge_make(size : Int) -> DslistdoublyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_edge_len(s : DslistdoublyEdge) -> Int { s.size }

pub fn ds_list_doubly_edge_get(s : DslistdoublyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_edge_set(s : DslistdoublyEdge, i : Int, v : Double) -> DslistdoublyEdge {
  let result = ds_list_doubly_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_edge_sum(s : DslistdoublyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_edge_mean(s : DslistdoublyEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_edge_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_edge_scale(s : DslistdoublyEdge, f : Double) -> DslistdoublyEdge {
  let result = ds_list_doubly_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_edge_add(a : DslistdoublyEdge, b : DslistdoublyEdge) -> DslistdoublyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_edge_copy(s : DslistdoublyEdge) -> DslistdoublyEdge {
  let result = ds_list_doubly_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_edge_fill(s : DslistdoublyEdge, v : Double) -> DslistdoublyEdge {
  let result = ds_list_doubly_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_edge_min(s : DslistdoublyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_edge_max(s : DslistdoublyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_edge_to_string(s : DslistdoublyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_path_make(size : Int) -> DslistdoublyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_path_len(s : DslistdoublyPath) -> Int { s.size }

pub fn ds_list_doubly_path_get(s : DslistdoublyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_path_set(s : DslistdoublyPath, i : Int, v : Double) -> DslistdoublyPath {
  let result = ds_list_doubly_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_path_sum(s : DslistdoublyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_path_mean(s : DslistdoublyPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_path_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_path_scale(s : DslistdoublyPath, f : Double) -> DslistdoublyPath {
  let result = ds_list_doubly_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_path_add(a : DslistdoublyPath, b : DslistdoublyPath) -> DslistdoublyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_path_copy(s : DslistdoublyPath) -> DslistdoublyPath {
  let result = ds_list_doubly_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_path_fill(s : DslistdoublyPath, v : Double) -> DslistdoublyPath {
  let result = ds_list_doubly_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_path_min(s : DslistdoublyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_path_max(s : DslistdoublyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_path_to_string(s : DslistdoublyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_cluster_make(size : Int) -> DslistdoublyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_cluster_len(s : DslistdoublyCluster) -> Int { s.size }

pub fn ds_list_doubly_cluster_get(s : DslistdoublyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_cluster_set(s : DslistdoublyCluster, i : Int, v : Double) -> DslistdoublyCluster {
  let result = ds_list_doubly_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_cluster_sum(s : DslistdoublyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_cluster_mean(s : DslistdoublyCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_cluster_scale(s : DslistdoublyCluster, f : Double) -> DslistdoublyCluster {
  let result = ds_list_doubly_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_cluster_add(a : DslistdoublyCluster, b : DslistdoublyCluster) -> DslistdoublyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_cluster_copy(s : DslistdoublyCluster) -> DslistdoublyCluster {
  let result = ds_list_doubly_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_cluster_fill(s : DslistdoublyCluster, v : Double) -> DslistdoublyCluster {
  let result = ds_list_doubly_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_cluster_min(s : DslistdoublyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_cluster_max(s : DslistdoublyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_cluster_to_string(s : DslistdoublyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_model_make(size : Int) -> DslistdoublyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_model_len(s : DslistdoublyModel) -> Int { s.size }

pub fn ds_list_doubly_model_get(s : DslistdoublyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_model_set(s : DslistdoublyModel, i : Int, v : Double) -> DslistdoublyModel {
  let result = ds_list_doubly_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_model_sum(s : DslistdoublyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_model_mean(s : DslistdoublyModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_model_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_model_scale(s : DslistdoublyModel, f : Double) -> DslistdoublyModel {
  let result = ds_list_doubly_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_model_add(a : DslistdoublyModel, b : DslistdoublyModel) -> DslistdoublyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_model_copy(s : DslistdoublyModel) -> DslistdoublyModel {
  let result = ds_list_doubly_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_model_fill(s : DslistdoublyModel, v : Double) -> DslistdoublyModel {
  let result = ds_list_doubly_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_model_min(s : DslistdoublyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_model_max(s : DslistdoublyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_model_to_string(s : DslistdoublyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_layer_make(size : Int) -> DslistdoublyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_layer_len(s : DslistdoublyLayer) -> Int { s.size }

pub fn ds_list_doubly_layer_get(s : DslistdoublyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_layer_set(s : DslistdoublyLayer, i : Int, v : Double) -> DslistdoublyLayer {
  let result = ds_list_doubly_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_layer_sum(s : DslistdoublyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_layer_mean(s : DslistdoublyLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_layer_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_layer_scale(s : DslistdoublyLayer, f : Double) -> DslistdoublyLayer {
  let result = ds_list_doubly_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_layer_add(a : DslistdoublyLayer, b : DslistdoublyLayer) -> DslistdoublyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_layer_copy(s : DslistdoublyLayer) -> DslistdoublyLayer {
  let result = ds_list_doubly_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_layer_fill(s : DslistdoublyLayer, v : Double) -> DslistdoublyLayer {
  let result = ds_list_doubly_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_layer_min(s : DslistdoublyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_layer_max(s : DslistdoublyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_layer_to_string(s : DslistdoublyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_buffer_make(size : Int) -> DslistdoublyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_buffer_len(s : DslistdoublyBuffer) -> Int { s.size }

pub fn ds_list_doubly_buffer_get(s : DslistdoublyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_buffer_set(s : DslistdoublyBuffer, i : Int, v : Double) -> DslistdoublyBuffer {
  let result = ds_list_doubly_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_buffer_sum(s : DslistdoublyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_buffer_mean(s : DslistdoublyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_buffer_scale(s : DslistdoublyBuffer, f : Double) -> DslistdoublyBuffer {
  let result = ds_list_doubly_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_buffer_add(a : DslistdoublyBuffer, b : DslistdoublyBuffer) -> DslistdoublyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_buffer_copy(s : DslistdoublyBuffer) -> DslistdoublyBuffer {
  let result = ds_list_doubly_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_buffer_fill(s : DslistdoublyBuffer, v : Double) -> DslistdoublyBuffer {
  let result = ds_list_doubly_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_buffer_min(s : DslistdoublyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_buffer_max(s : DslistdoublyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_buffer_to_string(s : DslistdoublyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_cursor_make(size : Int) -> DslistdoublyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_cursor_len(s : DslistdoublyCursor) -> Int { s.size }

pub fn ds_list_doubly_cursor_get(s : DslistdoublyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_cursor_set(s : DslistdoublyCursor, i : Int, v : Double) -> DslistdoublyCursor {
  let result = ds_list_doubly_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_cursor_sum(s : DslistdoublyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_cursor_mean(s : DslistdoublyCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_cursor_scale(s : DslistdoublyCursor, f : Double) -> DslistdoublyCursor {
  let result = ds_list_doubly_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_cursor_add(a : DslistdoublyCursor, b : DslistdoublyCursor) -> DslistdoublyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_cursor_copy(s : DslistdoublyCursor) -> DslistdoublyCursor {
  let result = ds_list_doubly_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_cursor_fill(s : DslistdoublyCursor, v : Double) -> DslistdoublyCursor {
  let result = ds_list_doubly_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_cursor_min(s : DslistdoublyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_cursor_max(s : DslistdoublyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_cursor_to_string(s : DslistdoublyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_view_make(size : Int) -> DslistdoublyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_view_len(s : DslistdoublyView) -> Int { s.size }

pub fn ds_list_doubly_view_get(s : DslistdoublyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_view_set(s : DslistdoublyView, i : Int, v : Double) -> DslistdoublyView {
  let result = ds_list_doubly_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_view_sum(s : DslistdoublyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_view_mean(s : DslistdoublyView) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_view_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_view_scale(s : DslistdoublyView, f : Double) -> DslistdoublyView {
  let result = ds_list_doubly_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_view_add(a : DslistdoublyView, b : DslistdoublyView) -> DslistdoublyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_view_copy(s : DslistdoublyView) -> DslistdoublyView {
  let result = ds_list_doubly_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_view_fill(s : DslistdoublyView, v : Double) -> DslistdoublyView {
  let result = ds_list_doubly_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_view_min(s : DslistdoublyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_view_max(s : DslistdoublyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_view_to_string(s : DslistdoublyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_range_make(size : Int) -> DslistdoublyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_range_len(s : DslistdoublyRange) -> Int { s.size }

pub fn ds_list_doubly_range_get(s : DslistdoublyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_range_set(s : DslistdoublyRange, i : Int, v : Double) -> DslistdoublyRange {
  let result = ds_list_doubly_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_range_sum(s : DslistdoublyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_range_mean(s : DslistdoublyRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_range_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_range_scale(s : DslistdoublyRange, f : Double) -> DslistdoublyRange {
  let result = ds_list_doubly_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_range_add(a : DslistdoublyRange, b : DslistdoublyRange) -> DslistdoublyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_range_copy(s : DslistdoublyRange) -> DslistdoublyRange {
  let result = ds_list_doubly_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_range_fill(s : DslistdoublyRange, v : Double) -> DslistdoublyRange {
  let result = ds_list_doubly_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_range_min(s : DslistdoublyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_range_max(s : DslistdoublyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_range_to_string(s : DslistdoublyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DslistdoublySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_list_doubly_slice_make(size : Int) -> DslistdoublySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_list_doubly_slice_len(s : DslistdoublySlice) -> Int { s.size }

pub fn ds_list_doubly_slice_get(s : DslistdoublySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_list_doubly_slice_set(s : DslistdoublySlice, i : Int, v : Double) -> DslistdoublySlice {
  let result = ds_list_doubly_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_slice_sum(s : DslistdoublySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_list_doubly_slice_mean(s : DslistdoublySlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_list_doubly_slice_sum(s) / s.size.to_double() }
}

pub fn ds_list_doubly_slice_scale(s : DslistdoublySlice, f : Double) -> DslistdoublySlice {
  let result = ds_list_doubly_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_list_doubly_slice_add(a : DslistdoublySlice, b : DslistdoublySlice) -> DslistdoublySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_list_doubly_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_list_doubly_slice_copy(s : DslistdoublySlice) -> DslistdoublySlice {
  let result = ds_list_doubly_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_list_doubly_slice_fill(s : DslistdoublySlice, v : Double) -> DslistdoublySlice {
  let result = ds_list_doubly_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_list_doubly_slice_min(s : DslistdoublySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_slice_max(s : DslistdoublySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_list_doubly_slice_to_string(s : DslistdoublySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

