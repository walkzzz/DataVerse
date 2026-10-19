///===
/// extcore/bio_phylo_distance

pub(all) struct BiophylodistancePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_distance_make_point(x : Double, y : Double) -> BiophylodistancePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_distance_make_point3(x : Double, y : Double, z : Double) -> BiophylodistancePoint {
  { x, y, z, label: 0 }
}

pub fn bio_phylo_distance_point_x(pt : BiophylodistancePoint) -> Double { pt.x }

pub fn bio_phylo_distance_point_y(pt : BiophylodistancePoint) -> Double { pt.y }

pub fn bio_phylo_distance_point_z(pt : BiophylodistancePoint) -> Double { pt.z }

pub fn bio_phylo_distance_point_label(pt : BiophylodistancePoint) -> Int { pt.label }

pub fn bio_phylo_distance_point_dist(a : BiophylodistancePoint, b : BiophylodistancePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_phylo_distance_point_add(a : BiophylodistancePoint, b : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_phylo_distance_point_sub(a : BiophylodistancePoint, b : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_phylo_distance_point_scale(pt : BiophylodistancePoint, s : Double) -> BiophylodistancePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_phylo_distance_point_dot(a : BiophylodistancePoint, b : BiophylodistancePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_phylo_distance_point_cross(a : BiophylodistancePoint, b : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_phylo_distance_point_norm(pt : BiophylodistancePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_phylo_distance_point_normalize(pt : BiophylodistancePoint) -> BiophylodistancePoint {
  let n = bio_phylo_distance_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_phylo_distance_point_scale(pt, 1.0 / n) }
}

pub fn bio_phylo_distance_point_negate(pt : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_phylo_distance_point_mid(a : BiophylodistancePoint, b : BiophylodistancePoint) -> BiophylodistancePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_phylo_distance_point_lerp(a : BiophylodistancePoint, b : BiophylodistancePoint, t : Double) -> BiophylodistancePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_phylo_distance_point_to_string(pt : BiophylodistancePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiophylodistanceSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_distance_make_series(vals : Array[Double], name : String) -> BiophylodistanceSeries {
  { vals, name, meta: 0 }
}

pub fn bio_phylo_distance_series_len(s : BiophylodistanceSeries) -> Int { s.vals.length() }

pub fn bio_phylo_distance_series_sum(s : BiophylodistanceSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_phylo_distance_series_mean(s : BiophylodistanceSeries) -> Double {
  let n = bio_phylo_distance_series_len(s)
  if n == 0 { 0.0 } else { bio_phylo_distance_series_sum(s) / n.to_double() }
}

pub fn bio_phylo_distance_series_min(s : BiophylodistanceSeries) -> Double {
  let n = bio_phylo_distance_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_distance_series_max(s : BiophylodistanceSeries) -> Double {
  let n = bio_phylo_distance_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_distance_series_range(s : BiophylodistanceSeries) -> Double {
  bio_phylo_distance_series_max(s) - bio_phylo_distance_series_min(s)
}

pub fn bio_phylo_distance_series_var(s : BiophylodistanceSeries) -> Double {
  let n = bio_phylo_distance_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_phylo_distance_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_phylo_distance_series_std(s : BiophylodistanceSeries) -> Double { @_common.sqrt(bio_phylo_distance_series_var(s)) }

pub fn bio_phylo_distance_series_median(s : BiophylodistanceSeries) -> Double {
  let n = bio_phylo_distance_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_phylo_distance_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_phylo_distance_series_scale(s : BiophylodistanceSeries, f : Double) -> BiophylodistanceSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_phylo_distance_series_add(a : BiophylodistanceSeries, b : BiophylodistanceSeries) -> BiophylodistanceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_phylo_distance_series_sub(a : BiophylodistanceSeries, b : BiophylodistanceSeries) -> BiophylodistanceSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_phylo_distance_series_normalize(s : BiophylodistanceSeries) -> BiophylodistanceSeries {
  let mn = bio_phylo_distance_series_min(s)
  let mx = bio_phylo_distance_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_phylo_distance_series_cumsum(s : BiophylodistanceSeries) -> BiophylodistanceSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_phylo_distance_series_to_string(s : BiophylodistanceSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylodistanceMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_distance_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylodistanceMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_distance_matrix_identity(n : Int) -> BiophylodistanceMatrix {
  let m = bio_phylo_distance_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_phylo_distance_matrix_get(m : BiophylodistanceMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_phylo_distance_matrix_transpose(m : BiophylodistanceMatrix) -> BiophylodistanceMatrix {
  let result = bio_phylo_distance_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_phylo_distance_matrix_add(a : BiophylodistanceMatrix, b : BiophylodistanceMatrix) -> BiophylodistanceMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_phylo_distance_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_phylo_distance_matrix_scale(m : BiophylodistanceMatrix, s : Double) -> BiophylodistanceMatrix {
  let result = bio_phylo_distance_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_phylo_distance_matrix_multiply(a : BiophylodistanceMatrix, b : BiophylodistanceMatrix) -> BiophylodistanceMatrix {
  if a.cols != b.rows { return bio_phylo_distance_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_phylo_distance_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_phylo_distance_matrix_trace(m : BiophylodistanceMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_phylo_distance_matrix_det(m : BiophylodistanceMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_phylo_distance_matrix_norm(m : BiophylodistanceMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_phylo_distance_matrix_to_string(m : BiophylodistanceMatrix) -> String {
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

pub(all) struct BiophylodistanceVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_distance_make_vector(comps : Array[Double]) -> BiophylodistanceVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_distance_vector_zero(dim : Int) -> BiophylodistanceVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_phylo_distance_vector_add(a : BiophylodistanceVector, b : BiophylodistanceVector) -> BiophylodistanceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_distance_vector_sub(a : BiophylodistanceVector, b : BiophylodistanceVector) -> BiophylodistanceVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_distance_vector_scale(v : BiophylodistanceVector, s : Double) -> BiophylodistanceVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_phylo_distance_vector_dot(a : BiophylodistanceVector, b : BiophylodistanceVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_phylo_distance_vector_norm(v : BiophylodistanceVector) -> Double { @_common.sqrt(bio_phylo_distance_vector_dot(v, v)) }

pub fn bio_phylo_distance_vector_normalize(v : BiophylodistanceVector) -> BiophylodistanceVector {
  let n = bio_phylo_distance_vector_norm(v)
  if n < 0.0000001 { v } else { bio_phylo_distance_vector_scale(v, 1.0 / n) }
}

pub fn bio_phylo_distance_vector_dist(a : BiophylodistanceVector, b : BiophylodistanceVector) -> Double {
  bio_phylo_distance_vector_norm(bio_phylo_distance_vector_sub(a, b))
}

pub fn bio_phylo_distance_vector_to_string(v : BiophylodistanceVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_distance_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_phylo_distance_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_phylo_distance_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_phylo_distance_std(data : Array[Double]) -> Double { @_common.sqrt(bio_phylo_distance_var(data)) }

pub fn bio_phylo_distance_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_phylo_distance_mean(a); let mb = bio_phylo_distance_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_phylo_distance_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_phylo_distance_std(a); let sb = bio_phylo_distance_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_phylo_distance_cov(a, b) / (sa * sb) }
}

pub fn bio_phylo_distance_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_phylo_distance_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_phylo_distance_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_phylo_distance_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_phylo_distance_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(bio_phylo_distance_mse(pred, labels))
}

pub fn bio_phylo_distance_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_phylo_distance_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_phylo_distance_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_phylo_distance_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_phylo_distance_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_phylo_distance_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_phylo_distance_precision(pred, labels, pos); let r = bio_phylo_distance_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_phylo_distance_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_phylo_distance_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_phylo_distance_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_phylo_distance_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_phylo_distance_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_phylo_distance_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_phylo_distance_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_phylo_distance_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_phylo_distance_fibonacci(n : Int) -> Int {
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

pub fn bio_phylo_distance_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_phylo_distance_min(data); let mx = bio_phylo_distance_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_phylo_distance_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_phylo_distance_mean(data); let sd = bio_phylo_distance_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_phylo_distance_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_phylo_distance_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_phylo_distance_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_phylo_distance_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_phylo_distance_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_phylo_distance_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct BiophylodistanceFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_frame_make(size : Int) -> BiophylodistanceFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_frame_len(s : BiophylodistanceFrame) -> Int { s.size }

pub fn bio_phylo_distance_frame_get(s : BiophylodistanceFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_frame_set(s : BiophylodistanceFrame, i : Int, v : Double) -> BiophylodistanceFrame {
  let result = bio_phylo_distance_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_frame_sum(s : BiophylodistanceFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_frame_mean(s : BiophylodistanceFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_frame_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_frame_scale(s : BiophylodistanceFrame, f : Double) -> BiophylodistanceFrame {
  let result = bio_phylo_distance_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_frame_add(a : BiophylodistanceFrame, b : BiophylodistanceFrame) -> BiophylodistanceFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_frame_copy(s : BiophylodistanceFrame) -> BiophylodistanceFrame {
  let result = bio_phylo_distance_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_frame_fill(s : BiophylodistanceFrame, v : Double) -> BiophylodistanceFrame {
  let result = bio_phylo_distance_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_frame_min(s : BiophylodistanceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_frame_max(s : BiophylodistanceFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_frame_to_string(s : BiophylodistanceFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_table_make(size : Int) -> BiophylodistanceTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_table_len(s : BiophylodistanceTable) -> Int { s.size }

pub fn bio_phylo_distance_table_get(s : BiophylodistanceTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_table_set(s : BiophylodistanceTable, i : Int, v : Double) -> BiophylodistanceTable {
  let result = bio_phylo_distance_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_table_sum(s : BiophylodistanceTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_table_mean(s : BiophylodistanceTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_table_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_table_scale(s : BiophylodistanceTable, f : Double) -> BiophylodistanceTable {
  let result = bio_phylo_distance_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_table_add(a : BiophylodistanceTable, b : BiophylodistanceTable) -> BiophylodistanceTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_table_copy(s : BiophylodistanceTable) -> BiophylodistanceTable {
  let result = bio_phylo_distance_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_table_fill(s : BiophylodistanceTable, v : Double) -> BiophylodistanceTable {
  let result = bio_phylo_distance_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_table_min(s : BiophylodistanceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_table_max(s : BiophylodistanceTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_table_to_string(s : BiophylodistanceTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_graphn_make(size : Int) -> BiophylodistanceGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_graphn_len(s : BiophylodistanceGraphN) -> Int { s.size }

pub fn bio_phylo_distance_graphn_get(s : BiophylodistanceGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_graphn_set(s : BiophylodistanceGraphN, i : Int, v : Double) -> BiophylodistanceGraphN {
  let result = bio_phylo_distance_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_graphn_sum(s : BiophylodistanceGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_graphn_mean(s : BiophylodistanceGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_graphn_scale(s : BiophylodistanceGraphN, f : Double) -> BiophylodistanceGraphN {
  let result = bio_phylo_distance_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_graphn_add(a : BiophylodistanceGraphN, b : BiophylodistanceGraphN) -> BiophylodistanceGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_graphn_copy(s : BiophylodistanceGraphN) -> BiophylodistanceGraphN {
  let result = bio_phylo_distance_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_graphn_fill(s : BiophylodistanceGraphN, v : Double) -> BiophylodistanceGraphN {
  let result = bio_phylo_distance_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_graphn_min(s : BiophylodistanceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_graphn_max(s : BiophylodistanceGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_graphn_to_string(s : BiophylodistanceGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_node_make(size : Int) -> BiophylodistanceNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_node_len(s : BiophylodistanceNode) -> Int { s.size }

pub fn bio_phylo_distance_node_get(s : BiophylodistanceNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_node_set(s : BiophylodistanceNode, i : Int, v : Double) -> BiophylodistanceNode {
  let result = bio_phylo_distance_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_node_sum(s : BiophylodistanceNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_node_mean(s : BiophylodistanceNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_node_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_node_scale(s : BiophylodistanceNode, f : Double) -> BiophylodistanceNode {
  let result = bio_phylo_distance_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_node_add(a : BiophylodistanceNode, b : BiophylodistanceNode) -> BiophylodistanceNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_node_copy(s : BiophylodistanceNode) -> BiophylodistanceNode {
  let result = bio_phylo_distance_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_node_fill(s : BiophylodistanceNode, v : Double) -> BiophylodistanceNode {
  let result = bio_phylo_distance_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_node_min(s : BiophylodistanceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_node_max(s : BiophylodistanceNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_node_to_string(s : BiophylodistanceNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_edge_make(size : Int) -> BiophylodistanceEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_edge_len(s : BiophylodistanceEdge) -> Int { s.size }

pub fn bio_phylo_distance_edge_get(s : BiophylodistanceEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_edge_set(s : BiophylodistanceEdge, i : Int, v : Double) -> BiophylodistanceEdge {
  let result = bio_phylo_distance_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_edge_sum(s : BiophylodistanceEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_edge_mean(s : BiophylodistanceEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_edge_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_edge_scale(s : BiophylodistanceEdge, f : Double) -> BiophylodistanceEdge {
  let result = bio_phylo_distance_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_edge_add(a : BiophylodistanceEdge, b : BiophylodistanceEdge) -> BiophylodistanceEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_edge_copy(s : BiophylodistanceEdge) -> BiophylodistanceEdge {
  let result = bio_phylo_distance_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_edge_fill(s : BiophylodistanceEdge, v : Double) -> BiophylodistanceEdge {
  let result = bio_phylo_distance_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_edge_min(s : BiophylodistanceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_edge_max(s : BiophylodistanceEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_edge_to_string(s : BiophylodistanceEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistancePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_path_make(size : Int) -> BiophylodistancePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_path_len(s : BiophylodistancePath) -> Int { s.size }

pub fn bio_phylo_distance_path_get(s : BiophylodistancePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_path_set(s : BiophylodistancePath, i : Int, v : Double) -> BiophylodistancePath {
  let result = bio_phylo_distance_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_path_sum(s : BiophylodistancePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_path_mean(s : BiophylodistancePath) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_path_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_path_scale(s : BiophylodistancePath, f : Double) -> BiophylodistancePath {
  let result = bio_phylo_distance_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_path_add(a : BiophylodistancePath, b : BiophylodistancePath) -> BiophylodistancePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_path_copy(s : BiophylodistancePath) -> BiophylodistancePath {
  let result = bio_phylo_distance_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_path_fill(s : BiophylodistancePath, v : Double) -> BiophylodistancePath {
  let result = bio_phylo_distance_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_path_min(s : BiophylodistancePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_path_max(s : BiophylodistancePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_path_to_string(s : BiophylodistancePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_cluster_make(size : Int) -> BiophylodistanceCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_cluster_len(s : BiophylodistanceCluster) -> Int { s.size }

pub fn bio_phylo_distance_cluster_get(s : BiophylodistanceCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_cluster_set(s : BiophylodistanceCluster, i : Int, v : Double) -> BiophylodistanceCluster {
  let result = bio_phylo_distance_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_cluster_sum(s : BiophylodistanceCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_cluster_mean(s : BiophylodistanceCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_cluster_scale(s : BiophylodistanceCluster, f : Double) -> BiophylodistanceCluster {
  let result = bio_phylo_distance_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_cluster_add(a : BiophylodistanceCluster, b : BiophylodistanceCluster) -> BiophylodistanceCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_cluster_copy(s : BiophylodistanceCluster) -> BiophylodistanceCluster {
  let result = bio_phylo_distance_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_cluster_fill(s : BiophylodistanceCluster, v : Double) -> BiophylodistanceCluster {
  let result = bio_phylo_distance_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_cluster_min(s : BiophylodistanceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_cluster_max(s : BiophylodistanceCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_cluster_to_string(s : BiophylodistanceCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_model_make(size : Int) -> BiophylodistanceModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_model_len(s : BiophylodistanceModel) -> Int { s.size }

pub fn bio_phylo_distance_model_get(s : BiophylodistanceModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_model_set(s : BiophylodistanceModel, i : Int, v : Double) -> BiophylodistanceModel {
  let result = bio_phylo_distance_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_model_sum(s : BiophylodistanceModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_model_mean(s : BiophylodistanceModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_model_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_model_scale(s : BiophylodistanceModel, f : Double) -> BiophylodistanceModel {
  let result = bio_phylo_distance_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_model_add(a : BiophylodistanceModel, b : BiophylodistanceModel) -> BiophylodistanceModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_model_copy(s : BiophylodistanceModel) -> BiophylodistanceModel {
  let result = bio_phylo_distance_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_model_fill(s : BiophylodistanceModel, v : Double) -> BiophylodistanceModel {
  let result = bio_phylo_distance_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_model_min(s : BiophylodistanceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_model_max(s : BiophylodistanceModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_model_to_string(s : BiophylodistanceModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_layer_make(size : Int) -> BiophylodistanceLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_layer_len(s : BiophylodistanceLayer) -> Int { s.size }

pub fn bio_phylo_distance_layer_get(s : BiophylodistanceLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_layer_set(s : BiophylodistanceLayer, i : Int, v : Double) -> BiophylodistanceLayer {
  let result = bio_phylo_distance_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_layer_sum(s : BiophylodistanceLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_layer_mean(s : BiophylodistanceLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_layer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_layer_scale(s : BiophylodistanceLayer, f : Double) -> BiophylodistanceLayer {
  let result = bio_phylo_distance_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_layer_add(a : BiophylodistanceLayer, b : BiophylodistanceLayer) -> BiophylodistanceLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_layer_copy(s : BiophylodistanceLayer) -> BiophylodistanceLayer {
  let result = bio_phylo_distance_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_layer_fill(s : BiophylodistanceLayer, v : Double) -> BiophylodistanceLayer {
  let result = bio_phylo_distance_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_layer_min(s : BiophylodistanceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_layer_max(s : BiophylodistanceLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_layer_to_string(s : BiophylodistanceLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_buffer_make(size : Int) -> BiophylodistanceBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_buffer_len(s : BiophylodistanceBuffer) -> Int { s.size }

pub fn bio_phylo_distance_buffer_get(s : BiophylodistanceBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_buffer_set(s : BiophylodistanceBuffer, i : Int, v : Double) -> BiophylodistanceBuffer {
  let result = bio_phylo_distance_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_buffer_sum(s : BiophylodistanceBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_buffer_mean(s : BiophylodistanceBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_buffer_scale(s : BiophylodistanceBuffer, f : Double) -> BiophylodistanceBuffer {
  let result = bio_phylo_distance_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_buffer_add(a : BiophylodistanceBuffer, b : BiophylodistanceBuffer) -> BiophylodistanceBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_buffer_copy(s : BiophylodistanceBuffer) -> BiophylodistanceBuffer {
  let result = bio_phylo_distance_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_buffer_fill(s : BiophylodistanceBuffer, v : Double) -> BiophylodistanceBuffer {
  let result = bio_phylo_distance_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_buffer_min(s : BiophylodistanceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_buffer_max(s : BiophylodistanceBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_buffer_to_string(s : BiophylodistanceBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_cursor_make(size : Int) -> BiophylodistanceCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_cursor_len(s : BiophylodistanceCursor) -> Int { s.size }

pub fn bio_phylo_distance_cursor_get(s : BiophylodistanceCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_cursor_set(s : BiophylodistanceCursor, i : Int, v : Double) -> BiophylodistanceCursor {
  let result = bio_phylo_distance_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_cursor_sum(s : BiophylodistanceCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_cursor_mean(s : BiophylodistanceCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_cursor_scale(s : BiophylodistanceCursor, f : Double) -> BiophylodistanceCursor {
  let result = bio_phylo_distance_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_cursor_add(a : BiophylodistanceCursor, b : BiophylodistanceCursor) -> BiophylodistanceCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_cursor_copy(s : BiophylodistanceCursor) -> BiophylodistanceCursor {
  let result = bio_phylo_distance_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_cursor_fill(s : BiophylodistanceCursor, v : Double) -> BiophylodistanceCursor {
  let result = bio_phylo_distance_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_cursor_min(s : BiophylodistanceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_cursor_max(s : BiophylodistanceCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_cursor_to_string(s : BiophylodistanceCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_view_make(size : Int) -> BiophylodistanceView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_view_len(s : BiophylodistanceView) -> Int { s.size }

pub fn bio_phylo_distance_view_get(s : BiophylodistanceView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_view_set(s : BiophylodistanceView, i : Int, v : Double) -> BiophylodistanceView {
  let result = bio_phylo_distance_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_view_sum(s : BiophylodistanceView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_view_mean(s : BiophylodistanceView) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_view_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_view_scale(s : BiophylodistanceView, f : Double) -> BiophylodistanceView {
  let result = bio_phylo_distance_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_view_add(a : BiophylodistanceView, b : BiophylodistanceView) -> BiophylodistanceView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_view_copy(s : BiophylodistanceView) -> BiophylodistanceView {
  let result = bio_phylo_distance_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_view_fill(s : BiophylodistanceView, v : Double) -> BiophylodistanceView {
  let result = bio_phylo_distance_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_view_min(s : BiophylodistanceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_view_max(s : BiophylodistanceView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_view_to_string(s : BiophylodistanceView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_range_make(size : Int) -> BiophylodistanceRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_range_len(s : BiophylodistanceRange) -> Int { s.size }

pub fn bio_phylo_distance_range_get(s : BiophylodistanceRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_range_set(s : BiophylodistanceRange, i : Int, v : Double) -> BiophylodistanceRange {
  let result = bio_phylo_distance_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_range_sum(s : BiophylodistanceRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_range_mean(s : BiophylodistanceRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_range_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_range_scale(s : BiophylodistanceRange, f : Double) -> BiophylodistanceRange {
  let result = bio_phylo_distance_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_range_add(a : BiophylodistanceRange, b : BiophylodistanceRange) -> BiophylodistanceRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_range_copy(s : BiophylodistanceRange) -> BiophylodistanceRange {
  let result = bio_phylo_distance_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_range_fill(s : BiophylodistanceRange, v : Double) -> BiophylodistanceRange {
  let result = bio_phylo_distance_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_range_min(s : BiophylodistanceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_range_max(s : BiophylodistanceRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_range_to_string(s : BiophylodistanceRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylodistanceSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_distance_slice_make(size : Int) -> BiophylodistanceSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_distance_slice_len(s : BiophylodistanceSlice) -> Int { s.size }

pub fn bio_phylo_distance_slice_get(s : BiophylodistanceSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_distance_slice_set(s : BiophylodistanceSlice, i : Int, v : Double) -> BiophylodistanceSlice {
  let result = bio_phylo_distance_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_slice_sum(s : BiophylodistanceSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_distance_slice_mean(s : BiophylodistanceSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_distance_slice_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_distance_slice_scale(s : BiophylodistanceSlice, f : Double) -> BiophylodistanceSlice {
  let result = bio_phylo_distance_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_distance_slice_add(a : BiophylodistanceSlice, b : BiophylodistanceSlice) -> BiophylodistanceSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_distance_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_distance_slice_copy(s : BiophylodistanceSlice) -> BiophylodistanceSlice {
  let result = bio_phylo_distance_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_distance_slice_fill(s : BiophylodistanceSlice, v : Double) -> BiophylodistanceSlice {
  let result = bio_phylo_distance_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_distance_slice_min(s : BiophylodistanceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_slice_max(s : BiophylodistanceSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_distance_slice_to_string(s : BiophylodistanceSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

