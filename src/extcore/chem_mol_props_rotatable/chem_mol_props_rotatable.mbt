///===
/// extcore/chem_mol_props_rotatable

pub(all) struct ChemmolpropsrotatablePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_rotatable_make_point(x : Double, y : Double) -> ChemmolpropsrotatablePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_rotatable_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropsrotatablePoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_rotatable_point_x(pt : ChemmolpropsrotatablePoint) -> Double { pt.x }

pub fn chem_mol_props_rotatable_point_y(pt : ChemmolpropsrotatablePoint) -> Double { pt.y }

pub fn chem_mol_props_rotatable_point_z(pt : ChemmolpropsrotatablePoint) -> Double { pt.z }

pub fn chem_mol_props_rotatable_point_label(pt : ChemmolpropsrotatablePoint) -> Int { pt.label }

pub fn chem_mol_props_rotatable_point_dist(a : ChemmolpropsrotatablePoint, b : ChemmolpropsrotatablePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_rotatable_point_add(a : ChemmolpropsrotatablePoint, b : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_rotatable_point_sub(a : ChemmolpropsrotatablePoint, b : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_rotatable_point_scale(pt : ChemmolpropsrotatablePoint, s : Double) -> ChemmolpropsrotatablePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_rotatable_point_dot(a : ChemmolpropsrotatablePoint, b : ChemmolpropsrotatablePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_rotatable_point_cross(a : ChemmolpropsrotatablePoint, b : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_rotatable_point_norm(pt : ChemmolpropsrotatablePoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_rotatable_point_normalize(pt : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  let n = chem_mol_props_rotatable_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_rotatable_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_rotatable_point_negate(pt : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_rotatable_point_mid(a : ChemmolpropsrotatablePoint, b : ChemmolpropsrotatablePoint) -> ChemmolpropsrotatablePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_rotatable_point_lerp(a : ChemmolpropsrotatablePoint, b : ChemmolpropsrotatablePoint, t : Double) -> ChemmolpropsrotatablePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_rotatable_point_to_string(pt : ChemmolpropsrotatablePoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_rotatable_make_series(vals : Array[Double], name : String) -> ChemmolpropsrotatableSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_rotatable_series_len(s : ChemmolpropsrotatableSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_rotatable_series_sum(s : ChemmolpropsrotatableSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_props_rotatable_series_mean(s : ChemmolpropsrotatableSeries) -> Double {
  let n = chem_mol_props_rotatable_series_len(s)
  if n == 0 { 0.0 } else { chem_mol_props_rotatable_series_sum(s) / n.to_double() }
}

pub fn chem_mol_props_rotatable_series_min(s : ChemmolpropsrotatableSeries) -> Double {
  let n = chem_mol_props_rotatable_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_series_max(s : ChemmolpropsrotatableSeries) -> Double {
  let n = chem_mol_props_rotatable_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_series_range(s : ChemmolpropsrotatableSeries) -> Double {
  chem_mol_props_rotatable_series_max(s) - chem_mol_props_rotatable_series_min(s)
}

pub fn chem_mol_props_rotatable_series_var(s : ChemmolpropsrotatableSeries) -> Double {
  let n = chem_mol_props_rotatable_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_mol_props_rotatable_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_mol_props_rotatable_series_std(s : ChemmolpropsrotatableSeries) -> Double { @_common.sqrt(chem_mol_props_rotatable_series_var(s)) }

pub fn chem_mol_props_rotatable_series_median(s : ChemmolpropsrotatableSeries) -> Double {
  let n = chem_mol_props_rotatable_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_props_rotatable_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_props_rotatable_series_scale(s : ChemmolpropsrotatableSeries, f : Double) -> ChemmolpropsrotatableSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_props_rotatable_series_add(a : ChemmolpropsrotatableSeries, b : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_rotatable_series_sub(a : ChemmolpropsrotatableSeries, b : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_rotatable_series_normalize(s : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  let mn = chem_mol_props_rotatable_series_min(s)
  let mx = chem_mol_props_rotatable_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_rotatable_series_cumsum(s : ChemmolpropsrotatableSeries) -> ChemmolpropsrotatableSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_rotatable_series_to_string(s : ChemmolpropsrotatableSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropsrotatableMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_rotatable_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropsrotatableMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_rotatable_matrix_identity(n : Int) -> ChemmolpropsrotatableMatrix {
  let m = chem_mol_props_rotatable_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_rotatable_matrix_get(m : ChemmolpropsrotatableMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_rotatable_matrix_transpose(m : ChemmolpropsrotatableMatrix) -> ChemmolpropsrotatableMatrix {
  let result = chem_mol_props_rotatable_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_rotatable_matrix_add(a : ChemmolpropsrotatableMatrix, b : ChemmolpropsrotatableMatrix) -> ChemmolpropsrotatableMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_rotatable_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_rotatable_matrix_scale(m : ChemmolpropsrotatableMatrix, s : Double) -> ChemmolpropsrotatableMatrix {
  let result = chem_mol_props_rotatable_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_rotatable_matrix_multiply(a : ChemmolpropsrotatableMatrix, b : ChemmolpropsrotatableMatrix) -> ChemmolpropsrotatableMatrix {
  if a.cols != b.rows { return chem_mol_props_rotatable_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_rotatable_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_rotatable_matrix_trace(m : ChemmolpropsrotatableMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_rotatable_matrix_det(m : ChemmolpropsrotatableMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_rotatable_matrix_norm(m : ChemmolpropsrotatableMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_props_rotatable_matrix_to_string(m : ChemmolpropsrotatableMatrix) -> String {
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

pub(all) struct ChemmolpropsrotatableVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_rotatable_make_vector(comps : Array[Double]) -> ChemmolpropsrotatableVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_rotatable_vector_zero(dim : Int) -> ChemmolpropsrotatableVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_rotatable_vector_add(a : ChemmolpropsrotatableVector, b : ChemmolpropsrotatableVector) -> ChemmolpropsrotatableVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_rotatable_vector_sub(a : ChemmolpropsrotatableVector, b : ChemmolpropsrotatableVector) -> ChemmolpropsrotatableVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_rotatable_vector_scale(v : ChemmolpropsrotatableVector, s : Double) -> ChemmolpropsrotatableVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_props_rotatable_vector_dot(a : ChemmolpropsrotatableVector, b : ChemmolpropsrotatableVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_rotatable_vector_norm(v : ChemmolpropsrotatableVector) -> Double { @_common.sqrt(chem_mol_props_rotatable_vector_dot(v, v)) }

pub fn chem_mol_props_rotatable_vector_normalize(v : ChemmolpropsrotatableVector) -> ChemmolpropsrotatableVector {
  let n = chem_mol_props_rotatable_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_rotatable_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_rotatable_vector_dist(a : ChemmolpropsrotatableVector, b : ChemmolpropsrotatableVector) -> Double {
  chem_mol_props_rotatable_vector_norm(chem_mol_props_rotatable_vector_sub(a, b))
}

pub fn chem_mol_props_rotatable_vector_to_string(v : ChemmolpropsrotatableVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_rotatable_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_rotatable_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_mol_props_rotatable_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_rotatable_std(data : Array[Double]) -> Double { @_common.sqrt(chem_mol_props_rotatable_var(data)) }

pub fn chem_mol_props_rotatable_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_mol_props_rotatable_mean(a); let mb = chem_mol_props_rotatable_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_rotatable_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_mol_props_rotatable_std(a); let sb = chem_mol_props_rotatable_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_mol_props_rotatable_cov(a, b) / (sa * sb) }
}

pub fn chem_mol_props_rotatable_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_props_rotatable_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_props_rotatable_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_mol_props_rotatable_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_rotatable_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(chem_mol_props_rotatable_mse(pred, labels))
}

pub fn chem_mol_props_rotatable_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_rotatable_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_mol_props_rotatable_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_mol_props_rotatable_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_mol_props_rotatable_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_mol_props_rotatable_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_mol_props_rotatable_precision(pred, labels, pos); let r = chem_mol_props_rotatable_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_mol_props_rotatable_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_mol_props_rotatable_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_mol_props_rotatable_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_mol_props_rotatable_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_mol_props_rotatable_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_mol_props_rotatable_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_mol_props_rotatable_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_mol_props_rotatable_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_mol_props_rotatable_fibonacci(n : Int) -> Int {
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

pub fn chem_mol_props_rotatable_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_mol_props_rotatable_min(data); let mx = chem_mol_props_rotatable_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_mol_props_rotatable_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_mol_props_rotatable_mean(data); let sd = chem_mol_props_rotatable_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_mol_props_rotatable_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_mol_props_rotatable_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_mol_props_rotatable_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_mol_props_rotatable_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ChemmolpropsrotatableFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_frame_make(size : Int) -> ChemmolpropsrotatableFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_frame_len(s : ChemmolpropsrotatableFrame) -> Int { s.size }

pub fn chem_mol_props_rotatable_frame_get(s : ChemmolpropsrotatableFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_frame_set(s : ChemmolpropsrotatableFrame, i : Int, v : Double) -> ChemmolpropsrotatableFrame {
  let result = chem_mol_props_rotatable_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_frame_sum(s : ChemmolpropsrotatableFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_frame_mean(s : ChemmolpropsrotatableFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_frame_scale(s : ChemmolpropsrotatableFrame, f : Double) -> ChemmolpropsrotatableFrame {
  let result = chem_mol_props_rotatable_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_frame_add(a : ChemmolpropsrotatableFrame, b : ChemmolpropsrotatableFrame) -> ChemmolpropsrotatableFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_frame_copy(s : ChemmolpropsrotatableFrame) -> ChemmolpropsrotatableFrame {
  let result = chem_mol_props_rotatable_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_frame_fill(s : ChemmolpropsrotatableFrame, v : Double) -> ChemmolpropsrotatableFrame {
  let result = chem_mol_props_rotatable_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_frame_min(s : ChemmolpropsrotatableFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_frame_max(s : ChemmolpropsrotatableFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_frame_to_string(s : ChemmolpropsrotatableFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_table_make(size : Int) -> ChemmolpropsrotatableTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_table_len(s : ChemmolpropsrotatableTable) -> Int { s.size }

pub fn chem_mol_props_rotatable_table_get(s : ChemmolpropsrotatableTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_table_set(s : ChemmolpropsrotatableTable, i : Int, v : Double) -> ChemmolpropsrotatableTable {
  let result = chem_mol_props_rotatable_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_table_sum(s : ChemmolpropsrotatableTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_table_mean(s : ChemmolpropsrotatableTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_table_scale(s : ChemmolpropsrotatableTable, f : Double) -> ChemmolpropsrotatableTable {
  let result = chem_mol_props_rotatable_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_table_add(a : ChemmolpropsrotatableTable, b : ChemmolpropsrotatableTable) -> ChemmolpropsrotatableTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_table_copy(s : ChemmolpropsrotatableTable) -> ChemmolpropsrotatableTable {
  let result = chem_mol_props_rotatable_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_table_fill(s : ChemmolpropsrotatableTable, v : Double) -> ChemmolpropsrotatableTable {
  let result = chem_mol_props_rotatable_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_table_min(s : ChemmolpropsrotatableTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_table_max(s : ChemmolpropsrotatableTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_table_to_string(s : ChemmolpropsrotatableTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_graphn_make(size : Int) -> ChemmolpropsrotatableGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_graphn_len(s : ChemmolpropsrotatableGraphN) -> Int { s.size }

pub fn chem_mol_props_rotatable_graphn_get(s : ChemmolpropsrotatableGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_graphn_set(s : ChemmolpropsrotatableGraphN, i : Int, v : Double) -> ChemmolpropsrotatableGraphN {
  let result = chem_mol_props_rotatable_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_graphn_sum(s : ChemmolpropsrotatableGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_graphn_mean(s : ChemmolpropsrotatableGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_graphn_scale(s : ChemmolpropsrotatableGraphN, f : Double) -> ChemmolpropsrotatableGraphN {
  let result = chem_mol_props_rotatable_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_graphn_add(a : ChemmolpropsrotatableGraphN, b : ChemmolpropsrotatableGraphN) -> ChemmolpropsrotatableGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_graphn_copy(s : ChemmolpropsrotatableGraphN) -> ChemmolpropsrotatableGraphN {
  let result = chem_mol_props_rotatable_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_graphn_fill(s : ChemmolpropsrotatableGraphN, v : Double) -> ChemmolpropsrotatableGraphN {
  let result = chem_mol_props_rotatable_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_graphn_min(s : ChemmolpropsrotatableGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_graphn_max(s : ChemmolpropsrotatableGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_graphn_to_string(s : ChemmolpropsrotatableGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_node_make(size : Int) -> ChemmolpropsrotatableNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_node_len(s : ChemmolpropsrotatableNode) -> Int { s.size }

pub fn chem_mol_props_rotatable_node_get(s : ChemmolpropsrotatableNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_node_set(s : ChemmolpropsrotatableNode, i : Int, v : Double) -> ChemmolpropsrotatableNode {
  let result = chem_mol_props_rotatable_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_node_sum(s : ChemmolpropsrotatableNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_node_mean(s : ChemmolpropsrotatableNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_node_scale(s : ChemmolpropsrotatableNode, f : Double) -> ChemmolpropsrotatableNode {
  let result = chem_mol_props_rotatable_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_node_add(a : ChemmolpropsrotatableNode, b : ChemmolpropsrotatableNode) -> ChemmolpropsrotatableNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_node_copy(s : ChemmolpropsrotatableNode) -> ChemmolpropsrotatableNode {
  let result = chem_mol_props_rotatable_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_node_fill(s : ChemmolpropsrotatableNode, v : Double) -> ChemmolpropsrotatableNode {
  let result = chem_mol_props_rotatable_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_node_min(s : ChemmolpropsrotatableNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_node_max(s : ChemmolpropsrotatableNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_node_to_string(s : ChemmolpropsrotatableNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_edge_make(size : Int) -> ChemmolpropsrotatableEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_edge_len(s : ChemmolpropsrotatableEdge) -> Int { s.size }

pub fn chem_mol_props_rotatable_edge_get(s : ChemmolpropsrotatableEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_edge_set(s : ChemmolpropsrotatableEdge, i : Int, v : Double) -> ChemmolpropsrotatableEdge {
  let result = chem_mol_props_rotatable_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_edge_sum(s : ChemmolpropsrotatableEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_edge_mean(s : ChemmolpropsrotatableEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_edge_scale(s : ChemmolpropsrotatableEdge, f : Double) -> ChemmolpropsrotatableEdge {
  let result = chem_mol_props_rotatable_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_edge_add(a : ChemmolpropsrotatableEdge, b : ChemmolpropsrotatableEdge) -> ChemmolpropsrotatableEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_edge_copy(s : ChemmolpropsrotatableEdge) -> ChemmolpropsrotatableEdge {
  let result = chem_mol_props_rotatable_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_edge_fill(s : ChemmolpropsrotatableEdge, v : Double) -> ChemmolpropsrotatableEdge {
  let result = chem_mol_props_rotatable_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_edge_min(s : ChemmolpropsrotatableEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_edge_max(s : ChemmolpropsrotatableEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_edge_to_string(s : ChemmolpropsrotatableEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatablePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_path_make(size : Int) -> ChemmolpropsrotatablePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_path_len(s : ChemmolpropsrotatablePath) -> Int { s.size }

pub fn chem_mol_props_rotatable_path_get(s : ChemmolpropsrotatablePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_path_set(s : ChemmolpropsrotatablePath, i : Int, v : Double) -> ChemmolpropsrotatablePath {
  let result = chem_mol_props_rotatable_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_path_sum(s : ChemmolpropsrotatablePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_path_mean(s : ChemmolpropsrotatablePath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_path_scale(s : ChemmolpropsrotatablePath, f : Double) -> ChemmolpropsrotatablePath {
  let result = chem_mol_props_rotatable_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_path_add(a : ChemmolpropsrotatablePath, b : ChemmolpropsrotatablePath) -> ChemmolpropsrotatablePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_path_copy(s : ChemmolpropsrotatablePath) -> ChemmolpropsrotatablePath {
  let result = chem_mol_props_rotatable_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_path_fill(s : ChemmolpropsrotatablePath, v : Double) -> ChemmolpropsrotatablePath {
  let result = chem_mol_props_rotatable_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_path_min(s : ChemmolpropsrotatablePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_path_max(s : ChemmolpropsrotatablePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_path_to_string(s : ChemmolpropsrotatablePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_cluster_make(size : Int) -> ChemmolpropsrotatableCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_cluster_len(s : ChemmolpropsrotatableCluster) -> Int { s.size }

pub fn chem_mol_props_rotatable_cluster_get(s : ChemmolpropsrotatableCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_cluster_set(s : ChemmolpropsrotatableCluster, i : Int, v : Double) -> ChemmolpropsrotatableCluster {
  let result = chem_mol_props_rotatable_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_cluster_sum(s : ChemmolpropsrotatableCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_cluster_mean(s : ChemmolpropsrotatableCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_cluster_scale(s : ChemmolpropsrotatableCluster, f : Double) -> ChemmolpropsrotatableCluster {
  let result = chem_mol_props_rotatable_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_cluster_add(a : ChemmolpropsrotatableCluster, b : ChemmolpropsrotatableCluster) -> ChemmolpropsrotatableCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_cluster_copy(s : ChemmolpropsrotatableCluster) -> ChemmolpropsrotatableCluster {
  let result = chem_mol_props_rotatable_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_cluster_fill(s : ChemmolpropsrotatableCluster, v : Double) -> ChemmolpropsrotatableCluster {
  let result = chem_mol_props_rotatable_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_cluster_min(s : ChemmolpropsrotatableCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_cluster_max(s : ChemmolpropsrotatableCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_cluster_to_string(s : ChemmolpropsrotatableCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_model_make(size : Int) -> ChemmolpropsrotatableModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_model_len(s : ChemmolpropsrotatableModel) -> Int { s.size }

pub fn chem_mol_props_rotatable_model_get(s : ChemmolpropsrotatableModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_model_set(s : ChemmolpropsrotatableModel, i : Int, v : Double) -> ChemmolpropsrotatableModel {
  let result = chem_mol_props_rotatable_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_model_sum(s : ChemmolpropsrotatableModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_model_mean(s : ChemmolpropsrotatableModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_model_scale(s : ChemmolpropsrotatableModel, f : Double) -> ChemmolpropsrotatableModel {
  let result = chem_mol_props_rotatable_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_model_add(a : ChemmolpropsrotatableModel, b : ChemmolpropsrotatableModel) -> ChemmolpropsrotatableModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_model_copy(s : ChemmolpropsrotatableModel) -> ChemmolpropsrotatableModel {
  let result = chem_mol_props_rotatable_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_model_fill(s : ChemmolpropsrotatableModel, v : Double) -> ChemmolpropsrotatableModel {
  let result = chem_mol_props_rotatable_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_model_min(s : ChemmolpropsrotatableModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_model_max(s : ChemmolpropsrotatableModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_model_to_string(s : ChemmolpropsrotatableModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_layer_make(size : Int) -> ChemmolpropsrotatableLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_layer_len(s : ChemmolpropsrotatableLayer) -> Int { s.size }

pub fn chem_mol_props_rotatable_layer_get(s : ChemmolpropsrotatableLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_layer_set(s : ChemmolpropsrotatableLayer, i : Int, v : Double) -> ChemmolpropsrotatableLayer {
  let result = chem_mol_props_rotatable_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_layer_sum(s : ChemmolpropsrotatableLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_layer_mean(s : ChemmolpropsrotatableLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_layer_scale(s : ChemmolpropsrotatableLayer, f : Double) -> ChemmolpropsrotatableLayer {
  let result = chem_mol_props_rotatable_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_layer_add(a : ChemmolpropsrotatableLayer, b : ChemmolpropsrotatableLayer) -> ChemmolpropsrotatableLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_layer_copy(s : ChemmolpropsrotatableLayer) -> ChemmolpropsrotatableLayer {
  let result = chem_mol_props_rotatable_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_layer_fill(s : ChemmolpropsrotatableLayer, v : Double) -> ChemmolpropsrotatableLayer {
  let result = chem_mol_props_rotatable_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_layer_min(s : ChemmolpropsrotatableLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_layer_max(s : ChemmolpropsrotatableLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_layer_to_string(s : ChemmolpropsrotatableLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_buffer_make(size : Int) -> ChemmolpropsrotatableBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_buffer_len(s : ChemmolpropsrotatableBuffer) -> Int { s.size }

pub fn chem_mol_props_rotatable_buffer_get(s : ChemmolpropsrotatableBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_buffer_set(s : ChemmolpropsrotatableBuffer, i : Int, v : Double) -> ChemmolpropsrotatableBuffer {
  let result = chem_mol_props_rotatable_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_buffer_sum(s : ChemmolpropsrotatableBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_buffer_mean(s : ChemmolpropsrotatableBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_buffer_scale(s : ChemmolpropsrotatableBuffer, f : Double) -> ChemmolpropsrotatableBuffer {
  let result = chem_mol_props_rotatable_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_buffer_add(a : ChemmolpropsrotatableBuffer, b : ChemmolpropsrotatableBuffer) -> ChemmolpropsrotatableBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_buffer_copy(s : ChemmolpropsrotatableBuffer) -> ChemmolpropsrotatableBuffer {
  let result = chem_mol_props_rotatable_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_buffer_fill(s : ChemmolpropsrotatableBuffer, v : Double) -> ChemmolpropsrotatableBuffer {
  let result = chem_mol_props_rotatable_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_buffer_min(s : ChemmolpropsrotatableBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_buffer_max(s : ChemmolpropsrotatableBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_buffer_to_string(s : ChemmolpropsrotatableBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_cursor_make(size : Int) -> ChemmolpropsrotatableCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_cursor_len(s : ChemmolpropsrotatableCursor) -> Int { s.size }

pub fn chem_mol_props_rotatable_cursor_get(s : ChemmolpropsrotatableCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_cursor_set(s : ChemmolpropsrotatableCursor, i : Int, v : Double) -> ChemmolpropsrotatableCursor {
  let result = chem_mol_props_rotatable_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_cursor_sum(s : ChemmolpropsrotatableCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_cursor_mean(s : ChemmolpropsrotatableCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_cursor_scale(s : ChemmolpropsrotatableCursor, f : Double) -> ChemmolpropsrotatableCursor {
  let result = chem_mol_props_rotatable_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_cursor_add(a : ChemmolpropsrotatableCursor, b : ChemmolpropsrotatableCursor) -> ChemmolpropsrotatableCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_cursor_copy(s : ChemmolpropsrotatableCursor) -> ChemmolpropsrotatableCursor {
  let result = chem_mol_props_rotatable_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_cursor_fill(s : ChemmolpropsrotatableCursor, v : Double) -> ChemmolpropsrotatableCursor {
  let result = chem_mol_props_rotatable_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_cursor_min(s : ChemmolpropsrotatableCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_cursor_max(s : ChemmolpropsrotatableCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_cursor_to_string(s : ChemmolpropsrotatableCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_view_make(size : Int) -> ChemmolpropsrotatableView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_view_len(s : ChemmolpropsrotatableView) -> Int { s.size }

pub fn chem_mol_props_rotatable_view_get(s : ChemmolpropsrotatableView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_view_set(s : ChemmolpropsrotatableView, i : Int, v : Double) -> ChemmolpropsrotatableView {
  let result = chem_mol_props_rotatable_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_view_sum(s : ChemmolpropsrotatableView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_view_mean(s : ChemmolpropsrotatableView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_view_scale(s : ChemmolpropsrotatableView, f : Double) -> ChemmolpropsrotatableView {
  let result = chem_mol_props_rotatable_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_view_add(a : ChemmolpropsrotatableView, b : ChemmolpropsrotatableView) -> ChemmolpropsrotatableView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_view_copy(s : ChemmolpropsrotatableView) -> ChemmolpropsrotatableView {
  let result = chem_mol_props_rotatable_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_view_fill(s : ChemmolpropsrotatableView, v : Double) -> ChemmolpropsrotatableView {
  let result = chem_mol_props_rotatable_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_view_min(s : ChemmolpropsrotatableView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_view_max(s : ChemmolpropsrotatableView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_view_to_string(s : ChemmolpropsrotatableView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_range_make(size : Int) -> ChemmolpropsrotatableRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_range_len(s : ChemmolpropsrotatableRange) -> Int { s.size }

pub fn chem_mol_props_rotatable_range_get(s : ChemmolpropsrotatableRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_range_set(s : ChemmolpropsrotatableRange, i : Int, v : Double) -> ChemmolpropsrotatableRange {
  let result = chem_mol_props_rotatable_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_range_sum(s : ChemmolpropsrotatableRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_range_mean(s : ChemmolpropsrotatableRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_range_scale(s : ChemmolpropsrotatableRange, f : Double) -> ChemmolpropsrotatableRange {
  let result = chem_mol_props_rotatable_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_range_add(a : ChemmolpropsrotatableRange, b : ChemmolpropsrotatableRange) -> ChemmolpropsrotatableRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_range_copy(s : ChemmolpropsrotatableRange) -> ChemmolpropsrotatableRange {
  let result = chem_mol_props_rotatable_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_range_fill(s : ChemmolpropsrotatableRange, v : Double) -> ChemmolpropsrotatableRange {
  let result = chem_mol_props_rotatable_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_range_min(s : ChemmolpropsrotatableRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_range_max(s : ChemmolpropsrotatableRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_range_to_string(s : ChemmolpropsrotatableRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropsrotatableSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_rotatable_slice_make(size : Int) -> ChemmolpropsrotatableSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_rotatable_slice_len(s : ChemmolpropsrotatableSlice) -> Int { s.size }

pub fn chem_mol_props_rotatable_slice_get(s : ChemmolpropsrotatableSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_rotatable_slice_set(s : ChemmolpropsrotatableSlice, i : Int, v : Double) -> ChemmolpropsrotatableSlice {
  let result = chem_mol_props_rotatable_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_slice_sum(s : ChemmolpropsrotatableSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_rotatable_slice_mean(s : ChemmolpropsrotatableSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_rotatable_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_rotatable_slice_scale(s : ChemmolpropsrotatableSlice, f : Double) -> ChemmolpropsrotatableSlice {
  let result = chem_mol_props_rotatable_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_rotatable_slice_add(a : ChemmolpropsrotatableSlice, b : ChemmolpropsrotatableSlice) -> ChemmolpropsrotatableSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_rotatable_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_rotatable_slice_copy(s : ChemmolpropsrotatableSlice) -> ChemmolpropsrotatableSlice {
  let result = chem_mol_props_rotatable_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_rotatable_slice_fill(s : ChemmolpropsrotatableSlice, v : Double) -> ChemmolpropsrotatableSlice {
  let result = chem_mol_props_rotatable_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_rotatable_slice_min(s : ChemmolpropsrotatableSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_slice_max(s : ChemmolpropsrotatableSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_rotatable_slice_to_string(s : ChemmolpropsrotatableSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

