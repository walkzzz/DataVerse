///===
/// extcore/bio_phylo_consensus

pub(all) struct BiophyloconsensusPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_consensus_make_point(x : Double, y : Double) -> BiophyloconsensusPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_consensus_make_point3(x : Double, y : Double, z : Double) -> BiophyloconsensusPoint {
  { x, y, z, label: 0 }
}

pub fn bio_phylo_consensus_point_x(pt : BiophyloconsensusPoint) -> Double { pt.x }

pub fn bio_phylo_consensus_point_y(pt : BiophyloconsensusPoint) -> Double { pt.y }

pub fn bio_phylo_consensus_point_z(pt : BiophyloconsensusPoint) -> Double { pt.z }

pub fn bio_phylo_consensus_point_label(pt : BiophyloconsensusPoint) -> Int { pt.label }

pub fn bio_phylo_consensus_point_dist(a : BiophyloconsensusPoint, b : BiophyloconsensusPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  bio_phylo_consensus_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_phylo_consensus_point_add(a : BiophyloconsensusPoint, b : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_phylo_consensus_point_sub(a : BiophyloconsensusPoint, b : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_phylo_consensus_point_scale(pt : BiophyloconsensusPoint, s : Double) -> BiophyloconsensusPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_phylo_consensus_point_dot(a : BiophyloconsensusPoint, b : BiophyloconsensusPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_phylo_consensus_point_cross(a : BiophyloconsensusPoint, b : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_phylo_consensus_point_norm(pt : BiophyloconsensusPoint) -> Double {
  bio_phylo_consensus_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_phylo_consensus_point_normalize(pt : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  let n = bio_phylo_consensus_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_phylo_consensus_point_scale(pt, 1.0 / n) }
}

pub fn bio_phylo_consensus_point_negate(pt : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_phylo_consensus_point_mid(a : BiophyloconsensusPoint, b : BiophyloconsensusPoint) -> BiophyloconsensusPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_phylo_consensus_point_lerp(a : BiophyloconsensusPoint, b : BiophyloconsensusPoint, t : Double) -> BiophyloconsensusPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_phylo_consensus_point_to_string(pt : BiophyloconsensusPoint) -> String {
  "(" + bio_phylo_consensus_dbl(pt.x) + ", " + bio_phylo_consensus_dbl(pt.y) + ", " + bio_phylo_consensus_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiophyloconsensusSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_consensus_make_series(vals : Array[Double], name : String) -> BiophyloconsensusSeries {
  { vals, name, meta: 0 }
}

pub fn bio_phylo_consensus_series_len(s : BiophyloconsensusSeries) -> Int { s.vals.length() }

pub fn bio_phylo_consensus_series_sum(s : BiophyloconsensusSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_phylo_consensus_series_mean(s : BiophyloconsensusSeries) -> Double {
  let n = bio_phylo_consensus_series_len(s)
  if n == 0 { 0.0 } else { bio_phylo_consensus_series_sum(s) / n.to_double() }
}

pub fn bio_phylo_consensus_series_min(s : BiophyloconsensusSeries) -> Double {
  let n = bio_phylo_consensus_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_consensus_series_max(s : BiophyloconsensusSeries) -> Double {
  let n = bio_phylo_consensus_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_consensus_series_range(s : BiophyloconsensusSeries) -> Double {
  bio_phylo_consensus_series_max(s) - bio_phylo_consensus_series_min(s)
}

pub fn bio_phylo_consensus_series_var(s : BiophyloconsensusSeries) -> Double {
  let n = bio_phylo_consensus_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_phylo_consensus_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_phylo_consensus_series_std(s : BiophyloconsensusSeries) -> Double { bio_phylo_consensus_sqrt(bio_phylo_consensus_series_var(s)) }

pub fn bio_phylo_consensus_series_median(s : BiophyloconsensusSeries) -> Double {
  let n = bio_phylo_consensus_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_phylo_consensus_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_phylo_consensus_series_scale(s : BiophyloconsensusSeries, f : Double) -> BiophyloconsensusSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = bio_phylo_consensus_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_phylo_consensus_series_add(a : BiophyloconsensusSeries, b : BiophyloconsensusSeries) -> BiophyloconsensusSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_phylo_consensus_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_phylo_consensus_series_sub(a : BiophyloconsensusSeries, b : BiophyloconsensusSeries) -> BiophyloconsensusSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_phylo_consensus_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_phylo_consensus_series_normalize(s : BiophyloconsensusSeries) -> BiophyloconsensusSeries {
  let mn = bio_phylo_consensus_series_min(s)
  let mx = bio_phylo_consensus_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = bio_phylo_consensus_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_phylo_consensus_series_cumsum(s : BiophyloconsensusSeries) -> BiophyloconsensusSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = bio_phylo_consensus_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_phylo_consensus_series_to_string(s : BiophyloconsensusSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_phylo_consensus_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloconsensusMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_consensus_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloconsensusMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_consensus_matrix_identity(n : Int) -> BiophyloconsensusMatrix {
  let m = bio_phylo_consensus_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_phylo_consensus_matrix_get(m : BiophyloconsensusMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_phylo_consensus_matrix_transpose(m : BiophyloconsensusMatrix) -> BiophyloconsensusMatrix {
  let result = bio_phylo_consensus_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_phylo_consensus_matrix_add(a : BiophyloconsensusMatrix, b : BiophyloconsensusMatrix) -> BiophyloconsensusMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_phylo_consensus_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_phylo_consensus_matrix_scale(m : BiophyloconsensusMatrix, s : Double) -> BiophyloconsensusMatrix {
  let result = bio_phylo_consensus_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_phylo_consensus_matrix_multiply(a : BiophyloconsensusMatrix, b : BiophyloconsensusMatrix) -> BiophyloconsensusMatrix {
  if a.cols != b.rows { return bio_phylo_consensus_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_phylo_consensus_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_phylo_consensus_matrix_trace(m : BiophyloconsensusMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_phylo_consensus_matrix_det(m : BiophyloconsensusMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_phylo_consensus_matrix_norm(m : BiophyloconsensusMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  bio_phylo_consensus_sqrt(sum)
}

pub fn bio_phylo_consensus_matrix_to_string(m : BiophyloconsensusMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + bio_phylo_consensus_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct BiophyloconsensusVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_consensus_make_vector(comps : Array[Double]) -> BiophyloconsensusVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_consensus_vector_zero(dim : Int) -> BiophyloconsensusVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_phylo_consensus_vector_add(a : BiophyloconsensusVector, b : BiophyloconsensusVector) -> BiophyloconsensusVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_phylo_consensus_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_consensus_vector_sub(a : BiophyloconsensusVector, b : BiophyloconsensusVector) -> BiophyloconsensusVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_phylo_consensus_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_consensus_vector_scale(v : BiophyloconsensusVector, s : Double) -> BiophyloconsensusVector {
  let mut result = []
  for i in 0..<v.dim { result = bio_phylo_consensus_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_phylo_consensus_vector_dot(a : BiophyloconsensusVector, b : BiophyloconsensusVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_phylo_consensus_vector_norm(v : BiophyloconsensusVector) -> Double { bio_phylo_consensus_sqrt(bio_phylo_consensus_vector_dot(v, v)) }

pub fn bio_phylo_consensus_vector_normalize(v : BiophyloconsensusVector) -> BiophyloconsensusVector {
  let n = bio_phylo_consensus_vector_norm(v)
  if n < 0.0000001 { v } else { bio_phylo_consensus_vector_scale(v, 1.0 / n) }
}

pub fn bio_phylo_consensus_vector_dist(a : BiophyloconsensusVector, b : BiophyloconsensusVector) -> Double {
  bio_phylo_consensus_vector_norm(bio_phylo_consensus_vector_sub(a, b))
}

pub fn bio_phylo_consensus_vector_to_string(v : BiophyloconsensusVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_phylo_consensus_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_consensus_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_phylo_consensus_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_phylo_consensus_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_phylo_consensus_std(data : Array[Double]) -> Double { bio_phylo_consensus_sqrt(bio_phylo_consensus_var(data)) }

pub fn bio_phylo_consensus_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_phylo_consensus_mean(a); let mb = bio_phylo_consensus_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_phylo_consensus_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_phylo_consensus_std(a); let sb = bio_phylo_consensus_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_phylo_consensus_cov(a, b) / (sa * sb) }
}

pub fn bio_phylo_consensus_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_phylo_consensus_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_phylo_consensus_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_phylo_consensus_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_phylo_consensus_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  bio_phylo_consensus_sqrt(bio_phylo_consensus_mse(pred, labels))
}

pub fn bio_phylo_consensus_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + bio_phylo_consensus_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_phylo_consensus_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_phylo_consensus_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_phylo_consensus_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_phylo_consensus_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_phylo_consensus_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_phylo_consensus_precision(pred, labels, pos); let r = bio_phylo_consensus_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_phylo_consensus_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_phylo_consensus_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_phylo_consensus_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_phylo_consensus_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_phylo_consensus_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_phylo_consensus_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_phylo_consensus_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_phylo_consensus_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_phylo_consensus_fibonacci(n : Int) -> Int {
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

pub fn bio_phylo_consensus_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_phylo_consensus_min(data); let mx = bio_phylo_consensus_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_phylo_consensus_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_phylo_consensus_mean(data); let sd = bio_phylo_consensus_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_phylo_consensus_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_phylo_consensus_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_phylo_consensus_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_phylo_consensus_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn bio_phylo_consensus_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn bio_phylo_consensus_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn bio_phylo_consensus_dbl(x : Double) -> String {
  let i = if x >= 0.0 { bio_phylo_consensus_int(x) } else { -bio_phylo_consensus_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { bio_phylo_consensus_int(f * 1000000.0) } else { bio_phylo_consensus_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn bio_phylo_consensus_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn bio_phylo_consensus_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct BiophyloconsensusFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_frame_make(size : Int) -> BiophyloconsensusFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_frame_len(s : BiophyloconsensusFrame) -> Int { s.size }

pub fn bio_phylo_consensus_frame_get(s : BiophyloconsensusFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_frame_set(s : BiophyloconsensusFrame, i : Int, v : Double) -> BiophyloconsensusFrame {
  let result = bio_phylo_consensus_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_frame_sum(s : BiophyloconsensusFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_frame_mean(s : BiophyloconsensusFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_frame_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_frame_scale(s : BiophyloconsensusFrame, f : Double) -> BiophyloconsensusFrame {
  let result = bio_phylo_consensus_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_frame_add(a : BiophyloconsensusFrame, b : BiophyloconsensusFrame) -> BiophyloconsensusFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_frame_copy(s : BiophyloconsensusFrame) -> BiophyloconsensusFrame {
  let result = bio_phylo_consensus_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_frame_fill(s : BiophyloconsensusFrame, v : Double) -> BiophyloconsensusFrame {
  let result = bio_phylo_consensus_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_frame_min(s : BiophyloconsensusFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_frame_max(s : BiophyloconsensusFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_frame_to_string(s : BiophyloconsensusFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_table_make(size : Int) -> BiophyloconsensusTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_table_len(s : BiophyloconsensusTable) -> Int { s.size }

pub fn bio_phylo_consensus_table_get(s : BiophyloconsensusTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_table_set(s : BiophyloconsensusTable, i : Int, v : Double) -> BiophyloconsensusTable {
  let result = bio_phylo_consensus_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_table_sum(s : BiophyloconsensusTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_table_mean(s : BiophyloconsensusTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_table_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_table_scale(s : BiophyloconsensusTable, f : Double) -> BiophyloconsensusTable {
  let result = bio_phylo_consensus_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_table_add(a : BiophyloconsensusTable, b : BiophyloconsensusTable) -> BiophyloconsensusTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_table_copy(s : BiophyloconsensusTable) -> BiophyloconsensusTable {
  let result = bio_phylo_consensus_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_table_fill(s : BiophyloconsensusTable, v : Double) -> BiophyloconsensusTable {
  let result = bio_phylo_consensus_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_table_min(s : BiophyloconsensusTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_table_max(s : BiophyloconsensusTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_table_to_string(s : BiophyloconsensusTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_graphn_make(size : Int) -> BiophyloconsensusGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_graphn_len(s : BiophyloconsensusGraphN) -> Int { s.size }

pub fn bio_phylo_consensus_graphn_get(s : BiophyloconsensusGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_graphn_set(s : BiophyloconsensusGraphN, i : Int, v : Double) -> BiophyloconsensusGraphN {
  let result = bio_phylo_consensus_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_graphn_sum(s : BiophyloconsensusGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_graphn_mean(s : BiophyloconsensusGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_graphn_scale(s : BiophyloconsensusGraphN, f : Double) -> BiophyloconsensusGraphN {
  let result = bio_phylo_consensus_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_graphn_add(a : BiophyloconsensusGraphN, b : BiophyloconsensusGraphN) -> BiophyloconsensusGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_graphn_copy(s : BiophyloconsensusGraphN) -> BiophyloconsensusGraphN {
  let result = bio_phylo_consensus_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_graphn_fill(s : BiophyloconsensusGraphN, v : Double) -> BiophyloconsensusGraphN {
  let result = bio_phylo_consensus_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_graphn_min(s : BiophyloconsensusGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_graphn_max(s : BiophyloconsensusGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_graphn_to_string(s : BiophyloconsensusGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_node_make(size : Int) -> BiophyloconsensusNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_node_len(s : BiophyloconsensusNode) -> Int { s.size }

pub fn bio_phylo_consensus_node_get(s : BiophyloconsensusNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_node_set(s : BiophyloconsensusNode, i : Int, v : Double) -> BiophyloconsensusNode {
  let result = bio_phylo_consensus_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_node_sum(s : BiophyloconsensusNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_node_mean(s : BiophyloconsensusNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_node_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_node_scale(s : BiophyloconsensusNode, f : Double) -> BiophyloconsensusNode {
  let result = bio_phylo_consensus_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_node_add(a : BiophyloconsensusNode, b : BiophyloconsensusNode) -> BiophyloconsensusNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_node_copy(s : BiophyloconsensusNode) -> BiophyloconsensusNode {
  let result = bio_phylo_consensus_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_node_fill(s : BiophyloconsensusNode, v : Double) -> BiophyloconsensusNode {
  let result = bio_phylo_consensus_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_node_min(s : BiophyloconsensusNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_node_max(s : BiophyloconsensusNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_node_to_string(s : BiophyloconsensusNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_edge_make(size : Int) -> BiophyloconsensusEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_edge_len(s : BiophyloconsensusEdge) -> Int { s.size }

pub fn bio_phylo_consensus_edge_get(s : BiophyloconsensusEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_edge_set(s : BiophyloconsensusEdge, i : Int, v : Double) -> BiophyloconsensusEdge {
  let result = bio_phylo_consensus_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_edge_sum(s : BiophyloconsensusEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_edge_mean(s : BiophyloconsensusEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_edge_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_edge_scale(s : BiophyloconsensusEdge, f : Double) -> BiophyloconsensusEdge {
  let result = bio_phylo_consensus_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_edge_add(a : BiophyloconsensusEdge, b : BiophyloconsensusEdge) -> BiophyloconsensusEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_edge_copy(s : BiophyloconsensusEdge) -> BiophyloconsensusEdge {
  let result = bio_phylo_consensus_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_edge_fill(s : BiophyloconsensusEdge, v : Double) -> BiophyloconsensusEdge {
  let result = bio_phylo_consensus_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_edge_min(s : BiophyloconsensusEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_edge_max(s : BiophyloconsensusEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_edge_to_string(s : BiophyloconsensusEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_path_make(size : Int) -> BiophyloconsensusPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_path_len(s : BiophyloconsensusPath) -> Int { s.size }

pub fn bio_phylo_consensus_path_get(s : BiophyloconsensusPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_path_set(s : BiophyloconsensusPath, i : Int, v : Double) -> BiophyloconsensusPath {
  let result = bio_phylo_consensus_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_path_sum(s : BiophyloconsensusPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_path_mean(s : BiophyloconsensusPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_path_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_path_scale(s : BiophyloconsensusPath, f : Double) -> BiophyloconsensusPath {
  let result = bio_phylo_consensus_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_path_add(a : BiophyloconsensusPath, b : BiophyloconsensusPath) -> BiophyloconsensusPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_path_copy(s : BiophyloconsensusPath) -> BiophyloconsensusPath {
  let result = bio_phylo_consensus_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_path_fill(s : BiophyloconsensusPath, v : Double) -> BiophyloconsensusPath {
  let result = bio_phylo_consensus_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_path_min(s : BiophyloconsensusPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_path_max(s : BiophyloconsensusPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_path_to_string(s : BiophyloconsensusPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_cluster_make(size : Int) -> BiophyloconsensusCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_cluster_len(s : BiophyloconsensusCluster) -> Int { s.size }

pub fn bio_phylo_consensus_cluster_get(s : BiophyloconsensusCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_cluster_set(s : BiophyloconsensusCluster, i : Int, v : Double) -> BiophyloconsensusCluster {
  let result = bio_phylo_consensus_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_cluster_sum(s : BiophyloconsensusCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_cluster_mean(s : BiophyloconsensusCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_cluster_scale(s : BiophyloconsensusCluster, f : Double) -> BiophyloconsensusCluster {
  let result = bio_phylo_consensus_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_cluster_add(a : BiophyloconsensusCluster, b : BiophyloconsensusCluster) -> BiophyloconsensusCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_cluster_copy(s : BiophyloconsensusCluster) -> BiophyloconsensusCluster {
  let result = bio_phylo_consensus_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_cluster_fill(s : BiophyloconsensusCluster, v : Double) -> BiophyloconsensusCluster {
  let result = bio_phylo_consensus_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_cluster_min(s : BiophyloconsensusCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_cluster_max(s : BiophyloconsensusCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_cluster_to_string(s : BiophyloconsensusCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_model_make(size : Int) -> BiophyloconsensusModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_model_len(s : BiophyloconsensusModel) -> Int { s.size }

pub fn bio_phylo_consensus_model_get(s : BiophyloconsensusModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_model_set(s : BiophyloconsensusModel, i : Int, v : Double) -> BiophyloconsensusModel {
  let result = bio_phylo_consensus_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_model_sum(s : BiophyloconsensusModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_model_mean(s : BiophyloconsensusModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_model_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_model_scale(s : BiophyloconsensusModel, f : Double) -> BiophyloconsensusModel {
  let result = bio_phylo_consensus_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_model_add(a : BiophyloconsensusModel, b : BiophyloconsensusModel) -> BiophyloconsensusModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_model_copy(s : BiophyloconsensusModel) -> BiophyloconsensusModel {
  let result = bio_phylo_consensus_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_model_fill(s : BiophyloconsensusModel, v : Double) -> BiophyloconsensusModel {
  let result = bio_phylo_consensus_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_model_min(s : BiophyloconsensusModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_model_max(s : BiophyloconsensusModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_model_to_string(s : BiophyloconsensusModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_layer_make(size : Int) -> BiophyloconsensusLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_layer_len(s : BiophyloconsensusLayer) -> Int { s.size }

pub fn bio_phylo_consensus_layer_get(s : BiophyloconsensusLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_layer_set(s : BiophyloconsensusLayer, i : Int, v : Double) -> BiophyloconsensusLayer {
  let result = bio_phylo_consensus_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_layer_sum(s : BiophyloconsensusLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_layer_mean(s : BiophyloconsensusLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_layer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_layer_scale(s : BiophyloconsensusLayer, f : Double) -> BiophyloconsensusLayer {
  let result = bio_phylo_consensus_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_layer_add(a : BiophyloconsensusLayer, b : BiophyloconsensusLayer) -> BiophyloconsensusLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_layer_copy(s : BiophyloconsensusLayer) -> BiophyloconsensusLayer {
  let result = bio_phylo_consensus_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_layer_fill(s : BiophyloconsensusLayer, v : Double) -> BiophyloconsensusLayer {
  let result = bio_phylo_consensus_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_layer_min(s : BiophyloconsensusLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_layer_max(s : BiophyloconsensusLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_layer_to_string(s : BiophyloconsensusLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_buffer_make(size : Int) -> BiophyloconsensusBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_buffer_len(s : BiophyloconsensusBuffer) -> Int { s.size }

pub fn bio_phylo_consensus_buffer_get(s : BiophyloconsensusBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_buffer_set(s : BiophyloconsensusBuffer, i : Int, v : Double) -> BiophyloconsensusBuffer {
  let result = bio_phylo_consensus_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_buffer_sum(s : BiophyloconsensusBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_buffer_mean(s : BiophyloconsensusBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_buffer_scale(s : BiophyloconsensusBuffer, f : Double) -> BiophyloconsensusBuffer {
  let result = bio_phylo_consensus_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_buffer_add(a : BiophyloconsensusBuffer, b : BiophyloconsensusBuffer) -> BiophyloconsensusBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_buffer_copy(s : BiophyloconsensusBuffer) -> BiophyloconsensusBuffer {
  let result = bio_phylo_consensus_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_buffer_fill(s : BiophyloconsensusBuffer, v : Double) -> BiophyloconsensusBuffer {
  let result = bio_phylo_consensus_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_buffer_min(s : BiophyloconsensusBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_buffer_max(s : BiophyloconsensusBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_buffer_to_string(s : BiophyloconsensusBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_cursor_make(size : Int) -> BiophyloconsensusCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_cursor_len(s : BiophyloconsensusCursor) -> Int { s.size }

pub fn bio_phylo_consensus_cursor_get(s : BiophyloconsensusCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_cursor_set(s : BiophyloconsensusCursor, i : Int, v : Double) -> BiophyloconsensusCursor {
  let result = bio_phylo_consensus_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_cursor_sum(s : BiophyloconsensusCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_cursor_mean(s : BiophyloconsensusCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_cursor_scale(s : BiophyloconsensusCursor, f : Double) -> BiophyloconsensusCursor {
  let result = bio_phylo_consensus_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_cursor_add(a : BiophyloconsensusCursor, b : BiophyloconsensusCursor) -> BiophyloconsensusCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_cursor_copy(s : BiophyloconsensusCursor) -> BiophyloconsensusCursor {
  let result = bio_phylo_consensus_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_cursor_fill(s : BiophyloconsensusCursor, v : Double) -> BiophyloconsensusCursor {
  let result = bio_phylo_consensus_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_cursor_min(s : BiophyloconsensusCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_cursor_max(s : BiophyloconsensusCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_cursor_to_string(s : BiophyloconsensusCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_view_make(size : Int) -> BiophyloconsensusView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_view_len(s : BiophyloconsensusView) -> Int { s.size }

pub fn bio_phylo_consensus_view_get(s : BiophyloconsensusView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_view_set(s : BiophyloconsensusView, i : Int, v : Double) -> BiophyloconsensusView {
  let result = bio_phylo_consensus_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_view_sum(s : BiophyloconsensusView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_view_mean(s : BiophyloconsensusView) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_view_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_view_scale(s : BiophyloconsensusView, f : Double) -> BiophyloconsensusView {
  let result = bio_phylo_consensus_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_view_add(a : BiophyloconsensusView, b : BiophyloconsensusView) -> BiophyloconsensusView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_view_copy(s : BiophyloconsensusView) -> BiophyloconsensusView {
  let result = bio_phylo_consensus_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_view_fill(s : BiophyloconsensusView, v : Double) -> BiophyloconsensusView {
  let result = bio_phylo_consensus_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_view_min(s : BiophyloconsensusView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_view_max(s : BiophyloconsensusView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_view_to_string(s : BiophyloconsensusView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_range_make(size : Int) -> BiophyloconsensusRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_range_len(s : BiophyloconsensusRange) -> Int { s.size }

pub fn bio_phylo_consensus_range_get(s : BiophyloconsensusRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_range_set(s : BiophyloconsensusRange, i : Int, v : Double) -> BiophyloconsensusRange {
  let result = bio_phylo_consensus_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_range_sum(s : BiophyloconsensusRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_range_mean(s : BiophyloconsensusRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_range_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_range_scale(s : BiophyloconsensusRange, f : Double) -> BiophyloconsensusRange {
  let result = bio_phylo_consensus_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_range_add(a : BiophyloconsensusRange, b : BiophyloconsensusRange) -> BiophyloconsensusRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_range_copy(s : BiophyloconsensusRange) -> BiophyloconsensusRange {
  let result = bio_phylo_consensus_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_range_fill(s : BiophyloconsensusRange, v : Double) -> BiophyloconsensusRange {
  let result = bio_phylo_consensus_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_range_min(s : BiophyloconsensusRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_range_max(s : BiophyloconsensusRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_range_to_string(s : BiophyloconsensusRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloconsensusSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_consensus_slice_make(size : Int) -> BiophyloconsensusSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_consensus_slice_len(s : BiophyloconsensusSlice) -> Int { s.size }

pub fn bio_phylo_consensus_slice_get(s : BiophyloconsensusSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_consensus_slice_set(s : BiophyloconsensusSlice, i : Int, v : Double) -> BiophyloconsensusSlice {
  let result = bio_phylo_consensus_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_slice_sum(s : BiophyloconsensusSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_consensus_slice_mean(s : BiophyloconsensusSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_consensus_slice_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_consensus_slice_scale(s : BiophyloconsensusSlice, f : Double) -> BiophyloconsensusSlice {
  let result = bio_phylo_consensus_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_consensus_slice_add(a : BiophyloconsensusSlice, b : BiophyloconsensusSlice) -> BiophyloconsensusSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_consensus_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_consensus_slice_copy(s : BiophyloconsensusSlice) -> BiophyloconsensusSlice {
  let result = bio_phylo_consensus_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_consensus_slice_fill(s : BiophyloconsensusSlice, v : Double) -> BiophyloconsensusSlice {
  let result = bio_phylo_consensus_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_consensus_slice_min(s : BiophyloconsensusSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_slice_max(s : BiophyloconsensusSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_consensus_slice_to_string(s : BiophyloconsensusSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn bio_phylo_consensus_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_consensus_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

