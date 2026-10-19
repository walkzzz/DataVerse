///===
/// extcore/bio_seq_assembly_hybrid

pub(all) struct BioseqassemblyhybridPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_hybrid_make_point(x : Double, y : Double) -> BioseqassemblyhybridPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_hybrid_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblyhybridPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_assembly_hybrid_point_x(pt : BioseqassemblyhybridPoint) -> Double { pt.x }

pub fn bio_seq_assembly_hybrid_point_y(pt : BioseqassemblyhybridPoint) -> Double { pt.y }

pub fn bio_seq_assembly_hybrid_point_z(pt : BioseqassemblyhybridPoint) -> Double { pt.z }

pub fn bio_seq_assembly_hybrid_point_label(pt : BioseqassemblyhybridPoint) -> Int { pt.label }

pub fn bio_seq_assembly_hybrid_point_dist(a : BioseqassemblyhybridPoint, b : BioseqassemblyhybridPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_assembly_hybrid_point_add(a : BioseqassemblyhybridPoint, b : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_assembly_hybrid_point_sub(a : BioseqassemblyhybridPoint, b : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_assembly_hybrid_point_scale(pt : BioseqassemblyhybridPoint, s : Double) -> BioseqassemblyhybridPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_assembly_hybrid_point_dot(a : BioseqassemblyhybridPoint, b : BioseqassemblyhybridPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_assembly_hybrid_point_cross(a : BioseqassemblyhybridPoint, b : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_assembly_hybrid_point_norm(pt : BioseqassemblyhybridPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_assembly_hybrid_point_normalize(pt : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  let n = bio_seq_assembly_hybrid_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_assembly_hybrid_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_assembly_hybrid_point_negate(pt : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_assembly_hybrid_point_mid(a : BioseqassemblyhybridPoint, b : BioseqassemblyhybridPoint) -> BioseqassemblyhybridPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_assembly_hybrid_point_lerp(a : BioseqassemblyhybridPoint, b : BioseqassemblyhybridPoint, t : Double) -> BioseqassemblyhybridPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_assembly_hybrid_point_to_string(pt : BioseqassemblyhybridPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_hybrid_make_series(vals : Array[Double], name : String) -> BioseqassemblyhybridSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_assembly_hybrid_series_len(s : BioseqassemblyhybridSeries) -> Int { s.vals.length() }

pub fn bio_seq_assembly_hybrid_series_sum(s : BioseqassemblyhybridSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_assembly_hybrid_series_mean(s : BioseqassemblyhybridSeries) -> Double {
  let n = bio_seq_assembly_hybrid_series_len(s)
  if n == 0 { 0.0 } else { bio_seq_assembly_hybrid_series_sum(s) / n.to_double() }
}

pub fn bio_seq_assembly_hybrid_series_min(s : BioseqassemblyhybridSeries) -> Double {
  let n = bio_seq_assembly_hybrid_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_series_max(s : BioseqassemblyhybridSeries) -> Double {
  let n = bio_seq_assembly_hybrid_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_series_range(s : BioseqassemblyhybridSeries) -> Double {
  bio_seq_assembly_hybrid_series_max(s) - bio_seq_assembly_hybrid_series_min(s)
}

pub fn bio_seq_assembly_hybrid_series_var(s : BioseqassemblyhybridSeries) -> Double {
  let n = bio_seq_assembly_hybrid_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_seq_assembly_hybrid_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_seq_assembly_hybrid_series_std(s : BioseqassemblyhybridSeries) -> Double { @_common.sqrt(bio_seq_assembly_hybrid_series_var(s)) }

pub fn bio_seq_assembly_hybrid_series_median(s : BioseqassemblyhybridSeries) -> Double {
  let n = bio_seq_assembly_hybrid_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_assembly_hybrid_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_assembly_hybrid_series_scale(s : BioseqassemblyhybridSeries, f : Double) -> BioseqassemblyhybridSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_assembly_hybrid_series_add(a : BioseqassemblyhybridSeries, b : BioseqassemblyhybridSeries) -> BioseqassemblyhybridSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_hybrid_series_sub(a : BioseqassemblyhybridSeries, b : BioseqassemblyhybridSeries) -> BioseqassemblyhybridSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_hybrid_series_normalize(s : BioseqassemblyhybridSeries) -> BioseqassemblyhybridSeries {
  let mn = bio_seq_assembly_hybrid_series_min(s)
  let mx = bio_seq_assembly_hybrid_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_assembly_hybrid_series_cumsum(s : BioseqassemblyhybridSeries) -> BioseqassemblyhybridSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_assembly_hybrid_series_to_string(s : BioseqassemblyhybridSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblyhybridMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_hybrid_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblyhybridMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_hybrid_matrix_identity(n : Int) -> BioseqassemblyhybridMatrix {
  let m = bio_seq_assembly_hybrid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_assembly_hybrid_matrix_get(m : BioseqassemblyhybridMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_assembly_hybrid_matrix_transpose(m : BioseqassemblyhybridMatrix) -> BioseqassemblyhybridMatrix {
  let result = bio_seq_assembly_hybrid_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_assembly_hybrid_matrix_add(a : BioseqassemblyhybridMatrix, b : BioseqassemblyhybridMatrix) -> BioseqassemblyhybridMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_assembly_hybrid_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_assembly_hybrid_matrix_scale(m : BioseqassemblyhybridMatrix, s : Double) -> BioseqassemblyhybridMatrix {
  let result = bio_seq_assembly_hybrid_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_assembly_hybrid_matrix_multiply(a : BioseqassemblyhybridMatrix, b : BioseqassemblyhybridMatrix) -> BioseqassemblyhybridMatrix {
  if a.cols != b.rows { return bio_seq_assembly_hybrid_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_assembly_hybrid_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_assembly_hybrid_matrix_trace(m : BioseqassemblyhybridMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_assembly_hybrid_matrix_det(m : BioseqassemblyhybridMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_assembly_hybrid_matrix_norm(m : BioseqassemblyhybridMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_assembly_hybrid_matrix_to_string(m : BioseqassemblyhybridMatrix) -> String {
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

pub(all) struct BioseqassemblyhybridVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_hybrid_make_vector(comps : Array[Double]) -> BioseqassemblyhybridVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_hybrid_vector_zero(dim : Int) -> BioseqassemblyhybridVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_assembly_hybrid_vector_add(a : BioseqassemblyhybridVector, b : BioseqassemblyhybridVector) -> BioseqassemblyhybridVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_hybrid_vector_sub(a : BioseqassemblyhybridVector, b : BioseqassemblyhybridVector) -> BioseqassemblyhybridVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_hybrid_vector_scale(v : BioseqassemblyhybridVector, s : Double) -> BioseqassemblyhybridVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_assembly_hybrid_vector_dot(a : BioseqassemblyhybridVector, b : BioseqassemblyhybridVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_assembly_hybrid_vector_norm(v : BioseqassemblyhybridVector) -> Double { @_common.sqrt(bio_seq_assembly_hybrid_vector_dot(v, v)) }

pub fn bio_seq_assembly_hybrid_vector_normalize(v : BioseqassemblyhybridVector) -> BioseqassemblyhybridVector {
  let n = bio_seq_assembly_hybrid_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_assembly_hybrid_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_assembly_hybrid_vector_dist(a : BioseqassemblyhybridVector, b : BioseqassemblyhybridVector) -> Double {
  bio_seq_assembly_hybrid_vector_norm(bio_seq_assembly_hybrid_vector_sub(a, b))
}

pub fn bio_seq_assembly_hybrid_vector_to_string(v : BioseqassemblyhybridVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_hybrid_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_hybrid_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_seq_assembly_hybrid_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_hybrid_std(data : Array[Double]) -> Double { @_common.sqrt(bio_seq_assembly_hybrid_var(data)) }

pub fn bio_seq_assembly_hybrid_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_seq_assembly_hybrid_mean(a); let mb = bio_seq_assembly_hybrid_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_hybrid_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_seq_assembly_hybrid_std(a); let sb = bio_seq_assembly_hybrid_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_seq_assembly_hybrid_cov(a, b) / (sa * sb) }
}

pub fn bio_seq_assembly_hybrid_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_assembly_hybrid_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_assembly_hybrid_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_seq_assembly_hybrid_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_hybrid_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(bio_seq_assembly_hybrid_mse(pred, labels))
}

pub fn bio_seq_assembly_hybrid_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_hybrid_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_seq_assembly_hybrid_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_seq_assembly_hybrid_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_seq_assembly_hybrid_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_seq_assembly_hybrid_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_seq_assembly_hybrid_precision(pred, labels, pos); let r = bio_seq_assembly_hybrid_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_seq_assembly_hybrid_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_seq_assembly_hybrid_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_seq_assembly_hybrid_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_seq_assembly_hybrid_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_seq_assembly_hybrid_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_seq_assembly_hybrid_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_seq_assembly_hybrid_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_seq_assembly_hybrid_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_seq_assembly_hybrid_fibonacci(n : Int) -> Int {
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

pub fn bio_seq_assembly_hybrid_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_seq_assembly_hybrid_min(data); let mx = bio_seq_assembly_hybrid_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_seq_assembly_hybrid_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_seq_assembly_hybrid_mean(data); let sd = bio_seq_assembly_hybrid_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_seq_assembly_hybrid_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_seq_assembly_hybrid_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_seq_assembly_hybrid_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_seq_assembly_hybrid_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct BioseqassemblyhybridFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_frame_make(size : Int) -> BioseqassemblyhybridFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_frame_len(s : BioseqassemblyhybridFrame) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_frame_get(s : BioseqassemblyhybridFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_frame_set(s : BioseqassemblyhybridFrame, i : Int, v : Double) -> BioseqassemblyhybridFrame {
  let result = bio_seq_assembly_hybrid_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_frame_sum(s : BioseqassemblyhybridFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_frame_mean(s : BioseqassemblyhybridFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_frame_scale(s : BioseqassemblyhybridFrame, f : Double) -> BioseqassemblyhybridFrame {
  let result = bio_seq_assembly_hybrid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_frame_add(a : BioseqassemblyhybridFrame, b : BioseqassemblyhybridFrame) -> BioseqassemblyhybridFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_frame_copy(s : BioseqassemblyhybridFrame) -> BioseqassemblyhybridFrame {
  let result = bio_seq_assembly_hybrid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_frame_fill(s : BioseqassemblyhybridFrame, v : Double) -> BioseqassemblyhybridFrame {
  let result = bio_seq_assembly_hybrid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_frame_min(s : BioseqassemblyhybridFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_frame_max(s : BioseqassemblyhybridFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_frame_to_string(s : BioseqassemblyhybridFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_table_make(size : Int) -> BioseqassemblyhybridTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_table_len(s : BioseqassemblyhybridTable) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_table_get(s : BioseqassemblyhybridTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_table_set(s : BioseqassemblyhybridTable, i : Int, v : Double) -> BioseqassemblyhybridTable {
  let result = bio_seq_assembly_hybrid_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_table_sum(s : BioseqassemblyhybridTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_table_mean(s : BioseqassemblyhybridTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_table_scale(s : BioseqassemblyhybridTable, f : Double) -> BioseqassemblyhybridTable {
  let result = bio_seq_assembly_hybrid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_table_add(a : BioseqassemblyhybridTable, b : BioseqassemblyhybridTable) -> BioseqassemblyhybridTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_table_copy(s : BioseqassemblyhybridTable) -> BioseqassemblyhybridTable {
  let result = bio_seq_assembly_hybrid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_table_fill(s : BioseqassemblyhybridTable, v : Double) -> BioseqassemblyhybridTable {
  let result = bio_seq_assembly_hybrid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_table_min(s : BioseqassemblyhybridTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_table_max(s : BioseqassemblyhybridTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_table_to_string(s : BioseqassemblyhybridTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_graphn_make(size : Int) -> BioseqassemblyhybridGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_graphn_len(s : BioseqassemblyhybridGraphN) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_graphn_get(s : BioseqassemblyhybridGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_graphn_set(s : BioseqassemblyhybridGraphN, i : Int, v : Double) -> BioseqassemblyhybridGraphN {
  let result = bio_seq_assembly_hybrid_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_graphn_sum(s : BioseqassemblyhybridGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_graphn_mean(s : BioseqassemblyhybridGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_graphn_scale(s : BioseqassemblyhybridGraphN, f : Double) -> BioseqassemblyhybridGraphN {
  let result = bio_seq_assembly_hybrid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_graphn_add(a : BioseqassemblyhybridGraphN, b : BioseqassemblyhybridGraphN) -> BioseqassemblyhybridGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_graphn_copy(s : BioseqassemblyhybridGraphN) -> BioseqassemblyhybridGraphN {
  let result = bio_seq_assembly_hybrid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_graphn_fill(s : BioseqassemblyhybridGraphN, v : Double) -> BioseqassemblyhybridGraphN {
  let result = bio_seq_assembly_hybrid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_graphn_min(s : BioseqassemblyhybridGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_graphn_max(s : BioseqassemblyhybridGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_graphn_to_string(s : BioseqassemblyhybridGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_node_make(size : Int) -> BioseqassemblyhybridNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_node_len(s : BioseqassemblyhybridNode) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_node_get(s : BioseqassemblyhybridNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_node_set(s : BioseqassemblyhybridNode, i : Int, v : Double) -> BioseqassemblyhybridNode {
  let result = bio_seq_assembly_hybrid_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_node_sum(s : BioseqassemblyhybridNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_node_mean(s : BioseqassemblyhybridNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_node_scale(s : BioseqassemblyhybridNode, f : Double) -> BioseqassemblyhybridNode {
  let result = bio_seq_assembly_hybrid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_node_add(a : BioseqassemblyhybridNode, b : BioseqassemblyhybridNode) -> BioseqassemblyhybridNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_node_copy(s : BioseqassemblyhybridNode) -> BioseqassemblyhybridNode {
  let result = bio_seq_assembly_hybrid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_node_fill(s : BioseqassemblyhybridNode, v : Double) -> BioseqassemblyhybridNode {
  let result = bio_seq_assembly_hybrid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_node_min(s : BioseqassemblyhybridNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_node_max(s : BioseqassemblyhybridNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_node_to_string(s : BioseqassemblyhybridNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_edge_make(size : Int) -> BioseqassemblyhybridEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_edge_len(s : BioseqassemblyhybridEdge) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_edge_get(s : BioseqassemblyhybridEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_edge_set(s : BioseqassemblyhybridEdge, i : Int, v : Double) -> BioseqassemblyhybridEdge {
  let result = bio_seq_assembly_hybrid_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_edge_sum(s : BioseqassemblyhybridEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_edge_mean(s : BioseqassemblyhybridEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_edge_scale(s : BioseqassemblyhybridEdge, f : Double) -> BioseqassemblyhybridEdge {
  let result = bio_seq_assembly_hybrid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_edge_add(a : BioseqassemblyhybridEdge, b : BioseqassemblyhybridEdge) -> BioseqassemblyhybridEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_edge_copy(s : BioseqassemblyhybridEdge) -> BioseqassemblyhybridEdge {
  let result = bio_seq_assembly_hybrid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_edge_fill(s : BioseqassemblyhybridEdge, v : Double) -> BioseqassemblyhybridEdge {
  let result = bio_seq_assembly_hybrid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_edge_min(s : BioseqassemblyhybridEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_edge_max(s : BioseqassemblyhybridEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_edge_to_string(s : BioseqassemblyhybridEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_path_make(size : Int) -> BioseqassemblyhybridPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_path_len(s : BioseqassemblyhybridPath) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_path_get(s : BioseqassemblyhybridPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_path_set(s : BioseqassemblyhybridPath, i : Int, v : Double) -> BioseqassemblyhybridPath {
  let result = bio_seq_assembly_hybrid_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_path_sum(s : BioseqassemblyhybridPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_path_mean(s : BioseqassemblyhybridPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_path_scale(s : BioseqassemblyhybridPath, f : Double) -> BioseqassemblyhybridPath {
  let result = bio_seq_assembly_hybrid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_path_add(a : BioseqassemblyhybridPath, b : BioseqassemblyhybridPath) -> BioseqassemblyhybridPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_path_copy(s : BioseqassemblyhybridPath) -> BioseqassemblyhybridPath {
  let result = bio_seq_assembly_hybrid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_path_fill(s : BioseqassemblyhybridPath, v : Double) -> BioseqassemblyhybridPath {
  let result = bio_seq_assembly_hybrid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_path_min(s : BioseqassemblyhybridPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_path_max(s : BioseqassemblyhybridPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_path_to_string(s : BioseqassemblyhybridPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_cluster_make(size : Int) -> BioseqassemblyhybridCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_cluster_len(s : BioseqassemblyhybridCluster) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_cluster_get(s : BioseqassemblyhybridCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_cluster_set(s : BioseqassemblyhybridCluster, i : Int, v : Double) -> BioseqassemblyhybridCluster {
  let result = bio_seq_assembly_hybrid_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_cluster_sum(s : BioseqassemblyhybridCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_cluster_mean(s : BioseqassemblyhybridCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_cluster_scale(s : BioseqassemblyhybridCluster, f : Double) -> BioseqassemblyhybridCluster {
  let result = bio_seq_assembly_hybrid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_cluster_add(a : BioseqassemblyhybridCluster, b : BioseqassemblyhybridCluster) -> BioseqassemblyhybridCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_cluster_copy(s : BioseqassemblyhybridCluster) -> BioseqassemblyhybridCluster {
  let result = bio_seq_assembly_hybrid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_cluster_fill(s : BioseqassemblyhybridCluster, v : Double) -> BioseqassemblyhybridCluster {
  let result = bio_seq_assembly_hybrid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_cluster_min(s : BioseqassemblyhybridCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_cluster_max(s : BioseqassemblyhybridCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_cluster_to_string(s : BioseqassemblyhybridCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_model_make(size : Int) -> BioseqassemblyhybridModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_model_len(s : BioseqassemblyhybridModel) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_model_get(s : BioseqassemblyhybridModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_model_set(s : BioseqassemblyhybridModel, i : Int, v : Double) -> BioseqassemblyhybridModel {
  let result = bio_seq_assembly_hybrid_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_model_sum(s : BioseqassemblyhybridModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_model_mean(s : BioseqassemblyhybridModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_model_scale(s : BioseqassemblyhybridModel, f : Double) -> BioseqassemblyhybridModel {
  let result = bio_seq_assembly_hybrid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_model_add(a : BioseqassemblyhybridModel, b : BioseqassemblyhybridModel) -> BioseqassemblyhybridModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_model_copy(s : BioseqassemblyhybridModel) -> BioseqassemblyhybridModel {
  let result = bio_seq_assembly_hybrid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_model_fill(s : BioseqassemblyhybridModel, v : Double) -> BioseqassemblyhybridModel {
  let result = bio_seq_assembly_hybrid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_model_min(s : BioseqassemblyhybridModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_model_max(s : BioseqassemblyhybridModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_model_to_string(s : BioseqassemblyhybridModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_layer_make(size : Int) -> BioseqassemblyhybridLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_layer_len(s : BioseqassemblyhybridLayer) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_layer_get(s : BioseqassemblyhybridLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_layer_set(s : BioseqassemblyhybridLayer, i : Int, v : Double) -> BioseqassemblyhybridLayer {
  let result = bio_seq_assembly_hybrid_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_layer_sum(s : BioseqassemblyhybridLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_layer_mean(s : BioseqassemblyhybridLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_layer_scale(s : BioseqassemblyhybridLayer, f : Double) -> BioseqassemblyhybridLayer {
  let result = bio_seq_assembly_hybrid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_layer_add(a : BioseqassemblyhybridLayer, b : BioseqassemblyhybridLayer) -> BioseqassemblyhybridLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_layer_copy(s : BioseqassemblyhybridLayer) -> BioseqassemblyhybridLayer {
  let result = bio_seq_assembly_hybrid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_layer_fill(s : BioseqassemblyhybridLayer, v : Double) -> BioseqassemblyhybridLayer {
  let result = bio_seq_assembly_hybrid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_layer_min(s : BioseqassemblyhybridLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_layer_max(s : BioseqassemblyhybridLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_layer_to_string(s : BioseqassemblyhybridLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_buffer_make(size : Int) -> BioseqassemblyhybridBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_buffer_len(s : BioseqassemblyhybridBuffer) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_buffer_get(s : BioseqassemblyhybridBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_buffer_set(s : BioseqassemblyhybridBuffer, i : Int, v : Double) -> BioseqassemblyhybridBuffer {
  let result = bio_seq_assembly_hybrid_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_buffer_sum(s : BioseqassemblyhybridBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_buffer_mean(s : BioseqassemblyhybridBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_buffer_scale(s : BioseqassemblyhybridBuffer, f : Double) -> BioseqassemblyhybridBuffer {
  let result = bio_seq_assembly_hybrid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_buffer_add(a : BioseqassemblyhybridBuffer, b : BioseqassemblyhybridBuffer) -> BioseqassemblyhybridBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_buffer_copy(s : BioseqassemblyhybridBuffer) -> BioseqassemblyhybridBuffer {
  let result = bio_seq_assembly_hybrid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_buffer_fill(s : BioseqassemblyhybridBuffer, v : Double) -> BioseqassemblyhybridBuffer {
  let result = bio_seq_assembly_hybrid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_buffer_min(s : BioseqassemblyhybridBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_buffer_max(s : BioseqassemblyhybridBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_buffer_to_string(s : BioseqassemblyhybridBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_cursor_make(size : Int) -> BioseqassemblyhybridCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_cursor_len(s : BioseqassemblyhybridCursor) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_cursor_get(s : BioseqassemblyhybridCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_cursor_set(s : BioseqassemblyhybridCursor, i : Int, v : Double) -> BioseqassemblyhybridCursor {
  let result = bio_seq_assembly_hybrid_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_cursor_sum(s : BioseqassemblyhybridCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_cursor_mean(s : BioseqassemblyhybridCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_cursor_scale(s : BioseqassemblyhybridCursor, f : Double) -> BioseqassemblyhybridCursor {
  let result = bio_seq_assembly_hybrid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_cursor_add(a : BioseqassemblyhybridCursor, b : BioseqassemblyhybridCursor) -> BioseqassemblyhybridCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_cursor_copy(s : BioseqassemblyhybridCursor) -> BioseqassemblyhybridCursor {
  let result = bio_seq_assembly_hybrid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_cursor_fill(s : BioseqassemblyhybridCursor, v : Double) -> BioseqassemblyhybridCursor {
  let result = bio_seq_assembly_hybrid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_cursor_min(s : BioseqassemblyhybridCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_cursor_max(s : BioseqassemblyhybridCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_cursor_to_string(s : BioseqassemblyhybridCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_view_make(size : Int) -> BioseqassemblyhybridView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_view_len(s : BioseqassemblyhybridView) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_view_get(s : BioseqassemblyhybridView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_view_set(s : BioseqassemblyhybridView, i : Int, v : Double) -> BioseqassemblyhybridView {
  let result = bio_seq_assembly_hybrid_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_view_sum(s : BioseqassemblyhybridView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_view_mean(s : BioseqassemblyhybridView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_view_scale(s : BioseqassemblyhybridView, f : Double) -> BioseqassemblyhybridView {
  let result = bio_seq_assembly_hybrid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_view_add(a : BioseqassemblyhybridView, b : BioseqassemblyhybridView) -> BioseqassemblyhybridView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_view_copy(s : BioseqassemblyhybridView) -> BioseqassemblyhybridView {
  let result = bio_seq_assembly_hybrid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_view_fill(s : BioseqassemblyhybridView, v : Double) -> BioseqassemblyhybridView {
  let result = bio_seq_assembly_hybrid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_view_min(s : BioseqassemblyhybridView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_view_max(s : BioseqassemblyhybridView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_view_to_string(s : BioseqassemblyhybridView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_range_make(size : Int) -> BioseqassemblyhybridRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_range_len(s : BioseqassemblyhybridRange) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_range_get(s : BioseqassemblyhybridRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_range_set(s : BioseqassemblyhybridRange, i : Int, v : Double) -> BioseqassemblyhybridRange {
  let result = bio_seq_assembly_hybrid_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_range_sum(s : BioseqassemblyhybridRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_range_mean(s : BioseqassemblyhybridRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_range_scale(s : BioseqassemblyhybridRange, f : Double) -> BioseqassemblyhybridRange {
  let result = bio_seq_assembly_hybrid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_range_add(a : BioseqassemblyhybridRange, b : BioseqassemblyhybridRange) -> BioseqassemblyhybridRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_range_copy(s : BioseqassemblyhybridRange) -> BioseqassemblyhybridRange {
  let result = bio_seq_assembly_hybrid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_range_fill(s : BioseqassemblyhybridRange, v : Double) -> BioseqassemblyhybridRange {
  let result = bio_seq_assembly_hybrid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_range_min(s : BioseqassemblyhybridRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_range_max(s : BioseqassemblyhybridRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_range_to_string(s : BioseqassemblyhybridRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblyhybridSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_hybrid_slice_make(size : Int) -> BioseqassemblyhybridSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_hybrid_slice_len(s : BioseqassemblyhybridSlice) -> Int { s.size }

pub fn bio_seq_assembly_hybrid_slice_get(s : BioseqassemblyhybridSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_hybrid_slice_set(s : BioseqassemblyhybridSlice, i : Int, v : Double) -> BioseqassemblyhybridSlice {
  let result = bio_seq_assembly_hybrid_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_slice_sum(s : BioseqassemblyhybridSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_hybrid_slice_mean(s : BioseqassemblyhybridSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_hybrid_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_hybrid_slice_scale(s : BioseqassemblyhybridSlice, f : Double) -> BioseqassemblyhybridSlice {
  let result = bio_seq_assembly_hybrid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_hybrid_slice_add(a : BioseqassemblyhybridSlice, b : BioseqassemblyhybridSlice) -> BioseqassemblyhybridSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_hybrid_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_slice_copy(s : BioseqassemblyhybridSlice) -> BioseqassemblyhybridSlice {
  let result = bio_seq_assembly_hybrid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_hybrid_slice_fill(s : BioseqassemblyhybridSlice, v : Double) -> BioseqassemblyhybridSlice {
  let result = bio_seq_assembly_hybrid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_hybrid_slice_min(s : BioseqassemblyhybridSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_slice_max(s : BioseqassemblyhybridSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_hybrid_slice_to_string(s : BioseqassemblyhybridSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

