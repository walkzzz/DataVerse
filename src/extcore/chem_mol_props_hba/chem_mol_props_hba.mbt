///===
/// extcore/chem_mol_props_hba

pub(all) struct ChemmolpropshbaPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_mol_props_hba_make_point(x : Double, y : Double) -> ChemmolpropshbaPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_mol_props_hba_make_point3(x : Double, y : Double, z : Double) -> ChemmolpropshbaPoint {
  { x, y, z, label: 0 }
}

pub fn chem_mol_props_hba_point_x(pt : ChemmolpropshbaPoint) -> Double { pt.x }

pub fn chem_mol_props_hba_point_y(pt : ChemmolpropshbaPoint) -> Double { pt.y }

pub fn chem_mol_props_hba_point_z(pt : ChemmolpropshbaPoint) -> Double { pt.z }

pub fn chem_mol_props_hba_point_label(pt : ChemmolpropshbaPoint) -> Int { pt.label }

pub fn chem_mol_props_hba_point_dist(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_mol_props_hba_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_mol_props_hba_point_add(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_mol_props_hba_point_sub(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_mol_props_hba_point_scale(pt : ChemmolpropshbaPoint, s : Double) -> ChemmolpropshbaPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_mol_props_hba_point_dot(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_mol_props_hba_point_cross(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_mol_props_hba_point_norm(pt : ChemmolpropshbaPoint) -> Double {
  chem_mol_props_hba_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_mol_props_hba_point_normalize(pt : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  let n = chem_mol_props_hba_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_mol_props_hba_point_scale(pt, 1.0 / n) }
}

pub fn chem_mol_props_hba_point_negate(pt : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_mol_props_hba_point_mid(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint) -> ChemmolpropshbaPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_mol_props_hba_point_lerp(a : ChemmolpropshbaPoint, b : ChemmolpropshbaPoint, t : Double) -> ChemmolpropshbaPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_mol_props_hba_point_to_string(pt : ChemmolpropshbaPoint) -> String {
  "(" + chem_mol_props_hba_dbl(pt.x) + ", " + chem_mol_props_hba_dbl(pt.y) + ", " + chem_mol_props_hba_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemmolpropshbaSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_mol_props_hba_make_series(vals : Array[Double], name : String) -> ChemmolpropshbaSeries {
  { vals, name, meta: 0 }
}

pub fn chem_mol_props_hba_series_len(s : ChemmolpropshbaSeries) -> Int { s.vals.length() }

pub fn chem_mol_props_hba_series_sum(s : ChemmolpropshbaSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_mol_props_hba_series_mean(s : ChemmolpropshbaSeries) -> Double {
  let n = chem_mol_props_hba_series_len(s)
  if n == 0 { 0.0 } else { chem_mol_props_hba_series_sum(s) / n.to_double() }
}

pub fn chem_mol_props_hba_series_min(s : ChemmolpropshbaSeries) -> Double {
  let n = chem_mol_props_hba_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_props_hba_series_max(s : ChemmolpropshbaSeries) -> Double {
  let n = chem_mol_props_hba_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_mol_props_hba_series_range(s : ChemmolpropshbaSeries) -> Double {
  chem_mol_props_hba_series_max(s) - chem_mol_props_hba_series_min(s)
}

pub fn chem_mol_props_hba_series_var(s : ChemmolpropshbaSeries) -> Double {
  let n = chem_mol_props_hba_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_mol_props_hba_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_mol_props_hba_series_std(s : ChemmolpropshbaSeries) -> Double { chem_mol_props_hba_sqrt(chem_mol_props_hba_series_var(s)) }

pub fn chem_mol_props_hba_series_median(s : ChemmolpropshbaSeries) -> Double {
  let n = chem_mol_props_hba_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_props_hba_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_props_hba_series_scale(s : ChemmolpropshbaSeries, f : Double) -> ChemmolpropshbaSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_mol_props_hba_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_mol_props_hba_series_add(a : ChemmolpropshbaSeries, b : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_mol_props_hba_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_mol_props_hba_series_sub(a : ChemmolpropshbaSeries, b : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_mol_props_hba_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_mol_props_hba_series_normalize(s : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  let mn = chem_mol_props_hba_series_min(s)
  let mx = chem_mol_props_hba_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_mol_props_hba_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_mol_props_hba_series_cumsum(s : ChemmolpropshbaSeries) -> ChemmolpropshbaSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_mol_props_hba_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_mol_props_hba_series_to_string(s : ChemmolpropshbaSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_mol_props_hba_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemmolpropshbaMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_mol_props_hba_make_matrix(rows : Int, cols : Int, val : Double) -> ChemmolpropshbaMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_mol_props_hba_matrix_identity(n : Int) -> ChemmolpropshbaMatrix {
  let m = chem_mol_props_hba_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_mol_props_hba_matrix_get(m : ChemmolpropshbaMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_mol_props_hba_matrix_transpose(m : ChemmolpropshbaMatrix) -> ChemmolpropshbaMatrix {
  let result = chem_mol_props_hba_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_mol_props_hba_matrix_add(a : ChemmolpropshbaMatrix, b : ChemmolpropshbaMatrix) -> ChemmolpropshbaMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_mol_props_hba_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_mol_props_hba_matrix_scale(m : ChemmolpropshbaMatrix, s : Double) -> ChemmolpropshbaMatrix {
  let result = chem_mol_props_hba_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_mol_props_hba_matrix_multiply(a : ChemmolpropshbaMatrix, b : ChemmolpropshbaMatrix) -> ChemmolpropshbaMatrix {
  if a.cols != b.rows { return chem_mol_props_hba_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_mol_props_hba_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_mol_props_hba_matrix_trace(m : ChemmolpropshbaMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_mol_props_hba_matrix_det(m : ChemmolpropshbaMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_mol_props_hba_matrix_norm(m : ChemmolpropshbaMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_mol_props_hba_sqrt(sum)
}

pub fn chem_mol_props_hba_matrix_to_string(m : ChemmolpropshbaMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_mol_props_hba_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemmolpropshbaVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_mol_props_hba_make_vector(comps : Array[Double]) -> ChemmolpropshbaVector {
  { comps, dim: comps.length() }
}

pub fn chem_mol_props_hba_vector_zero(dim : Int) -> ChemmolpropshbaVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_mol_props_hba_vector_add(a : ChemmolpropshbaVector, b : ChemmolpropshbaVector) -> ChemmolpropshbaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_mol_props_hba_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_hba_vector_sub(a : ChemmolpropshbaVector, b : ChemmolpropshbaVector) -> ChemmolpropshbaVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_mol_props_hba_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_mol_props_hba_vector_scale(v : ChemmolpropshbaVector, s : Double) -> ChemmolpropshbaVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_mol_props_hba_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_mol_props_hba_vector_dot(a : ChemmolpropshbaVector, b : ChemmolpropshbaVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_mol_props_hba_vector_norm(v : ChemmolpropshbaVector) -> Double { chem_mol_props_hba_sqrt(chem_mol_props_hba_vector_dot(v, v)) }

pub fn chem_mol_props_hba_vector_normalize(v : ChemmolpropshbaVector) -> ChemmolpropshbaVector {
  let n = chem_mol_props_hba_vector_norm(v)
  if n < 0.0000001 { v } else { chem_mol_props_hba_vector_scale(v, 1.0 / n) }
}

pub fn chem_mol_props_hba_vector_dist(a : ChemmolpropshbaVector, b : ChemmolpropshbaVector) -> Double {
  chem_mol_props_hba_vector_norm(chem_mol_props_hba_vector_sub(a, b))
}

pub fn chem_mol_props_hba_vector_to_string(v : ChemmolpropshbaVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_mol_props_hba_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_mol_props_hba_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_hba_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_mol_props_hba_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_hba_std(data : Array[Double]) -> Double { chem_mol_props_hba_sqrt(chem_mol_props_hba_var(data)) }

pub fn chem_mol_props_hba_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_mol_props_hba_mean(a); let mb = chem_mol_props_hba_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_hba_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_mol_props_hba_std(a); let sb = chem_mol_props_hba_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_mol_props_hba_cov(a, b) / (sa * sb) }
}

pub fn chem_mol_props_hba_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_mol_props_hba_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_mol_props_hba_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_mol_props_hba_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_hba_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_mol_props_hba_sqrt(chem_mol_props_hba_mse(pred, labels))
}

pub fn chem_mol_props_hba_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_mol_props_hba_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_mol_props_hba_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_mol_props_hba_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_mol_props_hba_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_mol_props_hba_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_mol_props_hba_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_mol_props_hba_precision(pred, labels, pos); let r = chem_mol_props_hba_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_mol_props_hba_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_mol_props_hba_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_mol_props_hba_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_mol_props_hba_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_mol_props_hba_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_mol_props_hba_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_mol_props_hba_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_mol_props_hba_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_mol_props_hba_fibonacci(n : Int) -> Int {
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

pub fn chem_mol_props_hba_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_mol_props_hba_min(data); let mx = chem_mol_props_hba_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_mol_props_hba_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_mol_props_hba_mean(data); let sd = chem_mol_props_hba_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_mol_props_hba_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_mol_props_hba_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_mol_props_hba_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_mol_props_hba_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_mol_props_hba_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_mol_props_hba_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_mol_props_hba_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_mol_props_hba_int(x) } else { -chem_mol_props_hba_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_mol_props_hba_int(f * 1000000.0) } else { chem_mol_props_hba_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_mol_props_hba_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_mol_props_hba_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemmolpropshbaFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_frame_make(size : Int) -> ChemmolpropshbaFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_frame_len(s : ChemmolpropshbaFrame) -> Int { s.size }

pub fn chem_mol_props_hba_frame_get(s : ChemmolpropshbaFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_frame_set(s : ChemmolpropshbaFrame, i : Int, v : Double) -> ChemmolpropshbaFrame {
  let result = chem_mol_props_hba_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_frame_sum(s : ChemmolpropshbaFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_frame_mean(s : ChemmolpropshbaFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_frame_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_frame_scale(s : ChemmolpropshbaFrame, f : Double) -> ChemmolpropshbaFrame {
  let result = chem_mol_props_hba_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_frame_add(a : ChemmolpropshbaFrame, b : ChemmolpropshbaFrame) -> ChemmolpropshbaFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_frame_copy(s : ChemmolpropshbaFrame) -> ChemmolpropshbaFrame {
  let result = chem_mol_props_hba_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_frame_fill(s : ChemmolpropshbaFrame, v : Double) -> ChemmolpropshbaFrame {
  let result = chem_mol_props_hba_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_frame_min(s : ChemmolpropshbaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_frame_max(s : ChemmolpropshbaFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_frame_to_string(s : ChemmolpropshbaFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_table_make(size : Int) -> ChemmolpropshbaTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_table_len(s : ChemmolpropshbaTable) -> Int { s.size }

pub fn chem_mol_props_hba_table_get(s : ChemmolpropshbaTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_table_set(s : ChemmolpropshbaTable, i : Int, v : Double) -> ChemmolpropshbaTable {
  let result = chem_mol_props_hba_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_table_sum(s : ChemmolpropshbaTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_table_mean(s : ChemmolpropshbaTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_table_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_table_scale(s : ChemmolpropshbaTable, f : Double) -> ChemmolpropshbaTable {
  let result = chem_mol_props_hba_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_table_add(a : ChemmolpropshbaTable, b : ChemmolpropshbaTable) -> ChemmolpropshbaTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_table_copy(s : ChemmolpropshbaTable) -> ChemmolpropshbaTable {
  let result = chem_mol_props_hba_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_table_fill(s : ChemmolpropshbaTable, v : Double) -> ChemmolpropshbaTable {
  let result = chem_mol_props_hba_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_table_min(s : ChemmolpropshbaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_table_max(s : ChemmolpropshbaTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_table_to_string(s : ChemmolpropshbaTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_graphn_make(size : Int) -> ChemmolpropshbaGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_graphn_len(s : ChemmolpropshbaGraphN) -> Int { s.size }

pub fn chem_mol_props_hba_graphn_get(s : ChemmolpropshbaGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_graphn_set(s : ChemmolpropshbaGraphN, i : Int, v : Double) -> ChemmolpropshbaGraphN {
  let result = chem_mol_props_hba_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_graphn_sum(s : ChemmolpropshbaGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_graphn_mean(s : ChemmolpropshbaGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_graphn_scale(s : ChemmolpropshbaGraphN, f : Double) -> ChemmolpropshbaGraphN {
  let result = chem_mol_props_hba_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_graphn_add(a : ChemmolpropshbaGraphN, b : ChemmolpropshbaGraphN) -> ChemmolpropshbaGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_graphn_copy(s : ChemmolpropshbaGraphN) -> ChemmolpropshbaGraphN {
  let result = chem_mol_props_hba_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_graphn_fill(s : ChemmolpropshbaGraphN, v : Double) -> ChemmolpropshbaGraphN {
  let result = chem_mol_props_hba_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_graphn_min(s : ChemmolpropshbaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_graphn_max(s : ChemmolpropshbaGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_graphn_to_string(s : ChemmolpropshbaGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_node_make(size : Int) -> ChemmolpropshbaNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_node_len(s : ChemmolpropshbaNode) -> Int { s.size }

pub fn chem_mol_props_hba_node_get(s : ChemmolpropshbaNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_node_set(s : ChemmolpropshbaNode, i : Int, v : Double) -> ChemmolpropshbaNode {
  let result = chem_mol_props_hba_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_node_sum(s : ChemmolpropshbaNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_node_mean(s : ChemmolpropshbaNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_node_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_node_scale(s : ChemmolpropshbaNode, f : Double) -> ChemmolpropshbaNode {
  let result = chem_mol_props_hba_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_node_add(a : ChemmolpropshbaNode, b : ChemmolpropshbaNode) -> ChemmolpropshbaNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_node_copy(s : ChemmolpropshbaNode) -> ChemmolpropshbaNode {
  let result = chem_mol_props_hba_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_node_fill(s : ChemmolpropshbaNode, v : Double) -> ChemmolpropshbaNode {
  let result = chem_mol_props_hba_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_node_min(s : ChemmolpropshbaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_node_max(s : ChemmolpropshbaNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_node_to_string(s : ChemmolpropshbaNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_edge_make(size : Int) -> ChemmolpropshbaEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_edge_len(s : ChemmolpropshbaEdge) -> Int { s.size }

pub fn chem_mol_props_hba_edge_get(s : ChemmolpropshbaEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_edge_set(s : ChemmolpropshbaEdge, i : Int, v : Double) -> ChemmolpropshbaEdge {
  let result = chem_mol_props_hba_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_edge_sum(s : ChemmolpropshbaEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_edge_mean(s : ChemmolpropshbaEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_edge_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_edge_scale(s : ChemmolpropshbaEdge, f : Double) -> ChemmolpropshbaEdge {
  let result = chem_mol_props_hba_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_edge_add(a : ChemmolpropshbaEdge, b : ChemmolpropshbaEdge) -> ChemmolpropshbaEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_edge_copy(s : ChemmolpropshbaEdge) -> ChemmolpropshbaEdge {
  let result = chem_mol_props_hba_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_edge_fill(s : ChemmolpropshbaEdge, v : Double) -> ChemmolpropshbaEdge {
  let result = chem_mol_props_hba_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_edge_min(s : ChemmolpropshbaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_edge_max(s : ChemmolpropshbaEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_edge_to_string(s : ChemmolpropshbaEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_path_make(size : Int) -> ChemmolpropshbaPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_path_len(s : ChemmolpropshbaPath) -> Int { s.size }

pub fn chem_mol_props_hba_path_get(s : ChemmolpropshbaPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_path_set(s : ChemmolpropshbaPath, i : Int, v : Double) -> ChemmolpropshbaPath {
  let result = chem_mol_props_hba_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_path_sum(s : ChemmolpropshbaPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_path_mean(s : ChemmolpropshbaPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_path_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_path_scale(s : ChemmolpropshbaPath, f : Double) -> ChemmolpropshbaPath {
  let result = chem_mol_props_hba_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_path_add(a : ChemmolpropshbaPath, b : ChemmolpropshbaPath) -> ChemmolpropshbaPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_path_copy(s : ChemmolpropshbaPath) -> ChemmolpropshbaPath {
  let result = chem_mol_props_hba_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_path_fill(s : ChemmolpropshbaPath, v : Double) -> ChemmolpropshbaPath {
  let result = chem_mol_props_hba_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_path_min(s : ChemmolpropshbaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_path_max(s : ChemmolpropshbaPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_path_to_string(s : ChemmolpropshbaPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_cluster_make(size : Int) -> ChemmolpropshbaCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_cluster_len(s : ChemmolpropshbaCluster) -> Int { s.size }

pub fn chem_mol_props_hba_cluster_get(s : ChemmolpropshbaCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_cluster_set(s : ChemmolpropshbaCluster, i : Int, v : Double) -> ChemmolpropshbaCluster {
  let result = chem_mol_props_hba_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_cluster_sum(s : ChemmolpropshbaCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_cluster_mean(s : ChemmolpropshbaCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_cluster_scale(s : ChemmolpropshbaCluster, f : Double) -> ChemmolpropshbaCluster {
  let result = chem_mol_props_hba_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_cluster_add(a : ChemmolpropshbaCluster, b : ChemmolpropshbaCluster) -> ChemmolpropshbaCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_cluster_copy(s : ChemmolpropshbaCluster) -> ChemmolpropshbaCluster {
  let result = chem_mol_props_hba_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_cluster_fill(s : ChemmolpropshbaCluster, v : Double) -> ChemmolpropshbaCluster {
  let result = chem_mol_props_hba_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_cluster_min(s : ChemmolpropshbaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_cluster_max(s : ChemmolpropshbaCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_cluster_to_string(s : ChemmolpropshbaCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_model_make(size : Int) -> ChemmolpropshbaModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_model_len(s : ChemmolpropshbaModel) -> Int { s.size }

pub fn chem_mol_props_hba_model_get(s : ChemmolpropshbaModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_model_set(s : ChemmolpropshbaModel, i : Int, v : Double) -> ChemmolpropshbaModel {
  let result = chem_mol_props_hba_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_model_sum(s : ChemmolpropshbaModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_model_mean(s : ChemmolpropshbaModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_model_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_model_scale(s : ChemmolpropshbaModel, f : Double) -> ChemmolpropshbaModel {
  let result = chem_mol_props_hba_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_model_add(a : ChemmolpropshbaModel, b : ChemmolpropshbaModel) -> ChemmolpropshbaModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_model_copy(s : ChemmolpropshbaModel) -> ChemmolpropshbaModel {
  let result = chem_mol_props_hba_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_model_fill(s : ChemmolpropshbaModel, v : Double) -> ChemmolpropshbaModel {
  let result = chem_mol_props_hba_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_model_min(s : ChemmolpropshbaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_model_max(s : ChemmolpropshbaModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_model_to_string(s : ChemmolpropshbaModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_layer_make(size : Int) -> ChemmolpropshbaLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_layer_len(s : ChemmolpropshbaLayer) -> Int { s.size }

pub fn chem_mol_props_hba_layer_get(s : ChemmolpropshbaLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_layer_set(s : ChemmolpropshbaLayer, i : Int, v : Double) -> ChemmolpropshbaLayer {
  let result = chem_mol_props_hba_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_layer_sum(s : ChemmolpropshbaLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_layer_mean(s : ChemmolpropshbaLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_layer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_layer_scale(s : ChemmolpropshbaLayer, f : Double) -> ChemmolpropshbaLayer {
  let result = chem_mol_props_hba_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_layer_add(a : ChemmolpropshbaLayer, b : ChemmolpropshbaLayer) -> ChemmolpropshbaLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_layer_copy(s : ChemmolpropshbaLayer) -> ChemmolpropshbaLayer {
  let result = chem_mol_props_hba_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_layer_fill(s : ChemmolpropshbaLayer, v : Double) -> ChemmolpropshbaLayer {
  let result = chem_mol_props_hba_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_layer_min(s : ChemmolpropshbaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_layer_max(s : ChemmolpropshbaLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_layer_to_string(s : ChemmolpropshbaLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_buffer_make(size : Int) -> ChemmolpropshbaBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_buffer_len(s : ChemmolpropshbaBuffer) -> Int { s.size }

pub fn chem_mol_props_hba_buffer_get(s : ChemmolpropshbaBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_buffer_set(s : ChemmolpropshbaBuffer, i : Int, v : Double) -> ChemmolpropshbaBuffer {
  let result = chem_mol_props_hba_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_buffer_sum(s : ChemmolpropshbaBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_buffer_mean(s : ChemmolpropshbaBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_buffer_scale(s : ChemmolpropshbaBuffer, f : Double) -> ChemmolpropshbaBuffer {
  let result = chem_mol_props_hba_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_buffer_add(a : ChemmolpropshbaBuffer, b : ChemmolpropshbaBuffer) -> ChemmolpropshbaBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_buffer_copy(s : ChemmolpropshbaBuffer) -> ChemmolpropshbaBuffer {
  let result = chem_mol_props_hba_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_buffer_fill(s : ChemmolpropshbaBuffer, v : Double) -> ChemmolpropshbaBuffer {
  let result = chem_mol_props_hba_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_buffer_min(s : ChemmolpropshbaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_buffer_max(s : ChemmolpropshbaBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_buffer_to_string(s : ChemmolpropshbaBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_cursor_make(size : Int) -> ChemmolpropshbaCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_cursor_len(s : ChemmolpropshbaCursor) -> Int { s.size }

pub fn chem_mol_props_hba_cursor_get(s : ChemmolpropshbaCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_cursor_set(s : ChemmolpropshbaCursor, i : Int, v : Double) -> ChemmolpropshbaCursor {
  let result = chem_mol_props_hba_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_cursor_sum(s : ChemmolpropshbaCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_cursor_mean(s : ChemmolpropshbaCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_cursor_scale(s : ChemmolpropshbaCursor, f : Double) -> ChemmolpropshbaCursor {
  let result = chem_mol_props_hba_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_cursor_add(a : ChemmolpropshbaCursor, b : ChemmolpropshbaCursor) -> ChemmolpropshbaCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_cursor_copy(s : ChemmolpropshbaCursor) -> ChemmolpropshbaCursor {
  let result = chem_mol_props_hba_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_cursor_fill(s : ChemmolpropshbaCursor, v : Double) -> ChemmolpropshbaCursor {
  let result = chem_mol_props_hba_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_cursor_min(s : ChemmolpropshbaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_cursor_max(s : ChemmolpropshbaCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_cursor_to_string(s : ChemmolpropshbaCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_view_make(size : Int) -> ChemmolpropshbaView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_view_len(s : ChemmolpropshbaView) -> Int { s.size }

pub fn chem_mol_props_hba_view_get(s : ChemmolpropshbaView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_view_set(s : ChemmolpropshbaView, i : Int, v : Double) -> ChemmolpropshbaView {
  let result = chem_mol_props_hba_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_view_sum(s : ChemmolpropshbaView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_view_mean(s : ChemmolpropshbaView) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_view_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_view_scale(s : ChemmolpropshbaView, f : Double) -> ChemmolpropshbaView {
  let result = chem_mol_props_hba_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_view_add(a : ChemmolpropshbaView, b : ChemmolpropshbaView) -> ChemmolpropshbaView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_view_copy(s : ChemmolpropshbaView) -> ChemmolpropshbaView {
  let result = chem_mol_props_hba_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_view_fill(s : ChemmolpropshbaView, v : Double) -> ChemmolpropshbaView {
  let result = chem_mol_props_hba_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_view_min(s : ChemmolpropshbaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_view_max(s : ChemmolpropshbaView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_view_to_string(s : ChemmolpropshbaView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_range_make(size : Int) -> ChemmolpropshbaRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_range_len(s : ChemmolpropshbaRange) -> Int { s.size }

pub fn chem_mol_props_hba_range_get(s : ChemmolpropshbaRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_range_set(s : ChemmolpropshbaRange, i : Int, v : Double) -> ChemmolpropshbaRange {
  let result = chem_mol_props_hba_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_range_sum(s : ChemmolpropshbaRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_range_mean(s : ChemmolpropshbaRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_range_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_range_scale(s : ChemmolpropshbaRange, f : Double) -> ChemmolpropshbaRange {
  let result = chem_mol_props_hba_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_range_add(a : ChemmolpropshbaRange, b : ChemmolpropshbaRange) -> ChemmolpropshbaRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_range_copy(s : ChemmolpropshbaRange) -> ChemmolpropshbaRange {
  let result = chem_mol_props_hba_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_range_fill(s : ChemmolpropshbaRange, v : Double) -> ChemmolpropshbaRange {
  let result = chem_mol_props_hba_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_range_min(s : ChemmolpropshbaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_range_max(s : ChemmolpropshbaRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_range_to_string(s : ChemmolpropshbaRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemmolpropshbaSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_mol_props_hba_slice_make(size : Int) -> ChemmolpropshbaSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_mol_props_hba_slice_len(s : ChemmolpropshbaSlice) -> Int { s.size }

pub fn chem_mol_props_hba_slice_get(s : ChemmolpropshbaSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_mol_props_hba_slice_set(s : ChemmolpropshbaSlice, i : Int, v : Double) -> ChemmolpropshbaSlice {
  let result = chem_mol_props_hba_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_slice_sum(s : ChemmolpropshbaSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_mol_props_hba_slice_mean(s : ChemmolpropshbaSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_mol_props_hba_slice_sum(s) / s.size.to_double() }
}

pub fn chem_mol_props_hba_slice_scale(s : ChemmolpropshbaSlice, f : Double) -> ChemmolpropshbaSlice {
  let result = chem_mol_props_hba_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_mol_props_hba_slice_add(a : ChemmolpropshbaSlice, b : ChemmolpropshbaSlice) -> ChemmolpropshbaSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_mol_props_hba_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_mol_props_hba_slice_copy(s : ChemmolpropshbaSlice) -> ChemmolpropshbaSlice {
  let result = chem_mol_props_hba_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_mol_props_hba_slice_fill(s : ChemmolpropshbaSlice, v : Double) -> ChemmolpropshbaSlice {
  let result = chem_mol_props_hba_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_mol_props_hba_slice_min(s : ChemmolpropshbaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_slice_max(s : ChemmolpropshbaSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_mol_props_hba_slice_to_string(s : ChemmolpropshbaSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_mol_props_hba_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_mol_props_hba_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

