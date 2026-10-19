///===
/// extcore/chem_desc_rdkit

pub(all) struct ChemdescrdkitPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_rdkit_make_point(x : Double, y : Double) -> ChemdescrdkitPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_rdkit_make_point3(x : Double, y : Double, z : Double) -> ChemdescrdkitPoint {
  { x, y, z, label: 0 }
}

pub fn chem_desc_rdkit_point_x(pt : ChemdescrdkitPoint) -> Double { pt.x }

pub fn chem_desc_rdkit_point_y(pt : ChemdescrdkitPoint) -> Double { pt.y }

pub fn chem_desc_rdkit_point_z(pt : ChemdescrdkitPoint) -> Double { pt.z }

pub fn chem_desc_rdkit_point_label(pt : ChemdescrdkitPoint) -> Int { pt.label }

pub fn chem_desc_rdkit_point_dist(a : ChemdescrdkitPoint, b : ChemdescrdkitPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_desc_rdkit_point_add(a : ChemdescrdkitPoint, b : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_desc_rdkit_point_sub(a : ChemdescrdkitPoint, b : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_desc_rdkit_point_scale(pt : ChemdescrdkitPoint, s : Double) -> ChemdescrdkitPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_desc_rdkit_point_dot(a : ChemdescrdkitPoint, b : ChemdescrdkitPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_desc_rdkit_point_cross(a : ChemdescrdkitPoint, b : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_desc_rdkit_point_norm(pt : ChemdescrdkitPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_desc_rdkit_point_normalize(pt : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  let n = chem_desc_rdkit_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_desc_rdkit_point_scale(pt, 1.0 / n) }
}

pub fn chem_desc_rdkit_point_negate(pt : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_desc_rdkit_point_mid(a : ChemdescrdkitPoint, b : ChemdescrdkitPoint) -> ChemdescrdkitPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_desc_rdkit_point_lerp(a : ChemdescrdkitPoint, b : ChemdescrdkitPoint, t : Double) -> ChemdescrdkitPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_desc_rdkit_point_to_string(pt : ChemdescrdkitPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemdescrdkitSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_rdkit_make_series(vals : Array[Double], name : String) -> ChemdescrdkitSeries {
  { vals, name, meta: 0 }
}

pub fn chem_desc_rdkit_series_len(s : ChemdescrdkitSeries) -> Int { s.vals.length() }

pub fn chem_desc_rdkit_series_sum(s : ChemdescrdkitSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_desc_rdkit_series_mean(s : ChemdescrdkitSeries) -> Double {
  let n = chem_desc_rdkit_series_len(s)
  if n == 0 { 0.0 } else { chem_desc_rdkit_series_sum(s) / n.to_double() }
}

pub fn chem_desc_rdkit_series_min(s : ChemdescrdkitSeries) -> Double {
  let n = chem_desc_rdkit_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_rdkit_series_max(s : ChemdescrdkitSeries) -> Double {
  let n = chem_desc_rdkit_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_rdkit_series_range(s : ChemdescrdkitSeries) -> Double {
  chem_desc_rdkit_series_max(s) - chem_desc_rdkit_series_min(s)
}

pub fn chem_desc_rdkit_series_var(s : ChemdescrdkitSeries) -> Double {
  let n = chem_desc_rdkit_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_desc_rdkit_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_desc_rdkit_series_std(s : ChemdescrdkitSeries) -> Double { @_common.sqrt(chem_desc_rdkit_series_var(s)) }

pub fn chem_desc_rdkit_series_median(s : ChemdescrdkitSeries) -> Double {
  let n = chem_desc_rdkit_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_desc_rdkit_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_desc_rdkit_series_scale(s : ChemdescrdkitSeries, f : Double) -> ChemdescrdkitSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_desc_rdkit_series_add(a : ChemdescrdkitSeries, b : ChemdescrdkitSeries) -> ChemdescrdkitSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_desc_rdkit_series_sub(a : ChemdescrdkitSeries, b : ChemdescrdkitSeries) -> ChemdescrdkitSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_desc_rdkit_series_normalize(s : ChemdescrdkitSeries) -> ChemdescrdkitSeries {
  let mn = chem_desc_rdkit_series_min(s)
  let mx = chem_desc_rdkit_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_desc_rdkit_series_cumsum(s : ChemdescrdkitSeries) -> ChemdescrdkitSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_desc_rdkit_series_to_string(s : ChemdescrdkitSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescrdkitMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_rdkit_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescrdkitMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_rdkit_matrix_identity(n : Int) -> ChemdescrdkitMatrix {
  let m = chem_desc_rdkit_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_desc_rdkit_matrix_get(m : ChemdescrdkitMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_desc_rdkit_matrix_transpose(m : ChemdescrdkitMatrix) -> ChemdescrdkitMatrix {
  let result = chem_desc_rdkit_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_desc_rdkit_matrix_add(a : ChemdescrdkitMatrix, b : ChemdescrdkitMatrix) -> ChemdescrdkitMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_desc_rdkit_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_desc_rdkit_matrix_scale(m : ChemdescrdkitMatrix, s : Double) -> ChemdescrdkitMatrix {
  let result = chem_desc_rdkit_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_desc_rdkit_matrix_multiply(a : ChemdescrdkitMatrix, b : ChemdescrdkitMatrix) -> ChemdescrdkitMatrix {
  if a.cols != b.rows { return chem_desc_rdkit_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_desc_rdkit_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_desc_rdkit_matrix_trace(m : ChemdescrdkitMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_desc_rdkit_matrix_det(m : ChemdescrdkitMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_desc_rdkit_matrix_norm(m : ChemdescrdkitMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_desc_rdkit_matrix_to_string(m : ChemdescrdkitMatrix) -> String {
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

pub(all) struct ChemdescrdkitVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_rdkit_make_vector(comps : Array[Double]) -> ChemdescrdkitVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_rdkit_vector_zero(dim : Int) -> ChemdescrdkitVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_desc_rdkit_vector_add(a : ChemdescrdkitVector, b : ChemdescrdkitVector) -> ChemdescrdkitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_rdkit_vector_sub(a : ChemdescrdkitVector, b : ChemdescrdkitVector) -> ChemdescrdkitVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_rdkit_vector_scale(v : ChemdescrdkitVector, s : Double) -> ChemdescrdkitVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_desc_rdkit_vector_dot(a : ChemdescrdkitVector, b : ChemdescrdkitVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_desc_rdkit_vector_norm(v : ChemdescrdkitVector) -> Double { @_common.sqrt(chem_desc_rdkit_vector_dot(v, v)) }

pub fn chem_desc_rdkit_vector_normalize(v : ChemdescrdkitVector) -> ChemdescrdkitVector {
  let n = chem_desc_rdkit_vector_norm(v)
  if n < 0.0000001 { v } else { chem_desc_rdkit_vector_scale(v, 1.0 / n) }
}

pub fn chem_desc_rdkit_vector_dist(a : ChemdescrdkitVector, b : ChemdescrdkitVector) -> Double {
  chem_desc_rdkit_vector_norm(chem_desc_rdkit_vector_sub(a, b))
}

pub fn chem_desc_rdkit_vector_to_string(v : ChemdescrdkitVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_rdkit_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_desc_rdkit_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_desc_rdkit_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_desc_rdkit_std(data : Array[Double]) -> Double { @_common.sqrt(chem_desc_rdkit_var(data)) }

pub fn chem_desc_rdkit_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_desc_rdkit_mean(a); let mb = chem_desc_rdkit_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_desc_rdkit_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_desc_rdkit_std(a); let sb = chem_desc_rdkit_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_desc_rdkit_cov(a, b) / (sa * sb) }
}

pub fn chem_desc_rdkit_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_desc_rdkit_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_desc_rdkit_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_desc_rdkit_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_desc_rdkit_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(chem_desc_rdkit_mse(pred, labels))
}

pub fn chem_desc_rdkit_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_desc_rdkit_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_desc_rdkit_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_desc_rdkit_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_desc_rdkit_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_desc_rdkit_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_desc_rdkit_precision(pred, labels, pos); let r = chem_desc_rdkit_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_desc_rdkit_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_desc_rdkit_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_desc_rdkit_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_desc_rdkit_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_desc_rdkit_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_desc_rdkit_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_desc_rdkit_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_desc_rdkit_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_desc_rdkit_fibonacci(n : Int) -> Int {
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

pub fn chem_desc_rdkit_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_desc_rdkit_min(data); let mx = chem_desc_rdkit_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_desc_rdkit_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_desc_rdkit_mean(data); let sd = chem_desc_rdkit_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_desc_rdkit_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_desc_rdkit_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_desc_rdkit_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_desc_rdkit_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ChemdescrdkitFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_frame_make(size : Int) -> ChemdescrdkitFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_frame_len(s : ChemdescrdkitFrame) -> Int { s.size }

pub fn chem_desc_rdkit_frame_get(s : ChemdescrdkitFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_frame_set(s : ChemdescrdkitFrame, i : Int, v : Double) -> ChemdescrdkitFrame {
  let result = chem_desc_rdkit_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_frame_sum(s : ChemdescrdkitFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_frame_mean(s : ChemdescrdkitFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_frame_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_frame_scale(s : ChemdescrdkitFrame, f : Double) -> ChemdescrdkitFrame {
  let result = chem_desc_rdkit_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_frame_add(a : ChemdescrdkitFrame, b : ChemdescrdkitFrame) -> ChemdescrdkitFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_frame_copy(s : ChemdescrdkitFrame) -> ChemdescrdkitFrame {
  let result = chem_desc_rdkit_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_frame_fill(s : ChemdescrdkitFrame, v : Double) -> ChemdescrdkitFrame {
  let result = chem_desc_rdkit_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_frame_min(s : ChemdescrdkitFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_frame_max(s : ChemdescrdkitFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_frame_to_string(s : ChemdescrdkitFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_table_make(size : Int) -> ChemdescrdkitTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_table_len(s : ChemdescrdkitTable) -> Int { s.size }

pub fn chem_desc_rdkit_table_get(s : ChemdescrdkitTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_table_set(s : ChemdescrdkitTable, i : Int, v : Double) -> ChemdescrdkitTable {
  let result = chem_desc_rdkit_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_table_sum(s : ChemdescrdkitTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_table_mean(s : ChemdescrdkitTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_table_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_table_scale(s : ChemdescrdkitTable, f : Double) -> ChemdescrdkitTable {
  let result = chem_desc_rdkit_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_table_add(a : ChemdescrdkitTable, b : ChemdescrdkitTable) -> ChemdescrdkitTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_table_copy(s : ChemdescrdkitTable) -> ChemdescrdkitTable {
  let result = chem_desc_rdkit_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_table_fill(s : ChemdescrdkitTable, v : Double) -> ChemdescrdkitTable {
  let result = chem_desc_rdkit_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_table_min(s : ChemdescrdkitTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_table_max(s : ChemdescrdkitTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_table_to_string(s : ChemdescrdkitTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_graphn_make(size : Int) -> ChemdescrdkitGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_graphn_len(s : ChemdescrdkitGraphN) -> Int { s.size }

pub fn chem_desc_rdkit_graphn_get(s : ChemdescrdkitGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_graphn_set(s : ChemdescrdkitGraphN, i : Int, v : Double) -> ChemdescrdkitGraphN {
  let result = chem_desc_rdkit_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_graphn_sum(s : ChemdescrdkitGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_graphn_mean(s : ChemdescrdkitGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_graphn_scale(s : ChemdescrdkitGraphN, f : Double) -> ChemdescrdkitGraphN {
  let result = chem_desc_rdkit_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_graphn_add(a : ChemdescrdkitGraphN, b : ChemdescrdkitGraphN) -> ChemdescrdkitGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_graphn_copy(s : ChemdescrdkitGraphN) -> ChemdescrdkitGraphN {
  let result = chem_desc_rdkit_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_graphn_fill(s : ChemdescrdkitGraphN, v : Double) -> ChemdescrdkitGraphN {
  let result = chem_desc_rdkit_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_graphn_min(s : ChemdescrdkitGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_graphn_max(s : ChemdescrdkitGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_graphn_to_string(s : ChemdescrdkitGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_node_make(size : Int) -> ChemdescrdkitNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_node_len(s : ChemdescrdkitNode) -> Int { s.size }

pub fn chem_desc_rdkit_node_get(s : ChemdescrdkitNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_node_set(s : ChemdescrdkitNode, i : Int, v : Double) -> ChemdescrdkitNode {
  let result = chem_desc_rdkit_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_node_sum(s : ChemdescrdkitNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_node_mean(s : ChemdescrdkitNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_node_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_node_scale(s : ChemdescrdkitNode, f : Double) -> ChemdescrdkitNode {
  let result = chem_desc_rdkit_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_node_add(a : ChemdescrdkitNode, b : ChemdescrdkitNode) -> ChemdescrdkitNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_node_copy(s : ChemdescrdkitNode) -> ChemdescrdkitNode {
  let result = chem_desc_rdkit_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_node_fill(s : ChemdescrdkitNode, v : Double) -> ChemdescrdkitNode {
  let result = chem_desc_rdkit_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_node_min(s : ChemdescrdkitNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_node_max(s : ChemdescrdkitNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_node_to_string(s : ChemdescrdkitNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_edge_make(size : Int) -> ChemdescrdkitEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_edge_len(s : ChemdescrdkitEdge) -> Int { s.size }

pub fn chem_desc_rdkit_edge_get(s : ChemdescrdkitEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_edge_set(s : ChemdescrdkitEdge, i : Int, v : Double) -> ChemdescrdkitEdge {
  let result = chem_desc_rdkit_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_edge_sum(s : ChemdescrdkitEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_edge_mean(s : ChemdescrdkitEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_edge_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_edge_scale(s : ChemdescrdkitEdge, f : Double) -> ChemdescrdkitEdge {
  let result = chem_desc_rdkit_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_edge_add(a : ChemdescrdkitEdge, b : ChemdescrdkitEdge) -> ChemdescrdkitEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_edge_copy(s : ChemdescrdkitEdge) -> ChemdescrdkitEdge {
  let result = chem_desc_rdkit_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_edge_fill(s : ChemdescrdkitEdge, v : Double) -> ChemdescrdkitEdge {
  let result = chem_desc_rdkit_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_edge_min(s : ChemdescrdkitEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_edge_max(s : ChemdescrdkitEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_edge_to_string(s : ChemdescrdkitEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_path_make(size : Int) -> ChemdescrdkitPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_path_len(s : ChemdescrdkitPath) -> Int { s.size }

pub fn chem_desc_rdkit_path_get(s : ChemdescrdkitPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_path_set(s : ChemdescrdkitPath, i : Int, v : Double) -> ChemdescrdkitPath {
  let result = chem_desc_rdkit_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_path_sum(s : ChemdescrdkitPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_path_mean(s : ChemdescrdkitPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_path_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_path_scale(s : ChemdescrdkitPath, f : Double) -> ChemdescrdkitPath {
  let result = chem_desc_rdkit_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_path_add(a : ChemdescrdkitPath, b : ChemdescrdkitPath) -> ChemdescrdkitPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_path_copy(s : ChemdescrdkitPath) -> ChemdescrdkitPath {
  let result = chem_desc_rdkit_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_path_fill(s : ChemdescrdkitPath, v : Double) -> ChemdescrdkitPath {
  let result = chem_desc_rdkit_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_path_min(s : ChemdescrdkitPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_path_max(s : ChemdescrdkitPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_path_to_string(s : ChemdescrdkitPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_cluster_make(size : Int) -> ChemdescrdkitCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_cluster_len(s : ChemdescrdkitCluster) -> Int { s.size }

pub fn chem_desc_rdkit_cluster_get(s : ChemdescrdkitCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_cluster_set(s : ChemdescrdkitCluster, i : Int, v : Double) -> ChemdescrdkitCluster {
  let result = chem_desc_rdkit_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_cluster_sum(s : ChemdescrdkitCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_cluster_mean(s : ChemdescrdkitCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_cluster_scale(s : ChemdescrdkitCluster, f : Double) -> ChemdescrdkitCluster {
  let result = chem_desc_rdkit_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_cluster_add(a : ChemdescrdkitCluster, b : ChemdescrdkitCluster) -> ChemdescrdkitCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_cluster_copy(s : ChemdescrdkitCluster) -> ChemdescrdkitCluster {
  let result = chem_desc_rdkit_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_cluster_fill(s : ChemdescrdkitCluster, v : Double) -> ChemdescrdkitCluster {
  let result = chem_desc_rdkit_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_cluster_min(s : ChemdescrdkitCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_cluster_max(s : ChemdescrdkitCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_cluster_to_string(s : ChemdescrdkitCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_model_make(size : Int) -> ChemdescrdkitModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_model_len(s : ChemdescrdkitModel) -> Int { s.size }

pub fn chem_desc_rdkit_model_get(s : ChemdescrdkitModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_model_set(s : ChemdescrdkitModel, i : Int, v : Double) -> ChemdescrdkitModel {
  let result = chem_desc_rdkit_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_model_sum(s : ChemdescrdkitModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_model_mean(s : ChemdescrdkitModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_model_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_model_scale(s : ChemdescrdkitModel, f : Double) -> ChemdescrdkitModel {
  let result = chem_desc_rdkit_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_model_add(a : ChemdescrdkitModel, b : ChemdescrdkitModel) -> ChemdescrdkitModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_model_copy(s : ChemdescrdkitModel) -> ChemdescrdkitModel {
  let result = chem_desc_rdkit_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_model_fill(s : ChemdescrdkitModel, v : Double) -> ChemdescrdkitModel {
  let result = chem_desc_rdkit_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_model_min(s : ChemdescrdkitModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_model_max(s : ChemdescrdkitModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_model_to_string(s : ChemdescrdkitModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_layer_make(size : Int) -> ChemdescrdkitLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_layer_len(s : ChemdescrdkitLayer) -> Int { s.size }

pub fn chem_desc_rdkit_layer_get(s : ChemdescrdkitLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_layer_set(s : ChemdescrdkitLayer, i : Int, v : Double) -> ChemdescrdkitLayer {
  let result = chem_desc_rdkit_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_layer_sum(s : ChemdescrdkitLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_layer_mean(s : ChemdescrdkitLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_layer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_layer_scale(s : ChemdescrdkitLayer, f : Double) -> ChemdescrdkitLayer {
  let result = chem_desc_rdkit_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_layer_add(a : ChemdescrdkitLayer, b : ChemdescrdkitLayer) -> ChemdescrdkitLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_layer_copy(s : ChemdescrdkitLayer) -> ChemdescrdkitLayer {
  let result = chem_desc_rdkit_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_layer_fill(s : ChemdescrdkitLayer, v : Double) -> ChemdescrdkitLayer {
  let result = chem_desc_rdkit_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_layer_min(s : ChemdescrdkitLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_layer_max(s : ChemdescrdkitLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_layer_to_string(s : ChemdescrdkitLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_buffer_make(size : Int) -> ChemdescrdkitBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_buffer_len(s : ChemdescrdkitBuffer) -> Int { s.size }

pub fn chem_desc_rdkit_buffer_get(s : ChemdescrdkitBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_buffer_set(s : ChemdescrdkitBuffer, i : Int, v : Double) -> ChemdescrdkitBuffer {
  let result = chem_desc_rdkit_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_buffer_sum(s : ChemdescrdkitBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_buffer_mean(s : ChemdescrdkitBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_buffer_scale(s : ChemdescrdkitBuffer, f : Double) -> ChemdescrdkitBuffer {
  let result = chem_desc_rdkit_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_buffer_add(a : ChemdescrdkitBuffer, b : ChemdescrdkitBuffer) -> ChemdescrdkitBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_buffer_copy(s : ChemdescrdkitBuffer) -> ChemdescrdkitBuffer {
  let result = chem_desc_rdkit_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_buffer_fill(s : ChemdescrdkitBuffer, v : Double) -> ChemdescrdkitBuffer {
  let result = chem_desc_rdkit_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_buffer_min(s : ChemdescrdkitBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_buffer_max(s : ChemdescrdkitBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_buffer_to_string(s : ChemdescrdkitBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_cursor_make(size : Int) -> ChemdescrdkitCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_cursor_len(s : ChemdescrdkitCursor) -> Int { s.size }

pub fn chem_desc_rdkit_cursor_get(s : ChemdescrdkitCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_cursor_set(s : ChemdescrdkitCursor, i : Int, v : Double) -> ChemdescrdkitCursor {
  let result = chem_desc_rdkit_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_cursor_sum(s : ChemdescrdkitCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_cursor_mean(s : ChemdescrdkitCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_cursor_scale(s : ChemdescrdkitCursor, f : Double) -> ChemdescrdkitCursor {
  let result = chem_desc_rdkit_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_cursor_add(a : ChemdescrdkitCursor, b : ChemdescrdkitCursor) -> ChemdescrdkitCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_cursor_copy(s : ChemdescrdkitCursor) -> ChemdescrdkitCursor {
  let result = chem_desc_rdkit_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_cursor_fill(s : ChemdescrdkitCursor, v : Double) -> ChemdescrdkitCursor {
  let result = chem_desc_rdkit_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_cursor_min(s : ChemdescrdkitCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_cursor_max(s : ChemdescrdkitCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_cursor_to_string(s : ChemdescrdkitCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_view_make(size : Int) -> ChemdescrdkitView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_view_len(s : ChemdescrdkitView) -> Int { s.size }

pub fn chem_desc_rdkit_view_get(s : ChemdescrdkitView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_view_set(s : ChemdescrdkitView, i : Int, v : Double) -> ChemdescrdkitView {
  let result = chem_desc_rdkit_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_view_sum(s : ChemdescrdkitView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_view_mean(s : ChemdescrdkitView) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_view_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_view_scale(s : ChemdescrdkitView, f : Double) -> ChemdescrdkitView {
  let result = chem_desc_rdkit_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_view_add(a : ChemdescrdkitView, b : ChemdescrdkitView) -> ChemdescrdkitView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_view_copy(s : ChemdescrdkitView) -> ChemdescrdkitView {
  let result = chem_desc_rdkit_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_view_fill(s : ChemdescrdkitView, v : Double) -> ChemdescrdkitView {
  let result = chem_desc_rdkit_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_view_min(s : ChemdescrdkitView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_view_max(s : ChemdescrdkitView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_view_to_string(s : ChemdescrdkitView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_range_make(size : Int) -> ChemdescrdkitRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_range_len(s : ChemdescrdkitRange) -> Int { s.size }

pub fn chem_desc_rdkit_range_get(s : ChemdescrdkitRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_range_set(s : ChemdescrdkitRange, i : Int, v : Double) -> ChemdescrdkitRange {
  let result = chem_desc_rdkit_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_range_sum(s : ChemdescrdkitRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_range_mean(s : ChemdescrdkitRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_range_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_range_scale(s : ChemdescrdkitRange, f : Double) -> ChemdescrdkitRange {
  let result = chem_desc_rdkit_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_range_add(a : ChemdescrdkitRange, b : ChemdescrdkitRange) -> ChemdescrdkitRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_range_copy(s : ChemdescrdkitRange) -> ChemdescrdkitRange {
  let result = chem_desc_rdkit_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_range_fill(s : ChemdescrdkitRange, v : Double) -> ChemdescrdkitRange {
  let result = chem_desc_rdkit_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_range_min(s : ChemdescrdkitRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_range_max(s : ChemdescrdkitRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_range_to_string(s : ChemdescrdkitRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescrdkitSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_rdkit_slice_make(size : Int) -> ChemdescrdkitSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_rdkit_slice_len(s : ChemdescrdkitSlice) -> Int { s.size }

pub fn chem_desc_rdkit_slice_get(s : ChemdescrdkitSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_rdkit_slice_set(s : ChemdescrdkitSlice, i : Int, v : Double) -> ChemdescrdkitSlice {
  let result = chem_desc_rdkit_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_slice_sum(s : ChemdescrdkitSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_rdkit_slice_mean(s : ChemdescrdkitSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_rdkit_slice_sum(s) / s.size.to_double() }
}

pub fn chem_desc_rdkit_slice_scale(s : ChemdescrdkitSlice, f : Double) -> ChemdescrdkitSlice {
  let result = chem_desc_rdkit_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_rdkit_slice_add(a : ChemdescrdkitSlice, b : ChemdescrdkitSlice) -> ChemdescrdkitSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_rdkit_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_rdkit_slice_copy(s : ChemdescrdkitSlice) -> ChemdescrdkitSlice {
  let result = chem_desc_rdkit_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_rdkit_slice_fill(s : ChemdescrdkitSlice, v : Double) -> ChemdescrdkitSlice {
  let result = chem_desc_rdkit_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_rdkit_slice_min(s : ChemdescrdkitSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_slice_max(s : ChemdescrdkitSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_rdkit_slice_to_string(s : ChemdescrdkitSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

