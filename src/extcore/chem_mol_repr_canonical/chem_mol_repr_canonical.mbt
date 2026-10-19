///===
/// extcore/chem_mol_repr_canonical

pub(all) struct ChemmolreprcanonicalPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_repr_canonical_make_point(x : Double, y : Double) -> ChemmolreprcanonicalPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_repr_canonical_make_point3(x : Double, y : Double, z : Double) -> ChemmolreprcanonicalPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_repr_canonical_point_x(pt : ChemmolreprcanonicalPoint) -> Double { pt.x }

pub fn chem_mol_repr_canonical_point_y(pt : ChemmolreprcanonicalPoint) -> Double { pt.y }

pub fn chem_mol_repr_canonical_point_z(pt : ChemmolreprcanonicalPoint) -> Double { pt.z }

pub fn chem_mol_repr_canonical_point_label(pt : ChemmolreprcanonicalPoint) -> Int { pt.label }

pub fn chem_mol_repr_canonical_point_dist(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_repr_canonical_point_add(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_repr_canonical_point_sub(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_repr_canonical_point_scale(pt : ChemmolreprcanonicalPoint, s : Double) -> ChemmolreprcanonicalPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_repr_canonical_point_dot(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_repr_canonical_point_cross(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_repr_canonical_point_norm(pt : ChemmolreprcanonicalPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_repr_canonical_point_normalize(pt : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  let n = chem_mol_repr_canonical_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_repr_canonical_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_repr_canonical_point_negate(pt : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_repr_canonical_point_mid(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint) -> ChemmolreprcanonicalPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_repr_canonical_point_lerp(a : ChemmolreprcanonicalPoint, b : ChemmolreprcanonicalPoint, t : Double) -> ChemmolreprcanonicalPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_repr_canonical_point_to_string(pt : ChemmolreprcanonicalPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_repr_canonical_make_series(vals : Array[Double], name : String) -> ChemmolreprcanonicalSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_repr_canonical_series_len(s : ChemmolreprcanonicalSeries) -> Int { s.vals.length() }

pub fn chem_mol_repr_canonical_series_sum(s : ChemmolreprcanonicalSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_repr_canonical_series_mean(s : ChemmolreprcanonicalSeries) -> Double {
  let n = chem_mol_repr_canonical_series_len(s)
  if n == 0 { 0.0 } else { chem_mol_repr_canonical_series_sum(s) / n.to_double() }
}

pub fn chem_mol_repr_canonical_series_min(s : ChemmolreprcanonicalSeries) -> Double {
  let n = chem_mol_repr_canonical_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_series_max(s : ChemmolreprcanonicalSeries) -> Double {
  let n = chem_mol_repr_canonical_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_series_range(s : ChemmolreprcanonicalSeries) -> Double {
  chem_mol_repr_canonical_series_max(s) - chem_mol_repr_canonical_series_min(s)
}

pub fn chem_mol_repr_canonical_series_var(s : ChemmolreprcanonicalSeries) -> Double {
  let n = chem_mol_repr_canonical_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_canonical_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_mol_repr_canonical_series_std(s : ChemmolreprcanonicalSeries) -> Double { @_common.sqrt(chem_mol_repr_canonical_series_var(s)) }

pub fn chem_mol_repr_canonical_series_median(s : ChemmolreprcanonicalSeries) -> Double {
  let n = chem_mol_repr_canonical_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_canonical_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_canonical_series_scale(s : ChemmolreprcanonicalSeries, f : Double) -> ChemmolreprcanonicalSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_repr_canonical_series_add(a : ChemmolreprcanonicalSeries, b : ChemmolreprcanonicalSeries) -> ChemmolreprcanonicalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_canonical_series_sub(a : ChemmolreprcanonicalSeries, b : ChemmolreprcanonicalSeries) -> ChemmolreprcanonicalSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_repr_canonical_series_normalize(s : ChemmolreprcanonicalSeries) -> ChemmolreprcanonicalSeries {
  let mn = chem_mol_repr_canonical_series_min(s)
  let mx = chem_mol_repr_canonical_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_repr_canonical_series_cumsum(s : ChemmolreprcanonicalSeries) -> ChemmolreprcanonicalSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_repr_canonical_series_to_string(s : ChemmolreprcanonicalSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolreprcanonicalMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_repr_canonical_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolreprcanonicalMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_repr_canonical_matrix_identity(n : Int) -> ChemmolreprcanonicalMatrix {
  let m = chem_mol_repr_canonical_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_repr_canonical_matrix_get(m : ChemmolreprcanonicalMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_repr_canonical_matrix_transpose(m : ChemmolreprcanonicalMatrix) -> ChemmolreprcanonicalMatrix {
  let result = chem_mol_repr_canonical_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_repr_canonical_matrix_add(a : ChemmolreprcanonicalMatrix, b : ChemmolreprcanonicalMatrix) -> ChemmolreprcanonicalMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_repr_canonical_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_repr_canonical_matrix_scale(m : ChemmolreprcanonicalMatrix, s : Double) -> ChemmolreprcanonicalMatrix {
  let result = chem_mol_repr_canonical_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_repr_canonical_matrix_multiply(a : ChemmolreprcanonicalMatrix, b : ChemmolreprcanonicalMatrix) -> ChemmolreprcanonicalMatrix {
  if a.cols != b.rows { return chem_mol_repr_canonical_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_repr_canonical_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_repr_canonical_matrix_trace(m : ChemmolreprcanonicalMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_repr_canonical_matrix_det(m : ChemmolreprcanonicalMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_repr_canonical_matrix_norm(m : ChemmolreprcanonicalMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_repr_canonical_matrix_to_string(m : ChemmolreprcanonicalMatrix) -> String {
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

pub(all) struct ChemmolreprcanonicalVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_repr_canonical_make_vector(comps : Array[Double]) -> ChemmolreprcanonicalVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_repr_canonical_vector_zero(dim : Int) -> ChemmolreprcanonicalVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_repr_canonical_vector_add(a : ChemmolreprcanonicalVector, b : ChemmolreprcanonicalVector) -> ChemmolreprcanonicalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_canonical_vector_sub(a : ChemmolreprcanonicalVector, b : ChemmolreprcanonicalVector) -> ChemmolreprcanonicalVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_repr_canonical_vector_scale(v : ChemmolreprcanonicalVector, s : Double) -> ChemmolreprcanonicalVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_repr_canonical_vector_dot(a : ChemmolreprcanonicalVector, b : ChemmolreprcanonicalVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_repr_canonical_vector_norm(v : ChemmolreprcanonicalVector) -> Double { @_common.sqrt(chem_mol_repr_canonical_vector_dot(v, v)) }

pub fn chem_mol_repr_canonical_vector_normalize(v : ChemmolreprcanonicalVector) -> ChemmolreprcanonicalVector {
  let n = chem_mol_repr_canonical_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_repr_canonical_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_repr_canonical_vector_dist(a : ChemmolreprcanonicalVector, b : ChemmolreprcanonicalVector) -> Double {
  chem_mol_repr_canonical_vector_norm(chem_mol_repr_canonical_vector_sub(a, b))
}

pub fn chem_mol_repr_canonical_vector_to_string(v : ChemmolreprcanonicalVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_repr_canonical_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_canonical_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_mol_repr_canonical_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_canonical_std(data : Array[Double]) -> Double { @_common.sqrt(chem_mol_repr_canonical_var(data)) }

pub fn chem_mol_repr_canonical_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_mol_repr_canonical_mean(a); let mb = chem_mol_repr_canonical_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_canonical_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_mol_repr_canonical_std(a); let sb = chem_mol_repr_canonical_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_mol_repr_canonical_cov(a, b) / (sa * sb) }
}

pub fn chem_mol_repr_canonical_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_repr_canonical_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_repr_canonical_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_mol_repr_canonical_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_canonical_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(chem_mol_repr_canonical_mse(pred, labels))
}

pub fn chem_mol_repr_canonical_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_mol_repr_canonical_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_mol_repr_canonical_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_mol_repr_canonical_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_mol_repr_canonical_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_mol_repr_canonical_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_mol_repr_canonical_precision(pred, labels, pos); let r = chem_mol_repr_canonical_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_mol_repr_canonical_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_mol_repr_canonical_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_mol_repr_canonical_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_mol_repr_canonical_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_mol_repr_canonical_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_mol_repr_canonical_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_mol_repr_canonical_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_mol_repr_canonical_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_mol_repr_canonical_fibonacci(n : Int) -> Int {
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

pub fn chem_mol_repr_canonical_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_mol_repr_canonical_min(data); let mx = chem_mol_repr_canonical_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_mol_repr_canonical_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_mol_repr_canonical_mean(data); let sd = chem_mol_repr_canonical_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_mol_repr_canonical_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_mol_repr_canonical_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_mol_repr_canonical_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_mol_repr_canonical_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ChemmolreprcanonicalFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_frame_make(size : Int) -> ChemmolreprcanonicalFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_frame_len(s : ChemmolreprcanonicalFrame) -> Int { s.size }

pub fn chem_mol_repr_canonical_frame_get(s : ChemmolreprcanonicalFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_frame_set(s : ChemmolreprcanonicalFrame, i : Int, v : Double) -> ChemmolreprcanonicalFrame {
  let result = chem_mol_repr_canonical_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_frame_sum(s : ChemmolreprcanonicalFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_frame_mean(s : ChemmolreprcanonicalFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_frame_scale(s : ChemmolreprcanonicalFrame, f : Double) -> ChemmolreprcanonicalFrame {
  let result = chem_mol_repr_canonical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_frame_add(a : ChemmolreprcanonicalFrame, b : ChemmolreprcanonicalFrame) -> ChemmolreprcanonicalFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_frame_copy(s : ChemmolreprcanonicalFrame) -> ChemmolreprcanonicalFrame {
  let result = chem_mol_repr_canonical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_frame_fill(s : ChemmolreprcanonicalFrame, v : Double) -> ChemmolreprcanonicalFrame {
  let result = chem_mol_repr_canonical_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_frame_min(s : ChemmolreprcanonicalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_frame_max(s : ChemmolreprcanonicalFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_frame_to_string(s : ChemmolreprcanonicalFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_table_make(size : Int) -> ChemmolreprcanonicalTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_table_len(s : ChemmolreprcanonicalTable) -> Int { s.size }

pub fn chem_mol_repr_canonical_table_get(s : ChemmolreprcanonicalTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_table_set(s : ChemmolreprcanonicalTable, i : Int, v : Double) -> ChemmolreprcanonicalTable {
  let result = chem_mol_repr_canonical_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_table_sum(s : ChemmolreprcanonicalTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_table_mean(s : ChemmolreprcanonicalTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_table_scale(s : ChemmolreprcanonicalTable, f : Double) -> ChemmolreprcanonicalTable {
  let result = chem_mol_repr_canonical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_table_add(a : ChemmolreprcanonicalTable, b : ChemmolreprcanonicalTable) -> ChemmolreprcanonicalTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_table_copy(s : ChemmolreprcanonicalTable) -> ChemmolreprcanonicalTable {
  let result = chem_mol_repr_canonical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_table_fill(s : ChemmolreprcanonicalTable, v : Double) -> ChemmolreprcanonicalTable {
  let result = chem_mol_repr_canonical_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_table_min(s : ChemmolreprcanonicalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_table_max(s : ChemmolreprcanonicalTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_table_to_string(s : ChemmolreprcanonicalTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_graphn_make(size : Int) -> ChemmolreprcanonicalGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_graphn_len(s : ChemmolreprcanonicalGraphN) -> Int { s.size }

pub fn chem_mol_repr_canonical_graphn_get(s : ChemmolreprcanonicalGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_graphn_set(s : ChemmolreprcanonicalGraphN, i : Int, v : Double) -> ChemmolreprcanonicalGraphN {
  let result = chem_mol_repr_canonical_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_graphn_sum(s : ChemmolreprcanonicalGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_graphn_mean(s : ChemmolreprcanonicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_graphn_scale(s : ChemmolreprcanonicalGraphN, f : Double) -> ChemmolreprcanonicalGraphN {
  let result = chem_mol_repr_canonical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_graphn_add(a : ChemmolreprcanonicalGraphN, b : ChemmolreprcanonicalGraphN) -> ChemmolreprcanonicalGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_graphn_copy(s : ChemmolreprcanonicalGraphN) -> ChemmolreprcanonicalGraphN {
  let result = chem_mol_repr_canonical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_graphn_fill(s : ChemmolreprcanonicalGraphN, v : Double) -> ChemmolreprcanonicalGraphN {
  let result = chem_mol_repr_canonical_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_graphn_min(s : ChemmolreprcanonicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_graphn_max(s : ChemmolreprcanonicalGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_graphn_to_string(s : ChemmolreprcanonicalGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_node_make(size : Int) -> ChemmolreprcanonicalNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_node_len(s : ChemmolreprcanonicalNode) -> Int { s.size }

pub fn chem_mol_repr_canonical_node_get(s : ChemmolreprcanonicalNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_node_set(s : ChemmolreprcanonicalNode, i : Int, v : Double) -> ChemmolreprcanonicalNode {
  let result = chem_mol_repr_canonical_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_node_sum(s : ChemmolreprcanonicalNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_node_mean(s : ChemmolreprcanonicalNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_node_scale(s : ChemmolreprcanonicalNode, f : Double) -> ChemmolreprcanonicalNode {
  let result = chem_mol_repr_canonical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_node_add(a : ChemmolreprcanonicalNode, b : ChemmolreprcanonicalNode) -> ChemmolreprcanonicalNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_node_copy(s : ChemmolreprcanonicalNode) -> ChemmolreprcanonicalNode {
  let result = chem_mol_repr_canonical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_node_fill(s : ChemmolreprcanonicalNode, v : Double) -> ChemmolreprcanonicalNode {
  let result = chem_mol_repr_canonical_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_node_min(s : ChemmolreprcanonicalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_node_max(s : ChemmolreprcanonicalNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_node_to_string(s : ChemmolreprcanonicalNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_edge_make(size : Int) -> ChemmolreprcanonicalEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_edge_len(s : ChemmolreprcanonicalEdge) -> Int { s.size }

pub fn chem_mol_repr_canonical_edge_get(s : ChemmolreprcanonicalEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_edge_set(s : ChemmolreprcanonicalEdge, i : Int, v : Double) -> ChemmolreprcanonicalEdge {
  let result = chem_mol_repr_canonical_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_edge_sum(s : ChemmolreprcanonicalEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_edge_mean(s : ChemmolreprcanonicalEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_edge_scale(s : ChemmolreprcanonicalEdge, f : Double) -> ChemmolreprcanonicalEdge {
  let result = chem_mol_repr_canonical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_edge_add(a : ChemmolreprcanonicalEdge, b : ChemmolreprcanonicalEdge) -> ChemmolreprcanonicalEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_edge_copy(s : ChemmolreprcanonicalEdge) -> ChemmolreprcanonicalEdge {
  let result = chem_mol_repr_canonical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_edge_fill(s : ChemmolreprcanonicalEdge, v : Double) -> ChemmolreprcanonicalEdge {
  let result = chem_mol_repr_canonical_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_edge_min(s : ChemmolreprcanonicalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_edge_max(s : ChemmolreprcanonicalEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_edge_to_string(s : ChemmolreprcanonicalEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_path_make(size : Int) -> ChemmolreprcanonicalPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_path_len(s : ChemmolreprcanonicalPath) -> Int { s.size }

pub fn chem_mol_repr_canonical_path_get(s : ChemmolreprcanonicalPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_path_set(s : ChemmolreprcanonicalPath, i : Int, v : Double) -> ChemmolreprcanonicalPath {
  let result = chem_mol_repr_canonical_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_path_sum(s : ChemmolreprcanonicalPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_path_mean(s : ChemmolreprcanonicalPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_path_scale(s : ChemmolreprcanonicalPath, f : Double) -> ChemmolreprcanonicalPath {
  let result = chem_mol_repr_canonical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_path_add(a : ChemmolreprcanonicalPath, b : ChemmolreprcanonicalPath) -> ChemmolreprcanonicalPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_path_copy(s : ChemmolreprcanonicalPath) -> ChemmolreprcanonicalPath {
  let result = chem_mol_repr_canonical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_path_fill(s : ChemmolreprcanonicalPath, v : Double) -> ChemmolreprcanonicalPath {
  let result = chem_mol_repr_canonical_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_path_min(s : ChemmolreprcanonicalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_path_max(s : ChemmolreprcanonicalPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_path_to_string(s : ChemmolreprcanonicalPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_cluster_make(size : Int) -> ChemmolreprcanonicalCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_cluster_len(s : ChemmolreprcanonicalCluster) -> Int { s.size }

pub fn chem_mol_repr_canonical_cluster_get(s : ChemmolreprcanonicalCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_cluster_set(s : ChemmolreprcanonicalCluster, i : Int, v : Double) -> ChemmolreprcanonicalCluster {
  let result = chem_mol_repr_canonical_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_cluster_sum(s : ChemmolreprcanonicalCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_cluster_mean(s : ChemmolreprcanonicalCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_cluster_scale(s : ChemmolreprcanonicalCluster, f : Double) -> ChemmolreprcanonicalCluster {
  let result = chem_mol_repr_canonical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_cluster_add(a : ChemmolreprcanonicalCluster, b : ChemmolreprcanonicalCluster) -> ChemmolreprcanonicalCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_cluster_copy(s : ChemmolreprcanonicalCluster) -> ChemmolreprcanonicalCluster {
  let result = chem_mol_repr_canonical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_cluster_fill(s : ChemmolreprcanonicalCluster, v : Double) -> ChemmolreprcanonicalCluster {
  let result = chem_mol_repr_canonical_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_cluster_min(s : ChemmolreprcanonicalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_cluster_max(s : ChemmolreprcanonicalCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_cluster_to_string(s : ChemmolreprcanonicalCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_model_make(size : Int) -> ChemmolreprcanonicalModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_model_len(s : ChemmolreprcanonicalModel) -> Int { s.size }

pub fn chem_mol_repr_canonical_model_get(s : ChemmolreprcanonicalModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_model_set(s : ChemmolreprcanonicalModel, i : Int, v : Double) -> ChemmolreprcanonicalModel {
  let result = chem_mol_repr_canonical_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_model_sum(s : ChemmolreprcanonicalModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_model_mean(s : ChemmolreprcanonicalModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_model_scale(s : ChemmolreprcanonicalModel, f : Double) -> ChemmolreprcanonicalModel {
  let result = chem_mol_repr_canonical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_model_add(a : ChemmolreprcanonicalModel, b : ChemmolreprcanonicalModel) -> ChemmolreprcanonicalModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_model_copy(s : ChemmolreprcanonicalModel) -> ChemmolreprcanonicalModel {
  let result = chem_mol_repr_canonical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_model_fill(s : ChemmolreprcanonicalModel, v : Double) -> ChemmolreprcanonicalModel {
  let result = chem_mol_repr_canonical_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_model_min(s : ChemmolreprcanonicalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_model_max(s : ChemmolreprcanonicalModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_model_to_string(s : ChemmolreprcanonicalModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_layer_make(size : Int) -> ChemmolreprcanonicalLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_layer_len(s : ChemmolreprcanonicalLayer) -> Int { s.size }

pub fn chem_mol_repr_canonical_layer_get(s : ChemmolreprcanonicalLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_layer_set(s : ChemmolreprcanonicalLayer, i : Int, v : Double) -> ChemmolreprcanonicalLayer {
  let result = chem_mol_repr_canonical_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_layer_sum(s : ChemmolreprcanonicalLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_layer_mean(s : ChemmolreprcanonicalLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_layer_scale(s : ChemmolreprcanonicalLayer, f : Double) -> ChemmolreprcanonicalLayer {
  let result = chem_mol_repr_canonical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_layer_add(a : ChemmolreprcanonicalLayer, b : ChemmolreprcanonicalLayer) -> ChemmolreprcanonicalLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_layer_copy(s : ChemmolreprcanonicalLayer) -> ChemmolreprcanonicalLayer {
  let result = chem_mol_repr_canonical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_layer_fill(s : ChemmolreprcanonicalLayer, v : Double) -> ChemmolreprcanonicalLayer {
  let result = chem_mol_repr_canonical_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_layer_min(s : ChemmolreprcanonicalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_layer_max(s : ChemmolreprcanonicalLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_layer_to_string(s : ChemmolreprcanonicalLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_buffer_make(size : Int) -> ChemmolreprcanonicalBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_buffer_len(s : ChemmolreprcanonicalBuffer) -> Int { s.size }

pub fn chem_mol_repr_canonical_buffer_get(s : ChemmolreprcanonicalBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_buffer_set(s : ChemmolreprcanonicalBuffer, i : Int, v : Double) -> ChemmolreprcanonicalBuffer {
  let result = chem_mol_repr_canonical_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_buffer_sum(s : ChemmolreprcanonicalBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_buffer_mean(s : ChemmolreprcanonicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_buffer_scale(s : ChemmolreprcanonicalBuffer, f : Double) -> ChemmolreprcanonicalBuffer {
  let result = chem_mol_repr_canonical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_buffer_add(a : ChemmolreprcanonicalBuffer, b : ChemmolreprcanonicalBuffer) -> ChemmolreprcanonicalBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_buffer_copy(s : ChemmolreprcanonicalBuffer) -> ChemmolreprcanonicalBuffer {
  let result = chem_mol_repr_canonical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_buffer_fill(s : ChemmolreprcanonicalBuffer, v : Double) -> ChemmolreprcanonicalBuffer {
  let result = chem_mol_repr_canonical_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_buffer_min(s : ChemmolreprcanonicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_buffer_max(s : ChemmolreprcanonicalBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_buffer_to_string(s : ChemmolreprcanonicalBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_cursor_make(size : Int) -> ChemmolreprcanonicalCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_cursor_len(s : ChemmolreprcanonicalCursor) -> Int { s.size }

pub fn chem_mol_repr_canonical_cursor_get(s : ChemmolreprcanonicalCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_cursor_set(s : ChemmolreprcanonicalCursor, i : Int, v : Double) -> ChemmolreprcanonicalCursor {
  let result = chem_mol_repr_canonical_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_cursor_sum(s : ChemmolreprcanonicalCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_cursor_mean(s : ChemmolreprcanonicalCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_cursor_scale(s : ChemmolreprcanonicalCursor, f : Double) -> ChemmolreprcanonicalCursor {
  let result = chem_mol_repr_canonical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_cursor_add(a : ChemmolreprcanonicalCursor, b : ChemmolreprcanonicalCursor) -> ChemmolreprcanonicalCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_cursor_copy(s : ChemmolreprcanonicalCursor) -> ChemmolreprcanonicalCursor {
  let result = chem_mol_repr_canonical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_cursor_fill(s : ChemmolreprcanonicalCursor, v : Double) -> ChemmolreprcanonicalCursor {
  let result = chem_mol_repr_canonical_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_cursor_min(s : ChemmolreprcanonicalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_cursor_max(s : ChemmolreprcanonicalCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_cursor_to_string(s : ChemmolreprcanonicalCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_view_make(size : Int) -> ChemmolreprcanonicalView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_view_len(s : ChemmolreprcanonicalView) -> Int { s.size }

pub fn chem_mol_repr_canonical_view_get(s : ChemmolreprcanonicalView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_view_set(s : ChemmolreprcanonicalView, i : Int, v : Double) -> ChemmolreprcanonicalView {
  let result = chem_mol_repr_canonical_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_view_sum(s : ChemmolreprcanonicalView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_view_mean(s : ChemmolreprcanonicalView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_view_scale(s : ChemmolreprcanonicalView, f : Double) -> ChemmolreprcanonicalView {
  let result = chem_mol_repr_canonical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_view_add(a : ChemmolreprcanonicalView, b : ChemmolreprcanonicalView) -> ChemmolreprcanonicalView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_view_copy(s : ChemmolreprcanonicalView) -> ChemmolreprcanonicalView {
  let result = chem_mol_repr_canonical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_view_fill(s : ChemmolreprcanonicalView, v : Double) -> ChemmolreprcanonicalView {
  let result = chem_mol_repr_canonical_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_view_min(s : ChemmolreprcanonicalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_view_max(s : ChemmolreprcanonicalView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_view_to_string(s : ChemmolreprcanonicalView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_range_make(size : Int) -> ChemmolreprcanonicalRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_range_len(s : ChemmolreprcanonicalRange) -> Int { s.size }

pub fn chem_mol_repr_canonical_range_get(s : ChemmolreprcanonicalRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_range_set(s : ChemmolreprcanonicalRange, i : Int, v : Double) -> ChemmolreprcanonicalRange {
  let result = chem_mol_repr_canonical_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_range_sum(s : ChemmolreprcanonicalRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_range_mean(s : ChemmolreprcanonicalRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_range_scale(s : ChemmolreprcanonicalRange, f : Double) -> ChemmolreprcanonicalRange {
  let result = chem_mol_repr_canonical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_range_add(a : ChemmolreprcanonicalRange, b : ChemmolreprcanonicalRange) -> ChemmolreprcanonicalRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_range_copy(s : ChemmolreprcanonicalRange) -> ChemmolreprcanonicalRange {
  let result = chem_mol_repr_canonical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_range_fill(s : ChemmolreprcanonicalRange, v : Double) -> ChemmolreprcanonicalRange {
  let result = chem_mol_repr_canonical_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_range_min(s : ChemmolreprcanonicalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_range_max(s : ChemmolreprcanonicalRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_range_to_string(s : ChemmolreprcanonicalRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolreprcanonicalSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_repr_canonical_slice_make(size : Int) -> ChemmolreprcanonicalSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_repr_canonical_slice_len(s : ChemmolreprcanonicalSlice) -> Int { s.size }

pub fn chem_mol_repr_canonical_slice_get(s : ChemmolreprcanonicalSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_repr_canonical_slice_set(s : ChemmolreprcanonicalSlice, i : Int, v : Double) -> ChemmolreprcanonicalSlice {
  let result = chem_mol_repr_canonical_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_slice_sum(s : ChemmolreprcanonicalSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_repr_canonical_slice_mean(s : ChemmolreprcanonicalSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_repr_canonical_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_repr_canonical_slice_scale(s : ChemmolreprcanonicalSlice, f : Double) -> ChemmolreprcanonicalSlice {
  let result = chem_mol_repr_canonical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_repr_canonical_slice_add(a : ChemmolreprcanonicalSlice, b : ChemmolreprcanonicalSlice) -> ChemmolreprcanonicalSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_repr_canonical_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_repr_canonical_slice_copy(s : ChemmolreprcanonicalSlice) -> ChemmolreprcanonicalSlice {
  let result = chem_mol_repr_canonical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_repr_canonical_slice_fill(s : ChemmolreprcanonicalSlice, v : Double) -> ChemmolreprcanonicalSlice {
  let result = chem_mol_repr_canonical_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_repr_canonical_slice_min(s : ChemmolreprcanonicalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_slice_max(s : ChemmolreprcanonicalSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_repr_canonical_slice_to_string(s : ChemmolreprcanonicalSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

