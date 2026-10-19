///===
/// extcore/bio_seq_align_global

pub(all) struct BioseqalignglobalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_global_make_point(x : Double, y : Double) -> BioseqalignglobalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_global_make_point3(x : Double, y : Double, z : Double) -> BioseqalignglobalPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_align_global_point_x(pt : BioseqalignglobalPoint) -> Double { pt.x }

pub fn bio_seq_align_global_point_y(pt : BioseqalignglobalPoint) -> Double { pt.y }

pub fn bio_seq_align_global_point_z(pt : BioseqalignglobalPoint) -> Double { pt.z }

pub fn bio_seq_align_global_point_label(pt : BioseqalignglobalPoint) -> Int { pt.label }

pub fn bio_seq_align_global_point_dist(a : BioseqalignglobalPoint, b : BioseqalignglobalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_align_global_point_add(a : BioseqalignglobalPoint, b : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_align_global_point_sub(a : BioseqalignglobalPoint, b : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_align_global_point_scale(pt : BioseqalignglobalPoint, s : Double) -> BioseqalignglobalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_align_global_point_dot(a : BioseqalignglobalPoint, b : BioseqalignglobalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_align_global_point_cross(a : BioseqalignglobalPoint, b : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_align_global_point_norm(pt : BioseqalignglobalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_align_global_point_normalize(pt : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  let n = bio_seq_align_global_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_align_global_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_align_global_point_negate(pt : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_align_global_point_mid(a : BioseqalignglobalPoint, b : BioseqalignglobalPoint) -> BioseqalignglobalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_align_global_point_lerp(a : BioseqalignglobalPoint, b : BioseqalignglobalPoint, t : Double) -> BioseqalignglobalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_align_global_point_to_string(pt : BioseqalignglobalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqalignglobalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_global_make_series(vals : Array[Double], name : String) -> BioseqalignglobalSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_align_global_series_len(s : BioseqalignglobalSeries) -> Int { s.vals.length() }

pub fn bio_seq_align_global_series_sum(s : BioseqalignglobalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_align_global_series_mean(s : BioseqalignglobalSeries) -> Double {
  let n = bio_seq_align_global_series_len(s)
  if n == 0 { 0.0 } else { bio_seq_align_global_series_sum(s) / n.to_double() }
}

pub fn bio_seq_align_global_series_min(s : BioseqalignglobalSeries) -> Double {
  let n = bio_seq_align_global_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_align_global_series_max(s : BioseqalignglobalSeries) -> Double {
  let n = bio_seq_align_global_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_align_global_series_range(s : BioseqalignglobalSeries) -> Double {
  bio_seq_align_global_series_max(s) - bio_seq_align_global_series_min(s)
}

pub fn bio_seq_align_global_series_var(s : BioseqalignglobalSeries) -> Double {
  let n = bio_seq_align_global_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_seq_align_global_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_seq_align_global_series_std(s : BioseqalignglobalSeries) -> Double { @_common.sqrt(bio_seq_align_global_series_var(s)) }

pub fn bio_seq_align_global_series_median(s : BioseqalignglobalSeries) -> Double {
  let n = bio_seq_align_global_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_align_global_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_align_global_series_scale(s : BioseqalignglobalSeries, f : Double) -> BioseqalignglobalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_align_global_series_add(a : BioseqalignglobalSeries, b : BioseqalignglobalSeries) -> BioseqalignglobalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_align_global_series_sub(a : BioseqalignglobalSeries, b : BioseqalignglobalSeries) -> BioseqalignglobalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_align_global_series_normalize(s : BioseqalignglobalSeries) -> BioseqalignglobalSeries {
  let mn = bio_seq_align_global_series_min(s)
  let mx = bio_seq_align_global_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_align_global_series_cumsum(s : BioseqalignglobalSeries) -> BioseqalignglobalSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_align_global_series_to_string(s : BioseqalignglobalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignglobalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_global_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignglobalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_global_matrix_identity(n : Int) -> BioseqalignglobalMatrix {
  let m = bio_seq_align_global_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_align_global_matrix_get(m : BioseqalignglobalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_align_global_matrix_transpose(m : BioseqalignglobalMatrix) -> BioseqalignglobalMatrix {
  let result = bio_seq_align_global_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_align_global_matrix_add(a : BioseqalignglobalMatrix, b : BioseqalignglobalMatrix) -> BioseqalignglobalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_align_global_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_align_global_matrix_scale(m : BioseqalignglobalMatrix, s : Double) -> BioseqalignglobalMatrix {
  let result = bio_seq_align_global_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_align_global_matrix_multiply(a : BioseqalignglobalMatrix, b : BioseqalignglobalMatrix) -> BioseqalignglobalMatrix {
  if a.cols != b.rows { return bio_seq_align_global_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_align_global_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_align_global_matrix_trace(m : BioseqalignglobalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_align_global_matrix_det(m : BioseqalignglobalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_align_global_matrix_norm(m : BioseqalignglobalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_align_global_matrix_to_string(m : BioseqalignglobalMatrix) -> String {
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

pub(all) struct BioseqalignglobalVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_global_make_vector(comps : Array[Double]) -> BioseqalignglobalVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_global_vector_zero(dim : Int) -> BioseqalignglobalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_align_global_vector_add(a : BioseqalignglobalVector, b : BioseqalignglobalVector) -> BioseqalignglobalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_global_vector_sub(a : BioseqalignglobalVector, b : BioseqalignglobalVector) -> BioseqalignglobalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_global_vector_scale(v : BioseqalignglobalVector, s : Double) -> BioseqalignglobalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_align_global_vector_dot(a : BioseqalignglobalVector, b : BioseqalignglobalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_align_global_vector_norm(v : BioseqalignglobalVector) -> Double { @_common.sqrt(bio_seq_align_global_vector_dot(v, v)) }

pub fn bio_seq_align_global_vector_normalize(v : BioseqalignglobalVector) -> BioseqalignglobalVector {
  let n = bio_seq_align_global_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_align_global_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_align_global_vector_dist(a : BioseqalignglobalVector, b : BioseqalignglobalVector) -> Double {
  bio_seq_align_global_vector_norm(bio_seq_align_global_vector_sub(a, b))
}

pub fn bio_seq_align_global_vector_to_string(v : BioseqalignglobalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_global_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_global_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_seq_align_global_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_global_std(data : Array[Double]) -> Double { @_common.sqrt(bio_seq_align_global_var(data)) }

pub fn bio_seq_align_global_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_seq_align_global_mean(a); let mb = bio_seq_align_global_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_global_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_seq_align_global_std(a); let sb = bio_seq_align_global_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_seq_align_global_cov(a, b) / (sa * sb) }
}

pub fn bio_seq_align_global_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_align_global_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_align_global_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_seq_align_global_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_global_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(bio_seq_align_global_mse(pred, labels))
}

pub fn bio_seq_align_global_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_global_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_seq_align_global_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_seq_align_global_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_seq_align_global_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_seq_align_global_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_seq_align_global_precision(pred, labels, pos); let r = bio_seq_align_global_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_seq_align_global_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_seq_align_global_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_seq_align_global_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_seq_align_global_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_seq_align_global_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_seq_align_global_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_seq_align_global_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_seq_align_global_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_seq_align_global_fibonacci(n : Int) -> Int {
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

pub fn bio_seq_align_global_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_seq_align_global_min(data); let mx = bio_seq_align_global_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_seq_align_global_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_seq_align_global_mean(data); let sd = bio_seq_align_global_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_seq_align_global_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_seq_align_global_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_seq_align_global_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_seq_align_global_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_seq_align_global_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_seq_align_global_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct BioseqalignglobalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_frame_make(size : Int) -> BioseqalignglobalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_frame_len(s : BioseqalignglobalFrame) -> Int { s.size }

pub fn bio_seq_align_global_frame_get(s : BioseqalignglobalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_frame_set(s : BioseqalignglobalFrame, i : Int, v : Double) -> BioseqalignglobalFrame {
  let result = bio_seq_align_global_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_frame_sum(s : BioseqalignglobalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_frame_mean(s : BioseqalignglobalFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_frame_scale(s : BioseqalignglobalFrame, f : Double) -> BioseqalignglobalFrame {
  let result = bio_seq_align_global_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_frame_add(a : BioseqalignglobalFrame, b : BioseqalignglobalFrame) -> BioseqalignglobalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_frame_copy(s : BioseqalignglobalFrame) -> BioseqalignglobalFrame {
  let result = bio_seq_align_global_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_frame_fill(s : BioseqalignglobalFrame, v : Double) -> BioseqalignglobalFrame {
  let result = bio_seq_align_global_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_frame_min(s : BioseqalignglobalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_frame_max(s : BioseqalignglobalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_frame_to_string(s : BioseqalignglobalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_table_make(size : Int) -> BioseqalignglobalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_table_len(s : BioseqalignglobalTable) -> Int { s.size }

pub fn bio_seq_align_global_table_get(s : BioseqalignglobalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_table_set(s : BioseqalignglobalTable, i : Int, v : Double) -> BioseqalignglobalTable {
  let result = bio_seq_align_global_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_table_sum(s : BioseqalignglobalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_table_mean(s : BioseqalignglobalTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_table_scale(s : BioseqalignglobalTable, f : Double) -> BioseqalignglobalTable {
  let result = bio_seq_align_global_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_table_add(a : BioseqalignglobalTable, b : BioseqalignglobalTable) -> BioseqalignglobalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_table_copy(s : BioseqalignglobalTable) -> BioseqalignglobalTable {
  let result = bio_seq_align_global_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_table_fill(s : BioseqalignglobalTable, v : Double) -> BioseqalignglobalTable {
  let result = bio_seq_align_global_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_table_min(s : BioseqalignglobalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_table_max(s : BioseqalignglobalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_table_to_string(s : BioseqalignglobalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_graphn_make(size : Int) -> BioseqalignglobalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_graphn_len(s : BioseqalignglobalGraphN) -> Int { s.size }

pub fn bio_seq_align_global_graphn_get(s : BioseqalignglobalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_graphn_set(s : BioseqalignglobalGraphN, i : Int, v : Double) -> BioseqalignglobalGraphN {
  let result = bio_seq_align_global_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_graphn_sum(s : BioseqalignglobalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_graphn_mean(s : BioseqalignglobalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_graphn_scale(s : BioseqalignglobalGraphN, f : Double) -> BioseqalignglobalGraphN {
  let result = bio_seq_align_global_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_graphn_add(a : BioseqalignglobalGraphN, b : BioseqalignglobalGraphN) -> BioseqalignglobalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_graphn_copy(s : BioseqalignglobalGraphN) -> BioseqalignglobalGraphN {
  let result = bio_seq_align_global_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_graphn_fill(s : BioseqalignglobalGraphN, v : Double) -> BioseqalignglobalGraphN {
  let result = bio_seq_align_global_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_graphn_min(s : BioseqalignglobalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_graphn_max(s : BioseqalignglobalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_graphn_to_string(s : BioseqalignglobalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_node_make(size : Int) -> BioseqalignglobalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_node_len(s : BioseqalignglobalNode) -> Int { s.size }

pub fn bio_seq_align_global_node_get(s : BioseqalignglobalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_node_set(s : BioseqalignglobalNode, i : Int, v : Double) -> BioseqalignglobalNode {
  let result = bio_seq_align_global_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_node_sum(s : BioseqalignglobalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_node_mean(s : BioseqalignglobalNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_node_scale(s : BioseqalignglobalNode, f : Double) -> BioseqalignglobalNode {
  let result = bio_seq_align_global_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_node_add(a : BioseqalignglobalNode, b : BioseqalignglobalNode) -> BioseqalignglobalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_node_copy(s : BioseqalignglobalNode) -> BioseqalignglobalNode {
  let result = bio_seq_align_global_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_node_fill(s : BioseqalignglobalNode, v : Double) -> BioseqalignglobalNode {
  let result = bio_seq_align_global_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_node_min(s : BioseqalignglobalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_node_max(s : BioseqalignglobalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_node_to_string(s : BioseqalignglobalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_edge_make(size : Int) -> BioseqalignglobalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_edge_len(s : BioseqalignglobalEdge) -> Int { s.size }

pub fn bio_seq_align_global_edge_get(s : BioseqalignglobalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_edge_set(s : BioseqalignglobalEdge, i : Int, v : Double) -> BioseqalignglobalEdge {
  let result = bio_seq_align_global_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_edge_sum(s : BioseqalignglobalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_edge_mean(s : BioseqalignglobalEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_edge_scale(s : BioseqalignglobalEdge, f : Double) -> BioseqalignglobalEdge {
  let result = bio_seq_align_global_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_edge_add(a : BioseqalignglobalEdge, b : BioseqalignglobalEdge) -> BioseqalignglobalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_edge_copy(s : BioseqalignglobalEdge) -> BioseqalignglobalEdge {
  let result = bio_seq_align_global_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_edge_fill(s : BioseqalignglobalEdge, v : Double) -> BioseqalignglobalEdge {
  let result = bio_seq_align_global_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_edge_min(s : BioseqalignglobalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_edge_max(s : BioseqalignglobalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_edge_to_string(s : BioseqalignglobalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_path_make(size : Int) -> BioseqalignglobalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_path_len(s : BioseqalignglobalPath) -> Int { s.size }

pub fn bio_seq_align_global_path_get(s : BioseqalignglobalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_path_set(s : BioseqalignglobalPath, i : Int, v : Double) -> BioseqalignglobalPath {
  let result = bio_seq_align_global_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_path_sum(s : BioseqalignglobalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_path_mean(s : BioseqalignglobalPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_path_scale(s : BioseqalignglobalPath, f : Double) -> BioseqalignglobalPath {
  let result = bio_seq_align_global_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_path_add(a : BioseqalignglobalPath, b : BioseqalignglobalPath) -> BioseqalignglobalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_path_copy(s : BioseqalignglobalPath) -> BioseqalignglobalPath {
  let result = bio_seq_align_global_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_path_fill(s : BioseqalignglobalPath, v : Double) -> BioseqalignglobalPath {
  let result = bio_seq_align_global_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_path_min(s : BioseqalignglobalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_path_max(s : BioseqalignglobalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_path_to_string(s : BioseqalignglobalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_cluster_make(size : Int) -> BioseqalignglobalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_cluster_len(s : BioseqalignglobalCluster) -> Int { s.size }

pub fn bio_seq_align_global_cluster_get(s : BioseqalignglobalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_cluster_set(s : BioseqalignglobalCluster, i : Int, v : Double) -> BioseqalignglobalCluster {
  let result = bio_seq_align_global_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_cluster_sum(s : BioseqalignglobalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_cluster_mean(s : BioseqalignglobalCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_cluster_scale(s : BioseqalignglobalCluster, f : Double) -> BioseqalignglobalCluster {
  let result = bio_seq_align_global_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_cluster_add(a : BioseqalignglobalCluster, b : BioseqalignglobalCluster) -> BioseqalignglobalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_cluster_copy(s : BioseqalignglobalCluster) -> BioseqalignglobalCluster {
  let result = bio_seq_align_global_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_cluster_fill(s : BioseqalignglobalCluster, v : Double) -> BioseqalignglobalCluster {
  let result = bio_seq_align_global_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_cluster_min(s : BioseqalignglobalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_cluster_max(s : BioseqalignglobalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_cluster_to_string(s : BioseqalignglobalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_model_make(size : Int) -> BioseqalignglobalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_model_len(s : BioseqalignglobalModel) -> Int { s.size }

pub fn bio_seq_align_global_model_get(s : BioseqalignglobalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_model_set(s : BioseqalignglobalModel, i : Int, v : Double) -> BioseqalignglobalModel {
  let result = bio_seq_align_global_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_model_sum(s : BioseqalignglobalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_model_mean(s : BioseqalignglobalModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_model_scale(s : BioseqalignglobalModel, f : Double) -> BioseqalignglobalModel {
  let result = bio_seq_align_global_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_model_add(a : BioseqalignglobalModel, b : BioseqalignglobalModel) -> BioseqalignglobalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_model_copy(s : BioseqalignglobalModel) -> BioseqalignglobalModel {
  let result = bio_seq_align_global_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_model_fill(s : BioseqalignglobalModel, v : Double) -> BioseqalignglobalModel {
  let result = bio_seq_align_global_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_model_min(s : BioseqalignglobalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_model_max(s : BioseqalignglobalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_model_to_string(s : BioseqalignglobalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_layer_make(size : Int) -> BioseqalignglobalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_layer_len(s : BioseqalignglobalLayer) -> Int { s.size }

pub fn bio_seq_align_global_layer_get(s : BioseqalignglobalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_layer_set(s : BioseqalignglobalLayer, i : Int, v : Double) -> BioseqalignglobalLayer {
  let result = bio_seq_align_global_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_layer_sum(s : BioseqalignglobalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_layer_mean(s : BioseqalignglobalLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_layer_scale(s : BioseqalignglobalLayer, f : Double) -> BioseqalignglobalLayer {
  let result = bio_seq_align_global_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_layer_add(a : BioseqalignglobalLayer, b : BioseqalignglobalLayer) -> BioseqalignglobalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_layer_copy(s : BioseqalignglobalLayer) -> BioseqalignglobalLayer {
  let result = bio_seq_align_global_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_layer_fill(s : BioseqalignglobalLayer, v : Double) -> BioseqalignglobalLayer {
  let result = bio_seq_align_global_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_layer_min(s : BioseqalignglobalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_layer_max(s : BioseqalignglobalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_layer_to_string(s : BioseqalignglobalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_buffer_make(size : Int) -> BioseqalignglobalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_buffer_len(s : BioseqalignglobalBuffer) -> Int { s.size }

pub fn bio_seq_align_global_buffer_get(s : BioseqalignglobalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_buffer_set(s : BioseqalignglobalBuffer, i : Int, v : Double) -> BioseqalignglobalBuffer {
  let result = bio_seq_align_global_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_buffer_sum(s : BioseqalignglobalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_buffer_mean(s : BioseqalignglobalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_buffer_scale(s : BioseqalignglobalBuffer, f : Double) -> BioseqalignglobalBuffer {
  let result = bio_seq_align_global_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_buffer_add(a : BioseqalignglobalBuffer, b : BioseqalignglobalBuffer) -> BioseqalignglobalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_buffer_copy(s : BioseqalignglobalBuffer) -> BioseqalignglobalBuffer {
  let result = bio_seq_align_global_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_buffer_fill(s : BioseqalignglobalBuffer, v : Double) -> BioseqalignglobalBuffer {
  let result = bio_seq_align_global_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_buffer_min(s : BioseqalignglobalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_buffer_max(s : BioseqalignglobalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_buffer_to_string(s : BioseqalignglobalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_cursor_make(size : Int) -> BioseqalignglobalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_cursor_len(s : BioseqalignglobalCursor) -> Int { s.size }

pub fn bio_seq_align_global_cursor_get(s : BioseqalignglobalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_cursor_set(s : BioseqalignglobalCursor, i : Int, v : Double) -> BioseqalignglobalCursor {
  let result = bio_seq_align_global_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_cursor_sum(s : BioseqalignglobalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_cursor_mean(s : BioseqalignglobalCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_cursor_scale(s : BioseqalignglobalCursor, f : Double) -> BioseqalignglobalCursor {
  let result = bio_seq_align_global_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_cursor_add(a : BioseqalignglobalCursor, b : BioseqalignglobalCursor) -> BioseqalignglobalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_cursor_copy(s : BioseqalignglobalCursor) -> BioseqalignglobalCursor {
  let result = bio_seq_align_global_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_cursor_fill(s : BioseqalignglobalCursor, v : Double) -> BioseqalignglobalCursor {
  let result = bio_seq_align_global_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_cursor_min(s : BioseqalignglobalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_cursor_max(s : BioseqalignglobalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_cursor_to_string(s : BioseqalignglobalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_view_make(size : Int) -> BioseqalignglobalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_view_len(s : BioseqalignglobalView) -> Int { s.size }

pub fn bio_seq_align_global_view_get(s : BioseqalignglobalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_view_set(s : BioseqalignglobalView, i : Int, v : Double) -> BioseqalignglobalView {
  let result = bio_seq_align_global_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_view_sum(s : BioseqalignglobalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_view_mean(s : BioseqalignglobalView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_view_scale(s : BioseqalignglobalView, f : Double) -> BioseqalignglobalView {
  let result = bio_seq_align_global_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_view_add(a : BioseqalignglobalView, b : BioseqalignglobalView) -> BioseqalignglobalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_view_copy(s : BioseqalignglobalView) -> BioseqalignglobalView {
  let result = bio_seq_align_global_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_view_fill(s : BioseqalignglobalView, v : Double) -> BioseqalignglobalView {
  let result = bio_seq_align_global_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_view_min(s : BioseqalignglobalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_view_max(s : BioseqalignglobalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_view_to_string(s : BioseqalignglobalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_range_make(size : Int) -> BioseqalignglobalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_range_len(s : BioseqalignglobalRange) -> Int { s.size }

pub fn bio_seq_align_global_range_get(s : BioseqalignglobalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_range_set(s : BioseqalignglobalRange, i : Int, v : Double) -> BioseqalignglobalRange {
  let result = bio_seq_align_global_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_range_sum(s : BioseqalignglobalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_range_mean(s : BioseqalignglobalRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_range_scale(s : BioseqalignglobalRange, f : Double) -> BioseqalignglobalRange {
  let result = bio_seq_align_global_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_range_add(a : BioseqalignglobalRange, b : BioseqalignglobalRange) -> BioseqalignglobalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_range_copy(s : BioseqalignglobalRange) -> BioseqalignglobalRange {
  let result = bio_seq_align_global_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_range_fill(s : BioseqalignglobalRange, v : Double) -> BioseqalignglobalRange {
  let result = bio_seq_align_global_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_range_min(s : BioseqalignglobalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_range_max(s : BioseqalignglobalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_range_to_string(s : BioseqalignglobalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignglobalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_global_slice_make(size : Int) -> BioseqalignglobalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_global_slice_len(s : BioseqalignglobalSlice) -> Int { s.size }

pub fn bio_seq_align_global_slice_get(s : BioseqalignglobalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_global_slice_set(s : BioseqalignglobalSlice, i : Int, v : Double) -> BioseqalignglobalSlice {
  let result = bio_seq_align_global_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_slice_sum(s : BioseqalignglobalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_global_slice_mean(s : BioseqalignglobalSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_global_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_global_slice_scale(s : BioseqalignglobalSlice, f : Double) -> BioseqalignglobalSlice {
  let result = bio_seq_align_global_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_global_slice_add(a : BioseqalignglobalSlice, b : BioseqalignglobalSlice) -> BioseqalignglobalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_global_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_global_slice_copy(s : BioseqalignglobalSlice) -> BioseqalignglobalSlice {
  let result = bio_seq_align_global_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_global_slice_fill(s : BioseqalignglobalSlice, v : Double) -> BioseqalignglobalSlice {
  let result = bio_seq_align_global_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_global_slice_min(s : BioseqalignglobalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_slice_max(s : BioseqalignglobalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_global_slice_to_string(s : BioseqalignglobalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

