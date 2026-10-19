///===
/// extcore/chem_mol_props_hbd

pub(all) struct ChemmolpropshbdPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_hbd_make_point(x : Double, y : Double) -> ChemmolpropshbdPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_hbd_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropshbdPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_hbd_point_x(pt : ChemmolpropshbdPoint) -> Double { pt.x }

pub fn chem_mol_props_hbd_point_y(pt : ChemmolpropshbdPoint) -> Double { pt.y }

pub fn chem_mol_props_hbd_point_z(pt : ChemmolpropshbdPoint) -> Double { pt.z }

pub fn chem_mol_props_hbd_point_label(pt : ChemmolpropshbdPoint) -> Int { pt.label }

pub fn chem_mol_props_hbd_point_dist(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_hbd_point_add(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_hbd_point_sub(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_hbd_point_scale(pt : ChemmolpropshbdPoint, s : Double) -> ChemmolpropshbdPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_hbd_point_dot(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_hbd_point_cross(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_hbd_point_norm(pt : ChemmolpropshbdPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_hbd_point_normalize(pt : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  let n = chem_mol_props_hbd_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_hbd_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_hbd_point_negate(pt : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_hbd_point_mid(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint) -> ChemmolpropshbdPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_hbd_point_lerp(a : ChemmolpropshbdPoint, b : ChemmolpropshbdPoint, t : Double) -> ChemmolpropshbdPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_hbd_point_to_string(pt : ChemmolpropshbdPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropshbdSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_hbd_make_series(vals : Array[Double], name : String) -> ChemmolpropshbdSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_hbd_series_len(s : ChemmolpropshbdSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_hbd_series_sum(s : ChemmolpropshbdSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_props_hbd_series_mean(s : ChemmolpropshbdSeries) -> Double {
  let n = chem_mol_props_hbd_series_len(s)
  if n == 0 { 0.0 } else { chem_mol_props_hbd_series_sum(s) / n.to_double() }
}

pub fn chem_mol_props_hbd_series_min(s : ChemmolpropshbdSeries) -> Double {
  let n = chem_mol_props_hbd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_series_max(s : ChemmolpropshbdSeries) -> Double {
  let n = chem_mol_props_hbd_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_series_range(s : ChemmolpropshbdSeries) -> Double {
  chem_mol_props_hbd_series_max(s) - chem_mol_props_hbd_series_min(s)
}

pub fn chem_mol_props_hbd_series_var(s : ChemmolpropshbdSeries) -> Double {
  let n = chem_mol_props_hbd_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_mol_props_hbd_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_mol_props_hbd_series_std(s : ChemmolpropshbdSeries) -> Double { @_common.sqrt(chem_mol_props_hbd_series_var(s)) }

pub fn chem_mol_props_hbd_series_median(s : ChemmolpropshbdSeries) -> Double {
  let n = chem_mol_props_hbd_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_props_hbd_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_props_hbd_series_scale(s : ChemmolpropshbdSeries, f : Double) -> ChemmolpropshbdSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_props_hbd_series_add(a : ChemmolpropshbdSeries, b : ChemmolpropshbdSeries) -> ChemmolpropshbdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_hbd_series_sub(a : ChemmolpropshbdSeries, b : ChemmolpropshbdSeries) -> ChemmolpropshbdSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_hbd_series_normalize(s : ChemmolpropshbdSeries) -> ChemmolpropshbdSeries {
  let mn = chem_mol_props_hbd_series_min(s)
  let mx = chem_mol_props_hbd_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_hbd_series_cumsum(s : ChemmolpropshbdSeries) -> ChemmolpropshbdSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_hbd_series_to_string(s : ChemmolpropshbdSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropshbdMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_hbd_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropshbdMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_hbd_matrix_identity(n : Int) -> ChemmolpropshbdMatrix {
  let m = chem_mol_props_hbd_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_hbd_matrix_get(m : ChemmolpropshbdMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_hbd_matrix_transpose(m : ChemmolpropshbdMatrix) -> ChemmolpropshbdMatrix {
  let result = chem_mol_props_hbd_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_hbd_matrix_add(a : ChemmolpropshbdMatrix, b : ChemmolpropshbdMatrix) -> ChemmolpropshbdMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_hbd_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_hbd_matrix_scale(m : ChemmolpropshbdMatrix, s : Double) -> ChemmolpropshbdMatrix {
  let result = chem_mol_props_hbd_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_hbd_matrix_multiply(a : ChemmolpropshbdMatrix, b : ChemmolpropshbdMatrix) -> ChemmolpropshbdMatrix {
  if a.cols != b.rows { return chem_mol_props_hbd_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_hbd_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_hbd_matrix_trace(m : ChemmolpropshbdMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_hbd_matrix_det(m : ChemmolpropshbdMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_hbd_matrix_norm(m : ChemmolpropshbdMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn chem_mol_props_hbd_matrix_to_string(m : ChemmolpropshbdMatrix) -> String {
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

pub(all) struct ChemmolpropshbdVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_hbd_make_vector(comps : Array[Double]) -> ChemmolpropshbdVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_hbd_vector_zero(dim : Int) -> ChemmolpropshbdVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_hbd_vector_add(a : ChemmolpropshbdVector, b : ChemmolpropshbdVector) -> ChemmolpropshbdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_hbd_vector_sub(a : ChemmolpropshbdVector, b : ChemmolpropshbdVector) -> ChemmolpropshbdVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_hbd_vector_scale(v : ChemmolpropshbdVector, s : Double) -> ChemmolpropshbdVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_props_hbd_vector_dot(a : ChemmolpropshbdVector, b : ChemmolpropshbdVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_hbd_vector_norm(v : ChemmolpropshbdVector) -> Double { @_common.sqrt(chem_mol_props_hbd_vector_dot(v, v)) }

pub fn chem_mol_props_hbd_vector_normalize(v : ChemmolpropshbdVector) -> ChemmolpropshbdVector {
  let n = chem_mol_props_hbd_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_hbd_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_hbd_vector_dist(a : ChemmolpropshbdVector, b : ChemmolpropshbdVector) -> Double {
  chem_mol_props_hbd_vector_norm(chem_mol_props_hbd_vector_sub(a, b))
}

pub fn chem_mol_props_hbd_vector_to_string(v : ChemmolpropshbdVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_hbd_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_hbd_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_mol_props_hbd_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_hbd_std(data : Array[Double]) -> Double { @_common.sqrt(chem_mol_props_hbd_var(data)) }

pub fn chem_mol_props_hbd_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_mol_props_hbd_mean(a); let mb = chem_mol_props_hbd_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_hbd_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_mol_props_hbd_std(a); let sb = chem_mol_props_hbd_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_mol_props_hbd_cov(a, b) / (sa * sb) }
}

pub fn chem_mol_props_hbd_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_props_hbd_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_props_hbd_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_mol_props_hbd_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_hbd_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(chem_mol_props_hbd_mse(pred, labels))
}

pub fn chem_mol_props_hbd_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_hbd_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_mol_props_hbd_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_mol_props_hbd_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_mol_props_hbd_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_mol_props_hbd_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_mol_props_hbd_precision(pred, labels, pos); let r = chem_mol_props_hbd_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_mol_props_hbd_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_mol_props_hbd_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_mol_props_hbd_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_mol_props_hbd_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_mol_props_hbd_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_mol_props_hbd_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_mol_props_hbd_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_mol_props_hbd_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_mol_props_hbd_fibonacci(n : Int) -> Int {
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

pub fn chem_mol_props_hbd_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_mol_props_hbd_min(data); let mx = chem_mol_props_hbd_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_mol_props_hbd_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_mol_props_hbd_mean(data); let sd = chem_mol_props_hbd_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_mol_props_hbd_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_mol_props_hbd_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_mol_props_hbd_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_mol_props_hbd_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct ChemmolpropshbdFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_frame_make(size : Int) -> ChemmolpropshbdFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_frame_len(s : ChemmolpropshbdFrame) -> Int { s.size }

pub fn chem_mol_props_hbd_frame_get(s : ChemmolpropshbdFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_frame_set(s : ChemmolpropshbdFrame, i : Int, v : Double) -> ChemmolpropshbdFrame {
  let result = chem_mol_props_hbd_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_frame_sum(s : ChemmolpropshbdFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_frame_mean(s : ChemmolpropshbdFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_frame_scale(s : ChemmolpropshbdFrame, f : Double) -> ChemmolpropshbdFrame {
  let result = chem_mol_props_hbd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_frame_add(a : ChemmolpropshbdFrame, b : ChemmolpropshbdFrame) -> ChemmolpropshbdFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_frame_copy(s : ChemmolpropshbdFrame) -> ChemmolpropshbdFrame {
  let result = chem_mol_props_hbd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_frame_fill(s : ChemmolpropshbdFrame, v : Double) -> ChemmolpropshbdFrame {
  let result = chem_mol_props_hbd_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_frame_min(s : ChemmolpropshbdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_frame_max(s : ChemmolpropshbdFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_frame_to_string(s : ChemmolpropshbdFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_table_make(size : Int) -> ChemmolpropshbdTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_table_len(s : ChemmolpropshbdTable) -> Int { s.size }

pub fn chem_mol_props_hbd_table_get(s : ChemmolpropshbdTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_table_set(s : ChemmolpropshbdTable, i : Int, v : Double) -> ChemmolpropshbdTable {
  let result = chem_mol_props_hbd_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_table_sum(s : ChemmolpropshbdTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_table_mean(s : ChemmolpropshbdTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_table_scale(s : ChemmolpropshbdTable, f : Double) -> ChemmolpropshbdTable {
  let result = chem_mol_props_hbd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_table_add(a : ChemmolpropshbdTable, b : ChemmolpropshbdTable) -> ChemmolpropshbdTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_table_copy(s : ChemmolpropshbdTable) -> ChemmolpropshbdTable {
  let result = chem_mol_props_hbd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_table_fill(s : ChemmolpropshbdTable, v : Double) -> ChemmolpropshbdTable {
  let result = chem_mol_props_hbd_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_table_min(s : ChemmolpropshbdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_table_max(s : ChemmolpropshbdTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_table_to_string(s : ChemmolpropshbdTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_graphn_make(size : Int) -> ChemmolpropshbdGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_graphn_len(s : ChemmolpropshbdGraphN) -> Int { s.size }

pub fn chem_mol_props_hbd_graphn_get(s : ChemmolpropshbdGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_graphn_set(s : ChemmolpropshbdGraphN, i : Int, v : Double) -> ChemmolpropshbdGraphN {
  let result = chem_mol_props_hbd_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_graphn_sum(s : ChemmolpropshbdGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_graphn_mean(s : ChemmolpropshbdGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_graphn_scale(s : ChemmolpropshbdGraphN, f : Double) -> ChemmolpropshbdGraphN {
  let result = chem_mol_props_hbd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_graphn_add(a : ChemmolpropshbdGraphN, b : ChemmolpropshbdGraphN) -> ChemmolpropshbdGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_graphn_copy(s : ChemmolpropshbdGraphN) -> ChemmolpropshbdGraphN {
  let result = chem_mol_props_hbd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_graphn_fill(s : ChemmolpropshbdGraphN, v : Double) -> ChemmolpropshbdGraphN {
  let result = chem_mol_props_hbd_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_graphn_min(s : ChemmolpropshbdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_graphn_max(s : ChemmolpropshbdGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_graphn_to_string(s : ChemmolpropshbdGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_node_make(size : Int) -> ChemmolpropshbdNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_node_len(s : ChemmolpropshbdNode) -> Int { s.size }

pub fn chem_mol_props_hbd_node_get(s : ChemmolpropshbdNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_node_set(s : ChemmolpropshbdNode, i : Int, v : Double) -> ChemmolpropshbdNode {
  let result = chem_mol_props_hbd_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_node_sum(s : ChemmolpropshbdNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_node_mean(s : ChemmolpropshbdNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_node_scale(s : ChemmolpropshbdNode, f : Double) -> ChemmolpropshbdNode {
  let result = chem_mol_props_hbd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_node_add(a : ChemmolpropshbdNode, b : ChemmolpropshbdNode) -> ChemmolpropshbdNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_node_copy(s : ChemmolpropshbdNode) -> ChemmolpropshbdNode {
  let result = chem_mol_props_hbd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_node_fill(s : ChemmolpropshbdNode, v : Double) -> ChemmolpropshbdNode {
  let result = chem_mol_props_hbd_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_node_min(s : ChemmolpropshbdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_node_max(s : ChemmolpropshbdNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_node_to_string(s : ChemmolpropshbdNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_edge_make(size : Int) -> ChemmolpropshbdEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_edge_len(s : ChemmolpropshbdEdge) -> Int { s.size }

pub fn chem_mol_props_hbd_edge_get(s : ChemmolpropshbdEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_edge_set(s : ChemmolpropshbdEdge, i : Int, v : Double) -> ChemmolpropshbdEdge {
  let result = chem_mol_props_hbd_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_edge_sum(s : ChemmolpropshbdEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_edge_mean(s : ChemmolpropshbdEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_edge_scale(s : ChemmolpropshbdEdge, f : Double) -> ChemmolpropshbdEdge {
  let result = chem_mol_props_hbd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_edge_add(a : ChemmolpropshbdEdge, b : ChemmolpropshbdEdge) -> ChemmolpropshbdEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_edge_copy(s : ChemmolpropshbdEdge) -> ChemmolpropshbdEdge {
  let result = chem_mol_props_hbd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_edge_fill(s : ChemmolpropshbdEdge, v : Double) -> ChemmolpropshbdEdge {
  let result = chem_mol_props_hbd_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_edge_min(s : ChemmolpropshbdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_edge_max(s : ChemmolpropshbdEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_edge_to_string(s : ChemmolpropshbdEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_path_make(size : Int) -> ChemmolpropshbdPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_path_len(s : ChemmolpropshbdPath) -> Int { s.size }

pub fn chem_mol_props_hbd_path_get(s : ChemmolpropshbdPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_path_set(s : ChemmolpropshbdPath, i : Int, v : Double) -> ChemmolpropshbdPath {
  let result = chem_mol_props_hbd_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_path_sum(s : ChemmolpropshbdPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_path_mean(s : ChemmolpropshbdPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_path_scale(s : ChemmolpropshbdPath, f : Double) -> ChemmolpropshbdPath {
  let result = chem_mol_props_hbd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_path_add(a : ChemmolpropshbdPath, b : ChemmolpropshbdPath) -> ChemmolpropshbdPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_path_copy(s : ChemmolpropshbdPath) -> ChemmolpropshbdPath {
  let result = chem_mol_props_hbd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_path_fill(s : ChemmolpropshbdPath, v : Double) -> ChemmolpropshbdPath {
  let result = chem_mol_props_hbd_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_path_min(s : ChemmolpropshbdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_path_max(s : ChemmolpropshbdPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_path_to_string(s : ChemmolpropshbdPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_cluster_make(size : Int) -> ChemmolpropshbdCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_cluster_len(s : ChemmolpropshbdCluster) -> Int { s.size }

pub fn chem_mol_props_hbd_cluster_get(s : ChemmolpropshbdCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_cluster_set(s : ChemmolpropshbdCluster, i : Int, v : Double) -> ChemmolpropshbdCluster {
  let result = chem_mol_props_hbd_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_cluster_sum(s : ChemmolpropshbdCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_cluster_mean(s : ChemmolpropshbdCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_cluster_scale(s : ChemmolpropshbdCluster, f : Double) -> ChemmolpropshbdCluster {
  let result = chem_mol_props_hbd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_cluster_add(a : ChemmolpropshbdCluster, b : ChemmolpropshbdCluster) -> ChemmolpropshbdCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_cluster_copy(s : ChemmolpropshbdCluster) -> ChemmolpropshbdCluster {
  let result = chem_mol_props_hbd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_cluster_fill(s : ChemmolpropshbdCluster, v : Double) -> ChemmolpropshbdCluster {
  let result = chem_mol_props_hbd_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_cluster_min(s : ChemmolpropshbdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_cluster_max(s : ChemmolpropshbdCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_cluster_to_string(s : ChemmolpropshbdCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_model_make(size : Int) -> ChemmolpropshbdModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_model_len(s : ChemmolpropshbdModel) -> Int { s.size }

pub fn chem_mol_props_hbd_model_get(s : ChemmolpropshbdModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_model_set(s : ChemmolpropshbdModel, i : Int, v : Double) -> ChemmolpropshbdModel {
  let result = chem_mol_props_hbd_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_model_sum(s : ChemmolpropshbdModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_model_mean(s : ChemmolpropshbdModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_model_scale(s : ChemmolpropshbdModel, f : Double) -> ChemmolpropshbdModel {
  let result = chem_mol_props_hbd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_model_add(a : ChemmolpropshbdModel, b : ChemmolpropshbdModel) -> ChemmolpropshbdModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_model_copy(s : ChemmolpropshbdModel) -> ChemmolpropshbdModel {
  let result = chem_mol_props_hbd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_model_fill(s : ChemmolpropshbdModel, v : Double) -> ChemmolpropshbdModel {
  let result = chem_mol_props_hbd_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_model_min(s : ChemmolpropshbdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_model_max(s : ChemmolpropshbdModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_model_to_string(s : ChemmolpropshbdModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_layer_make(size : Int) -> ChemmolpropshbdLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_layer_len(s : ChemmolpropshbdLayer) -> Int { s.size }

pub fn chem_mol_props_hbd_layer_get(s : ChemmolpropshbdLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_layer_set(s : ChemmolpropshbdLayer, i : Int, v : Double) -> ChemmolpropshbdLayer {
  let result = chem_mol_props_hbd_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_layer_sum(s : ChemmolpropshbdLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_layer_mean(s : ChemmolpropshbdLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_layer_scale(s : ChemmolpropshbdLayer, f : Double) -> ChemmolpropshbdLayer {
  let result = chem_mol_props_hbd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_layer_add(a : ChemmolpropshbdLayer, b : ChemmolpropshbdLayer) -> ChemmolpropshbdLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_layer_copy(s : ChemmolpropshbdLayer) -> ChemmolpropshbdLayer {
  let result = chem_mol_props_hbd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_layer_fill(s : ChemmolpropshbdLayer, v : Double) -> ChemmolpropshbdLayer {
  let result = chem_mol_props_hbd_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_layer_min(s : ChemmolpropshbdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_layer_max(s : ChemmolpropshbdLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_layer_to_string(s : ChemmolpropshbdLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_buffer_make(size : Int) -> ChemmolpropshbdBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_buffer_len(s : ChemmolpropshbdBuffer) -> Int { s.size }

pub fn chem_mol_props_hbd_buffer_get(s : ChemmolpropshbdBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_buffer_set(s : ChemmolpropshbdBuffer, i : Int, v : Double) -> ChemmolpropshbdBuffer {
  let result = chem_mol_props_hbd_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_buffer_sum(s : ChemmolpropshbdBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_buffer_mean(s : ChemmolpropshbdBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_buffer_scale(s : ChemmolpropshbdBuffer, f : Double) -> ChemmolpropshbdBuffer {
  let result = chem_mol_props_hbd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_buffer_add(a : ChemmolpropshbdBuffer, b : ChemmolpropshbdBuffer) -> ChemmolpropshbdBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_buffer_copy(s : ChemmolpropshbdBuffer) -> ChemmolpropshbdBuffer {
  let result = chem_mol_props_hbd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_buffer_fill(s : ChemmolpropshbdBuffer, v : Double) -> ChemmolpropshbdBuffer {
  let result = chem_mol_props_hbd_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_buffer_min(s : ChemmolpropshbdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_buffer_max(s : ChemmolpropshbdBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_buffer_to_string(s : ChemmolpropshbdBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_cursor_make(size : Int) -> ChemmolpropshbdCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_cursor_len(s : ChemmolpropshbdCursor) -> Int { s.size }

pub fn chem_mol_props_hbd_cursor_get(s : ChemmolpropshbdCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_cursor_set(s : ChemmolpropshbdCursor, i : Int, v : Double) -> ChemmolpropshbdCursor {
  let result = chem_mol_props_hbd_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_cursor_sum(s : ChemmolpropshbdCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_cursor_mean(s : ChemmolpropshbdCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_cursor_scale(s : ChemmolpropshbdCursor, f : Double) -> ChemmolpropshbdCursor {
  let result = chem_mol_props_hbd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_cursor_add(a : ChemmolpropshbdCursor, b : ChemmolpropshbdCursor) -> ChemmolpropshbdCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_cursor_copy(s : ChemmolpropshbdCursor) -> ChemmolpropshbdCursor {
  let result = chem_mol_props_hbd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_cursor_fill(s : ChemmolpropshbdCursor, v : Double) -> ChemmolpropshbdCursor {
  let result = chem_mol_props_hbd_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_cursor_min(s : ChemmolpropshbdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_cursor_max(s : ChemmolpropshbdCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_cursor_to_string(s : ChemmolpropshbdCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_view_make(size : Int) -> ChemmolpropshbdView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_view_len(s : ChemmolpropshbdView) -> Int { s.size }

pub fn chem_mol_props_hbd_view_get(s : ChemmolpropshbdView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_view_set(s : ChemmolpropshbdView, i : Int, v : Double) -> ChemmolpropshbdView {
  let result = chem_mol_props_hbd_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_view_sum(s : ChemmolpropshbdView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_view_mean(s : ChemmolpropshbdView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_view_scale(s : ChemmolpropshbdView, f : Double) -> ChemmolpropshbdView {
  let result = chem_mol_props_hbd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_view_add(a : ChemmolpropshbdView, b : ChemmolpropshbdView) -> ChemmolpropshbdView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_view_copy(s : ChemmolpropshbdView) -> ChemmolpropshbdView {
  let result = chem_mol_props_hbd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_view_fill(s : ChemmolpropshbdView, v : Double) -> ChemmolpropshbdView {
  let result = chem_mol_props_hbd_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_view_min(s : ChemmolpropshbdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_view_max(s : ChemmolpropshbdView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_view_to_string(s : ChemmolpropshbdView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_range_make(size : Int) -> ChemmolpropshbdRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_range_len(s : ChemmolpropshbdRange) -> Int { s.size }

pub fn chem_mol_props_hbd_range_get(s : ChemmolpropshbdRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_range_set(s : ChemmolpropshbdRange, i : Int, v : Double) -> ChemmolpropshbdRange {
  let result = chem_mol_props_hbd_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_range_sum(s : ChemmolpropshbdRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_range_mean(s : ChemmolpropshbdRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_range_scale(s : ChemmolpropshbdRange, f : Double) -> ChemmolpropshbdRange {
  let result = chem_mol_props_hbd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_range_add(a : ChemmolpropshbdRange, b : ChemmolpropshbdRange) -> ChemmolpropshbdRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_range_copy(s : ChemmolpropshbdRange) -> ChemmolpropshbdRange {
  let result = chem_mol_props_hbd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_range_fill(s : ChemmolpropshbdRange, v : Double) -> ChemmolpropshbdRange {
  let result = chem_mol_props_hbd_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_range_min(s : ChemmolpropshbdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_range_max(s : ChemmolpropshbdRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_range_to_string(s : ChemmolpropshbdRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbdSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hbd_slice_make(size : Int) -> ChemmolpropshbdSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hbd_slice_len(s : ChemmolpropshbdSlice) -> Int { s.size }

pub fn chem_mol_props_hbd_slice_get(s : ChemmolpropshbdSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hbd_slice_set(s : ChemmolpropshbdSlice, i : Int, v : Double) -> ChemmolpropshbdSlice {
  let result = chem_mol_props_hbd_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_slice_sum(s : ChemmolpropshbdSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hbd_slice_mean(s : ChemmolpropshbdSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hbd_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hbd_slice_scale(s : ChemmolpropshbdSlice, f : Double) -> ChemmolpropshbdSlice {
  let result = chem_mol_props_hbd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hbd_slice_add(a : ChemmolpropshbdSlice, b : ChemmolpropshbdSlice) -> ChemmolpropshbdSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hbd_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hbd_slice_copy(s : ChemmolpropshbdSlice) -> ChemmolpropshbdSlice {
  let result = chem_mol_props_hbd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hbd_slice_fill(s : ChemmolpropshbdSlice, v : Double) -> ChemmolpropshbdSlice {
  let result = chem_mol_props_hbd_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hbd_slice_min(s : ChemmolpropshbdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_slice_max(s : ChemmolpropshbdSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hbd_slice_to_string(s : ChemmolpropshbdSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

