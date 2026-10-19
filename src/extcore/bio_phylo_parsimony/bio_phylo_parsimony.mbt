///===
/// extcore/bio_phylo_parsimony

pub(all) struct BiophyloparsimonyPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_parsimony_make_point(x : Double, y : Double) -> BiophyloparsimonyPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_parsimony_make_point3(x : Double, y : Double, z : Double) -> BiophyloparsimonyPoint {
  { x, y, z, label: 0 }
}

pub fn bio_phylo_parsimony_point_x(pt : BiophyloparsimonyPoint) -> Double { pt.x }

pub fn bio_phylo_parsimony_point_y(pt : BiophyloparsimonyPoint) -> Double { pt.y }

pub fn bio_phylo_parsimony_point_z(pt : BiophyloparsimonyPoint) -> Double { pt.z }

pub fn bio_phylo_parsimony_point_label(pt : BiophyloparsimonyPoint) -> Int { pt.label }

pub fn bio_phylo_parsimony_point_dist(a : BiophyloparsimonyPoint, b : BiophyloparsimonyPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  bio_phylo_parsimony_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_phylo_parsimony_point_add(a : BiophyloparsimonyPoint, b : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_phylo_parsimony_point_sub(a : BiophyloparsimonyPoint, b : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_phylo_parsimony_point_scale(pt : BiophyloparsimonyPoint, s : Double) -> BiophyloparsimonyPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_phylo_parsimony_point_dot(a : BiophyloparsimonyPoint, b : BiophyloparsimonyPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_phylo_parsimony_point_cross(a : BiophyloparsimonyPoint, b : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_phylo_parsimony_point_norm(pt : BiophyloparsimonyPoint) -> Double {
  bio_phylo_parsimony_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_phylo_parsimony_point_normalize(pt : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  let n = bio_phylo_parsimony_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_phylo_parsimony_point_scale(pt, 1.0 / n) }
}

pub fn bio_phylo_parsimony_point_negate(pt : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_phylo_parsimony_point_mid(a : BiophyloparsimonyPoint, b : BiophyloparsimonyPoint) -> BiophyloparsimonyPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_phylo_parsimony_point_lerp(a : BiophyloparsimonyPoint, b : BiophyloparsimonyPoint, t : Double) -> BiophyloparsimonyPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_phylo_parsimony_point_to_string(pt : BiophyloparsimonyPoint) -> String {
  "(" + bio_phylo_parsimony_dbl(pt.x) + ", " + bio_phylo_parsimony_dbl(pt.y) + ", " + bio_phylo_parsimony_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiophyloparsimonySeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_parsimony_make_series(vals : Array[Double], name : String) -> BiophyloparsimonySeries {
  { vals, name, meta: 0 }
}

pub fn bio_phylo_parsimony_series_len(s : BiophyloparsimonySeries) -> Int { s.vals.length() }

pub fn bio_phylo_parsimony_series_sum(s : BiophyloparsimonySeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_phylo_parsimony_series_mean(s : BiophyloparsimonySeries) -> Double {
  let n = bio_phylo_parsimony_series_len(s)
  if n == 0 { 0.0 } else { bio_phylo_parsimony_series_sum(s) / n.to_double() }
}

pub fn bio_phylo_parsimony_series_min(s : BiophyloparsimonySeries) -> Double {
  let n = bio_phylo_parsimony_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_series_max(s : BiophyloparsimonySeries) -> Double {
  let n = bio_phylo_parsimony_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_series_range(s : BiophyloparsimonySeries) -> Double {
  bio_phylo_parsimony_series_max(s) - bio_phylo_parsimony_series_min(s)
}

pub fn bio_phylo_parsimony_series_var(s : BiophyloparsimonySeries) -> Double {
  let n = bio_phylo_parsimony_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_phylo_parsimony_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_phylo_parsimony_series_std(s : BiophyloparsimonySeries) -> Double { bio_phylo_parsimony_sqrt(bio_phylo_parsimony_series_var(s)) }

pub fn bio_phylo_parsimony_series_median(s : BiophyloparsimonySeries) -> Double {
  let n = bio_phylo_parsimony_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_phylo_parsimony_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_phylo_parsimony_series_scale(s : BiophyloparsimonySeries, f : Double) -> BiophyloparsimonySeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = bio_phylo_parsimony_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_phylo_parsimony_series_add(a : BiophyloparsimonySeries, b : BiophyloparsimonySeries) -> BiophyloparsimonySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_phylo_parsimony_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_phylo_parsimony_series_sub(a : BiophyloparsimonySeries, b : BiophyloparsimonySeries) -> BiophyloparsimonySeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = bio_phylo_parsimony_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_phylo_parsimony_series_normalize(s : BiophyloparsimonySeries) -> BiophyloparsimonySeries {
  let mn = bio_phylo_parsimony_series_min(s)
  let mx = bio_phylo_parsimony_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = bio_phylo_parsimony_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_phylo_parsimony_series_cumsum(s : BiophyloparsimonySeries) -> BiophyloparsimonySeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = bio_phylo_parsimony_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_phylo_parsimony_series_to_string(s : BiophyloparsimonySeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_phylo_parsimony_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophyloparsimonyMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_parsimony_make_matrix(rows : Int, cols : Int, val : Double) -> BiophyloparsimonyMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_parsimony_matrix_identity(n : Int) -> BiophyloparsimonyMatrix {
  let m = bio_phylo_parsimony_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_phylo_parsimony_matrix_get(m : BiophyloparsimonyMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_phylo_parsimony_matrix_transpose(m : BiophyloparsimonyMatrix) -> BiophyloparsimonyMatrix {
  let result = bio_phylo_parsimony_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_phylo_parsimony_matrix_add(a : BiophyloparsimonyMatrix, b : BiophyloparsimonyMatrix) -> BiophyloparsimonyMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_phylo_parsimony_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_phylo_parsimony_matrix_scale(m : BiophyloparsimonyMatrix, s : Double) -> BiophyloparsimonyMatrix {
  let result = bio_phylo_parsimony_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_phylo_parsimony_matrix_multiply(a : BiophyloparsimonyMatrix, b : BiophyloparsimonyMatrix) -> BiophyloparsimonyMatrix {
  if a.cols != b.rows { return bio_phylo_parsimony_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_phylo_parsimony_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_phylo_parsimony_matrix_trace(m : BiophyloparsimonyMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_phylo_parsimony_matrix_det(m : BiophyloparsimonyMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_phylo_parsimony_matrix_norm(m : BiophyloparsimonyMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  bio_phylo_parsimony_sqrt(sum)
}

pub fn bio_phylo_parsimony_matrix_to_string(m : BiophyloparsimonyMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + bio_phylo_parsimony_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct BiophyloparsimonyVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_parsimony_make_vector(comps : Array[Double]) -> BiophyloparsimonyVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_parsimony_vector_zero(dim : Int) -> BiophyloparsimonyVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_phylo_parsimony_vector_add(a : BiophyloparsimonyVector, b : BiophyloparsimonyVector) -> BiophyloparsimonyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_phylo_parsimony_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_parsimony_vector_sub(a : BiophyloparsimonyVector, b : BiophyloparsimonyVector) -> BiophyloparsimonyVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = bio_phylo_parsimony_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_parsimony_vector_scale(v : BiophyloparsimonyVector, s : Double) -> BiophyloparsimonyVector {
  let mut result = []
  for i in 0..<v.dim { result = bio_phylo_parsimony_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_phylo_parsimony_vector_dot(a : BiophyloparsimonyVector, b : BiophyloparsimonyVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_phylo_parsimony_vector_norm(v : BiophyloparsimonyVector) -> Double { bio_phylo_parsimony_sqrt(bio_phylo_parsimony_vector_dot(v, v)) }

pub fn bio_phylo_parsimony_vector_normalize(v : BiophyloparsimonyVector) -> BiophyloparsimonyVector {
  let n = bio_phylo_parsimony_vector_norm(v)
  if n < 0.0000001 { v } else { bio_phylo_parsimony_vector_scale(v, 1.0 / n) }
}

pub fn bio_phylo_parsimony_vector_dist(a : BiophyloparsimonyVector, b : BiophyloparsimonyVector) -> Double {
  bio_phylo_parsimony_vector_norm(bio_phylo_parsimony_vector_sub(a, b))
}

pub fn bio_phylo_parsimony_vector_to_string(v : BiophyloparsimonyVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + bio_phylo_parsimony_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_parsimony_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_phylo_parsimony_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_phylo_parsimony_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_phylo_parsimony_std(data : Array[Double]) -> Double { bio_phylo_parsimony_sqrt(bio_phylo_parsimony_var(data)) }

pub fn bio_phylo_parsimony_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_phylo_parsimony_mean(a); let mb = bio_phylo_parsimony_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_phylo_parsimony_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_phylo_parsimony_std(a); let sb = bio_phylo_parsimony_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_phylo_parsimony_cov(a, b) / (sa * sb) }
}

pub fn bio_phylo_parsimony_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_phylo_parsimony_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_phylo_parsimony_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_phylo_parsimony_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_phylo_parsimony_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  bio_phylo_parsimony_sqrt(bio_phylo_parsimony_mse(pred, labels))
}

pub fn bio_phylo_parsimony_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + bio_phylo_parsimony_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_phylo_parsimony_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_phylo_parsimony_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_phylo_parsimony_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_phylo_parsimony_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_phylo_parsimony_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_phylo_parsimony_precision(pred, labels, pos); let r = bio_phylo_parsimony_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_phylo_parsimony_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_phylo_parsimony_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_phylo_parsimony_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_phylo_parsimony_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_phylo_parsimony_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_phylo_parsimony_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_phylo_parsimony_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_phylo_parsimony_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_phylo_parsimony_fibonacci(n : Int) -> Int {
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

pub fn bio_phylo_parsimony_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_phylo_parsimony_min(data); let mx = bio_phylo_parsimony_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_phylo_parsimony_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_phylo_parsimony_mean(data); let sd = bio_phylo_parsimony_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_phylo_parsimony_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_phylo_parsimony_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_phylo_parsimony_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_phylo_parsimony_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn bio_phylo_parsimony_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn bio_phylo_parsimony_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn bio_phylo_parsimony_dbl(x : Double) -> String {
  let i = if x >= 0.0 { bio_phylo_parsimony_int(x) } else { -bio_phylo_parsimony_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { bio_phylo_parsimony_int(f * 1000000.0) } else { bio_phylo_parsimony_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn bio_phylo_parsimony_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn bio_phylo_parsimony_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct BiophyloparsimonyFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_frame_make(size : Int) -> BiophyloparsimonyFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_frame_len(s : BiophyloparsimonyFrame) -> Int { s.size }

pub fn bio_phylo_parsimony_frame_get(s : BiophyloparsimonyFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_frame_set(s : BiophyloparsimonyFrame, i : Int, v : Double) -> BiophyloparsimonyFrame {
  let result = bio_phylo_parsimony_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_frame_sum(s : BiophyloparsimonyFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_frame_mean(s : BiophyloparsimonyFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_frame_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_frame_scale(s : BiophyloparsimonyFrame, f : Double) -> BiophyloparsimonyFrame {
  let result = bio_phylo_parsimony_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_frame_add(a : BiophyloparsimonyFrame, b : BiophyloparsimonyFrame) -> BiophyloparsimonyFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_frame_copy(s : BiophyloparsimonyFrame) -> BiophyloparsimonyFrame {
  let result = bio_phylo_parsimony_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_frame_fill(s : BiophyloparsimonyFrame, v : Double) -> BiophyloparsimonyFrame {
  let result = bio_phylo_parsimony_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_frame_min(s : BiophyloparsimonyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_frame_max(s : BiophyloparsimonyFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_frame_to_string(s : BiophyloparsimonyFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_table_make(size : Int) -> BiophyloparsimonyTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_table_len(s : BiophyloparsimonyTable) -> Int { s.size }

pub fn bio_phylo_parsimony_table_get(s : BiophyloparsimonyTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_table_set(s : BiophyloparsimonyTable, i : Int, v : Double) -> BiophyloparsimonyTable {
  let result = bio_phylo_parsimony_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_table_sum(s : BiophyloparsimonyTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_table_mean(s : BiophyloparsimonyTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_table_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_table_scale(s : BiophyloparsimonyTable, f : Double) -> BiophyloparsimonyTable {
  let result = bio_phylo_parsimony_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_table_add(a : BiophyloparsimonyTable, b : BiophyloparsimonyTable) -> BiophyloparsimonyTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_table_copy(s : BiophyloparsimonyTable) -> BiophyloparsimonyTable {
  let result = bio_phylo_parsimony_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_table_fill(s : BiophyloparsimonyTable, v : Double) -> BiophyloparsimonyTable {
  let result = bio_phylo_parsimony_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_table_min(s : BiophyloparsimonyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_table_max(s : BiophyloparsimonyTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_table_to_string(s : BiophyloparsimonyTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_graphn_make(size : Int) -> BiophyloparsimonyGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_graphn_len(s : BiophyloparsimonyGraphN) -> Int { s.size }

pub fn bio_phylo_parsimony_graphn_get(s : BiophyloparsimonyGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_graphn_set(s : BiophyloparsimonyGraphN, i : Int, v : Double) -> BiophyloparsimonyGraphN {
  let result = bio_phylo_parsimony_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_graphn_sum(s : BiophyloparsimonyGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_graphn_mean(s : BiophyloparsimonyGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_graphn_scale(s : BiophyloparsimonyGraphN, f : Double) -> BiophyloparsimonyGraphN {
  let result = bio_phylo_parsimony_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_graphn_add(a : BiophyloparsimonyGraphN, b : BiophyloparsimonyGraphN) -> BiophyloparsimonyGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_graphn_copy(s : BiophyloparsimonyGraphN) -> BiophyloparsimonyGraphN {
  let result = bio_phylo_parsimony_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_graphn_fill(s : BiophyloparsimonyGraphN, v : Double) -> BiophyloparsimonyGraphN {
  let result = bio_phylo_parsimony_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_graphn_min(s : BiophyloparsimonyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_graphn_max(s : BiophyloparsimonyGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_graphn_to_string(s : BiophyloparsimonyGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_node_make(size : Int) -> BiophyloparsimonyNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_node_len(s : BiophyloparsimonyNode) -> Int { s.size }

pub fn bio_phylo_parsimony_node_get(s : BiophyloparsimonyNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_node_set(s : BiophyloparsimonyNode, i : Int, v : Double) -> BiophyloparsimonyNode {
  let result = bio_phylo_parsimony_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_node_sum(s : BiophyloparsimonyNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_node_mean(s : BiophyloparsimonyNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_node_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_node_scale(s : BiophyloparsimonyNode, f : Double) -> BiophyloparsimonyNode {
  let result = bio_phylo_parsimony_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_node_add(a : BiophyloparsimonyNode, b : BiophyloparsimonyNode) -> BiophyloparsimonyNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_node_copy(s : BiophyloparsimonyNode) -> BiophyloparsimonyNode {
  let result = bio_phylo_parsimony_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_node_fill(s : BiophyloparsimonyNode, v : Double) -> BiophyloparsimonyNode {
  let result = bio_phylo_parsimony_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_node_min(s : BiophyloparsimonyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_node_max(s : BiophyloparsimonyNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_node_to_string(s : BiophyloparsimonyNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_edge_make(size : Int) -> BiophyloparsimonyEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_edge_len(s : BiophyloparsimonyEdge) -> Int { s.size }

pub fn bio_phylo_parsimony_edge_get(s : BiophyloparsimonyEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_edge_set(s : BiophyloparsimonyEdge, i : Int, v : Double) -> BiophyloparsimonyEdge {
  let result = bio_phylo_parsimony_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_edge_sum(s : BiophyloparsimonyEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_edge_mean(s : BiophyloparsimonyEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_edge_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_edge_scale(s : BiophyloparsimonyEdge, f : Double) -> BiophyloparsimonyEdge {
  let result = bio_phylo_parsimony_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_edge_add(a : BiophyloparsimonyEdge, b : BiophyloparsimonyEdge) -> BiophyloparsimonyEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_edge_copy(s : BiophyloparsimonyEdge) -> BiophyloparsimonyEdge {
  let result = bio_phylo_parsimony_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_edge_fill(s : BiophyloparsimonyEdge, v : Double) -> BiophyloparsimonyEdge {
  let result = bio_phylo_parsimony_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_edge_min(s : BiophyloparsimonyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_edge_max(s : BiophyloparsimonyEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_edge_to_string(s : BiophyloparsimonyEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_path_make(size : Int) -> BiophyloparsimonyPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_path_len(s : BiophyloparsimonyPath) -> Int { s.size }

pub fn bio_phylo_parsimony_path_get(s : BiophyloparsimonyPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_path_set(s : BiophyloparsimonyPath, i : Int, v : Double) -> BiophyloparsimonyPath {
  let result = bio_phylo_parsimony_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_path_sum(s : BiophyloparsimonyPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_path_mean(s : BiophyloparsimonyPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_path_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_path_scale(s : BiophyloparsimonyPath, f : Double) -> BiophyloparsimonyPath {
  let result = bio_phylo_parsimony_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_path_add(a : BiophyloparsimonyPath, b : BiophyloparsimonyPath) -> BiophyloparsimonyPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_path_copy(s : BiophyloparsimonyPath) -> BiophyloparsimonyPath {
  let result = bio_phylo_parsimony_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_path_fill(s : BiophyloparsimonyPath, v : Double) -> BiophyloparsimonyPath {
  let result = bio_phylo_parsimony_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_path_min(s : BiophyloparsimonyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_path_max(s : BiophyloparsimonyPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_path_to_string(s : BiophyloparsimonyPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_cluster_make(size : Int) -> BiophyloparsimonyCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_cluster_len(s : BiophyloparsimonyCluster) -> Int { s.size }

pub fn bio_phylo_parsimony_cluster_get(s : BiophyloparsimonyCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_cluster_set(s : BiophyloparsimonyCluster, i : Int, v : Double) -> BiophyloparsimonyCluster {
  let result = bio_phylo_parsimony_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_cluster_sum(s : BiophyloparsimonyCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_cluster_mean(s : BiophyloparsimonyCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_cluster_scale(s : BiophyloparsimonyCluster, f : Double) -> BiophyloparsimonyCluster {
  let result = bio_phylo_parsimony_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_cluster_add(a : BiophyloparsimonyCluster, b : BiophyloparsimonyCluster) -> BiophyloparsimonyCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_cluster_copy(s : BiophyloparsimonyCluster) -> BiophyloparsimonyCluster {
  let result = bio_phylo_parsimony_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_cluster_fill(s : BiophyloparsimonyCluster, v : Double) -> BiophyloparsimonyCluster {
  let result = bio_phylo_parsimony_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_cluster_min(s : BiophyloparsimonyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_cluster_max(s : BiophyloparsimonyCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_cluster_to_string(s : BiophyloparsimonyCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_model_make(size : Int) -> BiophyloparsimonyModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_model_len(s : BiophyloparsimonyModel) -> Int { s.size }

pub fn bio_phylo_parsimony_model_get(s : BiophyloparsimonyModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_model_set(s : BiophyloparsimonyModel, i : Int, v : Double) -> BiophyloparsimonyModel {
  let result = bio_phylo_parsimony_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_model_sum(s : BiophyloparsimonyModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_model_mean(s : BiophyloparsimonyModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_model_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_model_scale(s : BiophyloparsimonyModel, f : Double) -> BiophyloparsimonyModel {
  let result = bio_phylo_parsimony_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_model_add(a : BiophyloparsimonyModel, b : BiophyloparsimonyModel) -> BiophyloparsimonyModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_model_copy(s : BiophyloparsimonyModel) -> BiophyloparsimonyModel {
  let result = bio_phylo_parsimony_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_model_fill(s : BiophyloparsimonyModel, v : Double) -> BiophyloparsimonyModel {
  let result = bio_phylo_parsimony_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_model_min(s : BiophyloparsimonyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_model_max(s : BiophyloparsimonyModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_model_to_string(s : BiophyloparsimonyModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_layer_make(size : Int) -> BiophyloparsimonyLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_layer_len(s : BiophyloparsimonyLayer) -> Int { s.size }

pub fn bio_phylo_parsimony_layer_get(s : BiophyloparsimonyLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_layer_set(s : BiophyloparsimonyLayer, i : Int, v : Double) -> BiophyloparsimonyLayer {
  let result = bio_phylo_parsimony_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_layer_sum(s : BiophyloparsimonyLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_layer_mean(s : BiophyloparsimonyLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_layer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_layer_scale(s : BiophyloparsimonyLayer, f : Double) -> BiophyloparsimonyLayer {
  let result = bio_phylo_parsimony_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_layer_add(a : BiophyloparsimonyLayer, b : BiophyloparsimonyLayer) -> BiophyloparsimonyLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_layer_copy(s : BiophyloparsimonyLayer) -> BiophyloparsimonyLayer {
  let result = bio_phylo_parsimony_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_layer_fill(s : BiophyloparsimonyLayer, v : Double) -> BiophyloparsimonyLayer {
  let result = bio_phylo_parsimony_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_layer_min(s : BiophyloparsimonyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_layer_max(s : BiophyloparsimonyLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_layer_to_string(s : BiophyloparsimonyLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_buffer_make(size : Int) -> BiophyloparsimonyBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_buffer_len(s : BiophyloparsimonyBuffer) -> Int { s.size }

pub fn bio_phylo_parsimony_buffer_get(s : BiophyloparsimonyBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_buffer_set(s : BiophyloparsimonyBuffer, i : Int, v : Double) -> BiophyloparsimonyBuffer {
  let result = bio_phylo_parsimony_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_buffer_sum(s : BiophyloparsimonyBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_buffer_mean(s : BiophyloparsimonyBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_buffer_scale(s : BiophyloparsimonyBuffer, f : Double) -> BiophyloparsimonyBuffer {
  let result = bio_phylo_parsimony_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_buffer_add(a : BiophyloparsimonyBuffer, b : BiophyloparsimonyBuffer) -> BiophyloparsimonyBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_buffer_copy(s : BiophyloparsimonyBuffer) -> BiophyloparsimonyBuffer {
  let result = bio_phylo_parsimony_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_buffer_fill(s : BiophyloparsimonyBuffer, v : Double) -> BiophyloparsimonyBuffer {
  let result = bio_phylo_parsimony_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_buffer_min(s : BiophyloparsimonyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_buffer_max(s : BiophyloparsimonyBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_buffer_to_string(s : BiophyloparsimonyBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_cursor_make(size : Int) -> BiophyloparsimonyCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_cursor_len(s : BiophyloparsimonyCursor) -> Int { s.size }

pub fn bio_phylo_parsimony_cursor_get(s : BiophyloparsimonyCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_cursor_set(s : BiophyloparsimonyCursor, i : Int, v : Double) -> BiophyloparsimonyCursor {
  let result = bio_phylo_parsimony_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_cursor_sum(s : BiophyloparsimonyCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_cursor_mean(s : BiophyloparsimonyCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_cursor_scale(s : BiophyloparsimonyCursor, f : Double) -> BiophyloparsimonyCursor {
  let result = bio_phylo_parsimony_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_cursor_add(a : BiophyloparsimonyCursor, b : BiophyloparsimonyCursor) -> BiophyloparsimonyCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_cursor_copy(s : BiophyloparsimonyCursor) -> BiophyloparsimonyCursor {
  let result = bio_phylo_parsimony_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_cursor_fill(s : BiophyloparsimonyCursor, v : Double) -> BiophyloparsimonyCursor {
  let result = bio_phylo_parsimony_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_cursor_min(s : BiophyloparsimonyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_cursor_max(s : BiophyloparsimonyCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_cursor_to_string(s : BiophyloparsimonyCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_view_make(size : Int) -> BiophyloparsimonyView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_view_len(s : BiophyloparsimonyView) -> Int { s.size }

pub fn bio_phylo_parsimony_view_get(s : BiophyloparsimonyView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_view_set(s : BiophyloparsimonyView, i : Int, v : Double) -> BiophyloparsimonyView {
  let result = bio_phylo_parsimony_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_view_sum(s : BiophyloparsimonyView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_view_mean(s : BiophyloparsimonyView) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_view_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_view_scale(s : BiophyloparsimonyView, f : Double) -> BiophyloparsimonyView {
  let result = bio_phylo_parsimony_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_view_add(a : BiophyloparsimonyView, b : BiophyloparsimonyView) -> BiophyloparsimonyView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_view_copy(s : BiophyloparsimonyView) -> BiophyloparsimonyView {
  let result = bio_phylo_parsimony_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_view_fill(s : BiophyloparsimonyView, v : Double) -> BiophyloparsimonyView {
  let result = bio_phylo_parsimony_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_view_min(s : BiophyloparsimonyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_view_max(s : BiophyloparsimonyView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_view_to_string(s : BiophyloparsimonyView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonyRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_range_make(size : Int) -> BiophyloparsimonyRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_range_len(s : BiophyloparsimonyRange) -> Int { s.size }

pub fn bio_phylo_parsimony_range_get(s : BiophyloparsimonyRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_range_set(s : BiophyloparsimonyRange, i : Int, v : Double) -> BiophyloparsimonyRange {
  let result = bio_phylo_parsimony_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_range_sum(s : BiophyloparsimonyRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_range_mean(s : BiophyloparsimonyRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_range_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_range_scale(s : BiophyloparsimonyRange, f : Double) -> BiophyloparsimonyRange {
  let result = bio_phylo_parsimony_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_range_add(a : BiophyloparsimonyRange, b : BiophyloparsimonyRange) -> BiophyloparsimonyRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_range_copy(s : BiophyloparsimonyRange) -> BiophyloparsimonyRange {
  let result = bio_phylo_parsimony_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_range_fill(s : BiophyloparsimonyRange, v : Double) -> BiophyloparsimonyRange {
  let result = bio_phylo_parsimony_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_range_min(s : BiophyloparsimonyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_range_max(s : BiophyloparsimonyRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_range_to_string(s : BiophyloparsimonyRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophyloparsimonySlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_parsimony_slice_make(size : Int) -> BiophyloparsimonySlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_parsimony_slice_len(s : BiophyloparsimonySlice) -> Int { s.size }

pub fn bio_phylo_parsimony_slice_get(s : BiophyloparsimonySlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_parsimony_slice_set(s : BiophyloparsimonySlice, i : Int, v : Double) -> BiophyloparsimonySlice {
  let result = bio_phylo_parsimony_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_slice_sum(s : BiophyloparsimonySlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_parsimony_slice_mean(s : BiophyloparsimonySlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_parsimony_slice_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_parsimony_slice_scale(s : BiophyloparsimonySlice, f : Double) -> BiophyloparsimonySlice {
  let result = bio_phylo_parsimony_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_parsimony_slice_add(a : BiophyloparsimonySlice, b : BiophyloparsimonySlice) -> BiophyloparsimonySlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_parsimony_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_parsimony_slice_copy(s : BiophyloparsimonySlice) -> BiophyloparsimonySlice {
  let result = bio_phylo_parsimony_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_parsimony_slice_fill(s : BiophyloparsimonySlice, v : Double) -> BiophyloparsimonySlice {
  let result = bio_phylo_parsimony_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_parsimony_slice_min(s : BiophyloparsimonySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_slice_max(s : BiophyloparsimonySlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_parsimony_slice_to_string(s : BiophyloparsimonySlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn bio_phylo_parsimony_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn bio_phylo_parsimony_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

