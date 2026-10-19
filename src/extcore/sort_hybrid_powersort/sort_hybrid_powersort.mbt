///===
/// extcore/sort_hybrid_powersort

pub(all) struct SorthybridpowersortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_powersort_make_point(x : Double, y : Double) -> SorthybridpowersortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_powersort_make_point3(x : Double, y : Double, z : Double) -> SorthybridpowersortPoint {
  { x, y, z, label: 0 }
}

pub fn sort_hybrid_powersort_point_x(pt : SorthybridpowersortPoint) -> Double { pt.x }

pub fn sort_hybrid_powersort_point_y(pt : SorthybridpowersortPoint) -> Double { pt.y }

pub fn sort_hybrid_powersort_point_z(pt : SorthybridpowersortPoint) -> Double { pt.z }

pub fn sort_hybrid_powersort_point_label(pt : SorthybridpowersortPoint) -> Int { pt.label }

pub fn sort_hybrid_powersort_point_dist(a : SorthybridpowersortPoint, b : SorthybridpowersortPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  sort_hybrid_powersort_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_hybrid_powersort_point_add(a : SorthybridpowersortPoint, b : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_hybrid_powersort_point_sub(a : SorthybridpowersortPoint, b : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_hybrid_powersort_point_scale(pt : SorthybridpowersortPoint, s : Double) -> SorthybridpowersortPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_hybrid_powersort_point_dot(a : SorthybridpowersortPoint, b : SorthybridpowersortPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_hybrid_powersort_point_cross(a : SorthybridpowersortPoint, b : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_hybrid_powersort_point_norm(pt : SorthybridpowersortPoint) -> Double {
  sort_hybrid_powersort_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_hybrid_powersort_point_normalize(pt : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  let n = sort_hybrid_powersort_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_hybrid_powersort_point_scale(pt, 1.0 / n) }
}

pub fn sort_hybrid_powersort_point_negate(pt : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_hybrid_powersort_point_mid(a : SorthybridpowersortPoint, b : SorthybridpowersortPoint) -> SorthybridpowersortPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_hybrid_powersort_point_lerp(a : SorthybridpowersortPoint, b : SorthybridpowersortPoint, t : Double) -> SorthybridpowersortPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_hybrid_powersort_point_to_string(pt : SorthybridpowersortPoint) -> String {
  "(" + sort_hybrid_powersort_dbl(pt.x) + ", " + sort_hybrid_powersort_dbl(pt.y) + ", " + sort_hybrid_powersort_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SorthybridpowersortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_powersort_make_series(vals : Array[Double], name : String) -> SorthybridpowersortSeries {
  { vals, name, meta: 0 }
}

pub fn sort_hybrid_powersort_series_len(s : SorthybridpowersortSeries) -> Int { s.vals.length() }

pub fn sort_hybrid_powersort_series_sum(s : SorthybridpowersortSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_hybrid_powersort_series_mean(s : SorthybridpowersortSeries) -> Double {
  let n = sort_hybrid_powersort_series_len(s)
  if n == 0 { 0.0 } else { sort_hybrid_powersort_series_sum(s) / n.to_double() }
}

pub fn sort_hybrid_powersort_series_min(s : SorthybridpowersortSeries) -> Double {
  let n = sort_hybrid_powersort_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_series_max(s : SorthybridpowersortSeries) -> Double {
  let n = sort_hybrid_powersort_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_series_range(s : SorthybridpowersortSeries) -> Double {
  sort_hybrid_powersort_series_max(s) - sort_hybrid_powersort_series_min(s)
}

pub fn sort_hybrid_powersort_series_var(s : SorthybridpowersortSeries) -> Double {
  let n = sort_hybrid_powersort_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_hybrid_powersort_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_hybrid_powersort_series_std(s : SorthybridpowersortSeries) -> Double { sort_hybrid_powersort_sqrt(sort_hybrid_powersort_series_var(s)) }

pub fn sort_hybrid_powersort_series_median(s : SorthybridpowersortSeries) -> Double {
  let n = sort_hybrid_powersort_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_hybrid_powersort_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_hybrid_powersort_series_scale(s : SorthybridpowersortSeries, f : Double) -> SorthybridpowersortSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = sort_hybrid_powersort_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_hybrid_powersort_series_add(a : SorthybridpowersortSeries, b : SorthybridpowersortSeries) -> SorthybridpowersortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_hybrid_powersort_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_hybrid_powersort_series_sub(a : SorthybridpowersortSeries, b : SorthybridpowersortSeries) -> SorthybridpowersortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_hybrid_powersort_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_hybrid_powersort_series_normalize(s : SorthybridpowersortSeries) -> SorthybridpowersortSeries {
  let mn = sort_hybrid_powersort_series_min(s)
  let mx = sort_hybrid_powersort_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = sort_hybrid_powersort_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_hybrid_powersort_series_cumsum(s : SorthybridpowersortSeries) -> SorthybridpowersortSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = sort_hybrid_powersort_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_hybrid_powersort_series_to_string(s : SorthybridpowersortSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_hybrid_powersort_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridpowersortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_powersort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridpowersortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_powersort_matrix_identity(n : Int) -> SorthybridpowersortMatrix {
  let m = sort_hybrid_powersort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_hybrid_powersort_matrix_get(m : SorthybridpowersortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_hybrid_powersort_matrix_transpose(m : SorthybridpowersortMatrix) -> SorthybridpowersortMatrix {
  let result = sort_hybrid_powersort_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_hybrid_powersort_matrix_add(a : SorthybridpowersortMatrix, b : SorthybridpowersortMatrix) -> SorthybridpowersortMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_hybrid_powersort_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_hybrid_powersort_matrix_scale(m : SorthybridpowersortMatrix, s : Double) -> SorthybridpowersortMatrix {
  let result = sort_hybrid_powersort_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_hybrid_powersort_matrix_multiply(a : SorthybridpowersortMatrix, b : SorthybridpowersortMatrix) -> SorthybridpowersortMatrix {
  if a.cols != b.rows { return sort_hybrid_powersort_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_hybrid_powersort_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_hybrid_powersort_matrix_trace(m : SorthybridpowersortMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_hybrid_powersort_matrix_det(m : SorthybridpowersortMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_hybrid_powersort_matrix_norm(m : SorthybridpowersortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  sort_hybrid_powersort_sqrt(sum)
}

pub fn sort_hybrid_powersort_matrix_to_string(m : SorthybridpowersortMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + sort_hybrid_powersort_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SorthybridpowersortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_powersort_make_vector(comps : Array[Double]) -> SorthybridpowersortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_powersort_vector_zero(dim : Int) -> SorthybridpowersortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_hybrid_powersort_vector_add(a : SorthybridpowersortVector, b : SorthybridpowersortVector) -> SorthybridpowersortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_hybrid_powersort_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_powersort_vector_sub(a : SorthybridpowersortVector, b : SorthybridpowersortVector) -> SorthybridpowersortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_hybrid_powersort_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_powersort_vector_scale(v : SorthybridpowersortVector, s : Double) -> SorthybridpowersortVector {
  let mut result = []
  for i in 0..<v.dim { result = sort_hybrid_powersort_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_hybrid_powersort_vector_dot(a : SorthybridpowersortVector, b : SorthybridpowersortVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_hybrid_powersort_vector_norm(v : SorthybridpowersortVector) -> Double { sort_hybrid_powersort_sqrt(sort_hybrid_powersort_vector_dot(v, v)) }

pub fn sort_hybrid_powersort_vector_normalize(v : SorthybridpowersortVector) -> SorthybridpowersortVector {
  let n = sort_hybrid_powersort_vector_norm(v)
  if n < 0.0000001 { v } else { sort_hybrid_powersort_vector_scale(v, 1.0 / n) }
}

pub fn sort_hybrid_powersort_vector_dist(a : SorthybridpowersortVector, b : SorthybridpowersortVector) -> Double {
  sort_hybrid_powersort_vector_norm(sort_hybrid_powersort_vector_sub(a, b))
}

pub fn sort_hybrid_powersort_vector_to_string(v : SorthybridpowersortVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_hybrid_powersort_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_powersort_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_powersort_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_hybrid_powersort_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_powersort_std(data : Array[Double]) -> Double { sort_hybrid_powersort_sqrt(sort_hybrid_powersort_var(data)) }

pub fn sort_hybrid_powersort_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_hybrid_powersort_mean(a); let mb = sort_hybrid_powersort_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_powersort_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_hybrid_powersort_std(a); let sb = sort_hybrid_powersort_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_hybrid_powersort_cov(a, b) / (sa * sb) }
}

pub fn sort_hybrid_powersort_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_hybrid_powersort_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_hybrid_powersort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_hybrid_powersort_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_powersort_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  sort_hybrid_powersort_sqrt(sort_hybrid_powersort_mse(pred, labels))
}

pub fn sort_hybrid_powersort_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + sort_hybrid_powersort_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_powersort_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_hybrid_powersort_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_hybrid_powersort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_hybrid_powersort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_hybrid_powersort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_hybrid_powersort_precision(pred, labels, pos); let r = sort_hybrid_powersort_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_hybrid_powersort_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_hybrid_powersort_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_hybrid_powersort_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_hybrid_powersort_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_hybrid_powersort_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_hybrid_powersort_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_hybrid_powersort_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_hybrid_powersort_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_hybrid_powersort_fibonacci(n : Int) -> Int {
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

pub fn sort_hybrid_powersort_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_hybrid_powersort_min(data); let mx = sort_hybrid_powersort_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_hybrid_powersort_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_hybrid_powersort_mean(data); let sd = sort_hybrid_powersort_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_hybrid_powersort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_hybrid_powersort_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_hybrid_powersort_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_hybrid_powersort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn sort_hybrid_powersort_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn sort_hybrid_powersort_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn sort_hybrid_powersort_dbl(x : Double) -> String {
  let i = if x >= 0.0 { sort_hybrid_powersort_int(x) } else { -sort_hybrid_powersort_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { sort_hybrid_powersort_int(f * 1000000.0) } else { sort_hybrid_powersort_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn sort_hybrid_powersort_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn sort_hybrid_powersort_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SorthybridpowersortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_frame_make(size : Int) -> SorthybridpowersortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_frame_len(s : SorthybridpowersortFrame) -> Int { s.size }

pub fn sort_hybrid_powersort_frame_get(s : SorthybridpowersortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_frame_set(s : SorthybridpowersortFrame, i : Int, v : Double) -> SorthybridpowersortFrame {
  let result = sort_hybrid_powersort_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_frame_sum(s : SorthybridpowersortFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_frame_mean(s : SorthybridpowersortFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_frame_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_frame_scale(s : SorthybridpowersortFrame, f : Double) -> SorthybridpowersortFrame {
  let result = sort_hybrid_powersort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_frame_add(a : SorthybridpowersortFrame, b : SorthybridpowersortFrame) -> SorthybridpowersortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_frame_copy(s : SorthybridpowersortFrame) -> SorthybridpowersortFrame {
  let result = sort_hybrid_powersort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_frame_fill(s : SorthybridpowersortFrame, v : Double) -> SorthybridpowersortFrame {
  let result = sort_hybrid_powersort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_frame_min(s : SorthybridpowersortFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_frame_max(s : SorthybridpowersortFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_frame_to_string(s : SorthybridpowersortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_table_make(size : Int) -> SorthybridpowersortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_table_len(s : SorthybridpowersortTable) -> Int { s.size }

pub fn sort_hybrid_powersort_table_get(s : SorthybridpowersortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_table_set(s : SorthybridpowersortTable, i : Int, v : Double) -> SorthybridpowersortTable {
  let result = sort_hybrid_powersort_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_table_sum(s : SorthybridpowersortTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_table_mean(s : SorthybridpowersortTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_table_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_table_scale(s : SorthybridpowersortTable, f : Double) -> SorthybridpowersortTable {
  let result = sort_hybrid_powersort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_table_add(a : SorthybridpowersortTable, b : SorthybridpowersortTable) -> SorthybridpowersortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_table_copy(s : SorthybridpowersortTable) -> SorthybridpowersortTable {
  let result = sort_hybrid_powersort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_table_fill(s : SorthybridpowersortTable, v : Double) -> SorthybridpowersortTable {
  let result = sort_hybrid_powersort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_table_min(s : SorthybridpowersortTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_table_max(s : SorthybridpowersortTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_table_to_string(s : SorthybridpowersortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_graphn_make(size : Int) -> SorthybridpowersortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_graphn_len(s : SorthybridpowersortGraphN) -> Int { s.size }

pub fn sort_hybrid_powersort_graphn_get(s : SorthybridpowersortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_graphn_set(s : SorthybridpowersortGraphN, i : Int, v : Double) -> SorthybridpowersortGraphN {
  let result = sort_hybrid_powersort_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_graphn_sum(s : SorthybridpowersortGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_graphn_mean(s : SorthybridpowersortGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_graphn_scale(s : SorthybridpowersortGraphN, f : Double) -> SorthybridpowersortGraphN {
  let result = sort_hybrid_powersort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_graphn_add(a : SorthybridpowersortGraphN, b : SorthybridpowersortGraphN) -> SorthybridpowersortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_graphn_copy(s : SorthybridpowersortGraphN) -> SorthybridpowersortGraphN {
  let result = sort_hybrid_powersort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_graphn_fill(s : SorthybridpowersortGraphN, v : Double) -> SorthybridpowersortGraphN {
  let result = sort_hybrid_powersort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_graphn_min(s : SorthybridpowersortGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_graphn_max(s : SorthybridpowersortGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_graphn_to_string(s : SorthybridpowersortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_node_make(size : Int) -> SorthybridpowersortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_node_len(s : SorthybridpowersortNode) -> Int { s.size }

pub fn sort_hybrid_powersort_node_get(s : SorthybridpowersortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_node_set(s : SorthybridpowersortNode, i : Int, v : Double) -> SorthybridpowersortNode {
  let result = sort_hybrid_powersort_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_node_sum(s : SorthybridpowersortNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_node_mean(s : SorthybridpowersortNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_node_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_node_scale(s : SorthybridpowersortNode, f : Double) -> SorthybridpowersortNode {
  let result = sort_hybrid_powersort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_node_add(a : SorthybridpowersortNode, b : SorthybridpowersortNode) -> SorthybridpowersortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_node_copy(s : SorthybridpowersortNode) -> SorthybridpowersortNode {
  let result = sort_hybrid_powersort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_node_fill(s : SorthybridpowersortNode, v : Double) -> SorthybridpowersortNode {
  let result = sort_hybrid_powersort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_node_min(s : SorthybridpowersortNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_node_max(s : SorthybridpowersortNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_node_to_string(s : SorthybridpowersortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_edge_make(size : Int) -> SorthybridpowersortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_edge_len(s : SorthybridpowersortEdge) -> Int { s.size }

pub fn sort_hybrid_powersort_edge_get(s : SorthybridpowersortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_edge_set(s : SorthybridpowersortEdge, i : Int, v : Double) -> SorthybridpowersortEdge {
  let result = sort_hybrid_powersort_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_edge_sum(s : SorthybridpowersortEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_edge_mean(s : SorthybridpowersortEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_edge_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_edge_scale(s : SorthybridpowersortEdge, f : Double) -> SorthybridpowersortEdge {
  let result = sort_hybrid_powersort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_edge_add(a : SorthybridpowersortEdge, b : SorthybridpowersortEdge) -> SorthybridpowersortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_edge_copy(s : SorthybridpowersortEdge) -> SorthybridpowersortEdge {
  let result = sort_hybrid_powersort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_edge_fill(s : SorthybridpowersortEdge, v : Double) -> SorthybridpowersortEdge {
  let result = sort_hybrid_powersort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_edge_min(s : SorthybridpowersortEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_edge_max(s : SorthybridpowersortEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_edge_to_string(s : SorthybridpowersortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_path_make(size : Int) -> SorthybridpowersortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_path_len(s : SorthybridpowersortPath) -> Int { s.size }

pub fn sort_hybrid_powersort_path_get(s : SorthybridpowersortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_path_set(s : SorthybridpowersortPath, i : Int, v : Double) -> SorthybridpowersortPath {
  let result = sort_hybrid_powersort_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_path_sum(s : SorthybridpowersortPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_path_mean(s : SorthybridpowersortPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_path_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_path_scale(s : SorthybridpowersortPath, f : Double) -> SorthybridpowersortPath {
  let result = sort_hybrid_powersort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_path_add(a : SorthybridpowersortPath, b : SorthybridpowersortPath) -> SorthybridpowersortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_path_copy(s : SorthybridpowersortPath) -> SorthybridpowersortPath {
  let result = sort_hybrid_powersort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_path_fill(s : SorthybridpowersortPath, v : Double) -> SorthybridpowersortPath {
  let result = sort_hybrid_powersort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_path_min(s : SorthybridpowersortPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_path_max(s : SorthybridpowersortPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_path_to_string(s : SorthybridpowersortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_cluster_make(size : Int) -> SorthybridpowersortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_cluster_len(s : SorthybridpowersortCluster) -> Int { s.size }

pub fn sort_hybrid_powersort_cluster_get(s : SorthybridpowersortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_cluster_set(s : SorthybridpowersortCluster, i : Int, v : Double) -> SorthybridpowersortCluster {
  let result = sort_hybrid_powersort_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_cluster_sum(s : SorthybridpowersortCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_cluster_mean(s : SorthybridpowersortCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_cluster_scale(s : SorthybridpowersortCluster, f : Double) -> SorthybridpowersortCluster {
  let result = sort_hybrid_powersort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_cluster_add(a : SorthybridpowersortCluster, b : SorthybridpowersortCluster) -> SorthybridpowersortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_cluster_copy(s : SorthybridpowersortCluster) -> SorthybridpowersortCluster {
  let result = sort_hybrid_powersort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_cluster_fill(s : SorthybridpowersortCluster, v : Double) -> SorthybridpowersortCluster {
  let result = sort_hybrid_powersort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_cluster_min(s : SorthybridpowersortCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_cluster_max(s : SorthybridpowersortCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_cluster_to_string(s : SorthybridpowersortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_model_make(size : Int) -> SorthybridpowersortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_model_len(s : SorthybridpowersortModel) -> Int { s.size }

pub fn sort_hybrid_powersort_model_get(s : SorthybridpowersortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_model_set(s : SorthybridpowersortModel, i : Int, v : Double) -> SorthybridpowersortModel {
  let result = sort_hybrid_powersort_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_model_sum(s : SorthybridpowersortModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_model_mean(s : SorthybridpowersortModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_model_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_model_scale(s : SorthybridpowersortModel, f : Double) -> SorthybridpowersortModel {
  let result = sort_hybrid_powersort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_model_add(a : SorthybridpowersortModel, b : SorthybridpowersortModel) -> SorthybridpowersortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_model_copy(s : SorthybridpowersortModel) -> SorthybridpowersortModel {
  let result = sort_hybrid_powersort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_model_fill(s : SorthybridpowersortModel, v : Double) -> SorthybridpowersortModel {
  let result = sort_hybrid_powersort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_model_min(s : SorthybridpowersortModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_model_max(s : SorthybridpowersortModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_model_to_string(s : SorthybridpowersortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_layer_make(size : Int) -> SorthybridpowersortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_layer_len(s : SorthybridpowersortLayer) -> Int { s.size }

pub fn sort_hybrid_powersort_layer_get(s : SorthybridpowersortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_layer_set(s : SorthybridpowersortLayer, i : Int, v : Double) -> SorthybridpowersortLayer {
  let result = sort_hybrid_powersort_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_layer_sum(s : SorthybridpowersortLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_layer_mean(s : SorthybridpowersortLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_layer_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_layer_scale(s : SorthybridpowersortLayer, f : Double) -> SorthybridpowersortLayer {
  let result = sort_hybrid_powersort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_layer_add(a : SorthybridpowersortLayer, b : SorthybridpowersortLayer) -> SorthybridpowersortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_layer_copy(s : SorthybridpowersortLayer) -> SorthybridpowersortLayer {
  let result = sort_hybrid_powersort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_layer_fill(s : SorthybridpowersortLayer, v : Double) -> SorthybridpowersortLayer {
  let result = sort_hybrid_powersort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_layer_min(s : SorthybridpowersortLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_layer_max(s : SorthybridpowersortLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_layer_to_string(s : SorthybridpowersortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_buffer_make(size : Int) -> SorthybridpowersortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_buffer_len(s : SorthybridpowersortBuffer) -> Int { s.size }

pub fn sort_hybrid_powersort_buffer_get(s : SorthybridpowersortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_buffer_set(s : SorthybridpowersortBuffer, i : Int, v : Double) -> SorthybridpowersortBuffer {
  let result = sort_hybrid_powersort_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_buffer_sum(s : SorthybridpowersortBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_buffer_mean(s : SorthybridpowersortBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_buffer_scale(s : SorthybridpowersortBuffer, f : Double) -> SorthybridpowersortBuffer {
  let result = sort_hybrid_powersort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_buffer_add(a : SorthybridpowersortBuffer, b : SorthybridpowersortBuffer) -> SorthybridpowersortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_buffer_copy(s : SorthybridpowersortBuffer) -> SorthybridpowersortBuffer {
  let result = sort_hybrid_powersort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_buffer_fill(s : SorthybridpowersortBuffer, v : Double) -> SorthybridpowersortBuffer {
  let result = sort_hybrid_powersort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_buffer_min(s : SorthybridpowersortBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_buffer_max(s : SorthybridpowersortBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_buffer_to_string(s : SorthybridpowersortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_cursor_make(size : Int) -> SorthybridpowersortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_cursor_len(s : SorthybridpowersortCursor) -> Int { s.size }

pub fn sort_hybrid_powersort_cursor_get(s : SorthybridpowersortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_cursor_set(s : SorthybridpowersortCursor, i : Int, v : Double) -> SorthybridpowersortCursor {
  let result = sort_hybrid_powersort_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_cursor_sum(s : SorthybridpowersortCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_cursor_mean(s : SorthybridpowersortCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_cursor_scale(s : SorthybridpowersortCursor, f : Double) -> SorthybridpowersortCursor {
  let result = sort_hybrid_powersort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_cursor_add(a : SorthybridpowersortCursor, b : SorthybridpowersortCursor) -> SorthybridpowersortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_cursor_copy(s : SorthybridpowersortCursor) -> SorthybridpowersortCursor {
  let result = sort_hybrid_powersort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_cursor_fill(s : SorthybridpowersortCursor, v : Double) -> SorthybridpowersortCursor {
  let result = sort_hybrid_powersort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_cursor_min(s : SorthybridpowersortCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_cursor_max(s : SorthybridpowersortCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_cursor_to_string(s : SorthybridpowersortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_view_make(size : Int) -> SorthybridpowersortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_view_len(s : SorthybridpowersortView) -> Int { s.size }

pub fn sort_hybrid_powersort_view_get(s : SorthybridpowersortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_view_set(s : SorthybridpowersortView, i : Int, v : Double) -> SorthybridpowersortView {
  let result = sort_hybrid_powersort_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_view_sum(s : SorthybridpowersortView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_view_mean(s : SorthybridpowersortView) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_view_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_view_scale(s : SorthybridpowersortView, f : Double) -> SorthybridpowersortView {
  let result = sort_hybrid_powersort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_view_add(a : SorthybridpowersortView, b : SorthybridpowersortView) -> SorthybridpowersortView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_view_copy(s : SorthybridpowersortView) -> SorthybridpowersortView {
  let result = sort_hybrid_powersort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_view_fill(s : SorthybridpowersortView, v : Double) -> SorthybridpowersortView {
  let result = sort_hybrid_powersort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_view_min(s : SorthybridpowersortView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_view_max(s : SorthybridpowersortView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_view_to_string(s : SorthybridpowersortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_range_make(size : Int) -> SorthybridpowersortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_range_len(s : SorthybridpowersortRange) -> Int { s.size }

pub fn sort_hybrid_powersort_range_get(s : SorthybridpowersortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_range_set(s : SorthybridpowersortRange, i : Int, v : Double) -> SorthybridpowersortRange {
  let result = sort_hybrid_powersort_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_range_sum(s : SorthybridpowersortRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_range_mean(s : SorthybridpowersortRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_range_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_range_scale(s : SorthybridpowersortRange, f : Double) -> SorthybridpowersortRange {
  let result = sort_hybrid_powersort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_range_add(a : SorthybridpowersortRange, b : SorthybridpowersortRange) -> SorthybridpowersortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_range_copy(s : SorthybridpowersortRange) -> SorthybridpowersortRange {
  let result = sort_hybrid_powersort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_range_fill(s : SorthybridpowersortRange, v : Double) -> SorthybridpowersortRange {
  let result = sort_hybrid_powersort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_range_min(s : SorthybridpowersortRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_range_max(s : SorthybridpowersortRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_range_to_string(s : SorthybridpowersortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridpowersortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_powersort_slice_make(size : Int) -> SorthybridpowersortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_powersort_slice_len(s : SorthybridpowersortSlice) -> Int { s.size }

pub fn sort_hybrid_powersort_slice_get(s : SorthybridpowersortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_powersort_slice_set(s : SorthybridpowersortSlice, i : Int, v : Double) -> SorthybridpowersortSlice {
  let result = sort_hybrid_powersort_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_slice_sum(s : SorthybridpowersortSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_powersort_slice_mean(s : SorthybridpowersortSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_powersort_slice_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_powersort_slice_scale(s : SorthybridpowersortSlice, f : Double) -> SorthybridpowersortSlice {
  let result = sort_hybrid_powersort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_powersort_slice_add(a : SorthybridpowersortSlice, b : SorthybridpowersortSlice) -> SorthybridpowersortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_powersort_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_powersort_slice_copy(s : SorthybridpowersortSlice) -> SorthybridpowersortSlice {
  let result = sort_hybrid_powersort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_powersort_slice_fill(s : SorthybridpowersortSlice, v : Double) -> SorthybridpowersortSlice {
  let result = sort_hybrid_powersort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_powersort_slice_min(s : SorthybridpowersortSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_slice_max(s : SorthybridpowersortSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_powersort_slice_to_string(s : SorthybridpowersortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn sort_hybrid_powersort_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_powersort_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

