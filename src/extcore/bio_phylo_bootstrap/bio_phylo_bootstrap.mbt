///===
/// extcore/bio_phylo_bootstrap

pub(all) struct BiophylobootstrapPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_phylo_bootstrap_make_point(x : Double, y : Double) -> BiophylobootstrapPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_phylo_bootstrap_make_point3(x : Double, y : Double, z : Double) -> BiophylobootstrapPoint {
  { x, y, z, label: 0 }
}

pub fn bio_phylo_bootstrap_point_x(pt : BiophylobootstrapPoint) -> Double { pt.x }

pub fn bio_phylo_bootstrap_point_y(pt : BiophylobootstrapPoint) -> Double { pt.y }

pub fn bio_phylo_bootstrap_point_z(pt : BiophylobootstrapPoint) -> Double { pt.z }

pub fn bio_phylo_bootstrap_point_label(pt : BiophylobootstrapPoint) -> Int { pt.label }

pub fn bio_phylo_bootstrap_point_dist(a : BiophylobootstrapPoint, b : BiophylobootstrapPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_phylo_bootstrap_point_add(a : BiophylobootstrapPoint, b : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_phylo_bootstrap_point_sub(a : BiophylobootstrapPoint, b : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_phylo_bootstrap_point_scale(pt : BiophylobootstrapPoint, s : Double) -> BiophylobootstrapPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_phylo_bootstrap_point_dot(a : BiophylobootstrapPoint, b : BiophylobootstrapPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_phylo_bootstrap_point_cross(a : BiophylobootstrapPoint, b : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_phylo_bootstrap_point_norm(pt : BiophylobootstrapPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_phylo_bootstrap_point_normalize(pt : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  let n = bio_phylo_bootstrap_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_phylo_bootstrap_point_scale(pt, 1.0 / n) }
}

pub fn bio_phylo_bootstrap_point_negate(pt : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_phylo_bootstrap_point_mid(a : BiophylobootstrapPoint, b : BiophylobootstrapPoint) -> BiophylobootstrapPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_phylo_bootstrap_point_lerp(a : BiophylobootstrapPoint, b : BiophylobootstrapPoint, t : Double) -> BiophylobootstrapPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_phylo_bootstrap_point_to_string(pt : BiophylobootstrapPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BiophylobootstrapSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_phylo_bootstrap_make_series(vals : Array[Double], name : String) -> BiophylobootstrapSeries {
  { vals, name, meta: 0 }
}

pub fn bio_phylo_bootstrap_series_len(s : BiophylobootstrapSeries) -> Int { s.vals.length() }

pub fn bio_phylo_bootstrap_series_sum(s : BiophylobootstrapSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_phylo_bootstrap_series_mean(s : BiophylobootstrapSeries) -> Double {
  let n = bio_phylo_bootstrap_series_len(s)
  if n == 0 { 0.0 } else { bio_phylo_bootstrap_series_sum(s) / n.to_double() }
}

pub fn bio_phylo_bootstrap_series_min(s : BiophylobootstrapSeries) -> Double {
  let n = bio_phylo_bootstrap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_series_max(s : BiophylobootstrapSeries) -> Double {
  let n = bio_phylo_bootstrap_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_series_range(s : BiophylobootstrapSeries) -> Double {
  bio_phylo_bootstrap_series_max(s) - bio_phylo_bootstrap_series_min(s)
}

pub fn bio_phylo_bootstrap_series_var(s : BiophylobootstrapSeries) -> Double {
  let n = bio_phylo_bootstrap_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_phylo_bootstrap_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_phylo_bootstrap_series_std(s : BiophylobootstrapSeries) -> Double { @_common.sqrt(bio_phylo_bootstrap_series_var(s)) }

pub fn bio_phylo_bootstrap_series_median(s : BiophylobootstrapSeries) -> Double {
  let n = bio_phylo_bootstrap_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_phylo_bootstrap_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_phylo_bootstrap_series_scale(s : BiophylobootstrapSeries, f : Double) -> BiophylobootstrapSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_phylo_bootstrap_series_add(a : BiophylobootstrapSeries, b : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_phylo_bootstrap_series_sub(a : BiophylobootstrapSeries, b : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_phylo_bootstrap_series_normalize(s : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  let mn = bio_phylo_bootstrap_series_min(s)
  let mx = bio_phylo_bootstrap_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_phylo_bootstrap_series_cumsum(s : BiophylobootstrapSeries) -> BiophylobootstrapSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_phylo_bootstrap_series_to_string(s : BiophylobootstrapSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BiophylobootstrapMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_phylo_bootstrap_make_matrix(rows : Int, cols : Int, val : Double) -> BiophylobootstrapMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_phylo_bootstrap_matrix_identity(n : Int) -> BiophylobootstrapMatrix {
  let m = bio_phylo_bootstrap_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_phylo_bootstrap_matrix_get(m : BiophylobootstrapMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_phylo_bootstrap_matrix_transpose(m : BiophylobootstrapMatrix) -> BiophylobootstrapMatrix {
  let result = bio_phylo_bootstrap_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_phylo_bootstrap_matrix_add(a : BiophylobootstrapMatrix, b : BiophylobootstrapMatrix) -> BiophylobootstrapMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_phylo_bootstrap_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_phylo_bootstrap_matrix_scale(m : BiophylobootstrapMatrix, s : Double) -> BiophylobootstrapMatrix {
  let result = bio_phylo_bootstrap_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_phylo_bootstrap_matrix_multiply(a : BiophylobootstrapMatrix, b : BiophylobootstrapMatrix) -> BiophylobootstrapMatrix {
  if a.cols != b.rows { return bio_phylo_bootstrap_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_phylo_bootstrap_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_phylo_bootstrap_matrix_trace(m : BiophylobootstrapMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_phylo_bootstrap_matrix_det(m : BiophylobootstrapMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_phylo_bootstrap_matrix_norm(m : BiophylobootstrapMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_phylo_bootstrap_matrix_to_string(m : BiophylobootstrapMatrix) -> String {
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

pub(all) struct BiophylobootstrapVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_phylo_bootstrap_make_vector(comps : Array[Double]) -> BiophylobootstrapVector {
  { comps, dim: comps.length() }
}

pub fn bio_phylo_bootstrap_vector_zero(dim : Int) -> BiophylobootstrapVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_phylo_bootstrap_vector_add(a : BiophylobootstrapVector, b : BiophylobootstrapVector) -> BiophylobootstrapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_bootstrap_vector_sub(a : BiophylobootstrapVector, b : BiophylobootstrapVector) -> BiophylobootstrapVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_phylo_bootstrap_vector_scale(v : BiophylobootstrapVector, s : Double) -> BiophylobootstrapVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_phylo_bootstrap_vector_dot(a : BiophylobootstrapVector, b : BiophylobootstrapVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_phylo_bootstrap_vector_norm(v : BiophylobootstrapVector) -> Double { @_common.sqrt(bio_phylo_bootstrap_vector_dot(v, v)) }

pub fn bio_phylo_bootstrap_vector_normalize(v : BiophylobootstrapVector) -> BiophylobootstrapVector {
  let n = bio_phylo_bootstrap_vector_norm(v)
  if n < 0.0000001 { v } else { bio_phylo_bootstrap_vector_scale(v, 1.0 / n) }
}

pub fn bio_phylo_bootstrap_vector_dist(a : BiophylobootstrapVector, b : BiophylobootstrapVector) -> Double {
  bio_phylo_bootstrap_vector_norm(bio_phylo_bootstrap_vector_sub(a, b))
}

pub fn bio_phylo_bootstrap_vector_to_string(v : BiophylobootstrapVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_phylo_bootstrap_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_phylo_bootstrap_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_phylo_bootstrap_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_phylo_bootstrap_std(data : Array[Double]) -> Double { @_common.sqrt(bio_phylo_bootstrap_var(data)) }

pub fn bio_phylo_bootstrap_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_phylo_bootstrap_mean(a); let mb = bio_phylo_bootstrap_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_phylo_bootstrap_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_phylo_bootstrap_std(a); let sb = bio_phylo_bootstrap_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_phylo_bootstrap_cov(a, b) / (sa * sb) }
}

pub fn bio_phylo_bootstrap_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_phylo_bootstrap_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_phylo_bootstrap_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_phylo_bootstrap_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_phylo_bootstrap_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(bio_phylo_bootstrap_mse(pred, labels))
}

pub fn bio_phylo_bootstrap_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_phylo_bootstrap_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_phylo_bootstrap_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_phylo_bootstrap_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_phylo_bootstrap_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_phylo_bootstrap_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_phylo_bootstrap_precision(pred, labels, pos); let r = bio_phylo_bootstrap_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_phylo_bootstrap_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_phylo_bootstrap_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_phylo_bootstrap_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_phylo_bootstrap_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_phylo_bootstrap_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_phylo_bootstrap_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_phylo_bootstrap_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_phylo_bootstrap_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_phylo_bootstrap_fibonacci(n : Int) -> Int {
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

pub fn bio_phylo_bootstrap_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_phylo_bootstrap_min(data); let mx = bio_phylo_bootstrap_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_phylo_bootstrap_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_phylo_bootstrap_mean(data); let sd = bio_phylo_bootstrap_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_phylo_bootstrap_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_phylo_bootstrap_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_phylo_bootstrap_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_phylo_bootstrap_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct BiophylobootstrapFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_frame_make(size : Int) -> BiophylobootstrapFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_frame_len(s : BiophylobootstrapFrame) -> Int { s.size }

pub fn bio_phylo_bootstrap_frame_get(s : BiophylobootstrapFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_frame_set(s : BiophylobootstrapFrame, i : Int, v : Double) -> BiophylobootstrapFrame {
  let result = bio_phylo_bootstrap_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_frame_sum(s : BiophylobootstrapFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_frame_mean(s : BiophylobootstrapFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_frame_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_frame_scale(s : BiophylobootstrapFrame, f : Double) -> BiophylobootstrapFrame {
  let result = bio_phylo_bootstrap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_frame_add(a : BiophylobootstrapFrame, b : BiophylobootstrapFrame) -> BiophylobootstrapFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_frame_copy(s : BiophylobootstrapFrame) -> BiophylobootstrapFrame {
  let result = bio_phylo_bootstrap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_frame_fill(s : BiophylobootstrapFrame, v : Double) -> BiophylobootstrapFrame {
  let result = bio_phylo_bootstrap_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_frame_min(s : BiophylobootstrapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_frame_max(s : BiophylobootstrapFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_frame_to_string(s : BiophylobootstrapFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_table_make(size : Int) -> BiophylobootstrapTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_table_len(s : BiophylobootstrapTable) -> Int { s.size }

pub fn bio_phylo_bootstrap_table_get(s : BiophylobootstrapTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_table_set(s : BiophylobootstrapTable, i : Int, v : Double) -> BiophylobootstrapTable {
  let result = bio_phylo_bootstrap_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_table_sum(s : BiophylobootstrapTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_table_mean(s : BiophylobootstrapTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_table_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_table_scale(s : BiophylobootstrapTable, f : Double) -> BiophylobootstrapTable {
  let result = bio_phylo_bootstrap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_table_add(a : BiophylobootstrapTable, b : BiophylobootstrapTable) -> BiophylobootstrapTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_table_copy(s : BiophylobootstrapTable) -> BiophylobootstrapTable {
  let result = bio_phylo_bootstrap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_table_fill(s : BiophylobootstrapTable, v : Double) -> BiophylobootstrapTable {
  let result = bio_phylo_bootstrap_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_table_min(s : BiophylobootstrapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_table_max(s : BiophylobootstrapTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_table_to_string(s : BiophylobootstrapTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_graphn_make(size : Int) -> BiophylobootstrapGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_graphn_len(s : BiophylobootstrapGraphN) -> Int { s.size }

pub fn bio_phylo_bootstrap_graphn_get(s : BiophylobootstrapGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_graphn_set(s : BiophylobootstrapGraphN, i : Int, v : Double) -> BiophylobootstrapGraphN {
  let result = bio_phylo_bootstrap_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_graphn_sum(s : BiophylobootstrapGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_graphn_mean(s : BiophylobootstrapGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_graphn_scale(s : BiophylobootstrapGraphN, f : Double) -> BiophylobootstrapGraphN {
  let result = bio_phylo_bootstrap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_graphn_add(a : BiophylobootstrapGraphN, b : BiophylobootstrapGraphN) -> BiophylobootstrapGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_graphn_copy(s : BiophylobootstrapGraphN) -> BiophylobootstrapGraphN {
  let result = bio_phylo_bootstrap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_graphn_fill(s : BiophylobootstrapGraphN, v : Double) -> BiophylobootstrapGraphN {
  let result = bio_phylo_bootstrap_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_graphn_min(s : BiophylobootstrapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_graphn_max(s : BiophylobootstrapGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_graphn_to_string(s : BiophylobootstrapGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_node_make(size : Int) -> BiophylobootstrapNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_node_len(s : BiophylobootstrapNode) -> Int { s.size }

pub fn bio_phylo_bootstrap_node_get(s : BiophylobootstrapNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_node_set(s : BiophylobootstrapNode, i : Int, v : Double) -> BiophylobootstrapNode {
  let result = bio_phylo_bootstrap_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_node_sum(s : BiophylobootstrapNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_node_mean(s : BiophylobootstrapNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_node_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_node_scale(s : BiophylobootstrapNode, f : Double) -> BiophylobootstrapNode {
  let result = bio_phylo_bootstrap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_node_add(a : BiophylobootstrapNode, b : BiophylobootstrapNode) -> BiophylobootstrapNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_node_copy(s : BiophylobootstrapNode) -> BiophylobootstrapNode {
  let result = bio_phylo_bootstrap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_node_fill(s : BiophylobootstrapNode, v : Double) -> BiophylobootstrapNode {
  let result = bio_phylo_bootstrap_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_node_min(s : BiophylobootstrapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_node_max(s : BiophylobootstrapNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_node_to_string(s : BiophylobootstrapNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_edge_make(size : Int) -> BiophylobootstrapEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_edge_len(s : BiophylobootstrapEdge) -> Int { s.size }

pub fn bio_phylo_bootstrap_edge_get(s : BiophylobootstrapEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_edge_set(s : BiophylobootstrapEdge, i : Int, v : Double) -> BiophylobootstrapEdge {
  let result = bio_phylo_bootstrap_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_edge_sum(s : BiophylobootstrapEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_edge_mean(s : BiophylobootstrapEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_edge_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_edge_scale(s : BiophylobootstrapEdge, f : Double) -> BiophylobootstrapEdge {
  let result = bio_phylo_bootstrap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_edge_add(a : BiophylobootstrapEdge, b : BiophylobootstrapEdge) -> BiophylobootstrapEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_edge_copy(s : BiophylobootstrapEdge) -> BiophylobootstrapEdge {
  let result = bio_phylo_bootstrap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_edge_fill(s : BiophylobootstrapEdge, v : Double) -> BiophylobootstrapEdge {
  let result = bio_phylo_bootstrap_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_edge_min(s : BiophylobootstrapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_edge_max(s : BiophylobootstrapEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_edge_to_string(s : BiophylobootstrapEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_path_make(size : Int) -> BiophylobootstrapPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_path_len(s : BiophylobootstrapPath) -> Int { s.size }

pub fn bio_phylo_bootstrap_path_get(s : BiophylobootstrapPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_path_set(s : BiophylobootstrapPath, i : Int, v : Double) -> BiophylobootstrapPath {
  let result = bio_phylo_bootstrap_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_path_sum(s : BiophylobootstrapPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_path_mean(s : BiophylobootstrapPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_path_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_path_scale(s : BiophylobootstrapPath, f : Double) -> BiophylobootstrapPath {
  let result = bio_phylo_bootstrap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_path_add(a : BiophylobootstrapPath, b : BiophylobootstrapPath) -> BiophylobootstrapPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_path_copy(s : BiophylobootstrapPath) -> BiophylobootstrapPath {
  let result = bio_phylo_bootstrap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_path_fill(s : BiophylobootstrapPath, v : Double) -> BiophylobootstrapPath {
  let result = bio_phylo_bootstrap_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_path_min(s : BiophylobootstrapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_path_max(s : BiophylobootstrapPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_path_to_string(s : BiophylobootstrapPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_cluster_make(size : Int) -> BiophylobootstrapCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_cluster_len(s : BiophylobootstrapCluster) -> Int { s.size }

pub fn bio_phylo_bootstrap_cluster_get(s : BiophylobootstrapCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_cluster_set(s : BiophylobootstrapCluster, i : Int, v : Double) -> BiophylobootstrapCluster {
  let result = bio_phylo_bootstrap_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_cluster_sum(s : BiophylobootstrapCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_cluster_mean(s : BiophylobootstrapCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_cluster_scale(s : BiophylobootstrapCluster, f : Double) -> BiophylobootstrapCluster {
  let result = bio_phylo_bootstrap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_cluster_add(a : BiophylobootstrapCluster, b : BiophylobootstrapCluster) -> BiophylobootstrapCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_cluster_copy(s : BiophylobootstrapCluster) -> BiophylobootstrapCluster {
  let result = bio_phylo_bootstrap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_cluster_fill(s : BiophylobootstrapCluster, v : Double) -> BiophylobootstrapCluster {
  let result = bio_phylo_bootstrap_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_cluster_min(s : BiophylobootstrapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_cluster_max(s : BiophylobootstrapCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_cluster_to_string(s : BiophylobootstrapCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_model_make(size : Int) -> BiophylobootstrapModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_model_len(s : BiophylobootstrapModel) -> Int { s.size }

pub fn bio_phylo_bootstrap_model_get(s : BiophylobootstrapModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_model_set(s : BiophylobootstrapModel, i : Int, v : Double) -> BiophylobootstrapModel {
  let result = bio_phylo_bootstrap_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_model_sum(s : BiophylobootstrapModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_model_mean(s : BiophylobootstrapModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_model_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_model_scale(s : BiophylobootstrapModel, f : Double) -> BiophylobootstrapModel {
  let result = bio_phylo_bootstrap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_model_add(a : BiophylobootstrapModel, b : BiophylobootstrapModel) -> BiophylobootstrapModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_model_copy(s : BiophylobootstrapModel) -> BiophylobootstrapModel {
  let result = bio_phylo_bootstrap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_model_fill(s : BiophylobootstrapModel, v : Double) -> BiophylobootstrapModel {
  let result = bio_phylo_bootstrap_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_model_min(s : BiophylobootstrapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_model_max(s : BiophylobootstrapModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_model_to_string(s : BiophylobootstrapModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_layer_make(size : Int) -> BiophylobootstrapLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_layer_len(s : BiophylobootstrapLayer) -> Int { s.size }

pub fn bio_phylo_bootstrap_layer_get(s : BiophylobootstrapLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_layer_set(s : BiophylobootstrapLayer, i : Int, v : Double) -> BiophylobootstrapLayer {
  let result = bio_phylo_bootstrap_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_layer_sum(s : BiophylobootstrapLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_layer_mean(s : BiophylobootstrapLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_layer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_layer_scale(s : BiophylobootstrapLayer, f : Double) -> BiophylobootstrapLayer {
  let result = bio_phylo_bootstrap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_layer_add(a : BiophylobootstrapLayer, b : BiophylobootstrapLayer) -> BiophylobootstrapLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_layer_copy(s : BiophylobootstrapLayer) -> BiophylobootstrapLayer {
  let result = bio_phylo_bootstrap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_layer_fill(s : BiophylobootstrapLayer, v : Double) -> BiophylobootstrapLayer {
  let result = bio_phylo_bootstrap_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_layer_min(s : BiophylobootstrapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_layer_max(s : BiophylobootstrapLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_layer_to_string(s : BiophylobootstrapLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_buffer_make(size : Int) -> BiophylobootstrapBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_buffer_len(s : BiophylobootstrapBuffer) -> Int { s.size }

pub fn bio_phylo_bootstrap_buffer_get(s : BiophylobootstrapBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_buffer_set(s : BiophylobootstrapBuffer, i : Int, v : Double) -> BiophylobootstrapBuffer {
  let result = bio_phylo_bootstrap_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_buffer_sum(s : BiophylobootstrapBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_buffer_mean(s : BiophylobootstrapBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_buffer_scale(s : BiophylobootstrapBuffer, f : Double) -> BiophylobootstrapBuffer {
  let result = bio_phylo_bootstrap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_buffer_add(a : BiophylobootstrapBuffer, b : BiophylobootstrapBuffer) -> BiophylobootstrapBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_buffer_copy(s : BiophylobootstrapBuffer) -> BiophylobootstrapBuffer {
  let result = bio_phylo_bootstrap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_buffer_fill(s : BiophylobootstrapBuffer, v : Double) -> BiophylobootstrapBuffer {
  let result = bio_phylo_bootstrap_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_buffer_min(s : BiophylobootstrapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_buffer_max(s : BiophylobootstrapBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_buffer_to_string(s : BiophylobootstrapBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_cursor_make(size : Int) -> BiophylobootstrapCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_cursor_len(s : BiophylobootstrapCursor) -> Int { s.size }

pub fn bio_phylo_bootstrap_cursor_get(s : BiophylobootstrapCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_cursor_set(s : BiophylobootstrapCursor, i : Int, v : Double) -> BiophylobootstrapCursor {
  let result = bio_phylo_bootstrap_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_cursor_sum(s : BiophylobootstrapCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_cursor_mean(s : BiophylobootstrapCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_cursor_scale(s : BiophylobootstrapCursor, f : Double) -> BiophylobootstrapCursor {
  let result = bio_phylo_bootstrap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_cursor_add(a : BiophylobootstrapCursor, b : BiophylobootstrapCursor) -> BiophylobootstrapCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_cursor_copy(s : BiophylobootstrapCursor) -> BiophylobootstrapCursor {
  let result = bio_phylo_bootstrap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_cursor_fill(s : BiophylobootstrapCursor, v : Double) -> BiophylobootstrapCursor {
  let result = bio_phylo_bootstrap_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_cursor_min(s : BiophylobootstrapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_cursor_max(s : BiophylobootstrapCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_cursor_to_string(s : BiophylobootstrapCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_view_make(size : Int) -> BiophylobootstrapView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_view_len(s : BiophylobootstrapView) -> Int { s.size }

pub fn bio_phylo_bootstrap_view_get(s : BiophylobootstrapView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_view_set(s : BiophylobootstrapView, i : Int, v : Double) -> BiophylobootstrapView {
  let result = bio_phylo_bootstrap_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_view_sum(s : BiophylobootstrapView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_view_mean(s : BiophylobootstrapView) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_view_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_view_scale(s : BiophylobootstrapView, f : Double) -> BiophylobootstrapView {
  let result = bio_phylo_bootstrap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_view_add(a : BiophylobootstrapView, b : BiophylobootstrapView) -> BiophylobootstrapView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_view_copy(s : BiophylobootstrapView) -> BiophylobootstrapView {
  let result = bio_phylo_bootstrap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_view_fill(s : BiophylobootstrapView, v : Double) -> BiophylobootstrapView {
  let result = bio_phylo_bootstrap_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_view_min(s : BiophylobootstrapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_view_max(s : BiophylobootstrapView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_view_to_string(s : BiophylobootstrapView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_range_make(size : Int) -> BiophylobootstrapRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_range_len(s : BiophylobootstrapRange) -> Int { s.size }

pub fn bio_phylo_bootstrap_range_get(s : BiophylobootstrapRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_range_set(s : BiophylobootstrapRange, i : Int, v : Double) -> BiophylobootstrapRange {
  let result = bio_phylo_bootstrap_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_range_sum(s : BiophylobootstrapRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_range_mean(s : BiophylobootstrapRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_range_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_range_scale(s : BiophylobootstrapRange, f : Double) -> BiophylobootstrapRange {
  let result = bio_phylo_bootstrap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_range_add(a : BiophylobootstrapRange, b : BiophylobootstrapRange) -> BiophylobootstrapRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_range_copy(s : BiophylobootstrapRange) -> BiophylobootstrapRange {
  let result = bio_phylo_bootstrap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_range_fill(s : BiophylobootstrapRange, v : Double) -> BiophylobootstrapRange {
  let result = bio_phylo_bootstrap_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_range_min(s : BiophylobootstrapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_range_max(s : BiophylobootstrapRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_range_to_string(s : BiophylobootstrapRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BiophylobootstrapSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_phylo_bootstrap_slice_make(size : Int) -> BiophylobootstrapSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_phylo_bootstrap_slice_len(s : BiophylobootstrapSlice) -> Int { s.size }

pub fn bio_phylo_bootstrap_slice_get(s : BiophylobootstrapSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_phylo_bootstrap_slice_set(s : BiophylobootstrapSlice, i : Int, v : Double) -> BiophylobootstrapSlice {
  let result = bio_phylo_bootstrap_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_slice_sum(s : BiophylobootstrapSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_phylo_bootstrap_slice_mean(s : BiophylobootstrapSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_phylo_bootstrap_slice_sum(s) / s.size.to_double() }
}

pub fn bio_phylo_bootstrap_slice_scale(s : BiophylobootstrapSlice, f : Double) -> BiophylobootstrapSlice {
  let result = bio_phylo_bootstrap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_phylo_bootstrap_slice_add(a : BiophylobootstrapSlice, b : BiophylobootstrapSlice) -> BiophylobootstrapSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_phylo_bootstrap_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_phylo_bootstrap_slice_copy(s : BiophylobootstrapSlice) -> BiophylobootstrapSlice {
  let result = bio_phylo_bootstrap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_phylo_bootstrap_slice_fill(s : BiophylobootstrapSlice, v : Double) -> BiophylobootstrapSlice {
  let result = bio_phylo_bootstrap_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_phylo_bootstrap_slice_min(s : BiophylobootstrapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_slice_max(s : BiophylobootstrapSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_phylo_bootstrap_slice_to_string(s : BiophylobootstrapSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

