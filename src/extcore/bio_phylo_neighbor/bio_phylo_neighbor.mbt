///===
/// extcore/bio_phylo_neighbor

pub(all) struct BiophyloneighborPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_neighbor_make_point(x : Double, y : Double) -> BiophyloneighborPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_neighbor_make_point3(x : Double, y : Double, z : Double) -> BiophyloneighborPoint {
  { x, y, z, label: 0 }
}

pub fn bio_phylo_neighbor_point_x(pt : BiophyloneighborPoint) -> Double { pt.x }

pub fn bio_phylo_neighbor_point_y(pt : BiophyloneighborPoint) -> Double { pt.y }

pub fn bio_phylo_neighbor_point_z(pt : BiophyloneighborPoint) -> Double { pt.z }

pub fn bio_phylo_neighbor_point_label(pt : BiophyloneighborPoint) -> Int { pt.label }

pub fn bio_phylo_neighbor_point_dist(a : BiophyloneighborPoint, b : BiophyloneighborPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  bio_phylo_neighbor_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_phylo_neighbor_point_add(a : BiophyloneighborPoint, b : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_phylo_neighbor_point_sub(a : BiophyloneighborPoint, b : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_phylo_neighbor_point_scale(pt : BiophyloneighborPoint, s : Double) -> BiophyloneighborPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_phylo_neighbor_point_dot(a : BiophyloneighborPoint, b : BiophyloneighborPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_phylo_neighbor_point_cross(a : BiophyloneighborPoint, b : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_phylo_neighbor_point_norm(pt : BiophyloneighborPoint) -> Double {
  bio_phylo_neighbor_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_phylo_neighbor_point_normalize(pt : BiophyloneighborPoint) -> BiophyloneighborPoint {
  let n = bio_phylo_neighbor_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_phylo_neighbor_point_scale(pt, 1.0 / n) }
}

pub fn bio_phylo_neighbor_point_negate(pt : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_phylo_neighbor_point_mid(a : BiophyloneighborPoint, b : BiophyloneighborPoint) -> BiophyloneighborPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_phylo_neighbor_point_lerp(a : BiophyloneighborPoint, b : BiophyloneighborPoint, t : Double) -> BiophyloneighborPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_phylo_neighbor_point_to_string(pt : BiophyloneighborPoint) -> String {
  "(" + bio_phylo_neighbor_dbl(pt.x) + ", " + bio_phylo_neighbor_dbl(pt.y) + ", " + bio_phylo_neighbor_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiophyloneighborSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_neighbor_make_series(vals : Array[Double], name : String) -> BiophyloneighborSeries {
  { vals, name, meta: 0 }
}

pub fn bio_phylo_neighbor_series_len(s : BiophyloneighborSeries) -> Int { s.vals.length() }

pub fn bio_phylo_neighbor_series_sum(s : BiophyloneighborSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_phylo_neighbor_series_mean(s : BiophyloneighborSeries) -> Double {
  let n = bio_phylo_neighbor_series_len(s)
  if n == 0 { 0.0 } else { bio_phylo_neighbor_series_sum(s) / n.to_double() }
}

pub fn bio_phylo_neighbor_series_min(s : BiophyloneighborSeries) -> Double {
  let n = bio_phylo_neighbor_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_series_max(s : BiophyloneighborSeries) -> Double {
  let n = bio_phylo_neighbor_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_series_range(s : BiophyloneighborSeries) -> Double {
  bio_phylo_neighbor_series_max(s) - bio_phylo_neighbor_series_min(s)
}

pub fn bio_phylo_neighbor_series_var(s : BiophyloneighborSeries) -> Double {
  let n = bio_phylo_neighbor_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_phylo_neighbor_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_phylo_neighbor_series_std(s : BiophyloneighborSeries) -> Double { bio_phylo_neighbor_sqrt(bio_phylo_neighbor_series_var(s)) }

pub fn bio_phylo_neighbor_series_median(s : BiophyloneighborSeries) -> Double {
  let n = bio_phylo_neighbor_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_phylo_neighbor_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_phylo_neighbor_series_scale(s : BiophyloneighborSeries, f : Double) -> BiophyloneighborSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = bio_phylo_neighbor_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_phylo_neighbor_series_add(a : BiophyloneighborSeries, b : BiophyloneighborSeries) -> BiophyloneighborSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_phylo_neighbor_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_phylo_neighbor_series_sub(a : BiophyloneighborSeries, b : BiophyloneighborSeries) -> BiophyloneighborSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_phylo_neighbor_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_phylo_neighbor_series_normalize(s : BiophyloneighborSeries) -> BiophyloneighborSeries {
  let mn = bio_phylo_neighbor_series_min(s)
  let mx = bio_phylo_neighbor_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = bio_phylo_neighbor_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_phylo_neighbor_series_cumsum(s : BiophyloneighborSeries) -> BiophyloneighborSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = bio_phylo_neighbor_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_phylo_neighbor_series_to_string(s : BiophyloneighborSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_phylo_neighbor_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloneighborMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_neighbor_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloneighborMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_neighbor_matrix_identity(n : Int) -> BiophyloneighborMatrix {
  let m = bio_phylo_neighbor_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_phylo_neighbor_matrix_get(m : BiophyloneighborMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_phylo_neighbor_matrix_transpose(m : BiophyloneighborMatrix) -> BiophyloneighborMatrix {
  let result = bio_phylo_neighbor_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_phylo_neighbor_matrix_add(a : BiophyloneighborMatrix, b : BiophyloneighborMatrix) -> BiophyloneighborMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_phylo_neighbor_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_phylo_neighbor_matrix_scale(m : BiophyloneighborMatrix, s : Double) -> BiophyloneighborMatrix {
  let result = bio_phylo_neighbor_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_phylo_neighbor_matrix_multiply(a : BiophyloneighborMatrix, b : BiophyloneighborMatrix) -> BiophyloneighborMatrix {
  if a.cols != b.rows { return bio_phylo_neighbor_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_phylo_neighbor_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_phylo_neighbor_matrix_trace(m : BiophyloneighborMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_phylo_neighbor_matrix_det(m : BiophyloneighborMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_phylo_neighbor_matrix_norm(m : BiophyloneighborMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  bio_phylo_neighbor_sqrt(sum)
}

pub fn bio_phylo_neighbor_matrix_to_string(m : BiophyloneighborMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + bio_phylo_neighbor_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct BiophyloneighborVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_neighbor_make_vector(comps : Array[Double]) -> BiophyloneighborVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_neighbor_vector_zero(dim : Int) -> BiophyloneighborVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_phylo_neighbor_vector_add(a : BiophyloneighborVector, b : BiophyloneighborVector) -> BiophyloneighborVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_phylo_neighbor_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_neighbor_vector_sub(a : BiophyloneighborVector, b : BiophyloneighborVector) -> BiophyloneighborVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_phylo_neighbor_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_neighbor_vector_scale(v : BiophyloneighborVector, s : Double) -> BiophyloneighborVector {
  let mut result = []
  for i in 0..<v.dim { result = bio_phylo_neighbor_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_phylo_neighbor_vector_dot(a : BiophyloneighborVector, b : BiophyloneighborVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_phylo_neighbor_vector_norm(v : BiophyloneighborVector) -> Double { bio_phylo_neighbor_sqrt(bio_phylo_neighbor_vector_dot(v, v)) }

pub fn bio_phylo_neighbor_vector_normalize(v : BiophyloneighborVector) -> BiophyloneighborVector {
  let n = bio_phylo_neighbor_vector_norm(v)
  if n < 0.0000001 { v } else { bio_phylo_neighbor_vector_scale(v, 1.0 / n) }
}

pub fn bio_phylo_neighbor_vector_dist(a : BiophyloneighborVector, b : BiophyloneighborVector) -> Double {
  bio_phylo_neighbor_vector_norm(bio_phylo_neighbor_vector_sub(a, b))
}

pub fn bio_phylo_neighbor_vector_to_string(v : BiophyloneighborVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_phylo_neighbor_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_neighbor_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_phylo_neighbor_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_phylo_neighbor_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_phylo_neighbor_std(data : Array[Double]) -> Double { bio_phylo_neighbor_sqrt(bio_phylo_neighbor_var(data)) }

pub fn bio_phylo_neighbor_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_phylo_neighbor_mean(a); let mb = bio_phylo_neighbor_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_phylo_neighbor_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_phylo_neighbor_std(a); let sb = bio_phylo_neighbor_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_phylo_neighbor_cov(a, b) / (sa * sb) }
}

pub fn bio_phylo_neighbor_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_phylo_neighbor_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_phylo_neighbor_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_phylo_neighbor_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_phylo_neighbor_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  bio_phylo_neighbor_sqrt(bio_phylo_neighbor_mse(pred, labels))
}

pub fn bio_phylo_neighbor_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + bio_phylo_neighbor_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_phylo_neighbor_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_phylo_neighbor_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_phylo_neighbor_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_phylo_neighbor_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_phylo_neighbor_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_phylo_neighbor_precision(pred, labels, pos); let r = bio_phylo_neighbor_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_phylo_neighbor_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_phylo_neighbor_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_phylo_neighbor_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_phylo_neighbor_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_phylo_neighbor_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_phylo_neighbor_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_phylo_neighbor_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_phylo_neighbor_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_phylo_neighbor_fibonacci(n : Int) -> Int {
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

pub fn bio_phylo_neighbor_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_phylo_neighbor_min(data); let mx = bio_phylo_neighbor_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_phylo_neighbor_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_phylo_neighbor_mean(data); let sd = bio_phylo_neighbor_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_phylo_neighbor_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_phylo_neighbor_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_phylo_neighbor_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_phylo_neighbor_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn bio_phylo_neighbor_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn bio_phylo_neighbor_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn bio_phylo_neighbor_dbl(x : Double) -> String {
  let i = if x >= 0.0 { bio_phylo_neighbor_int(x) } else { -bio_phylo_neighbor_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { bio_phylo_neighbor_int(f * 1000000.0) } else { bio_phylo_neighbor_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn bio_phylo_neighbor_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn bio_phylo_neighbor_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct BiophyloneighborFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_frame_make(size : Int) -> BiophyloneighborFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_frame_len(s : BiophyloneighborFrame) -> Int { s.size }

pub fn bio_phylo_neighbor_frame_get(s : BiophyloneighborFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_frame_set(s : BiophyloneighborFrame, i : Int, v : Double) -> BiophyloneighborFrame {
  let result = bio_phylo_neighbor_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_frame_sum(s : BiophyloneighborFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_frame_mean(s : BiophyloneighborFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_frame_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_frame_scale(s : BiophyloneighborFrame, f : Double) -> BiophyloneighborFrame {
  let result = bio_phylo_neighbor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_frame_add(a : BiophyloneighborFrame, b : BiophyloneighborFrame) -> BiophyloneighborFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_frame_copy(s : BiophyloneighborFrame) -> BiophyloneighborFrame {
  let result = bio_phylo_neighbor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_frame_fill(s : BiophyloneighborFrame, v : Double) -> BiophyloneighborFrame {
  let result = bio_phylo_neighbor_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_frame_min(s : BiophyloneighborFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_frame_max(s : BiophyloneighborFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_frame_to_string(s : BiophyloneighborFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_table_make(size : Int) -> BiophyloneighborTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_table_len(s : BiophyloneighborTable) -> Int { s.size }

pub fn bio_phylo_neighbor_table_get(s : BiophyloneighborTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_table_set(s : BiophyloneighborTable, i : Int, v : Double) -> BiophyloneighborTable {
  let result = bio_phylo_neighbor_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_table_sum(s : BiophyloneighborTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_table_mean(s : BiophyloneighborTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_table_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_table_scale(s : BiophyloneighborTable, f : Double) -> BiophyloneighborTable {
  let result = bio_phylo_neighbor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_table_add(a : BiophyloneighborTable, b : BiophyloneighborTable) -> BiophyloneighborTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_table_copy(s : BiophyloneighborTable) -> BiophyloneighborTable {
  let result = bio_phylo_neighbor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_table_fill(s : BiophyloneighborTable, v : Double) -> BiophyloneighborTable {
  let result = bio_phylo_neighbor_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_table_min(s : BiophyloneighborTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_table_max(s : BiophyloneighborTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_table_to_string(s : BiophyloneighborTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_graphn_make(size : Int) -> BiophyloneighborGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_graphn_len(s : BiophyloneighborGraphN) -> Int { s.size }

pub fn bio_phylo_neighbor_graphn_get(s : BiophyloneighborGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_graphn_set(s : BiophyloneighborGraphN, i : Int, v : Double) -> BiophyloneighborGraphN {
  let result = bio_phylo_neighbor_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_graphn_sum(s : BiophyloneighborGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_graphn_mean(s : BiophyloneighborGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_graphn_scale(s : BiophyloneighborGraphN, f : Double) -> BiophyloneighborGraphN {
  let result = bio_phylo_neighbor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_graphn_add(a : BiophyloneighborGraphN, b : BiophyloneighborGraphN) -> BiophyloneighborGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_graphn_copy(s : BiophyloneighborGraphN) -> BiophyloneighborGraphN {
  let result = bio_phylo_neighbor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_graphn_fill(s : BiophyloneighborGraphN, v : Double) -> BiophyloneighborGraphN {
  let result = bio_phylo_neighbor_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_graphn_min(s : BiophyloneighborGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_graphn_max(s : BiophyloneighborGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_graphn_to_string(s : BiophyloneighborGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_node_make(size : Int) -> BiophyloneighborNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_node_len(s : BiophyloneighborNode) -> Int { s.size }

pub fn bio_phylo_neighbor_node_get(s : BiophyloneighborNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_node_set(s : BiophyloneighborNode, i : Int, v : Double) -> BiophyloneighborNode {
  let result = bio_phylo_neighbor_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_node_sum(s : BiophyloneighborNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_node_mean(s : BiophyloneighborNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_node_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_node_scale(s : BiophyloneighborNode, f : Double) -> BiophyloneighborNode {
  let result = bio_phylo_neighbor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_node_add(a : BiophyloneighborNode, b : BiophyloneighborNode) -> BiophyloneighborNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_node_copy(s : BiophyloneighborNode) -> BiophyloneighborNode {
  let result = bio_phylo_neighbor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_node_fill(s : BiophyloneighborNode, v : Double) -> BiophyloneighborNode {
  let result = bio_phylo_neighbor_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_node_min(s : BiophyloneighborNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_node_max(s : BiophyloneighborNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_node_to_string(s : BiophyloneighborNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_edge_make(size : Int) -> BiophyloneighborEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_edge_len(s : BiophyloneighborEdge) -> Int { s.size }

pub fn bio_phylo_neighbor_edge_get(s : BiophyloneighborEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_edge_set(s : BiophyloneighborEdge, i : Int, v : Double) -> BiophyloneighborEdge {
  let result = bio_phylo_neighbor_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_edge_sum(s : BiophyloneighborEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_edge_mean(s : BiophyloneighborEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_edge_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_edge_scale(s : BiophyloneighborEdge, f : Double) -> BiophyloneighborEdge {
  let result = bio_phylo_neighbor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_edge_add(a : BiophyloneighborEdge, b : BiophyloneighborEdge) -> BiophyloneighborEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_edge_copy(s : BiophyloneighborEdge) -> BiophyloneighborEdge {
  let result = bio_phylo_neighbor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_edge_fill(s : BiophyloneighborEdge, v : Double) -> BiophyloneighborEdge {
  let result = bio_phylo_neighbor_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_edge_min(s : BiophyloneighborEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_edge_max(s : BiophyloneighborEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_edge_to_string(s : BiophyloneighborEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_path_make(size : Int) -> BiophyloneighborPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_path_len(s : BiophyloneighborPath) -> Int { s.size }

pub fn bio_phylo_neighbor_path_get(s : BiophyloneighborPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_path_set(s : BiophyloneighborPath, i : Int, v : Double) -> BiophyloneighborPath {
  let result = bio_phylo_neighbor_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_path_sum(s : BiophyloneighborPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_path_mean(s : BiophyloneighborPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_path_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_path_scale(s : BiophyloneighborPath, f : Double) -> BiophyloneighborPath {
  let result = bio_phylo_neighbor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_path_add(a : BiophyloneighborPath, b : BiophyloneighborPath) -> BiophyloneighborPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_path_copy(s : BiophyloneighborPath) -> BiophyloneighborPath {
  let result = bio_phylo_neighbor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_path_fill(s : BiophyloneighborPath, v : Double) -> BiophyloneighborPath {
  let result = bio_phylo_neighbor_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_path_min(s : BiophyloneighborPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_path_max(s : BiophyloneighborPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_path_to_string(s : BiophyloneighborPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_cluster_make(size : Int) -> BiophyloneighborCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_cluster_len(s : BiophyloneighborCluster) -> Int { s.size }

pub fn bio_phylo_neighbor_cluster_get(s : BiophyloneighborCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_cluster_set(s : BiophyloneighborCluster, i : Int, v : Double) -> BiophyloneighborCluster {
  let result = bio_phylo_neighbor_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_cluster_sum(s : BiophyloneighborCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_cluster_mean(s : BiophyloneighborCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_cluster_scale(s : BiophyloneighborCluster, f : Double) -> BiophyloneighborCluster {
  let result = bio_phylo_neighbor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_cluster_add(a : BiophyloneighborCluster, b : BiophyloneighborCluster) -> BiophyloneighborCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_cluster_copy(s : BiophyloneighborCluster) -> BiophyloneighborCluster {
  let result = bio_phylo_neighbor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_cluster_fill(s : BiophyloneighborCluster, v : Double) -> BiophyloneighborCluster {
  let result = bio_phylo_neighbor_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_cluster_min(s : BiophyloneighborCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_cluster_max(s : BiophyloneighborCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_cluster_to_string(s : BiophyloneighborCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_model_make(size : Int) -> BiophyloneighborModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_model_len(s : BiophyloneighborModel) -> Int { s.size }

pub fn bio_phylo_neighbor_model_get(s : BiophyloneighborModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_model_set(s : BiophyloneighborModel, i : Int, v : Double) -> BiophyloneighborModel {
  let result = bio_phylo_neighbor_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_model_sum(s : BiophyloneighborModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_model_mean(s : BiophyloneighborModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_model_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_model_scale(s : BiophyloneighborModel, f : Double) -> BiophyloneighborModel {
  let result = bio_phylo_neighbor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_model_add(a : BiophyloneighborModel, b : BiophyloneighborModel) -> BiophyloneighborModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_model_copy(s : BiophyloneighborModel) -> BiophyloneighborModel {
  let result = bio_phylo_neighbor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_model_fill(s : BiophyloneighborModel, v : Double) -> BiophyloneighborModel {
  let result = bio_phylo_neighbor_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_model_min(s : BiophyloneighborModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_model_max(s : BiophyloneighborModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_model_to_string(s : BiophyloneighborModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_layer_make(size : Int) -> BiophyloneighborLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_layer_len(s : BiophyloneighborLayer) -> Int { s.size }

pub fn bio_phylo_neighbor_layer_get(s : BiophyloneighborLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_layer_set(s : BiophyloneighborLayer, i : Int, v : Double) -> BiophyloneighborLayer {
  let result = bio_phylo_neighbor_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_layer_sum(s : BiophyloneighborLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_layer_mean(s : BiophyloneighborLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_layer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_layer_scale(s : BiophyloneighborLayer, f : Double) -> BiophyloneighborLayer {
  let result = bio_phylo_neighbor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_layer_add(a : BiophyloneighborLayer, b : BiophyloneighborLayer) -> BiophyloneighborLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_layer_copy(s : BiophyloneighborLayer) -> BiophyloneighborLayer {
  let result = bio_phylo_neighbor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_layer_fill(s : BiophyloneighborLayer, v : Double) -> BiophyloneighborLayer {
  let result = bio_phylo_neighbor_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_layer_min(s : BiophyloneighborLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_layer_max(s : BiophyloneighborLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_layer_to_string(s : BiophyloneighborLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_buffer_make(size : Int) -> BiophyloneighborBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_buffer_len(s : BiophyloneighborBuffer) -> Int { s.size }

pub fn bio_phylo_neighbor_buffer_get(s : BiophyloneighborBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_buffer_set(s : BiophyloneighborBuffer, i : Int, v : Double) -> BiophyloneighborBuffer {
  let result = bio_phylo_neighbor_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_buffer_sum(s : BiophyloneighborBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_buffer_mean(s : BiophyloneighborBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_buffer_scale(s : BiophyloneighborBuffer, f : Double) -> BiophyloneighborBuffer {
  let result = bio_phylo_neighbor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_buffer_add(a : BiophyloneighborBuffer, b : BiophyloneighborBuffer) -> BiophyloneighborBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_buffer_copy(s : BiophyloneighborBuffer) -> BiophyloneighborBuffer {
  let result = bio_phylo_neighbor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_buffer_fill(s : BiophyloneighborBuffer, v : Double) -> BiophyloneighborBuffer {
  let result = bio_phylo_neighbor_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_buffer_min(s : BiophyloneighborBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_buffer_max(s : BiophyloneighborBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_buffer_to_string(s : BiophyloneighborBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_cursor_make(size : Int) -> BiophyloneighborCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_cursor_len(s : BiophyloneighborCursor) -> Int { s.size }

pub fn bio_phylo_neighbor_cursor_get(s : BiophyloneighborCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_cursor_set(s : BiophyloneighborCursor, i : Int, v : Double) -> BiophyloneighborCursor {
  let result = bio_phylo_neighbor_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_cursor_sum(s : BiophyloneighborCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_cursor_mean(s : BiophyloneighborCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_cursor_scale(s : BiophyloneighborCursor, f : Double) -> BiophyloneighborCursor {
  let result = bio_phylo_neighbor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_cursor_add(a : BiophyloneighborCursor, b : BiophyloneighborCursor) -> BiophyloneighborCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_cursor_copy(s : BiophyloneighborCursor) -> BiophyloneighborCursor {
  let result = bio_phylo_neighbor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_cursor_fill(s : BiophyloneighborCursor, v : Double) -> BiophyloneighborCursor {
  let result = bio_phylo_neighbor_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_cursor_min(s : BiophyloneighborCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_cursor_max(s : BiophyloneighborCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_cursor_to_string(s : BiophyloneighborCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_view_make(size : Int) -> BiophyloneighborView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_view_len(s : BiophyloneighborView) -> Int { s.size }

pub fn bio_phylo_neighbor_view_get(s : BiophyloneighborView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_view_set(s : BiophyloneighborView, i : Int, v : Double) -> BiophyloneighborView {
  let result = bio_phylo_neighbor_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_view_sum(s : BiophyloneighborView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_view_mean(s : BiophyloneighborView) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_view_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_view_scale(s : BiophyloneighborView, f : Double) -> BiophyloneighborView {
  let result = bio_phylo_neighbor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_view_add(a : BiophyloneighborView, b : BiophyloneighborView) -> BiophyloneighborView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_view_copy(s : BiophyloneighborView) -> BiophyloneighborView {
  let result = bio_phylo_neighbor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_view_fill(s : BiophyloneighborView, v : Double) -> BiophyloneighborView {
  let result = bio_phylo_neighbor_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_view_min(s : BiophyloneighborView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_view_max(s : BiophyloneighborView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_view_to_string(s : BiophyloneighborView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_range_make(size : Int) -> BiophyloneighborRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_range_len(s : BiophyloneighborRange) -> Int { s.size }

pub fn bio_phylo_neighbor_range_get(s : BiophyloneighborRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_range_set(s : BiophyloneighborRange, i : Int, v : Double) -> BiophyloneighborRange {
  let result = bio_phylo_neighbor_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_range_sum(s : BiophyloneighborRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_range_mean(s : BiophyloneighborRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_range_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_range_scale(s : BiophyloneighborRange, f : Double) -> BiophyloneighborRange {
  let result = bio_phylo_neighbor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_range_add(a : BiophyloneighborRange, b : BiophyloneighborRange) -> BiophyloneighborRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_range_copy(s : BiophyloneighborRange) -> BiophyloneighborRange {
  let result = bio_phylo_neighbor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_range_fill(s : BiophyloneighborRange, v : Double) -> BiophyloneighborRange {
  let result = bio_phylo_neighbor_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_range_min(s : BiophyloneighborRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_range_max(s : BiophyloneighborRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_range_to_string(s : BiophyloneighborRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloneighborSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_neighbor_slice_make(size : Int) -> BiophyloneighborSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_neighbor_slice_len(s : BiophyloneighborSlice) -> Int { s.size }

pub fn bio_phylo_neighbor_slice_get(s : BiophyloneighborSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_neighbor_slice_set(s : BiophyloneighborSlice, i : Int, v : Double) -> BiophyloneighborSlice {
  let result = bio_phylo_neighbor_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_slice_sum(s : BiophyloneighborSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_neighbor_slice_mean(s : BiophyloneighborSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_neighbor_slice_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_neighbor_slice_scale(s : BiophyloneighborSlice, f : Double) -> BiophyloneighborSlice {
  let result = bio_phylo_neighbor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_neighbor_slice_add(a : BiophyloneighborSlice, b : BiophyloneighborSlice) -> BiophyloneighborSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_neighbor_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_neighbor_slice_copy(s : BiophyloneighborSlice) -> BiophyloneighborSlice {
  let result = bio_phylo_neighbor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_neighbor_slice_fill(s : BiophyloneighborSlice, v : Double) -> BiophyloneighborSlice {
  let result = bio_phylo_neighbor_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_neighbor_slice_min(s : BiophyloneighborSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_slice_max(s : BiophyloneighborSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_neighbor_slice_to_string(s : BiophyloneighborSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn bio_phylo_neighbor_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_neighbor_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

