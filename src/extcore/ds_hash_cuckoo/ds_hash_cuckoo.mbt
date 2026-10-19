///===
/// extcore/ds_hash_cuckoo

pub(all) struct DshashcuckooPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn ds_hash_cuckoo_make_point(x : Double, y : Double) -> DshashcuckooPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn ds_hash_cuckoo_make_point3(x : Double, y : Double, z : Double) -> DshashcuckooPoint {
  { x, y, z, label: 0 }
}

pub fn ds_hash_cuckoo_point_x(pt : DshashcuckooPoint) -> Double { pt.x }

pub fn ds_hash_cuckoo_point_y(pt : DshashcuckooPoint) -> Double { pt.y }

pub fn ds_hash_cuckoo_point_z(pt : DshashcuckooPoint) -> Double { pt.z }

pub fn ds_hash_cuckoo_point_label(pt : DshashcuckooPoint) -> Int { pt.label }

pub fn ds_hash_cuckoo_point_dist(a : DshashcuckooPoint, b : DshashcuckooPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn ds_hash_cuckoo_point_add(a : DshashcuckooPoint, b : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn ds_hash_cuckoo_point_sub(a : DshashcuckooPoint, b : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn ds_hash_cuckoo_point_scale(pt : DshashcuckooPoint, s : Double) -> DshashcuckooPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn ds_hash_cuckoo_point_dot(a : DshashcuckooPoint, b : DshashcuckooPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn ds_hash_cuckoo_point_cross(a : DshashcuckooPoint, b : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn ds_hash_cuckoo_point_norm(pt : DshashcuckooPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn ds_hash_cuckoo_point_normalize(pt : DshashcuckooPoint) -> DshashcuckooPoint {
  let n = ds_hash_cuckoo_point_norm(pt)
  if n < 0.0000001 { pt } else { ds_hash_cuckoo_point_scale(pt, 1.0 / n) }
}

pub fn ds_hash_cuckoo_point_negate(pt : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn ds_hash_cuckoo_point_mid(a : DshashcuckooPoint, b : DshashcuckooPoint) -> DshashcuckooPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn ds_hash_cuckoo_point_lerp(a : DshashcuckooPoint, b : DshashcuckooPoint, t : Double) -> DshashcuckooPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn ds_hash_cuckoo_point_to_string(pt : DshashcuckooPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct DshashcuckooSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn ds_hash_cuckoo_make_series(vals : Array[Double], name : String) -> DshashcuckooSeries {
  { vals, name, meta: 0 }
}

pub fn ds_hash_cuckoo_series_len(s : DshashcuckooSeries) -> Int { s.vals.length() }

pub fn ds_hash_cuckoo_series_sum(s : DshashcuckooSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn ds_hash_cuckoo_series_mean(s : DshashcuckooSeries) -> Double {
  let n = ds_hash_cuckoo_series_len(s)
  if n == 0 { 0.0 } else { ds_hash_cuckoo_series_sum(s) / n.to_double() }
}

pub fn ds_hash_cuckoo_series_min(s : DshashcuckooSeries) -> Double {
  let n = ds_hash_cuckoo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_series_max(s : DshashcuckooSeries) -> Double {
  let n = ds_hash_cuckoo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_series_range(s : DshashcuckooSeries) -> Double {
  ds_hash_cuckoo_series_max(s) - ds_hash_cuckoo_series_min(s)
}

pub fn ds_hash_cuckoo_series_var(s : DshashcuckooSeries) -> Double {
  let n = ds_hash_cuckoo_series_len(s)
  if n == 0 { 0.0 } else {
    let m = ds_hash_cuckoo_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn ds_hash_cuckoo_series_std(s : DshashcuckooSeries) -> Double { @_common.sqrt(ds_hash_cuckoo_series_var(s)) }

pub fn ds_hash_cuckoo_series_median(s : DshashcuckooSeries) -> Double {
  let n = ds_hash_cuckoo_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_cuckoo_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_cuckoo_series_scale(s : DshashcuckooSeries, f : Double) -> DshashcuckooSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn ds_hash_cuckoo_series_add(a : DshashcuckooSeries, b : DshashcuckooSeries) -> DshashcuckooSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn ds_hash_cuckoo_series_sub(a : DshashcuckooSeries, b : DshashcuckooSeries) -> DshashcuckooSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn ds_hash_cuckoo_series_normalize(s : DshashcuckooSeries) -> DshashcuckooSeries {
  let mn = ds_hash_cuckoo_series_min(s)
  let mx = ds_hash_cuckoo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn ds_hash_cuckoo_series_cumsum(s : DshashcuckooSeries) -> DshashcuckooSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn ds_hash_cuckoo_series_to_string(s : DshashcuckooSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct DshashcuckooMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn ds_hash_cuckoo_make_matrix(rows : Int, cols : Int, val : Double) -> DshashcuckooMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn ds_hash_cuckoo_matrix_identity(n : Int) -> DshashcuckooMatrix {
  let m = ds_hash_cuckoo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn ds_hash_cuckoo_matrix_get(m : DshashcuckooMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn ds_hash_cuckoo_matrix_transpose(m : DshashcuckooMatrix) -> DshashcuckooMatrix {
  let result = ds_hash_cuckoo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn ds_hash_cuckoo_matrix_add(a : DshashcuckooMatrix, b : DshashcuckooMatrix) -> DshashcuckooMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = ds_hash_cuckoo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn ds_hash_cuckoo_matrix_scale(m : DshashcuckooMatrix, s : Double) -> DshashcuckooMatrix {
  let result = ds_hash_cuckoo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn ds_hash_cuckoo_matrix_multiply(a : DshashcuckooMatrix, b : DshashcuckooMatrix) -> DshashcuckooMatrix {
  if a.cols != b.rows { return ds_hash_cuckoo_make_matrix(a.rows, b.cols, 0.0) }
  let result = ds_hash_cuckoo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn ds_hash_cuckoo_matrix_trace(m : DshashcuckooMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn ds_hash_cuckoo_matrix_det(m : DshashcuckooMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn ds_hash_cuckoo_matrix_norm(m : DshashcuckooMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn ds_hash_cuckoo_matrix_to_string(m : DshashcuckooMatrix) -> String {
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

pub(all) struct DshashcuckooVector {
  comps : Array[Double]
  dim : Int
}

pub fn ds_hash_cuckoo_make_vector(comps : Array[Double]) -> DshashcuckooVector {
  { comps, dim: comps.length() }
}

pub fn ds_hash_cuckoo_vector_zero(dim : Int) -> DshashcuckooVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn ds_hash_cuckoo_vector_add(a : DshashcuckooVector, b : DshashcuckooVector) -> DshashcuckooVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_cuckoo_vector_sub(a : DshashcuckooVector, b : DshashcuckooVector) -> DshashcuckooVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn ds_hash_cuckoo_vector_scale(v : DshashcuckooVector, s : Double) -> DshashcuckooVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn ds_hash_cuckoo_vector_dot(a : DshashcuckooVector, b : DshashcuckooVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn ds_hash_cuckoo_vector_norm(v : DshashcuckooVector) -> Double { @_common.sqrt(ds_hash_cuckoo_vector_dot(v, v)) }

pub fn ds_hash_cuckoo_vector_normalize(v : DshashcuckooVector) -> DshashcuckooVector {
  let n = ds_hash_cuckoo_vector_norm(v)
  if n < 0.0000001 { v } else { ds_hash_cuckoo_vector_scale(v, 1.0 / n) }
}

pub fn ds_hash_cuckoo_vector_dist(a : DshashcuckooVector, b : DshashcuckooVector) -> Double {
  ds_hash_cuckoo_vector_norm(ds_hash_cuckoo_vector_sub(a, b))
}

pub fn ds_hash_cuckoo_vector_to_string(v : DshashcuckooVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn ds_hash_cuckoo_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn ds_hash_cuckoo_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = ds_hash_cuckoo_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_cuckoo_std(data : Array[Double]) -> Double { @_common.sqrt(ds_hash_cuckoo_var(data)) }

pub fn ds_hash_cuckoo_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = ds_hash_cuckoo_mean(a); let mb = ds_hash_cuckoo_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn ds_hash_cuckoo_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = ds_hash_cuckoo_std(a); let sb = ds_hash_cuckoo_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { ds_hash_cuckoo_cov(a, b) / (sa * sb) }
}

pub fn ds_hash_cuckoo_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = ds_hash_cuckoo_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn ds_hash_cuckoo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn ds_hash_cuckoo_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn ds_hash_cuckoo_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(ds_hash_cuckoo_mse(pred, labels))
}

pub fn ds_hash_cuckoo_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn ds_hash_cuckoo_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = ds_hash_cuckoo_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn ds_hash_cuckoo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn ds_hash_cuckoo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn ds_hash_cuckoo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = ds_hash_cuckoo_precision(pred, labels, pos); let r = ds_hash_cuckoo_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn ds_hash_cuckoo_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn ds_hash_cuckoo_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = ds_hash_cuckoo_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn ds_hash_cuckoo_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn ds_hash_cuckoo_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn ds_hash_cuckoo_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = ds_hash_cuckoo_gcd(a, b)
    (a / g) * b
  }
}

pub fn ds_hash_cuckoo_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn ds_hash_cuckoo_fibonacci(n : Int) -> Int {
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

pub fn ds_hash_cuckoo_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = ds_hash_cuckoo_min(data); let mx = ds_hash_cuckoo_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn ds_hash_cuckoo_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = ds_hash_cuckoo_mean(data); let sd = ds_hash_cuckoo_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn ds_hash_cuckoo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn ds_hash_cuckoo_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn ds_hash_cuckoo_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn ds_hash_cuckoo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct DshashcuckooFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_frame_make(size : Int) -> DshashcuckooFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_frame_len(s : DshashcuckooFrame) -> Int { s.size }

pub fn ds_hash_cuckoo_frame_get(s : DshashcuckooFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_frame_set(s : DshashcuckooFrame, i : Int, v : Double) -> DshashcuckooFrame {
  let result = ds_hash_cuckoo_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_frame_sum(s : DshashcuckooFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_frame_mean(s : DshashcuckooFrame) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_frame_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_frame_scale(s : DshashcuckooFrame, f : Double) -> DshashcuckooFrame {
  let result = ds_hash_cuckoo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_frame_add(a : DshashcuckooFrame, b : DshashcuckooFrame) -> DshashcuckooFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_frame_copy(s : DshashcuckooFrame) -> DshashcuckooFrame {
  let result = ds_hash_cuckoo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_frame_fill(s : DshashcuckooFrame, v : Double) -> DshashcuckooFrame {
  let result = ds_hash_cuckoo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_frame_min(s : DshashcuckooFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_frame_max(s : DshashcuckooFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_frame_to_string(s : DshashcuckooFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_table_make(size : Int) -> DshashcuckooTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_table_len(s : DshashcuckooTable) -> Int { s.size }

pub fn ds_hash_cuckoo_table_get(s : DshashcuckooTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_table_set(s : DshashcuckooTable, i : Int, v : Double) -> DshashcuckooTable {
  let result = ds_hash_cuckoo_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_table_sum(s : DshashcuckooTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_table_mean(s : DshashcuckooTable) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_table_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_table_scale(s : DshashcuckooTable, f : Double) -> DshashcuckooTable {
  let result = ds_hash_cuckoo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_table_add(a : DshashcuckooTable, b : DshashcuckooTable) -> DshashcuckooTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_table_copy(s : DshashcuckooTable) -> DshashcuckooTable {
  let result = ds_hash_cuckoo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_table_fill(s : DshashcuckooTable, v : Double) -> DshashcuckooTable {
  let result = ds_hash_cuckoo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_table_min(s : DshashcuckooTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_table_max(s : DshashcuckooTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_table_to_string(s : DshashcuckooTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_graphn_make(size : Int) -> DshashcuckooGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_graphn_len(s : DshashcuckooGraphN) -> Int { s.size }

pub fn ds_hash_cuckoo_graphn_get(s : DshashcuckooGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_graphn_set(s : DshashcuckooGraphN, i : Int, v : Double) -> DshashcuckooGraphN {
  let result = ds_hash_cuckoo_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_graphn_sum(s : DshashcuckooGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_graphn_mean(s : DshashcuckooGraphN) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_graphn_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_graphn_scale(s : DshashcuckooGraphN, f : Double) -> DshashcuckooGraphN {
  let result = ds_hash_cuckoo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_graphn_add(a : DshashcuckooGraphN, b : DshashcuckooGraphN) -> DshashcuckooGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_graphn_copy(s : DshashcuckooGraphN) -> DshashcuckooGraphN {
  let result = ds_hash_cuckoo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_graphn_fill(s : DshashcuckooGraphN, v : Double) -> DshashcuckooGraphN {
  let result = ds_hash_cuckoo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_graphn_min(s : DshashcuckooGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_graphn_max(s : DshashcuckooGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_graphn_to_string(s : DshashcuckooGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_node_make(size : Int) -> DshashcuckooNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_node_len(s : DshashcuckooNode) -> Int { s.size }

pub fn ds_hash_cuckoo_node_get(s : DshashcuckooNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_node_set(s : DshashcuckooNode, i : Int, v : Double) -> DshashcuckooNode {
  let result = ds_hash_cuckoo_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_node_sum(s : DshashcuckooNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_node_mean(s : DshashcuckooNode) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_node_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_node_scale(s : DshashcuckooNode, f : Double) -> DshashcuckooNode {
  let result = ds_hash_cuckoo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_node_add(a : DshashcuckooNode, b : DshashcuckooNode) -> DshashcuckooNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_node_copy(s : DshashcuckooNode) -> DshashcuckooNode {
  let result = ds_hash_cuckoo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_node_fill(s : DshashcuckooNode, v : Double) -> DshashcuckooNode {
  let result = ds_hash_cuckoo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_node_min(s : DshashcuckooNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_node_max(s : DshashcuckooNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_node_to_string(s : DshashcuckooNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_edge_make(size : Int) -> DshashcuckooEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_edge_len(s : DshashcuckooEdge) -> Int { s.size }

pub fn ds_hash_cuckoo_edge_get(s : DshashcuckooEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_edge_set(s : DshashcuckooEdge, i : Int, v : Double) -> DshashcuckooEdge {
  let result = ds_hash_cuckoo_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_edge_sum(s : DshashcuckooEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_edge_mean(s : DshashcuckooEdge) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_edge_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_edge_scale(s : DshashcuckooEdge, f : Double) -> DshashcuckooEdge {
  let result = ds_hash_cuckoo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_edge_add(a : DshashcuckooEdge, b : DshashcuckooEdge) -> DshashcuckooEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_edge_copy(s : DshashcuckooEdge) -> DshashcuckooEdge {
  let result = ds_hash_cuckoo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_edge_fill(s : DshashcuckooEdge, v : Double) -> DshashcuckooEdge {
  let result = ds_hash_cuckoo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_edge_min(s : DshashcuckooEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_edge_max(s : DshashcuckooEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_edge_to_string(s : DshashcuckooEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_path_make(size : Int) -> DshashcuckooPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_path_len(s : DshashcuckooPath) -> Int { s.size }

pub fn ds_hash_cuckoo_path_get(s : DshashcuckooPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_path_set(s : DshashcuckooPath, i : Int, v : Double) -> DshashcuckooPath {
  let result = ds_hash_cuckoo_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_path_sum(s : DshashcuckooPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_path_mean(s : DshashcuckooPath) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_path_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_path_scale(s : DshashcuckooPath, f : Double) -> DshashcuckooPath {
  let result = ds_hash_cuckoo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_path_add(a : DshashcuckooPath, b : DshashcuckooPath) -> DshashcuckooPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_path_copy(s : DshashcuckooPath) -> DshashcuckooPath {
  let result = ds_hash_cuckoo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_path_fill(s : DshashcuckooPath, v : Double) -> DshashcuckooPath {
  let result = ds_hash_cuckoo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_path_min(s : DshashcuckooPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_path_max(s : DshashcuckooPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_path_to_string(s : DshashcuckooPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_cluster_make(size : Int) -> DshashcuckooCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_cluster_len(s : DshashcuckooCluster) -> Int { s.size }

pub fn ds_hash_cuckoo_cluster_get(s : DshashcuckooCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_cluster_set(s : DshashcuckooCluster, i : Int, v : Double) -> DshashcuckooCluster {
  let result = ds_hash_cuckoo_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_cluster_sum(s : DshashcuckooCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_cluster_mean(s : DshashcuckooCluster) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_cluster_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_cluster_scale(s : DshashcuckooCluster, f : Double) -> DshashcuckooCluster {
  let result = ds_hash_cuckoo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_cluster_add(a : DshashcuckooCluster, b : DshashcuckooCluster) -> DshashcuckooCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_cluster_copy(s : DshashcuckooCluster) -> DshashcuckooCluster {
  let result = ds_hash_cuckoo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_cluster_fill(s : DshashcuckooCluster, v : Double) -> DshashcuckooCluster {
  let result = ds_hash_cuckoo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_cluster_min(s : DshashcuckooCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_cluster_max(s : DshashcuckooCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_cluster_to_string(s : DshashcuckooCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_model_make(size : Int) -> DshashcuckooModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_model_len(s : DshashcuckooModel) -> Int { s.size }

pub fn ds_hash_cuckoo_model_get(s : DshashcuckooModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_model_set(s : DshashcuckooModel, i : Int, v : Double) -> DshashcuckooModel {
  let result = ds_hash_cuckoo_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_model_sum(s : DshashcuckooModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_model_mean(s : DshashcuckooModel) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_model_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_model_scale(s : DshashcuckooModel, f : Double) -> DshashcuckooModel {
  let result = ds_hash_cuckoo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_model_add(a : DshashcuckooModel, b : DshashcuckooModel) -> DshashcuckooModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_model_copy(s : DshashcuckooModel) -> DshashcuckooModel {
  let result = ds_hash_cuckoo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_model_fill(s : DshashcuckooModel, v : Double) -> DshashcuckooModel {
  let result = ds_hash_cuckoo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_model_min(s : DshashcuckooModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_model_max(s : DshashcuckooModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_model_to_string(s : DshashcuckooModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_layer_make(size : Int) -> DshashcuckooLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_layer_len(s : DshashcuckooLayer) -> Int { s.size }

pub fn ds_hash_cuckoo_layer_get(s : DshashcuckooLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_layer_set(s : DshashcuckooLayer, i : Int, v : Double) -> DshashcuckooLayer {
  let result = ds_hash_cuckoo_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_layer_sum(s : DshashcuckooLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_layer_mean(s : DshashcuckooLayer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_layer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_layer_scale(s : DshashcuckooLayer, f : Double) -> DshashcuckooLayer {
  let result = ds_hash_cuckoo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_layer_add(a : DshashcuckooLayer, b : DshashcuckooLayer) -> DshashcuckooLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_layer_copy(s : DshashcuckooLayer) -> DshashcuckooLayer {
  let result = ds_hash_cuckoo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_layer_fill(s : DshashcuckooLayer, v : Double) -> DshashcuckooLayer {
  let result = ds_hash_cuckoo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_layer_min(s : DshashcuckooLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_layer_max(s : DshashcuckooLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_layer_to_string(s : DshashcuckooLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_buffer_make(size : Int) -> DshashcuckooBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_buffer_len(s : DshashcuckooBuffer) -> Int { s.size }

pub fn ds_hash_cuckoo_buffer_get(s : DshashcuckooBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_buffer_set(s : DshashcuckooBuffer, i : Int, v : Double) -> DshashcuckooBuffer {
  let result = ds_hash_cuckoo_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_buffer_sum(s : DshashcuckooBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_buffer_mean(s : DshashcuckooBuffer) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_buffer_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_buffer_scale(s : DshashcuckooBuffer, f : Double) -> DshashcuckooBuffer {
  let result = ds_hash_cuckoo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_buffer_add(a : DshashcuckooBuffer, b : DshashcuckooBuffer) -> DshashcuckooBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_buffer_copy(s : DshashcuckooBuffer) -> DshashcuckooBuffer {
  let result = ds_hash_cuckoo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_buffer_fill(s : DshashcuckooBuffer, v : Double) -> DshashcuckooBuffer {
  let result = ds_hash_cuckoo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_buffer_min(s : DshashcuckooBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_buffer_max(s : DshashcuckooBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_buffer_to_string(s : DshashcuckooBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_cursor_make(size : Int) -> DshashcuckooCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_cursor_len(s : DshashcuckooCursor) -> Int { s.size }

pub fn ds_hash_cuckoo_cursor_get(s : DshashcuckooCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_cursor_set(s : DshashcuckooCursor, i : Int, v : Double) -> DshashcuckooCursor {
  let result = ds_hash_cuckoo_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_cursor_sum(s : DshashcuckooCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_cursor_mean(s : DshashcuckooCursor) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_cursor_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_cursor_scale(s : DshashcuckooCursor, f : Double) -> DshashcuckooCursor {
  let result = ds_hash_cuckoo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_cursor_add(a : DshashcuckooCursor, b : DshashcuckooCursor) -> DshashcuckooCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_cursor_copy(s : DshashcuckooCursor) -> DshashcuckooCursor {
  let result = ds_hash_cuckoo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_cursor_fill(s : DshashcuckooCursor, v : Double) -> DshashcuckooCursor {
  let result = ds_hash_cuckoo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_cursor_min(s : DshashcuckooCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_cursor_max(s : DshashcuckooCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_cursor_to_string(s : DshashcuckooCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_view_make(size : Int) -> DshashcuckooView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_view_len(s : DshashcuckooView) -> Int { s.size }

pub fn ds_hash_cuckoo_view_get(s : DshashcuckooView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_view_set(s : DshashcuckooView, i : Int, v : Double) -> DshashcuckooView {
  let result = ds_hash_cuckoo_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_view_sum(s : DshashcuckooView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_view_mean(s : DshashcuckooView) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_view_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_view_scale(s : DshashcuckooView, f : Double) -> DshashcuckooView {
  let result = ds_hash_cuckoo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_view_add(a : DshashcuckooView, b : DshashcuckooView) -> DshashcuckooView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_view_copy(s : DshashcuckooView) -> DshashcuckooView {
  let result = ds_hash_cuckoo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_view_fill(s : DshashcuckooView, v : Double) -> DshashcuckooView {
  let result = ds_hash_cuckoo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_view_min(s : DshashcuckooView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_view_max(s : DshashcuckooView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_view_to_string(s : DshashcuckooView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_range_make(size : Int) -> DshashcuckooRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_range_len(s : DshashcuckooRange) -> Int { s.size }

pub fn ds_hash_cuckoo_range_get(s : DshashcuckooRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_range_set(s : DshashcuckooRange, i : Int, v : Double) -> DshashcuckooRange {
  let result = ds_hash_cuckoo_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_range_sum(s : DshashcuckooRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_range_mean(s : DshashcuckooRange) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_range_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_range_scale(s : DshashcuckooRange, f : Double) -> DshashcuckooRange {
  let result = ds_hash_cuckoo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_range_add(a : DshashcuckooRange, b : DshashcuckooRange) -> DshashcuckooRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_range_copy(s : DshashcuckooRange) -> DshashcuckooRange {
  let result = ds_hash_cuckoo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_range_fill(s : DshashcuckooRange, v : Double) -> DshashcuckooRange {
  let result = ds_hash_cuckoo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_range_min(s : DshashcuckooRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_range_max(s : DshashcuckooRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_range_to_string(s : DshashcuckooRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct DshashcuckooSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn ds_hash_cuckoo_slice_make(size : Int) -> DshashcuckooSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn ds_hash_cuckoo_slice_len(s : DshashcuckooSlice) -> Int { s.size }

pub fn ds_hash_cuckoo_slice_get(s : DshashcuckooSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn ds_hash_cuckoo_slice_set(s : DshashcuckooSlice, i : Int, v : Double) -> DshashcuckooSlice {
  let result = ds_hash_cuckoo_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_slice_sum(s : DshashcuckooSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn ds_hash_cuckoo_slice_mean(s : DshashcuckooSlice) -> Double {
  if s.size == 0 { 0.0 } else { ds_hash_cuckoo_slice_sum(s) / s.size.to_double() }
}

pub fn ds_hash_cuckoo_slice_scale(s : DshashcuckooSlice, f : Double) -> DshashcuckooSlice {
  let result = ds_hash_cuckoo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn ds_hash_cuckoo_slice_add(a : DshashcuckooSlice, b : DshashcuckooSlice) -> DshashcuckooSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = ds_hash_cuckoo_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn ds_hash_cuckoo_slice_copy(s : DshashcuckooSlice) -> DshashcuckooSlice {
  let result = ds_hash_cuckoo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn ds_hash_cuckoo_slice_fill(s : DshashcuckooSlice, v : Double) -> DshashcuckooSlice {
  let result = ds_hash_cuckoo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn ds_hash_cuckoo_slice_min(s : DshashcuckooSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_slice_max(s : DshashcuckooSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn ds_hash_cuckoo_slice_to_string(s : DshashcuckooSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

