///===
/// extcore/sort_hybrid_wikisort

pub(all) struct SorthybridwikisortPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn sort_hybrid_wikisort_make_point(x : Double, y : Double) -> SorthybridwikisortPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn sort_hybrid_wikisort_make_point3(x : Double, y : Double, z : Double) -> SorthybridwikisortPoint {
  { x, y, z, label: 0 }
}

pub fn sort_hybrid_wikisort_point_x(pt : SorthybridwikisortPoint) -> Double { pt.x }

pub fn sort_hybrid_wikisort_point_y(pt : SorthybridwikisortPoint) -> Double { pt.y }

pub fn sort_hybrid_wikisort_point_z(pt : SorthybridwikisortPoint) -> Double { pt.z }

pub fn sort_hybrid_wikisort_point_label(pt : SorthybridwikisortPoint) -> Int { pt.label }

pub fn sort_hybrid_wikisort_point_dist(a : SorthybridwikisortPoint, b : SorthybridwikisortPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  sort_hybrid_wikisort_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn sort_hybrid_wikisort_point_add(a : SorthybridwikisortPoint, b : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn sort_hybrid_wikisort_point_sub(a : SorthybridwikisortPoint, b : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn sort_hybrid_wikisort_point_scale(pt : SorthybridwikisortPoint, s : Double) -> SorthybridwikisortPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn sort_hybrid_wikisort_point_dot(a : SorthybridwikisortPoint, b : SorthybridwikisortPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn sort_hybrid_wikisort_point_cross(a : SorthybridwikisortPoint, b : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn sort_hybrid_wikisort_point_norm(pt : SorthybridwikisortPoint) -> Double {
  sort_hybrid_wikisort_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn sort_hybrid_wikisort_point_normalize(pt : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  let n = sort_hybrid_wikisort_point_norm(pt)
  if n < 0.0000001 { pt } else { sort_hybrid_wikisort_point_scale(pt, 1.0 / n) }
}

pub fn sort_hybrid_wikisort_point_negate(pt : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn sort_hybrid_wikisort_point_mid(a : SorthybridwikisortPoint, b : SorthybridwikisortPoint) -> SorthybridwikisortPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn sort_hybrid_wikisort_point_lerp(a : SorthybridwikisortPoint, b : SorthybridwikisortPoint, t : Double) -> SorthybridwikisortPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn sort_hybrid_wikisort_point_to_string(pt : SorthybridwikisortPoint) -> String {
  "(" + sort_hybrid_wikisort_dbl(pt.x) + ", " + sort_hybrid_wikisort_dbl(pt.y) + ", " + sort_hybrid_wikisort_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct SorthybridwikisortSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn sort_hybrid_wikisort_make_series(vals : Array[Double], name : String) -> SorthybridwikisortSeries {
  { vals, name, meta: 0 }
}

pub fn sort_hybrid_wikisort_series_len(s : SorthybridwikisortSeries) -> Int { s.vals.length() }

pub fn sort_hybrid_wikisort_series_sum(s : SorthybridwikisortSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn sort_hybrid_wikisort_series_mean(s : SorthybridwikisortSeries) -> Double {
  let n = sort_hybrid_wikisort_series_len(s)
  if n == 0 { 0.0 } else { sort_hybrid_wikisort_series_sum(s) / n.to_double() }
}

pub fn sort_hybrid_wikisort_series_min(s : SorthybridwikisortSeries) -> Double {
  let n = sort_hybrid_wikisort_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_series_max(s : SorthybridwikisortSeries) -> Double {
  let n = sort_hybrid_wikisort_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_series_range(s : SorthybridwikisortSeries) -> Double {
  sort_hybrid_wikisort_series_max(s) - sort_hybrid_wikisort_series_min(s)
}

pub fn sort_hybrid_wikisort_series_var(s : SorthybridwikisortSeries) -> Double {
  let n = sort_hybrid_wikisort_series_len(s)
  if n == 0 { 0.0 } else {
    let m = sort_hybrid_wikisort_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_series_std(s : SorthybridwikisortSeries) -> Double { sort_hybrid_wikisort_sqrt(sort_hybrid_wikisort_series_var(s)) }

pub fn sort_hybrid_wikisort_series_median(s : SorthybridwikisortSeries) -> Double {
  let n = sort_hybrid_wikisort_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = sort_hybrid_wikisort_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_hybrid_wikisort_series_scale(s : SorthybridwikisortSeries, f : Double) -> SorthybridwikisortSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = sort_hybrid_wikisort_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn sort_hybrid_wikisort_series_add(a : SorthybridwikisortSeries, b : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_hybrid_wikisort_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn sort_hybrid_wikisort_series_sub(a : SorthybridwikisortSeries, b : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = sort_hybrid_wikisort_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn sort_hybrid_wikisort_series_normalize(s : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  let mn = sort_hybrid_wikisort_series_min(s)
  let mx = sort_hybrid_wikisort_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = sort_hybrid_wikisort_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn sort_hybrid_wikisort_series_cumsum(s : SorthybridwikisortSeries) -> SorthybridwikisortSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = sort_hybrid_wikisort_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn sort_hybrid_wikisort_series_to_string(s : SorthybridwikisortSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_hybrid_wikisort_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct SorthybridwikisortMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn sort_hybrid_wikisort_make_matrix(rows : Int, cols : Int, val : Double) -> SorthybridwikisortMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn sort_hybrid_wikisort_matrix_identity(n : Int) -> SorthybridwikisortMatrix {
  let m = sort_hybrid_wikisort_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn sort_hybrid_wikisort_matrix_get(m : SorthybridwikisortMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn sort_hybrid_wikisort_matrix_transpose(m : SorthybridwikisortMatrix) -> SorthybridwikisortMatrix {
  let result = sort_hybrid_wikisort_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn sort_hybrid_wikisort_matrix_add(a : SorthybridwikisortMatrix, b : SorthybridwikisortMatrix) -> SorthybridwikisortMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = sort_hybrid_wikisort_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn sort_hybrid_wikisort_matrix_scale(m : SorthybridwikisortMatrix, s : Double) -> SorthybridwikisortMatrix {
  let result = sort_hybrid_wikisort_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn sort_hybrid_wikisort_matrix_multiply(a : SorthybridwikisortMatrix, b : SorthybridwikisortMatrix) -> SorthybridwikisortMatrix {
  if a.cols != b.rows { return sort_hybrid_wikisort_make_matrix(a.rows, b.cols, 0.0) }
  let result = sort_hybrid_wikisort_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn sort_hybrid_wikisort_matrix_trace(m : SorthybridwikisortMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn sort_hybrid_wikisort_matrix_det(m : SorthybridwikisortMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn sort_hybrid_wikisort_matrix_norm(m : SorthybridwikisortMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  sort_hybrid_wikisort_sqrt(sum)
}

pub fn sort_hybrid_wikisort_matrix_to_string(m : SorthybridwikisortMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + sort_hybrid_wikisort_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct SorthybridwikisortVector {
  comps : Array[Double]
  dim : Int
}

pub fn sort_hybrid_wikisort_make_vector(comps : Array[Double]) -> SorthybridwikisortVector {
  { comps, dim: comps.length() }
}

pub fn sort_hybrid_wikisort_vector_zero(dim : Int) -> SorthybridwikisortVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn sort_hybrid_wikisort_vector_add(a : SorthybridwikisortVector, b : SorthybridwikisortVector) -> SorthybridwikisortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_hybrid_wikisort_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_wikisort_vector_sub(a : SorthybridwikisortVector, b : SorthybridwikisortVector) -> SorthybridwikisortVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = sort_hybrid_wikisort_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn sort_hybrid_wikisort_vector_scale(v : SorthybridwikisortVector, s : Double) -> SorthybridwikisortVector {
  let mut result = []
  for i in 0..<v.dim { result = sort_hybrid_wikisort_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn sort_hybrid_wikisort_vector_dot(a : SorthybridwikisortVector, b : SorthybridwikisortVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn sort_hybrid_wikisort_vector_norm(v : SorthybridwikisortVector) -> Double { sort_hybrid_wikisort_sqrt(sort_hybrid_wikisort_vector_dot(v, v)) }

pub fn sort_hybrid_wikisort_vector_normalize(v : SorthybridwikisortVector) -> SorthybridwikisortVector {
  let n = sort_hybrid_wikisort_vector_norm(v)
  if n < 0.0000001 { v } else { sort_hybrid_wikisort_vector_scale(v, 1.0 / n) }
}

pub fn sort_hybrid_wikisort_vector_dist(a : SorthybridwikisortVector, b : SorthybridwikisortVector) -> Double {
  sort_hybrid_wikisort_vector_norm(sort_hybrid_wikisort_vector_sub(a, b))
}

pub fn sort_hybrid_wikisort_vector_to_string(v : SorthybridwikisortVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + sort_hybrid_wikisort_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn sort_hybrid_wikisort_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = sort_hybrid_wikisort_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_std(data : Array[Double]) -> Double { sort_hybrid_wikisort_sqrt(sort_hybrid_wikisort_var(data)) }

pub fn sort_hybrid_wikisort_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = sort_hybrid_wikisort_mean(a); let mb = sort_hybrid_wikisort_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = sort_hybrid_wikisort_std(a); let sb = sort_hybrid_wikisort_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { sort_hybrid_wikisort_cov(a, b) / (sa * sb) }
}

pub fn sort_hybrid_wikisort_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = sort_hybrid_wikisort_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn sort_hybrid_wikisort_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  sort_hybrid_wikisort_sqrt(sort_hybrid_wikisort_mse(pred, labels))
}

pub fn sort_hybrid_wikisort_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + sort_hybrid_wikisort_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = sort_hybrid_wikisort_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn sort_hybrid_wikisort_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn sort_hybrid_wikisort_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn sort_hybrid_wikisort_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = sort_hybrid_wikisort_precision(pred, labels, pos); let r = sort_hybrid_wikisort_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn sort_hybrid_wikisort_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn sort_hybrid_wikisort_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = sort_hybrid_wikisort_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn sort_hybrid_wikisort_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn sort_hybrid_wikisort_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn sort_hybrid_wikisort_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = sort_hybrid_wikisort_gcd(a, b)
    (a / g) * b
  }
}

pub fn sort_hybrid_wikisort_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn sort_hybrid_wikisort_fibonacci(n : Int) -> Int {
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

pub fn sort_hybrid_wikisort_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = sort_hybrid_wikisort_min(data); let mx = sort_hybrid_wikisort_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn sort_hybrid_wikisort_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = sort_hybrid_wikisort_mean(data); let sd = sort_hybrid_wikisort_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn sort_hybrid_wikisort_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn sort_hybrid_wikisort_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn sort_hybrid_wikisort_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn sort_hybrid_wikisort_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn sort_hybrid_wikisort_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn sort_hybrid_wikisort_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn sort_hybrid_wikisort_dbl(x : Double) -> String {
  let i = if x >= 0.0 { sort_hybrid_wikisort_int(x) } else { -sort_hybrid_wikisort_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { sort_hybrid_wikisort_int(f * 1000000.0) } else { sort_hybrid_wikisort_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn sort_hybrid_wikisort_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn sort_hybrid_wikisort_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct SorthybridwikisortFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_frame_make(size : Int) -> SorthybridwikisortFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_frame_len(s : SorthybridwikisortFrame) -> Int { s.size }

pub fn sort_hybrid_wikisort_frame_get(s : SorthybridwikisortFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_frame_set(s : SorthybridwikisortFrame, i : Int, v : Double) -> SorthybridwikisortFrame {
  let result = sort_hybrid_wikisort_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_frame_sum(s : SorthybridwikisortFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_frame_mean(s : SorthybridwikisortFrame) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_frame_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_frame_scale(s : SorthybridwikisortFrame, f : Double) -> SorthybridwikisortFrame {
  let result = sort_hybrid_wikisort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_frame_add(a : SorthybridwikisortFrame, b : SorthybridwikisortFrame) -> SorthybridwikisortFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_frame_copy(s : SorthybridwikisortFrame) -> SorthybridwikisortFrame {
  let result = sort_hybrid_wikisort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_frame_fill(s : SorthybridwikisortFrame, v : Double) -> SorthybridwikisortFrame {
  let result = sort_hybrid_wikisort_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_frame_min(s : SorthybridwikisortFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_frame_max(s : SorthybridwikisortFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_frame_to_string(s : SorthybridwikisortFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_table_make(size : Int) -> SorthybridwikisortTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_table_len(s : SorthybridwikisortTable) -> Int { s.size }

pub fn sort_hybrid_wikisort_table_get(s : SorthybridwikisortTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_table_set(s : SorthybridwikisortTable, i : Int, v : Double) -> SorthybridwikisortTable {
  let result = sort_hybrid_wikisort_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_table_sum(s : SorthybridwikisortTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_table_mean(s : SorthybridwikisortTable) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_table_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_table_scale(s : SorthybridwikisortTable, f : Double) -> SorthybridwikisortTable {
  let result = sort_hybrid_wikisort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_table_add(a : SorthybridwikisortTable, b : SorthybridwikisortTable) -> SorthybridwikisortTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_table_copy(s : SorthybridwikisortTable) -> SorthybridwikisortTable {
  let result = sort_hybrid_wikisort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_table_fill(s : SorthybridwikisortTable, v : Double) -> SorthybridwikisortTable {
  let result = sort_hybrid_wikisort_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_table_min(s : SorthybridwikisortTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_table_max(s : SorthybridwikisortTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_table_to_string(s : SorthybridwikisortTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_graphn_make(size : Int) -> SorthybridwikisortGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_graphn_len(s : SorthybridwikisortGraphN) -> Int { s.size }

pub fn sort_hybrid_wikisort_graphn_get(s : SorthybridwikisortGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_graphn_set(s : SorthybridwikisortGraphN, i : Int, v : Double) -> SorthybridwikisortGraphN {
  let result = sort_hybrid_wikisort_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_graphn_sum(s : SorthybridwikisortGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_graphn_mean(s : SorthybridwikisortGraphN) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_graphn_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_graphn_scale(s : SorthybridwikisortGraphN, f : Double) -> SorthybridwikisortGraphN {
  let result = sort_hybrid_wikisort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_graphn_add(a : SorthybridwikisortGraphN, b : SorthybridwikisortGraphN) -> SorthybridwikisortGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_graphn_copy(s : SorthybridwikisortGraphN) -> SorthybridwikisortGraphN {
  let result = sort_hybrid_wikisort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_graphn_fill(s : SorthybridwikisortGraphN, v : Double) -> SorthybridwikisortGraphN {
  let result = sort_hybrid_wikisort_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_graphn_min(s : SorthybridwikisortGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_graphn_max(s : SorthybridwikisortGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_graphn_to_string(s : SorthybridwikisortGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_node_make(size : Int) -> SorthybridwikisortNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_node_len(s : SorthybridwikisortNode) -> Int { s.size }

pub fn sort_hybrid_wikisort_node_get(s : SorthybridwikisortNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_node_set(s : SorthybridwikisortNode, i : Int, v : Double) -> SorthybridwikisortNode {
  let result = sort_hybrid_wikisort_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_node_sum(s : SorthybridwikisortNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_node_mean(s : SorthybridwikisortNode) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_node_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_node_scale(s : SorthybridwikisortNode, f : Double) -> SorthybridwikisortNode {
  let result = sort_hybrid_wikisort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_node_add(a : SorthybridwikisortNode, b : SorthybridwikisortNode) -> SorthybridwikisortNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_node_copy(s : SorthybridwikisortNode) -> SorthybridwikisortNode {
  let result = sort_hybrid_wikisort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_node_fill(s : SorthybridwikisortNode, v : Double) -> SorthybridwikisortNode {
  let result = sort_hybrid_wikisort_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_node_min(s : SorthybridwikisortNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_node_max(s : SorthybridwikisortNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_node_to_string(s : SorthybridwikisortNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_edge_make(size : Int) -> SorthybridwikisortEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_edge_len(s : SorthybridwikisortEdge) -> Int { s.size }

pub fn sort_hybrid_wikisort_edge_get(s : SorthybridwikisortEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_edge_set(s : SorthybridwikisortEdge, i : Int, v : Double) -> SorthybridwikisortEdge {
  let result = sort_hybrid_wikisort_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_edge_sum(s : SorthybridwikisortEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_edge_mean(s : SorthybridwikisortEdge) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_edge_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_edge_scale(s : SorthybridwikisortEdge, f : Double) -> SorthybridwikisortEdge {
  let result = sort_hybrid_wikisort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_edge_add(a : SorthybridwikisortEdge, b : SorthybridwikisortEdge) -> SorthybridwikisortEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_edge_copy(s : SorthybridwikisortEdge) -> SorthybridwikisortEdge {
  let result = sort_hybrid_wikisort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_edge_fill(s : SorthybridwikisortEdge, v : Double) -> SorthybridwikisortEdge {
  let result = sort_hybrid_wikisort_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_edge_min(s : SorthybridwikisortEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_edge_max(s : SorthybridwikisortEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_edge_to_string(s : SorthybridwikisortEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_path_make(size : Int) -> SorthybridwikisortPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_path_len(s : SorthybridwikisortPath) -> Int { s.size }

pub fn sort_hybrid_wikisort_path_get(s : SorthybridwikisortPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_path_set(s : SorthybridwikisortPath, i : Int, v : Double) -> SorthybridwikisortPath {
  let result = sort_hybrid_wikisort_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_path_sum(s : SorthybridwikisortPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_path_mean(s : SorthybridwikisortPath) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_path_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_path_scale(s : SorthybridwikisortPath, f : Double) -> SorthybridwikisortPath {
  let result = sort_hybrid_wikisort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_path_add(a : SorthybridwikisortPath, b : SorthybridwikisortPath) -> SorthybridwikisortPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_path_copy(s : SorthybridwikisortPath) -> SorthybridwikisortPath {
  let result = sort_hybrid_wikisort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_path_fill(s : SorthybridwikisortPath, v : Double) -> SorthybridwikisortPath {
  let result = sort_hybrid_wikisort_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_path_min(s : SorthybridwikisortPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_path_max(s : SorthybridwikisortPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_path_to_string(s : SorthybridwikisortPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_cluster_make(size : Int) -> SorthybridwikisortCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_cluster_len(s : SorthybridwikisortCluster) -> Int { s.size }

pub fn sort_hybrid_wikisort_cluster_get(s : SorthybridwikisortCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_cluster_set(s : SorthybridwikisortCluster, i : Int, v : Double) -> SorthybridwikisortCluster {
  let result = sort_hybrid_wikisort_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_cluster_sum(s : SorthybridwikisortCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_cluster_mean(s : SorthybridwikisortCluster) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_cluster_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_cluster_scale(s : SorthybridwikisortCluster, f : Double) -> SorthybridwikisortCluster {
  let result = sort_hybrid_wikisort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_cluster_add(a : SorthybridwikisortCluster, b : SorthybridwikisortCluster) -> SorthybridwikisortCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_cluster_copy(s : SorthybridwikisortCluster) -> SorthybridwikisortCluster {
  let result = sort_hybrid_wikisort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_cluster_fill(s : SorthybridwikisortCluster, v : Double) -> SorthybridwikisortCluster {
  let result = sort_hybrid_wikisort_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_cluster_min(s : SorthybridwikisortCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_cluster_max(s : SorthybridwikisortCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_cluster_to_string(s : SorthybridwikisortCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_model_make(size : Int) -> SorthybridwikisortModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_model_len(s : SorthybridwikisortModel) -> Int { s.size }

pub fn sort_hybrid_wikisort_model_get(s : SorthybridwikisortModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_model_set(s : SorthybridwikisortModel, i : Int, v : Double) -> SorthybridwikisortModel {
  let result = sort_hybrid_wikisort_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_model_sum(s : SorthybridwikisortModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_model_mean(s : SorthybridwikisortModel) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_model_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_model_scale(s : SorthybridwikisortModel, f : Double) -> SorthybridwikisortModel {
  let result = sort_hybrid_wikisort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_model_add(a : SorthybridwikisortModel, b : SorthybridwikisortModel) -> SorthybridwikisortModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_model_copy(s : SorthybridwikisortModel) -> SorthybridwikisortModel {
  let result = sort_hybrid_wikisort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_model_fill(s : SorthybridwikisortModel, v : Double) -> SorthybridwikisortModel {
  let result = sort_hybrid_wikisort_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_model_min(s : SorthybridwikisortModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_model_max(s : SorthybridwikisortModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_model_to_string(s : SorthybridwikisortModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_layer_make(size : Int) -> SorthybridwikisortLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_layer_len(s : SorthybridwikisortLayer) -> Int { s.size }

pub fn sort_hybrid_wikisort_layer_get(s : SorthybridwikisortLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_layer_set(s : SorthybridwikisortLayer, i : Int, v : Double) -> SorthybridwikisortLayer {
  let result = sort_hybrid_wikisort_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_layer_sum(s : SorthybridwikisortLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_layer_mean(s : SorthybridwikisortLayer) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_layer_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_layer_scale(s : SorthybridwikisortLayer, f : Double) -> SorthybridwikisortLayer {
  let result = sort_hybrid_wikisort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_layer_add(a : SorthybridwikisortLayer, b : SorthybridwikisortLayer) -> SorthybridwikisortLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_layer_copy(s : SorthybridwikisortLayer) -> SorthybridwikisortLayer {
  let result = sort_hybrid_wikisort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_layer_fill(s : SorthybridwikisortLayer, v : Double) -> SorthybridwikisortLayer {
  let result = sort_hybrid_wikisort_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_layer_min(s : SorthybridwikisortLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_layer_max(s : SorthybridwikisortLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_layer_to_string(s : SorthybridwikisortLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_buffer_make(size : Int) -> SorthybridwikisortBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_buffer_len(s : SorthybridwikisortBuffer) -> Int { s.size }

pub fn sort_hybrid_wikisort_buffer_get(s : SorthybridwikisortBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_buffer_set(s : SorthybridwikisortBuffer, i : Int, v : Double) -> SorthybridwikisortBuffer {
  let result = sort_hybrid_wikisort_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_buffer_sum(s : SorthybridwikisortBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_buffer_mean(s : SorthybridwikisortBuffer) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_buffer_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_buffer_scale(s : SorthybridwikisortBuffer, f : Double) -> SorthybridwikisortBuffer {
  let result = sort_hybrid_wikisort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_buffer_add(a : SorthybridwikisortBuffer, b : SorthybridwikisortBuffer) -> SorthybridwikisortBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_buffer_copy(s : SorthybridwikisortBuffer) -> SorthybridwikisortBuffer {
  let result = sort_hybrid_wikisort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_buffer_fill(s : SorthybridwikisortBuffer, v : Double) -> SorthybridwikisortBuffer {
  let result = sort_hybrid_wikisort_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_buffer_min(s : SorthybridwikisortBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_buffer_max(s : SorthybridwikisortBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_buffer_to_string(s : SorthybridwikisortBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_cursor_make(size : Int) -> SorthybridwikisortCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_cursor_len(s : SorthybridwikisortCursor) -> Int { s.size }

pub fn sort_hybrid_wikisort_cursor_get(s : SorthybridwikisortCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_cursor_set(s : SorthybridwikisortCursor, i : Int, v : Double) -> SorthybridwikisortCursor {
  let result = sort_hybrid_wikisort_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_cursor_sum(s : SorthybridwikisortCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_cursor_mean(s : SorthybridwikisortCursor) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_cursor_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_cursor_scale(s : SorthybridwikisortCursor, f : Double) -> SorthybridwikisortCursor {
  let result = sort_hybrid_wikisort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_cursor_add(a : SorthybridwikisortCursor, b : SorthybridwikisortCursor) -> SorthybridwikisortCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_cursor_copy(s : SorthybridwikisortCursor) -> SorthybridwikisortCursor {
  let result = sort_hybrid_wikisort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_cursor_fill(s : SorthybridwikisortCursor, v : Double) -> SorthybridwikisortCursor {
  let result = sort_hybrid_wikisort_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_cursor_min(s : SorthybridwikisortCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_cursor_max(s : SorthybridwikisortCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_cursor_to_string(s : SorthybridwikisortCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_view_make(size : Int) -> SorthybridwikisortView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_view_len(s : SorthybridwikisortView) -> Int { s.size }

pub fn sort_hybrid_wikisort_view_get(s : SorthybridwikisortView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_view_set(s : SorthybridwikisortView, i : Int, v : Double) -> SorthybridwikisortView {
  let result = sort_hybrid_wikisort_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_view_sum(s : SorthybridwikisortView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_view_mean(s : SorthybridwikisortView) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_view_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_view_scale(s : SorthybridwikisortView, f : Double) -> SorthybridwikisortView {
  let result = sort_hybrid_wikisort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_view_add(a : SorthybridwikisortView, b : SorthybridwikisortView) -> SorthybridwikisortView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_view_copy(s : SorthybridwikisortView) -> SorthybridwikisortView {
  let result = sort_hybrid_wikisort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_view_fill(s : SorthybridwikisortView, v : Double) -> SorthybridwikisortView {
  let result = sort_hybrid_wikisort_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_view_min(s : SorthybridwikisortView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_view_max(s : SorthybridwikisortView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_view_to_string(s : SorthybridwikisortView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_range_make(size : Int) -> SorthybridwikisortRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_range_len(s : SorthybridwikisortRange) -> Int { s.size }

pub fn sort_hybrid_wikisort_range_get(s : SorthybridwikisortRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_range_set(s : SorthybridwikisortRange, i : Int, v : Double) -> SorthybridwikisortRange {
  let result = sort_hybrid_wikisort_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_range_sum(s : SorthybridwikisortRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_range_mean(s : SorthybridwikisortRange) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_range_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_range_scale(s : SorthybridwikisortRange, f : Double) -> SorthybridwikisortRange {
  let result = sort_hybrid_wikisort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_range_add(a : SorthybridwikisortRange, b : SorthybridwikisortRange) -> SorthybridwikisortRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_range_copy(s : SorthybridwikisortRange) -> SorthybridwikisortRange {
  let result = sort_hybrid_wikisort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_range_fill(s : SorthybridwikisortRange, v : Double) -> SorthybridwikisortRange {
  let result = sort_hybrid_wikisort_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_range_min(s : SorthybridwikisortRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_range_max(s : SorthybridwikisortRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_range_to_string(s : SorthybridwikisortRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct SorthybridwikisortSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn sort_hybrid_wikisort_slice_make(size : Int) -> SorthybridwikisortSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn sort_hybrid_wikisort_slice_len(s : SorthybridwikisortSlice) -> Int { s.size }

pub fn sort_hybrid_wikisort_slice_get(s : SorthybridwikisortSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn sort_hybrid_wikisort_slice_set(s : SorthybridwikisortSlice, i : Int, v : Double) -> SorthybridwikisortSlice {
  let result = sort_hybrid_wikisort_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_slice_sum(s : SorthybridwikisortSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn sort_hybrid_wikisort_slice_mean(s : SorthybridwikisortSlice) -> Double {
  if s.size == 0 { 0.0 } else { sort_hybrid_wikisort_slice_sum(s) / s.size.to_double() }
}

pub fn sort_hybrid_wikisort_slice_scale(s : SorthybridwikisortSlice, f : Double) -> SorthybridwikisortSlice {
  let result = sort_hybrid_wikisort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn sort_hybrid_wikisort_slice_add(a : SorthybridwikisortSlice, b : SorthybridwikisortSlice) -> SorthybridwikisortSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = sort_hybrid_wikisort_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn sort_hybrid_wikisort_slice_copy(s : SorthybridwikisortSlice) -> SorthybridwikisortSlice {
  let result = sort_hybrid_wikisort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn sort_hybrid_wikisort_slice_fill(s : SorthybridwikisortSlice, v : Double) -> SorthybridwikisortSlice {
  let result = sort_hybrid_wikisort_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn sort_hybrid_wikisort_slice_min(s : SorthybridwikisortSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_slice_max(s : SorthybridwikisortSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn sort_hybrid_wikisort_slice_to_string(s : SorthybridwikisortSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn sort_hybrid_wikisort_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn sort_hybrid_wikisort_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

