///===
/// extcore/bio_seq_assembly_string

pub(all) struct BioseqassemblystringPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn bio_seq_assembly_string_make_point(x : Double, y : Double) -> BioseqassemblystringPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn bio_seq_assembly_string_make_point3(x : Double, y : Double, z : Double) -> BioseqassemblystringPoint {
  { x, y, z, label: 0 }
}

pub fn bio_seq_assembly_string_point_x(pt : BioseqassemblystringPoint) -> Double { pt.x }

pub fn bio_seq_assembly_string_point_y(pt : BioseqassemblystringPoint) -> Double { pt.y }

pub fn bio_seq_assembly_string_point_z(pt : BioseqassemblystringPoint) -> Double { pt.z }

pub fn bio_seq_assembly_string_point_label(pt : BioseqassemblystringPoint) -> Int { pt.label }

pub fn bio_seq_assembly_string_point_dist(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn bio_seq_assembly_string_point_add(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn bio_seq_assembly_string_point_sub(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn bio_seq_assembly_string_point_scale(pt : BioseqassemblystringPoint, s : Double) -> BioseqassemblystringPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn bio_seq_assembly_string_point_dot(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn bio_seq_assembly_string_point_cross(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn bio_seq_assembly_string_point_norm(pt : BioseqassemblystringPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn bio_seq_assembly_string_point_normalize(pt : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  let n = bio_seq_assembly_string_point_norm(pt)
  if n < 0.0000001 { pt } else { bio_seq_assembly_string_point_scale(pt, 1.0 / n) }
}

pub fn bio_seq_assembly_string_point_negate(pt : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn bio_seq_assembly_string_point_mid(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint) -> BioseqassemblystringPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn bio_seq_assembly_string_point_lerp(a : BioseqassemblystringPoint, b : BioseqassemblystringPoint, t : Double) -> BioseqassemblystringPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn bio_seq_assembly_string_point_to_string(pt : BioseqassemblystringPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct BioseqassemblystringSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn bio_seq_assembly_string_make_series(vals : Array[Double], name : String) -> BioseqassemblystringSeries {
  { vals, name, meta: 0 }
}

pub fn bio_seq_assembly_string_series_len(s : BioseqassemblystringSeries) -> Int { s.vals.length() }

pub fn bio_seq_assembly_string_series_sum(s : BioseqassemblystringSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn bio_seq_assembly_string_series_mean(s : BioseqassemblystringSeries) -> Double {
  let n = bio_seq_assembly_string_series_len(s)
  if n == 0 { 0.0 } else { bio_seq_assembly_string_series_sum(s) / n.to_double() }
}

pub fn bio_seq_assembly_string_series_min(s : BioseqassemblystringSeries) -> Double {
  let n = bio_seq_assembly_string_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_series_max(s : BioseqassemblystringSeries) -> Double {
  let n = bio_seq_assembly_string_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_series_range(s : BioseqassemblystringSeries) -> Double {
  bio_seq_assembly_string_series_max(s) - bio_seq_assembly_string_series_min(s)
}

pub fn bio_seq_assembly_string_series_var(s : BioseqassemblystringSeries) -> Double {
  let n = bio_seq_assembly_string_series_len(s)
  if n == 0 { 0.0 } else {
    let m = bio_seq_assembly_string_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn bio_seq_assembly_string_series_std(s : BioseqassemblystringSeries) -> Double { @_common.sqrt(bio_seq_assembly_string_series_var(s)) }

pub fn bio_seq_assembly_string_series_median(s : BioseqassemblystringSeries) -> Double {
  let n = bio_seq_assembly_string_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_assembly_string_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_assembly_string_series_scale(s : BioseqassemblystringSeries, f : Double) -> BioseqassemblystringSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn bio_seq_assembly_string_series_add(a : BioseqassemblystringSeries, b : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_string_series_sub(a : BioseqassemblystringSeries, b : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn bio_seq_assembly_string_series_normalize(s : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  let mn = bio_seq_assembly_string_series_min(s)
  let mx = bio_seq_assembly_string_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn bio_seq_assembly_string_series_cumsum(s : BioseqassemblystringSeries) -> BioseqassemblystringSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn bio_seq_assembly_string_series_to_string(s : BioseqassemblystringSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct BioseqassemblystringMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn bio_seq_assembly_string_make_matrix(rows : Int, cols : Int, val : Double) -> BioseqassemblystringMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn bio_seq_assembly_string_matrix_identity(n : Int) -> BioseqassemblystringMatrix {
  let m = bio_seq_assembly_string_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn bio_seq_assembly_string_matrix_get(m : BioseqassemblystringMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn bio_seq_assembly_string_matrix_transpose(m : BioseqassemblystringMatrix) -> BioseqassemblystringMatrix {
  let result = bio_seq_assembly_string_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn bio_seq_assembly_string_matrix_add(a : BioseqassemblystringMatrix, b : BioseqassemblystringMatrix) -> BioseqassemblystringMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = bio_seq_assembly_string_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn bio_seq_assembly_string_matrix_scale(m : BioseqassemblystringMatrix, s : Double) -> BioseqassemblystringMatrix {
  let result = bio_seq_assembly_string_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn bio_seq_assembly_string_matrix_multiply(a : BioseqassemblystringMatrix, b : BioseqassemblystringMatrix) -> BioseqassemblystringMatrix {
  if a.cols != b.rows { return bio_seq_assembly_string_make_matrix(a.rows, b.cols, 0.0) }
  let result = bio_seq_assembly_string_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn bio_seq_assembly_string_matrix_trace(m : BioseqassemblystringMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn bio_seq_assembly_string_matrix_det(m : BioseqassemblystringMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn bio_seq_assembly_string_matrix_norm(m : BioseqassemblystringMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn bio_seq_assembly_string_matrix_to_string(m : BioseqassemblystringMatrix) -> String {
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

pub(all) struct BioseqassemblystringVector {
  comps : Array[Double]
  dim : Int
}

pub fn bio_seq_assembly_string_make_vector(comps : Array[Double]) -> BioseqassemblystringVector {
  { comps, dim: comps.length() }
}

pub fn bio_seq_assembly_string_vector_zero(dim : Int) -> BioseqassemblystringVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn bio_seq_assembly_string_vector_add(a : BioseqassemblystringVector, b : BioseqassemblystringVector) -> BioseqassemblystringVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_string_vector_sub(a : BioseqassemblystringVector, b : BioseqassemblystringVector) -> BioseqassemblystringVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn bio_seq_assembly_string_vector_scale(v : BioseqassemblystringVector, s : Double) -> BioseqassemblystringVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn bio_seq_assembly_string_vector_dot(a : BioseqassemblystringVector, b : BioseqassemblystringVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn bio_seq_assembly_string_vector_norm(v : BioseqassemblystringVector) -> Double { @_common.sqrt(bio_seq_assembly_string_vector_dot(v, v)) }

pub fn bio_seq_assembly_string_vector_normalize(v : BioseqassemblystringVector) -> BioseqassemblystringVector {
  let n = bio_seq_assembly_string_vector_norm(v)
  if n < 0.0000001 { v } else { bio_seq_assembly_string_vector_scale(v, 1.0 / n) }
}

pub fn bio_seq_assembly_string_vector_dist(a : BioseqassemblystringVector, b : BioseqassemblystringVector) -> Double {
  bio_seq_assembly_string_vector_norm(bio_seq_assembly_string_vector_sub(a, b))
}

pub fn bio_seq_assembly_string_vector_to_string(v : BioseqassemblystringVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn bio_seq_assembly_string_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_string_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = bio_seq_assembly_string_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_string_std(data : Array[Double]) -> Double { @_common.sqrt(bio_seq_assembly_string_var(data)) }

pub fn bio_seq_assembly_string_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = bio_seq_assembly_string_mean(a); let mb = bio_seq_assembly_string_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_string_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = bio_seq_assembly_string_std(a); let sb = bio_seq_assembly_string_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { bio_seq_assembly_string_cov(a, b) / (sa * sb) }
}

pub fn bio_seq_assembly_string_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = bio_seq_assembly_string_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn bio_seq_assembly_string_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn bio_seq_assembly_string_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_string_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(bio_seq_assembly_string_mse(pred, labels))
}

pub fn bio_seq_assembly_string_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn bio_seq_assembly_string_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = bio_seq_assembly_string_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn bio_seq_assembly_string_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn bio_seq_assembly_string_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn bio_seq_assembly_string_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = bio_seq_assembly_string_precision(pred, labels, pos); let r = bio_seq_assembly_string_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn bio_seq_assembly_string_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn bio_seq_assembly_string_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = bio_seq_assembly_string_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn bio_seq_assembly_string_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn bio_seq_assembly_string_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn bio_seq_assembly_string_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = bio_seq_assembly_string_gcd(a, b)
    (a / g) * b
  }
}

pub fn bio_seq_assembly_string_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn bio_seq_assembly_string_fibonacci(n : Int) -> Int {
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

pub fn bio_seq_assembly_string_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = bio_seq_assembly_string_min(data); let mx = bio_seq_assembly_string_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn bio_seq_assembly_string_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = bio_seq_assembly_string_mean(data); let sd = bio_seq_assembly_string_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn bio_seq_assembly_string_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn bio_seq_assembly_string_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn bio_seq_assembly_string_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn bio_seq_assembly_string_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct BioseqassemblystringFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_frame_make(size : Int) -> BioseqassemblystringFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_frame_len(s : BioseqassemblystringFrame) -> Int { s.size }

pub fn bio_seq_assembly_string_frame_get(s : BioseqassemblystringFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_frame_set(s : BioseqassemblystringFrame, i : Int, v : Double) -> BioseqassemblystringFrame {
  let result = bio_seq_assembly_string_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_frame_sum(s : BioseqassemblystringFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_frame_mean(s : BioseqassemblystringFrame) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_frame_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_frame_scale(s : BioseqassemblystringFrame, f : Double) -> BioseqassemblystringFrame {
  let result = bio_seq_assembly_string_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_frame_add(a : BioseqassemblystringFrame, b : BioseqassemblystringFrame) -> BioseqassemblystringFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_frame_copy(s : BioseqassemblystringFrame) -> BioseqassemblystringFrame {
  let result = bio_seq_assembly_string_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_frame_fill(s : BioseqassemblystringFrame, v : Double) -> BioseqassemblystringFrame {
  let result = bio_seq_assembly_string_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_frame_min(s : BioseqassemblystringFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_frame_max(s : BioseqassemblystringFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_frame_to_string(s : BioseqassemblystringFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_table_make(size : Int) -> BioseqassemblystringTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_table_len(s : BioseqassemblystringTable) -> Int { s.size }

pub fn bio_seq_assembly_string_table_get(s : BioseqassemblystringTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_table_set(s : BioseqassemblystringTable, i : Int, v : Double) -> BioseqassemblystringTable {
  let result = bio_seq_assembly_string_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_table_sum(s : BioseqassemblystringTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_table_mean(s : BioseqassemblystringTable) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_table_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_table_scale(s : BioseqassemblystringTable, f : Double) -> BioseqassemblystringTable {
  let result = bio_seq_assembly_string_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_table_add(a : BioseqassemblystringTable, b : BioseqassemblystringTable) -> BioseqassemblystringTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_table_copy(s : BioseqassemblystringTable) -> BioseqassemblystringTable {
  let result = bio_seq_assembly_string_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_table_fill(s : BioseqassemblystringTable, v : Double) -> BioseqassemblystringTable {
  let result = bio_seq_assembly_string_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_table_min(s : BioseqassemblystringTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_table_max(s : BioseqassemblystringTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_table_to_string(s : BioseqassemblystringTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_graphn_make(size : Int) -> BioseqassemblystringGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_graphn_len(s : BioseqassemblystringGraphN) -> Int { s.size }

pub fn bio_seq_assembly_string_graphn_get(s : BioseqassemblystringGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_graphn_set(s : BioseqassemblystringGraphN, i : Int, v : Double) -> BioseqassemblystringGraphN {
  let result = bio_seq_assembly_string_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_graphn_sum(s : BioseqassemblystringGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_graphn_mean(s : BioseqassemblystringGraphN) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_graphn_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_graphn_scale(s : BioseqassemblystringGraphN, f : Double) -> BioseqassemblystringGraphN {
  let result = bio_seq_assembly_string_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_graphn_add(a : BioseqassemblystringGraphN, b : BioseqassemblystringGraphN) -> BioseqassemblystringGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_graphn_copy(s : BioseqassemblystringGraphN) -> BioseqassemblystringGraphN {
  let result = bio_seq_assembly_string_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_graphn_fill(s : BioseqassemblystringGraphN, v : Double) -> BioseqassemblystringGraphN {
  let result = bio_seq_assembly_string_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_graphn_min(s : BioseqassemblystringGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_graphn_max(s : BioseqassemblystringGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_graphn_to_string(s : BioseqassemblystringGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_node_make(size : Int) -> BioseqassemblystringNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_node_len(s : BioseqassemblystringNode) -> Int { s.size }

pub fn bio_seq_assembly_string_node_get(s : BioseqassemblystringNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_node_set(s : BioseqassemblystringNode, i : Int, v : Double) -> BioseqassemblystringNode {
  let result = bio_seq_assembly_string_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_node_sum(s : BioseqassemblystringNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_node_mean(s : BioseqassemblystringNode) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_node_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_node_scale(s : BioseqassemblystringNode, f : Double) -> BioseqassemblystringNode {
  let result = bio_seq_assembly_string_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_node_add(a : BioseqassemblystringNode, b : BioseqassemblystringNode) -> BioseqassemblystringNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_node_copy(s : BioseqassemblystringNode) -> BioseqassemblystringNode {
  let result = bio_seq_assembly_string_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_node_fill(s : BioseqassemblystringNode, v : Double) -> BioseqassemblystringNode {
  let result = bio_seq_assembly_string_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_node_min(s : BioseqassemblystringNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_node_max(s : BioseqassemblystringNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_node_to_string(s : BioseqassemblystringNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_edge_make(size : Int) -> BioseqassemblystringEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_edge_len(s : BioseqassemblystringEdge) -> Int { s.size }

pub fn bio_seq_assembly_string_edge_get(s : BioseqassemblystringEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_edge_set(s : BioseqassemblystringEdge, i : Int, v : Double) -> BioseqassemblystringEdge {
  let result = bio_seq_assembly_string_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_edge_sum(s : BioseqassemblystringEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_edge_mean(s : BioseqassemblystringEdge) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_edge_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_edge_scale(s : BioseqassemblystringEdge, f : Double) -> BioseqassemblystringEdge {
  let result = bio_seq_assembly_string_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_edge_add(a : BioseqassemblystringEdge, b : BioseqassemblystringEdge) -> BioseqassemblystringEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_edge_copy(s : BioseqassemblystringEdge) -> BioseqassemblystringEdge {
  let result = bio_seq_assembly_string_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_edge_fill(s : BioseqassemblystringEdge, v : Double) -> BioseqassemblystringEdge {
  let result = bio_seq_assembly_string_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_edge_min(s : BioseqassemblystringEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_edge_max(s : BioseqassemblystringEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_edge_to_string(s : BioseqassemblystringEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_path_make(size : Int) -> BioseqassemblystringPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_path_len(s : BioseqassemblystringPath) -> Int { s.size }

pub fn bio_seq_assembly_string_path_get(s : BioseqassemblystringPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_path_set(s : BioseqassemblystringPath, i : Int, v : Double) -> BioseqassemblystringPath {
  let result = bio_seq_assembly_string_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_path_sum(s : BioseqassemblystringPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_path_mean(s : BioseqassemblystringPath) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_path_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_path_scale(s : BioseqassemblystringPath, f : Double) -> BioseqassemblystringPath {
  let result = bio_seq_assembly_string_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_path_add(a : BioseqassemblystringPath, b : BioseqassemblystringPath) -> BioseqassemblystringPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_path_copy(s : BioseqassemblystringPath) -> BioseqassemblystringPath {
  let result = bio_seq_assembly_string_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_path_fill(s : BioseqassemblystringPath, v : Double) -> BioseqassemblystringPath {
  let result = bio_seq_assembly_string_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_path_min(s : BioseqassemblystringPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_path_max(s : BioseqassemblystringPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_path_to_string(s : BioseqassemblystringPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_cluster_make(size : Int) -> BioseqassemblystringCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_cluster_len(s : BioseqassemblystringCluster) -> Int { s.size }

pub fn bio_seq_assembly_string_cluster_get(s : BioseqassemblystringCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_cluster_set(s : BioseqassemblystringCluster, i : Int, v : Double) -> BioseqassemblystringCluster {
  let result = bio_seq_assembly_string_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_cluster_sum(s : BioseqassemblystringCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_cluster_mean(s : BioseqassemblystringCluster) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_cluster_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_cluster_scale(s : BioseqassemblystringCluster, f : Double) -> BioseqassemblystringCluster {
  let result = bio_seq_assembly_string_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_cluster_add(a : BioseqassemblystringCluster, b : BioseqassemblystringCluster) -> BioseqassemblystringCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_cluster_copy(s : BioseqassemblystringCluster) -> BioseqassemblystringCluster {
  let result = bio_seq_assembly_string_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_cluster_fill(s : BioseqassemblystringCluster, v : Double) -> BioseqassemblystringCluster {
  let result = bio_seq_assembly_string_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_cluster_min(s : BioseqassemblystringCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_cluster_max(s : BioseqassemblystringCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_cluster_to_string(s : BioseqassemblystringCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_model_make(size : Int) -> BioseqassemblystringModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_model_len(s : BioseqassemblystringModel) -> Int { s.size }

pub fn bio_seq_assembly_string_model_get(s : BioseqassemblystringModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_model_set(s : BioseqassemblystringModel, i : Int, v : Double) -> BioseqassemblystringModel {
  let result = bio_seq_assembly_string_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_model_sum(s : BioseqassemblystringModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_model_mean(s : BioseqassemblystringModel) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_model_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_model_scale(s : BioseqassemblystringModel, f : Double) -> BioseqassemblystringModel {
  let result = bio_seq_assembly_string_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_model_add(a : BioseqassemblystringModel, b : BioseqassemblystringModel) -> BioseqassemblystringModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_model_copy(s : BioseqassemblystringModel) -> BioseqassemblystringModel {
  let result = bio_seq_assembly_string_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_model_fill(s : BioseqassemblystringModel, v : Double) -> BioseqassemblystringModel {
  let result = bio_seq_assembly_string_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_model_min(s : BioseqassemblystringModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_model_max(s : BioseqassemblystringModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_model_to_string(s : BioseqassemblystringModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_layer_make(size : Int) -> BioseqassemblystringLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_layer_len(s : BioseqassemblystringLayer) -> Int { s.size }

pub fn bio_seq_assembly_string_layer_get(s : BioseqassemblystringLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_layer_set(s : BioseqassemblystringLayer, i : Int, v : Double) -> BioseqassemblystringLayer {
  let result = bio_seq_assembly_string_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_layer_sum(s : BioseqassemblystringLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_layer_mean(s : BioseqassemblystringLayer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_layer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_layer_scale(s : BioseqassemblystringLayer, f : Double) -> BioseqassemblystringLayer {
  let result = bio_seq_assembly_string_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_layer_add(a : BioseqassemblystringLayer, b : BioseqassemblystringLayer) -> BioseqassemblystringLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_layer_copy(s : BioseqassemblystringLayer) -> BioseqassemblystringLayer {
  let result = bio_seq_assembly_string_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_layer_fill(s : BioseqassemblystringLayer, v : Double) -> BioseqassemblystringLayer {
  let result = bio_seq_assembly_string_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_layer_min(s : BioseqassemblystringLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_layer_max(s : BioseqassemblystringLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_layer_to_string(s : BioseqassemblystringLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_buffer_make(size : Int) -> BioseqassemblystringBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_buffer_len(s : BioseqassemblystringBuffer) -> Int { s.size }

pub fn bio_seq_assembly_string_buffer_get(s : BioseqassemblystringBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_buffer_set(s : BioseqassemblystringBuffer, i : Int, v : Double) -> BioseqassemblystringBuffer {
  let result = bio_seq_assembly_string_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_buffer_sum(s : BioseqassemblystringBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_buffer_mean(s : BioseqassemblystringBuffer) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_buffer_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_buffer_scale(s : BioseqassemblystringBuffer, f : Double) -> BioseqassemblystringBuffer {
  let result = bio_seq_assembly_string_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_buffer_add(a : BioseqassemblystringBuffer, b : BioseqassemblystringBuffer) -> BioseqassemblystringBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_buffer_copy(s : BioseqassemblystringBuffer) -> BioseqassemblystringBuffer {
  let result = bio_seq_assembly_string_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_buffer_fill(s : BioseqassemblystringBuffer, v : Double) -> BioseqassemblystringBuffer {
  let result = bio_seq_assembly_string_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_buffer_min(s : BioseqassemblystringBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_buffer_max(s : BioseqassemblystringBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_buffer_to_string(s : BioseqassemblystringBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_cursor_make(size : Int) -> BioseqassemblystringCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_cursor_len(s : BioseqassemblystringCursor) -> Int { s.size }

pub fn bio_seq_assembly_string_cursor_get(s : BioseqassemblystringCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_cursor_set(s : BioseqassemblystringCursor, i : Int, v : Double) -> BioseqassemblystringCursor {
  let result = bio_seq_assembly_string_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_cursor_sum(s : BioseqassemblystringCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_cursor_mean(s : BioseqassemblystringCursor) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_cursor_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_cursor_scale(s : BioseqassemblystringCursor, f : Double) -> BioseqassemblystringCursor {
  let result = bio_seq_assembly_string_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_cursor_add(a : BioseqassemblystringCursor, b : BioseqassemblystringCursor) -> BioseqassemblystringCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_cursor_copy(s : BioseqassemblystringCursor) -> BioseqassemblystringCursor {
  let result = bio_seq_assembly_string_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_cursor_fill(s : BioseqassemblystringCursor, v : Double) -> BioseqassemblystringCursor {
  let result = bio_seq_assembly_string_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_cursor_min(s : BioseqassemblystringCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_cursor_max(s : BioseqassemblystringCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_cursor_to_string(s : BioseqassemblystringCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_view_make(size : Int) -> BioseqassemblystringView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_view_len(s : BioseqassemblystringView) -> Int { s.size }

pub fn bio_seq_assembly_string_view_get(s : BioseqassemblystringView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_view_set(s : BioseqassemblystringView, i : Int, v : Double) -> BioseqassemblystringView {
  let result = bio_seq_assembly_string_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_view_sum(s : BioseqassemblystringView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_view_mean(s : BioseqassemblystringView) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_view_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_view_scale(s : BioseqassemblystringView, f : Double) -> BioseqassemblystringView {
  let result = bio_seq_assembly_string_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_view_add(a : BioseqassemblystringView, b : BioseqassemblystringView) -> BioseqassemblystringView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_view_copy(s : BioseqassemblystringView) -> BioseqassemblystringView {
  let result = bio_seq_assembly_string_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_view_fill(s : BioseqassemblystringView, v : Double) -> BioseqassemblystringView {
  let result = bio_seq_assembly_string_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_view_min(s : BioseqassemblystringView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_view_max(s : BioseqassemblystringView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_view_to_string(s : BioseqassemblystringView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_range_make(size : Int) -> BioseqassemblystringRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_range_len(s : BioseqassemblystringRange) -> Int { s.size }

pub fn bio_seq_assembly_string_range_get(s : BioseqassemblystringRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_range_set(s : BioseqassemblystringRange, i : Int, v : Double) -> BioseqassemblystringRange {
  let result = bio_seq_assembly_string_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_range_sum(s : BioseqassemblystringRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_range_mean(s : BioseqassemblystringRange) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_range_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_range_scale(s : BioseqassemblystringRange, f : Double) -> BioseqassemblystringRange {
  let result = bio_seq_assembly_string_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_range_add(a : BioseqassemblystringRange, b : BioseqassemblystringRange) -> BioseqassemblystringRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_range_copy(s : BioseqassemblystringRange) -> BioseqassemblystringRange {
  let result = bio_seq_assembly_string_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_range_fill(s : BioseqassemblystringRange, v : Double) -> BioseqassemblystringRange {
  let result = bio_seq_assembly_string_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_range_min(s : BioseqassemblystringRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_range_max(s : BioseqassemblystringRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_range_to_string(s : BioseqassemblystringRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct BioseqassemblystringSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn bio_seq_assembly_string_slice_make(size : Int) -> BioseqassemblystringSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn bio_seq_assembly_string_slice_len(s : BioseqassemblystringSlice) -> Int { s.size }

pub fn bio_seq_assembly_string_slice_get(s : BioseqassemblystringSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn bio_seq_assembly_string_slice_set(s : BioseqassemblystringSlice, i : Int, v : Double) -> BioseqassemblystringSlice {
  let result = bio_seq_assembly_string_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_slice_sum(s : BioseqassemblystringSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn bio_seq_assembly_string_slice_mean(s : BioseqassemblystringSlice) -> Double {
  if s.size == 0 { 0.0 } else { bio_seq_assembly_string_slice_sum(s) / s.size.to_double() }
}

pub fn bio_seq_assembly_string_slice_scale(s : BioseqassemblystringSlice, f : Double) -> BioseqassemblystringSlice {
  let result = bio_seq_assembly_string_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn bio_seq_assembly_string_slice_add(a : BioseqassemblystringSlice, b : BioseqassemblystringSlice) -> BioseqassemblystringSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = bio_seq_assembly_string_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn bio_seq_assembly_string_slice_copy(s : BioseqassemblystringSlice) -> BioseqassemblystringSlice {
  let result = bio_seq_assembly_string_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn bio_seq_assembly_string_slice_fill(s : BioseqassemblystringSlice, v : Double) -> BioseqassemblystringSlice {
  let result = bio_seq_assembly_string_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn bio_seq_assembly_string_slice_min(s : BioseqassemblystringSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_slice_max(s : BioseqassemblystringSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn bio_seq_assembly_string_slice_to_string(s : BioseqassemblystringSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

