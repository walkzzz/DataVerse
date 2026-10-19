///===
/// extcore/bio_seq_align_semi

pub(all) struct BioseqalignsemiPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_align_semi_make_point(x : Double, y : Double) -> BioseqalignsemiPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_align_semi_make_point3(x : Double, y : Double, z : Double) -> BioseqalignsemiPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_align_semi_point_x(pt : BioseqalignsemiPoint) -> Double { pt.x }

pub fn bio_seq_align_semi_point_y(pt : BioseqalignsemiPoint) -> Double { pt.y }

pub fn bio_seq_align_semi_point_z(pt : BioseqalignsemiPoint) -> Double { pt.z }

pub fn bio_seq_align_semi_point_label(pt : BioseqalignsemiPoint) -> Int { pt.label }

pub fn bio_seq_align_semi_point_dist(a : BioseqalignsemiPoint, b : BioseqalignsemiPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_align_semi_point_add(a : BioseqalignsemiPoint, b : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_align_semi_point_sub(a : BioseqalignsemiPoint, b : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_align_semi_point_scale(pt : BioseqalignsemiPoint, s : Double) -> BioseqalignsemiPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_align_semi_point_dot(a : BioseqalignsemiPoint, b : BioseqalignsemiPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_align_semi_point_cross(a : BioseqalignsemiPoint, b : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_align_semi_point_norm(pt : BioseqalignsemiPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_align_semi_point_normalize(pt : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  let n = bio_seq_align_semi_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_align_semi_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_align_semi_point_negate(pt : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_align_semi_point_mid(a : BioseqalignsemiPoint, b : BioseqalignsemiPoint) -> BioseqalignsemiPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_align_semi_point_lerp(a : BioseqalignsemiPoint, b : BioseqalignsemiPoint, t : Double) -> BioseqalignsemiPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_align_semi_point_to_string(pt : BioseqalignsemiPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqalignsemiSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_align_semi_make_series(vals : Array[Double], name : String) -> BioseqalignsemiSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_align_semi_series_len(s : BioseqalignsemiSeries) -> Int { s.vals.length() }

pub fn bio_seq_align_semi_series_sum(s : BioseqalignsemiSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_align_semi_series_mean(s : BioseqalignsemiSeries) -> Double {
  let n = bio_seq_align_semi_series_len(s)
  if n == 0 { 0.0 } else { bio_seq_align_semi_series_sum(s) / n.to_double() }
}

pub fn bio_seq_align_semi_series_min(s : BioseqalignsemiSeries) -> Double {
  let n = bio_seq_align_semi_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_align_semi_series_max(s : BioseqalignsemiSeries) -> Double {
  let n = bio_seq_align_semi_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_align_semi_series_range(s : BioseqalignsemiSeries) -> Double {
  bio_seq_align_semi_series_max(s) - bio_seq_align_semi_series_min(s)
}

pub fn bio_seq_align_semi_series_var(s : BioseqalignsemiSeries) -> Double {
  let n = bio_seq_align_semi_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_seq_align_semi_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_seq_align_semi_series_std(s : BioseqalignsemiSeries) -> Double { @_common.sqrt(bio_seq_align_semi_series_var(s)) }

pub fn bio_seq_align_semi_series_median(s : BioseqalignsemiSeries) -> Double {
  let n = bio_seq_align_semi_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_align_semi_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_align_semi_series_scale(s : BioseqalignsemiSeries, f : Double) -> BioseqalignsemiSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_align_semi_series_add(a : BioseqalignsemiSeries, b : BioseqalignsemiSeries) -> BioseqalignsemiSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_align_semi_series_sub(a : BioseqalignsemiSeries, b : BioseqalignsemiSeries) -> BioseqalignsemiSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_align_semi_series_normalize(s : BioseqalignsemiSeries) -> BioseqalignsemiSeries {
  let mn = bio_seq_align_semi_series_min(s)
  let mx = bio_seq_align_semi_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_align_semi_series_cumsum(s : BioseqalignsemiSeries) -> BioseqalignsemiSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_align_semi_series_to_string(s : BioseqalignsemiSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqalignsemiMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_align_semi_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqalignsemiMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_align_semi_matrix_identity(n : Int) -> BioseqalignsemiMatrix {
  let m = bio_seq_align_semi_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_align_semi_matrix_get(m : BioseqalignsemiMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_align_semi_matrix_transpose(m : BioseqalignsemiMatrix) -> BioseqalignsemiMatrix {
  let result = bio_seq_align_semi_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_align_semi_matrix_add(a : BioseqalignsemiMatrix, b : BioseqalignsemiMatrix) -> BioseqalignsemiMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_align_semi_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_align_semi_matrix_scale(m : BioseqalignsemiMatrix, s : Double) -> BioseqalignsemiMatrix {
  let result = bio_seq_align_semi_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_align_semi_matrix_multiply(a : BioseqalignsemiMatrix, b : BioseqalignsemiMatrix) -> BioseqalignsemiMatrix {
  if a.cols != b.rows { return bio_seq_align_semi_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_align_semi_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_align_semi_matrix_trace(m : BioseqalignsemiMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_align_semi_matrix_det(m : BioseqalignsemiMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_align_semi_matrix_norm(m : BioseqalignsemiMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_align_semi_matrix_to_string(m : BioseqalignsemiMatrix) -> String {
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

pub(all) struct BioseqalignsemiVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_align_semi_make_vector(comps : Array[Double]) -> BioseqalignsemiVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_align_semi_vector_zero(dim : Int) -> BioseqalignsemiVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_align_semi_vector_add(a : BioseqalignsemiVector, b : BioseqalignsemiVector) -> BioseqalignsemiVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_semi_vector_sub(a : BioseqalignsemiVector, b : BioseqalignsemiVector) -> BioseqalignsemiVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_align_semi_vector_scale(v : BioseqalignsemiVector, s : Double) -> BioseqalignsemiVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_align_semi_vector_dot(a : BioseqalignsemiVector, b : BioseqalignsemiVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_align_semi_vector_norm(v : BioseqalignsemiVector) -> Double { @_common.sqrt(bio_seq_align_semi_vector_dot(v, v)) }

pub fn bio_seq_align_semi_vector_normalize(v : BioseqalignsemiVector) -> BioseqalignsemiVector {
  let n = bio_seq_align_semi_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_align_semi_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_align_semi_vector_dist(a : BioseqalignsemiVector, b : BioseqalignsemiVector) -> Double {
  bio_seq_align_semi_vector_norm(bio_seq_align_semi_vector_sub(a, b))
}

pub fn bio_seq_align_semi_vector_to_string(v : BioseqalignsemiVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_align_semi_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_semi_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_seq_align_semi_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_semi_std(data : Array[Double]) -> Double { @_common.sqrt(bio_seq_align_semi_var(data)) }

pub fn bio_seq_align_semi_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_seq_align_semi_mean(a); let mb = bio_seq_align_semi_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_semi_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_seq_align_semi_std(a); let sb = bio_seq_align_semi_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_seq_align_semi_cov(a, b) / (sa * sb) }
}

pub fn bio_seq_align_semi_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_align_semi_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_align_semi_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_seq_align_semi_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_semi_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(bio_seq_align_semi_mse(pred, labels))
}

pub fn bio_seq_align_semi_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_seq_align_semi_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_seq_align_semi_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_seq_align_semi_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_seq_align_semi_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_seq_align_semi_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_seq_align_semi_precision(pred, labels, pos); let r = bio_seq_align_semi_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_seq_align_semi_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_seq_align_semi_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_seq_align_semi_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_seq_align_semi_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_seq_align_semi_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_seq_align_semi_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_seq_align_semi_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_seq_align_semi_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_seq_align_semi_fibonacci(n : Int) -> Int {
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

pub fn bio_seq_align_semi_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_seq_align_semi_min(data); let mx = bio_seq_align_semi_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_seq_align_semi_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_seq_align_semi_mean(data); let sd = bio_seq_align_semi_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_seq_align_semi_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_seq_align_semi_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_seq_align_semi_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_seq_align_semi_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct BioseqalignsemiFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_frame_make(size : Int) -> BioseqalignsemiFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_frame_len(s : BioseqalignsemiFrame) -> Int { s.size }

pub fn bio_seq_align_semi_frame_get(s : BioseqalignsemiFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_frame_set(s : BioseqalignsemiFrame, i : Int, v : Double) -> BioseqalignsemiFrame {
  let result = bio_seq_align_semi_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_frame_sum(s : BioseqalignsemiFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_frame_mean(s : BioseqalignsemiFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_frame_scale(s : BioseqalignsemiFrame, f : Double) -> BioseqalignsemiFrame {
  let result = bio_seq_align_semi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_frame_add(a : BioseqalignsemiFrame, b : BioseqalignsemiFrame) -> BioseqalignsemiFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_frame_copy(s : BioseqalignsemiFrame) -> BioseqalignsemiFrame {
  let result = bio_seq_align_semi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_frame_fill(s : BioseqalignsemiFrame, v : Double) -> BioseqalignsemiFrame {
  let result = bio_seq_align_semi_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_frame_min(s : BioseqalignsemiFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_frame_max(s : BioseqalignsemiFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_frame_to_string(s : BioseqalignsemiFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_table_make(size : Int) -> BioseqalignsemiTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_table_len(s : BioseqalignsemiTable) -> Int { s.size }

pub fn bio_seq_align_semi_table_get(s : BioseqalignsemiTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_table_set(s : BioseqalignsemiTable, i : Int, v : Double) -> BioseqalignsemiTable {
  let result = bio_seq_align_semi_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_table_sum(s : BioseqalignsemiTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_table_mean(s : BioseqalignsemiTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_table_scale(s : BioseqalignsemiTable, f : Double) -> BioseqalignsemiTable {
  let result = bio_seq_align_semi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_table_add(a : BioseqalignsemiTable, b : BioseqalignsemiTable) -> BioseqalignsemiTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_table_copy(s : BioseqalignsemiTable) -> BioseqalignsemiTable {
  let result = bio_seq_align_semi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_table_fill(s : BioseqalignsemiTable, v : Double) -> BioseqalignsemiTable {
  let result = bio_seq_align_semi_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_table_min(s : BioseqalignsemiTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_table_max(s : BioseqalignsemiTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_table_to_string(s : BioseqalignsemiTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_graphn_make(size : Int) -> BioseqalignsemiGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_graphn_len(s : BioseqalignsemiGraphN) -> Int { s.size }

pub fn bio_seq_align_semi_graphn_get(s : BioseqalignsemiGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_graphn_set(s : BioseqalignsemiGraphN, i : Int, v : Double) -> BioseqalignsemiGraphN {
  let result = bio_seq_align_semi_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_graphn_sum(s : BioseqalignsemiGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_graphn_mean(s : BioseqalignsemiGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_graphn_scale(s : BioseqalignsemiGraphN, f : Double) -> BioseqalignsemiGraphN {
  let result = bio_seq_align_semi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_graphn_add(a : BioseqalignsemiGraphN, b : BioseqalignsemiGraphN) -> BioseqalignsemiGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_graphn_copy(s : BioseqalignsemiGraphN) -> BioseqalignsemiGraphN {
  let result = bio_seq_align_semi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_graphn_fill(s : BioseqalignsemiGraphN, v : Double) -> BioseqalignsemiGraphN {
  let result = bio_seq_align_semi_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_graphn_min(s : BioseqalignsemiGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_graphn_max(s : BioseqalignsemiGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_graphn_to_string(s : BioseqalignsemiGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_node_make(size : Int) -> BioseqalignsemiNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_node_len(s : BioseqalignsemiNode) -> Int { s.size }

pub fn bio_seq_align_semi_node_get(s : BioseqalignsemiNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_node_set(s : BioseqalignsemiNode, i : Int, v : Double) -> BioseqalignsemiNode {
  let result = bio_seq_align_semi_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_node_sum(s : BioseqalignsemiNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_node_mean(s : BioseqalignsemiNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_node_scale(s : BioseqalignsemiNode, f : Double) -> BioseqalignsemiNode {
  let result = bio_seq_align_semi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_node_add(a : BioseqalignsemiNode, b : BioseqalignsemiNode) -> BioseqalignsemiNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_node_copy(s : BioseqalignsemiNode) -> BioseqalignsemiNode {
  let result = bio_seq_align_semi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_node_fill(s : BioseqalignsemiNode, v : Double) -> BioseqalignsemiNode {
  let result = bio_seq_align_semi_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_node_min(s : BioseqalignsemiNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_node_max(s : BioseqalignsemiNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_node_to_string(s : BioseqalignsemiNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_edge_make(size : Int) -> BioseqalignsemiEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_edge_len(s : BioseqalignsemiEdge) -> Int { s.size }

pub fn bio_seq_align_semi_edge_get(s : BioseqalignsemiEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_edge_set(s : BioseqalignsemiEdge, i : Int, v : Double) -> BioseqalignsemiEdge {
  let result = bio_seq_align_semi_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_edge_sum(s : BioseqalignsemiEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_edge_mean(s : BioseqalignsemiEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_edge_scale(s : BioseqalignsemiEdge, f : Double) -> BioseqalignsemiEdge {
  let result = bio_seq_align_semi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_edge_add(a : BioseqalignsemiEdge, b : BioseqalignsemiEdge) -> BioseqalignsemiEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_edge_copy(s : BioseqalignsemiEdge) -> BioseqalignsemiEdge {
  let result = bio_seq_align_semi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_edge_fill(s : BioseqalignsemiEdge, v : Double) -> BioseqalignsemiEdge {
  let result = bio_seq_align_semi_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_edge_min(s : BioseqalignsemiEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_edge_max(s : BioseqalignsemiEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_edge_to_string(s : BioseqalignsemiEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_path_make(size : Int) -> BioseqalignsemiPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_path_len(s : BioseqalignsemiPath) -> Int { s.size }

pub fn bio_seq_align_semi_path_get(s : BioseqalignsemiPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_path_set(s : BioseqalignsemiPath, i : Int, v : Double) -> BioseqalignsemiPath {
  let result = bio_seq_align_semi_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_path_sum(s : BioseqalignsemiPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_path_mean(s : BioseqalignsemiPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_path_scale(s : BioseqalignsemiPath, f : Double) -> BioseqalignsemiPath {
  let result = bio_seq_align_semi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_path_add(a : BioseqalignsemiPath, b : BioseqalignsemiPath) -> BioseqalignsemiPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_path_copy(s : BioseqalignsemiPath) -> BioseqalignsemiPath {
  let result = bio_seq_align_semi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_path_fill(s : BioseqalignsemiPath, v : Double) -> BioseqalignsemiPath {
  let result = bio_seq_align_semi_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_path_min(s : BioseqalignsemiPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_path_max(s : BioseqalignsemiPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_path_to_string(s : BioseqalignsemiPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_cluster_make(size : Int) -> BioseqalignsemiCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_cluster_len(s : BioseqalignsemiCluster) -> Int { s.size }

pub fn bio_seq_align_semi_cluster_get(s : BioseqalignsemiCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_cluster_set(s : BioseqalignsemiCluster, i : Int, v : Double) -> BioseqalignsemiCluster {
  let result = bio_seq_align_semi_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_cluster_sum(s : BioseqalignsemiCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_cluster_mean(s : BioseqalignsemiCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_cluster_scale(s : BioseqalignsemiCluster, f : Double) -> BioseqalignsemiCluster {
  let result = bio_seq_align_semi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_cluster_add(a : BioseqalignsemiCluster, b : BioseqalignsemiCluster) -> BioseqalignsemiCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_cluster_copy(s : BioseqalignsemiCluster) -> BioseqalignsemiCluster {
  let result = bio_seq_align_semi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_cluster_fill(s : BioseqalignsemiCluster, v : Double) -> BioseqalignsemiCluster {
  let result = bio_seq_align_semi_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_cluster_min(s : BioseqalignsemiCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_cluster_max(s : BioseqalignsemiCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_cluster_to_string(s : BioseqalignsemiCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_model_make(size : Int) -> BioseqalignsemiModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_model_len(s : BioseqalignsemiModel) -> Int { s.size }

pub fn bio_seq_align_semi_model_get(s : BioseqalignsemiModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_model_set(s : BioseqalignsemiModel, i : Int, v : Double) -> BioseqalignsemiModel {
  let result = bio_seq_align_semi_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_model_sum(s : BioseqalignsemiModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_model_mean(s : BioseqalignsemiModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_model_scale(s : BioseqalignsemiModel, f : Double) -> BioseqalignsemiModel {
  let result = bio_seq_align_semi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_model_add(a : BioseqalignsemiModel, b : BioseqalignsemiModel) -> BioseqalignsemiModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_model_copy(s : BioseqalignsemiModel) -> BioseqalignsemiModel {
  let result = bio_seq_align_semi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_model_fill(s : BioseqalignsemiModel, v : Double) -> BioseqalignsemiModel {
  let result = bio_seq_align_semi_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_model_min(s : BioseqalignsemiModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_model_max(s : BioseqalignsemiModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_model_to_string(s : BioseqalignsemiModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_layer_make(size : Int) -> BioseqalignsemiLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_layer_len(s : BioseqalignsemiLayer) -> Int { s.size }

pub fn bio_seq_align_semi_layer_get(s : BioseqalignsemiLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_layer_set(s : BioseqalignsemiLayer, i : Int, v : Double) -> BioseqalignsemiLayer {
  let result = bio_seq_align_semi_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_layer_sum(s : BioseqalignsemiLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_layer_mean(s : BioseqalignsemiLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_layer_scale(s : BioseqalignsemiLayer, f : Double) -> BioseqalignsemiLayer {
  let result = bio_seq_align_semi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_layer_add(a : BioseqalignsemiLayer, b : BioseqalignsemiLayer) -> BioseqalignsemiLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_layer_copy(s : BioseqalignsemiLayer) -> BioseqalignsemiLayer {
  let result = bio_seq_align_semi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_layer_fill(s : BioseqalignsemiLayer, v : Double) -> BioseqalignsemiLayer {
  let result = bio_seq_align_semi_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_layer_min(s : BioseqalignsemiLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_layer_max(s : BioseqalignsemiLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_layer_to_string(s : BioseqalignsemiLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_buffer_make(size : Int) -> BioseqalignsemiBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_buffer_len(s : BioseqalignsemiBuffer) -> Int { s.size }

pub fn bio_seq_align_semi_buffer_get(s : BioseqalignsemiBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_buffer_set(s : BioseqalignsemiBuffer, i : Int, v : Double) -> BioseqalignsemiBuffer {
  let result = bio_seq_align_semi_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_buffer_sum(s : BioseqalignsemiBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_buffer_mean(s : BioseqalignsemiBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_buffer_scale(s : BioseqalignsemiBuffer, f : Double) -> BioseqalignsemiBuffer {
  let result = bio_seq_align_semi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_buffer_add(a : BioseqalignsemiBuffer, b : BioseqalignsemiBuffer) -> BioseqalignsemiBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_buffer_copy(s : BioseqalignsemiBuffer) -> BioseqalignsemiBuffer {
  let result = bio_seq_align_semi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_buffer_fill(s : BioseqalignsemiBuffer, v : Double) -> BioseqalignsemiBuffer {
  let result = bio_seq_align_semi_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_buffer_min(s : BioseqalignsemiBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_buffer_max(s : BioseqalignsemiBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_buffer_to_string(s : BioseqalignsemiBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_cursor_make(size : Int) -> BioseqalignsemiCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_cursor_len(s : BioseqalignsemiCursor) -> Int { s.size }

pub fn bio_seq_align_semi_cursor_get(s : BioseqalignsemiCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_cursor_set(s : BioseqalignsemiCursor, i : Int, v : Double) -> BioseqalignsemiCursor {
  let result = bio_seq_align_semi_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_cursor_sum(s : BioseqalignsemiCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_cursor_mean(s : BioseqalignsemiCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_cursor_scale(s : BioseqalignsemiCursor, f : Double) -> BioseqalignsemiCursor {
  let result = bio_seq_align_semi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_cursor_add(a : BioseqalignsemiCursor, b : BioseqalignsemiCursor) -> BioseqalignsemiCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_cursor_copy(s : BioseqalignsemiCursor) -> BioseqalignsemiCursor {
  let result = bio_seq_align_semi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_cursor_fill(s : BioseqalignsemiCursor, v : Double) -> BioseqalignsemiCursor {
  let result = bio_seq_align_semi_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_cursor_min(s : BioseqalignsemiCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_cursor_max(s : BioseqalignsemiCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_cursor_to_string(s : BioseqalignsemiCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_view_make(size : Int) -> BioseqalignsemiView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_view_len(s : BioseqalignsemiView) -> Int { s.size }

pub fn bio_seq_align_semi_view_get(s : BioseqalignsemiView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_view_set(s : BioseqalignsemiView, i : Int, v : Double) -> BioseqalignsemiView {
  let result = bio_seq_align_semi_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_view_sum(s : BioseqalignsemiView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_view_mean(s : BioseqalignsemiView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_view_scale(s : BioseqalignsemiView, f : Double) -> BioseqalignsemiView {
  let result = bio_seq_align_semi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_view_add(a : BioseqalignsemiView, b : BioseqalignsemiView) -> BioseqalignsemiView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_view_copy(s : BioseqalignsemiView) -> BioseqalignsemiView {
  let result = bio_seq_align_semi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_view_fill(s : BioseqalignsemiView, v : Double) -> BioseqalignsemiView {
  let result = bio_seq_align_semi_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_view_min(s : BioseqalignsemiView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_view_max(s : BioseqalignsemiView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_view_to_string(s : BioseqalignsemiView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_range_make(size : Int) -> BioseqalignsemiRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_range_len(s : BioseqalignsemiRange) -> Int { s.size }

pub fn bio_seq_align_semi_range_get(s : BioseqalignsemiRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_range_set(s : BioseqalignsemiRange, i : Int, v : Double) -> BioseqalignsemiRange {
  let result = bio_seq_align_semi_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_range_sum(s : BioseqalignsemiRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_range_mean(s : BioseqalignsemiRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_range_scale(s : BioseqalignsemiRange, f : Double) -> BioseqalignsemiRange {
  let result = bio_seq_align_semi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_range_add(a : BioseqalignsemiRange, b : BioseqalignsemiRange) -> BioseqalignsemiRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_range_copy(s : BioseqalignsemiRange) -> BioseqalignsemiRange {
  let result = bio_seq_align_semi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_range_fill(s : BioseqalignsemiRange, v : Double) -> BioseqalignsemiRange {
  let result = bio_seq_align_semi_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_range_min(s : BioseqalignsemiRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_range_max(s : BioseqalignsemiRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_range_to_string(s : BioseqalignsemiRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqalignsemiSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_align_semi_slice_make(size : Int) -> BioseqalignsemiSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_align_semi_slice_len(s : BioseqalignsemiSlice) -> Int { s.size }

pub fn bio_seq_align_semi_slice_get(s : BioseqalignsemiSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_align_semi_slice_set(s : BioseqalignsemiSlice, i : Int, v : Double) -> BioseqalignsemiSlice {
  let result = bio_seq_align_semi_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_slice_sum(s : BioseqalignsemiSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_align_semi_slice_mean(s : BioseqalignsemiSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_align_semi_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_align_semi_slice_scale(s : BioseqalignsemiSlice, f : Double) -> BioseqalignsemiSlice {
  let result = bio_seq_align_semi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_align_semi_slice_add(a : BioseqalignsemiSlice, b : BioseqalignsemiSlice) -> BioseqalignsemiSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_align_semi_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_align_semi_slice_copy(s : BioseqalignsemiSlice) -> BioseqalignsemiSlice {
  let result = bio_seq_align_semi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_align_semi_slice_fill(s : BioseqalignsemiSlice, v : Double) -> BioseqalignsemiSlice {
  let result = bio_seq_align_semi_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_align_semi_slice_min(s : BioseqalignsemiSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_slice_max(s : BioseqalignsemiSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_align_semi_slice_to_string(s : BioseqalignsemiSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

