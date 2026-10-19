///===
/// extcore/chem_rxn_thermo

pub(all) struct ChemrxnthermoPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_thermo_make_point(x : Double, y : Double) -> ChemrxnthermoPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_thermo_make_point3(x : Double, y : Double, z : Double) -> ChemrxnthermoPoint {
  { x, y, z, label: 0 }
}

pub fn chem_rxn_thermo_point_x(pt : ChemrxnthermoPoint) -> Double { pt.x }

pub fn chem_rxn_thermo_point_y(pt : ChemrxnthermoPoint) -> Double { pt.y }

pub fn chem_rxn_thermo_point_z(pt : ChemrxnthermoPoint) -> Double { pt.z }

pub fn chem_rxn_thermo_point_label(pt : ChemrxnthermoPoint) -> Int { pt.label }

pub fn chem_rxn_thermo_point_dist(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_rxn_thermo_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_rxn_thermo_point_add(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_rxn_thermo_point_sub(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_rxn_thermo_point_scale(pt : ChemrxnthermoPoint, s : Double) -> ChemrxnthermoPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_rxn_thermo_point_dot(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_rxn_thermo_point_cross(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_rxn_thermo_point_norm(pt : ChemrxnthermoPoint) -> Double {
  chem_rxn_thermo_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_rxn_thermo_point_normalize(pt : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  let n = chem_rxn_thermo_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_rxn_thermo_point_scale(pt, 1.0 / n) }
}

pub fn chem_rxn_thermo_point_negate(pt : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_rxn_thermo_point_mid(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint) -> ChemrxnthermoPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_rxn_thermo_point_lerp(a : ChemrxnthermoPoint, b : ChemrxnthermoPoint, t : Double) -> ChemrxnthermoPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_rxn_thermo_point_to_string(pt : ChemrxnthermoPoint) -> String {
  "(" + chem_rxn_thermo_dbl(pt.x) + ", " + chem_rxn_thermo_dbl(pt.y) + ", " + chem_rxn_thermo_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemrxnthermoSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_thermo_make_series(vals : Array[Double], name : String) -> ChemrxnthermoSeries {
  { vals, name, meta: 0 }
}

pub fn chem_rxn_thermo_series_len(s : ChemrxnthermoSeries) -> Int { s.vals.length() }

pub fn chem_rxn_thermo_series_sum(s : ChemrxnthermoSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_rxn_thermo_series_mean(s : ChemrxnthermoSeries) -> Double {
  let n = chem_rxn_thermo_series_len(s)
  if n == 0 { 0.0 } else { chem_rxn_thermo_series_sum(s) / n.to_double() }
}

pub fn chem_rxn_thermo_series_min(s : ChemrxnthermoSeries) -> Double {
  let n = chem_rxn_thermo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_rxn_thermo_series_max(s : ChemrxnthermoSeries) -> Double {
  let n = chem_rxn_thermo_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_rxn_thermo_series_range(s : ChemrxnthermoSeries) -> Double {
  chem_rxn_thermo_series_max(s) - chem_rxn_thermo_series_min(s)
}

pub fn chem_rxn_thermo_series_var(s : ChemrxnthermoSeries) -> Double {
  let n = chem_rxn_thermo_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_rxn_thermo_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_rxn_thermo_series_std(s : ChemrxnthermoSeries) -> Double { chem_rxn_thermo_sqrt(chem_rxn_thermo_series_var(s)) }

pub fn chem_rxn_thermo_series_median(s : ChemrxnthermoSeries) -> Double {
  let n = chem_rxn_thermo_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_rxn_thermo_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_rxn_thermo_series_scale(s : ChemrxnthermoSeries, f : Double) -> ChemrxnthermoSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_rxn_thermo_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_rxn_thermo_series_add(a : ChemrxnthermoSeries, b : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_rxn_thermo_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_rxn_thermo_series_sub(a : ChemrxnthermoSeries, b : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_rxn_thermo_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_rxn_thermo_series_normalize(s : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  let mn = chem_rxn_thermo_series_min(s)
  let mx = chem_rxn_thermo_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_rxn_thermo_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_rxn_thermo_series_cumsum(s : ChemrxnthermoSeries) -> ChemrxnthermoSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_rxn_thermo_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_rxn_thermo_series_to_string(s : ChemrxnthermoSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_rxn_thermo_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnthermoMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_thermo_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnthermoMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_thermo_matrix_identity(n : Int) -> ChemrxnthermoMatrix {
  let m = chem_rxn_thermo_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_rxn_thermo_matrix_get(m : ChemrxnthermoMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_rxn_thermo_matrix_transpose(m : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  let result = chem_rxn_thermo_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_rxn_thermo_matrix_add(a : ChemrxnthermoMatrix, b : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_rxn_thermo_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_rxn_thermo_matrix_scale(m : ChemrxnthermoMatrix, s : Double) -> ChemrxnthermoMatrix {
  let result = chem_rxn_thermo_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_rxn_thermo_matrix_multiply(a : ChemrxnthermoMatrix, b : ChemrxnthermoMatrix) -> ChemrxnthermoMatrix {
  if a.cols != b.rows { return chem_rxn_thermo_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_rxn_thermo_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_rxn_thermo_matrix_trace(m : ChemrxnthermoMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_rxn_thermo_matrix_det(m : ChemrxnthermoMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_rxn_thermo_matrix_norm(m : ChemrxnthermoMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_rxn_thermo_sqrt(sum)
}

pub fn chem_rxn_thermo_matrix_to_string(m : ChemrxnthermoMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_rxn_thermo_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemrxnthermoVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_thermo_make_vector(comps : Array[Double]) -> ChemrxnthermoVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_thermo_vector_zero(dim : Int) -> ChemrxnthermoVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_rxn_thermo_vector_add(a : ChemrxnthermoVector, b : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_rxn_thermo_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_thermo_vector_sub(a : ChemrxnthermoVector, b : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_rxn_thermo_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_thermo_vector_scale(v : ChemrxnthermoVector, s : Double) -> ChemrxnthermoVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_rxn_thermo_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_rxn_thermo_vector_dot(a : ChemrxnthermoVector, b : ChemrxnthermoVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_rxn_thermo_vector_norm(v : ChemrxnthermoVector) -> Double { chem_rxn_thermo_sqrt(chem_rxn_thermo_vector_dot(v, v)) }

pub fn chem_rxn_thermo_vector_normalize(v : ChemrxnthermoVector) -> ChemrxnthermoVector {
  let n = chem_rxn_thermo_vector_norm(v)
  if n < 0.0000001 { v } else { chem_rxn_thermo_vector_scale(v, 1.0 / n) }
}

pub fn chem_rxn_thermo_vector_dist(a : ChemrxnthermoVector, b : ChemrxnthermoVector) -> Double {
  chem_rxn_thermo_vector_norm(chem_rxn_thermo_vector_sub(a, b))
}

pub fn chem_rxn_thermo_vector_to_string(v : ChemrxnthermoVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_rxn_thermo_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_thermo_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_rxn_thermo_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_rxn_thermo_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_rxn_thermo_std(data : Array[Double]) -> Double { chem_rxn_thermo_sqrt(chem_rxn_thermo_var(data)) }

pub fn chem_rxn_thermo_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_rxn_thermo_mean(a); let mb = chem_rxn_thermo_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_rxn_thermo_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_rxn_thermo_std(a); let sb = chem_rxn_thermo_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_rxn_thermo_cov(a, b) / (sa * sb) }
}

pub fn chem_rxn_thermo_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_rxn_thermo_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_rxn_thermo_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_rxn_thermo_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_rxn_thermo_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_rxn_thermo_sqrt(chem_rxn_thermo_mse(pred, labels))
}

pub fn chem_rxn_thermo_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_rxn_thermo_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_rxn_thermo_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_rxn_thermo_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_rxn_thermo_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_rxn_thermo_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_rxn_thermo_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_rxn_thermo_precision(pred, labels, pos); let r = chem_rxn_thermo_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_rxn_thermo_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_rxn_thermo_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_rxn_thermo_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_rxn_thermo_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_rxn_thermo_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_rxn_thermo_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_rxn_thermo_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_rxn_thermo_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_rxn_thermo_fibonacci(n : Int) -> Int {
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

pub fn chem_rxn_thermo_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_rxn_thermo_min(data); let mx = chem_rxn_thermo_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_rxn_thermo_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_rxn_thermo_mean(data); let sd = chem_rxn_thermo_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_rxn_thermo_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_rxn_thermo_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_rxn_thermo_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_rxn_thermo_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_rxn_thermo_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_rxn_thermo_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_rxn_thermo_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_rxn_thermo_int(x) } else { -chem_rxn_thermo_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_rxn_thermo_int(f * 1000000.0) } else { chem_rxn_thermo_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_rxn_thermo_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_rxn_thermo_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemrxnthermoFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_frame_make(size : Int) -> ChemrxnthermoFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_frame_len(s : ChemrxnthermoFrame) -> Int { s.size }

pub fn chem_rxn_thermo_frame_get(s : ChemrxnthermoFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_frame_set(s : ChemrxnthermoFrame, i : Int, v : Double) -> ChemrxnthermoFrame {
  let result = chem_rxn_thermo_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_frame_sum(s : ChemrxnthermoFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_frame_mean(s : ChemrxnthermoFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_frame_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_frame_scale(s : ChemrxnthermoFrame, f : Double) -> ChemrxnthermoFrame {
  let result = chem_rxn_thermo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_frame_add(a : ChemrxnthermoFrame, b : ChemrxnthermoFrame) -> ChemrxnthermoFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_frame_copy(s : ChemrxnthermoFrame) -> ChemrxnthermoFrame {
  let result = chem_rxn_thermo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_frame_fill(s : ChemrxnthermoFrame, v : Double) -> ChemrxnthermoFrame {
  let result = chem_rxn_thermo_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_frame_min(s : ChemrxnthermoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_frame_max(s : ChemrxnthermoFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_frame_to_string(s : ChemrxnthermoFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_table_make(size : Int) -> ChemrxnthermoTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_table_len(s : ChemrxnthermoTable) -> Int { s.size }

pub fn chem_rxn_thermo_table_get(s : ChemrxnthermoTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_table_set(s : ChemrxnthermoTable, i : Int, v : Double) -> ChemrxnthermoTable {
  let result = chem_rxn_thermo_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_table_sum(s : ChemrxnthermoTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_table_mean(s : ChemrxnthermoTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_table_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_table_scale(s : ChemrxnthermoTable, f : Double) -> ChemrxnthermoTable {
  let result = chem_rxn_thermo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_table_add(a : ChemrxnthermoTable, b : ChemrxnthermoTable) -> ChemrxnthermoTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_table_copy(s : ChemrxnthermoTable) -> ChemrxnthermoTable {
  let result = chem_rxn_thermo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_table_fill(s : ChemrxnthermoTable, v : Double) -> ChemrxnthermoTable {
  let result = chem_rxn_thermo_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_table_min(s : ChemrxnthermoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_table_max(s : ChemrxnthermoTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_table_to_string(s : ChemrxnthermoTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_graphn_make(size : Int) -> ChemrxnthermoGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_graphn_len(s : ChemrxnthermoGraphN) -> Int { s.size }

pub fn chem_rxn_thermo_graphn_get(s : ChemrxnthermoGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_graphn_set(s : ChemrxnthermoGraphN, i : Int, v : Double) -> ChemrxnthermoGraphN {
  let result = chem_rxn_thermo_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_graphn_sum(s : ChemrxnthermoGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_graphn_mean(s : ChemrxnthermoGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_graphn_scale(s : ChemrxnthermoGraphN, f : Double) -> ChemrxnthermoGraphN {
  let result = chem_rxn_thermo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_graphn_add(a : ChemrxnthermoGraphN, b : ChemrxnthermoGraphN) -> ChemrxnthermoGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_graphn_copy(s : ChemrxnthermoGraphN) -> ChemrxnthermoGraphN {
  let result = chem_rxn_thermo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_graphn_fill(s : ChemrxnthermoGraphN, v : Double) -> ChemrxnthermoGraphN {
  let result = chem_rxn_thermo_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_graphn_min(s : ChemrxnthermoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_graphn_max(s : ChemrxnthermoGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_graphn_to_string(s : ChemrxnthermoGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_node_make(size : Int) -> ChemrxnthermoNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_node_len(s : ChemrxnthermoNode) -> Int { s.size }

pub fn chem_rxn_thermo_node_get(s : ChemrxnthermoNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_node_set(s : ChemrxnthermoNode, i : Int, v : Double) -> ChemrxnthermoNode {
  let result = chem_rxn_thermo_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_node_sum(s : ChemrxnthermoNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_node_mean(s : ChemrxnthermoNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_node_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_node_scale(s : ChemrxnthermoNode, f : Double) -> ChemrxnthermoNode {
  let result = chem_rxn_thermo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_node_add(a : ChemrxnthermoNode, b : ChemrxnthermoNode) -> ChemrxnthermoNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_node_copy(s : ChemrxnthermoNode) -> ChemrxnthermoNode {
  let result = chem_rxn_thermo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_node_fill(s : ChemrxnthermoNode, v : Double) -> ChemrxnthermoNode {
  let result = chem_rxn_thermo_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_node_min(s : ChemrxnthermoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_node_max(s : ChemrxnthermoNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_node_to_string(s : ChemrxnthermoNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_edge_make(size : Int) -> ChemrxnthermoEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_edge_len(s : ChemrxnthermoEdge) -> Int { s.size }

pub fn chem_rxn_thermo_edge_get(s : ChemrxnthermoEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_edge_set(s : ChemrxnthermoEdge, i : Int, v : Double) -> ChemrxnthermoEdge {
  let result = chem_rxn_thermo_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_edge_sum(s : ChemrxnthermoEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_edge_mean(s : ChemrxnthermoEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_edge_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_edge_scale(s : ChemrxnthermoEdge, f : Double) -> ChemrxnthermoEdge {
  let result = chem_rxn_thermo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_edge_add(a : ChemrxnthermoEdge, b : ChemrxnthermoEdge) -> ChemrxnthermoEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_edge_copy(s : ChemrxnthermoEdge) -> ChemrxnthermoEdge {
  let result = chem_rxn_thermo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_edge_fill(s : ChemrxnthermoEdge, v : Double) -> ChemrxnthermoEdge {
  let result = chem_rxn_thermo_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_edge_min(s : ChemrxnthermoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_edge_max(s : ChemrxnthermoEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_edge_to_string(s : ChemrxnthermoEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_path_make(size : Int) -> ChemrxnthermoPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_path_len(s : ChemrxnthermoPath) -> Int { s.size }

pub fn chem_rxn_thermo_path_get(s : ChemrxnthermoPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_path_set(s : ChemrxnthermoPath, i : Int, v : Double) -> ChemrxnthermoPath {
  let result = chem_rxn_thermo_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_path_sum(s : ChemrxnthermoPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_path_mean(s : ChemrxnthermoPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_path_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_path_scale(s : ChemrxnthermoPath, f : Double) -> ChemrxnthermoPath {
  let result = chem_rxn_thermo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_path_add(a : ChemrxnthermoPath, b : ChemrxnthermoPath) -> ChemrxnthermoPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_path_copy(s : ChemrxnthermoPath) -> ChemrxnthermoPath {
  let result = chem_rxn_thermo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_path_fill(s : ChemrxnthermoPath, v : Double) -> ChemrxnthermoPath {
  let result = chem_rxn_thermo_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_path_min(s : ChemrxnthermoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_path_max(s : ChemrxnthermoPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_path_to_string(s : ChemrxnthermoPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_cluster_make(size : Int) -> ChemrxnthermoCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_cluster_len(s : ChemrxnthermoCluster) -> Int { s.size }

pub fn chem_rxn_thermo_cluster_get(s : ChemrxnthermoCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_cluster_set(s : ChemrxnthermoCluster, i : Int, v : Double) -> ChemrxnthermoCluster {
  let result = chem_rxn_thermo_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_cluster_sum(s : ChemrxnthermoCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_cluster_mean(s : ChemrxnthermoCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_cluster_scale(s : ChemrxnthermoCluster, f : Double) -> ChemrxnthermoCluster {
  let result = chem_rxn_thermo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_cluster_add(a : ChemrxnthermoCluster, b : ChemrxnthermoCluster) -> ChemrxnthermoCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_cluster_copy(s : ChemrxnthermoCluster) -> ChemrxnthermoCluster {
  let result = chem_rxn_thermo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_cluster_fill(s : ChemrxnthermoCluster, v : Double) -> ChemrxnthermoCluster {
  let result = chem_rxn_thermo_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_cluster_min(s : ChemrxnthermoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_cluster_max(s : ChemrxnthermoCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_cluster_to_string(s : ChemrxnthermoCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_model_make(size : Int) -> ChemrxnthermoModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_model_len(s : ChemrxnthermoModel) -> Int { s.size }

pub fn chem_rxn_thermo_model_get(s : ChemrxnthermoModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_model_set(s : ChemrxnthermoModel, i : Int, v : Double) -> ChemrxnthermoModel {
  let result = chem_rxn_thermo_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_model_sum(s : ChemrxnthermoModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_model_mean(s : ChemrxnthermoModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_model_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_model_scale(s : ChemrxnthermoModel, f : Double) -> ChemrxnthermoModel {
  let result = chem_rxn_thermo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_model_add(a : ChemrxnthermoModel, b : ChemrxnthermoModel) -> ChemrxnthermoModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_model_copy(s : ChemrxnthermoModel) -> ChemrxnthermoModel {
  let result = chem_rxn_thermo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_model_fill(s : ChemrxnthermoModel, v : Double) -> ChemrxnthermoModel {
  let result = chem_rxn_thermo_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_model_min(s : ChemrxnthermoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_model_max(s : ChemrxnthermoModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_model_to_string(s : ChemrxnthermoModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_layer_make(size : Int) -> ChemrxnthermoLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_layer_len(s : ChemrxnthermoLayer) -> Int { s.size }

pub fn chem_rxn_thermo_layer_get(s : ChemrxnthermoLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_layer_set(s : ChemrxnthermoLayer, i : Int, v : Double) -> ChemrxnthermoLayer {
  let result = chem_rxn_thermo_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_layer_sum(s : ChemrxnthermoLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_layer_mean(s : ChemrxnthermoLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_layer_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_layer_scale(s : ChemrxnthermoLayer, f : Double) -> ChemrxnthermoLayer {
  let result = chem_rxn_thermo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_layer_add(a : ChemrxnthermoLayer, b : ChemrxnthermoLayer) -> ChemrxnthermoLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_layer_copy(s : ChemrxnthermoLayer) -> ChemrxnthermoLayer {
  let result = chem_rxn_thermo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_layer_fill(s : ChemrxnthermoLayer, v : Double) -> ChemrxnthermoLayer {
  let result = chem_rxn_thermo_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_layer_min(s : ChemrxnthermoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_layer_max(s : ChemrxnthermoLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_layer_to_string(s : ChemrxnthermoLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_buffer_make(size : Int) -> ChemrxnthermoBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_buffer_len(s : ChemrxnthermoBuffer) -> Int { s.size }

pub fn chem_rxn_thermo_buffer_get(s : ChemrxnthermoBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_buffer_set(s : ChemrxnthermoBuffer, i : Int, v : Double) -> ChemrxnthermoBuffer {
  let result = chem_rxn_thermo_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_buffer_sum(s : ChemrxnthermoBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_buffer_mean(s : ChemrxnthermoBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_buffer_scale(s : ChemrxnthermoBuffer, f : Double) -> ChemrxnthermoBuffer {
  let result = chem_rxn_thermo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_buffer_add(a : ChemrxnthermoBuffer, b : ChemrxnthermoBuffer) -> ChemrxnthermoBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_buffer_copy(s : ChemrxnthermoBuffer) -> ChemrxnthermoBuffer {
  let result = chem_rxn_thermo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_buffer_fill(s : ChemrxnthermoBuffer, v : Double) -> ChemrxnthermoBuffer {
  let result = chem_rxn_thermo_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_buffer_min(s : ChemrxnthermoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_buffer_max(s : ChemrxnthermoBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_buffer_to_string(s : ChemrxnthermoBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_cursor_make(size : Int) -> ChemrxnthermoCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_cursor_len(s : ChemrxnthermoCursor) -> Int { s.size }

pub fn chem_rxn_thermo_cursor_get(s : ChemrxnthermoCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_cursor_set(s : ChemrxnthermoCursor, i : Int, v : Double) -> ChemrxnthermoCursor {
  let result = chem_rxn_thermo_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_cursor_sum(s : ChemrxnthermoCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_cursor_mean(s : ChemrxnthermoCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_cursor_scale(s : ChemrxnthermoCursor, f : Double) -> ChemrxnthermoCursor {
  let result = chem_rxn_thermo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_cursor_add(a : ChemrxnthermoCursor, b : ChemrxnthermoCursor) -> ChemrxnthermoCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_cursor_copy(s : ChemrxnthermoCursor) -> ChemrxnthermoCursor {
  let result = chem_rxn_thermo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_cursor_fill(s : ChemrxnthermoCursor, v : Double) -> ChemrxnthermoCursor {
  let result = chem_rxn_thermo_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_cursor_min(s : ChemrxnthermoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_cursor_max(s : ChemrxnthermoCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_cursor_to_string(s : ChemrxnthermoCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_view_make(size : Int) -> ChemrxnthermoView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_view_len(s : ChemrxnthermoView) -> Int { s.size }

pub fn chem_rxn_thermo_view_get(s : ChemrxnthermoView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_view_set(s : ChemrxnthermoView, i : Int, v : Double) -> ChemrxnthermoView {
  let result = chem_rxn_thermo_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_view_sum(s : ChemrxnthermoView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_view_mean(s : ChemrxnthermoView) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_view_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_view_scale(s : ChemrxnthermoView, f : Double) -> ChemrxnthermoView {
  let result = chem_rxn_thermo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_view_add(a : ChemrxnthermoView, b : ChemrxnthermoView) -> ChemrxnthermoView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_view_copy(s : ChemrxnthermoView) -> ChemrxnthermoView {
  let result = chem_rxn_thermo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_view_fill(s : ChemrxnthermoView, v : Double) -> ChemrxnthermoView {
  let result = chem_rxn_thermo_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_view_min(s : ChemrxnthermoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_view_max(s : ChemrxnthermoView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_view_to_string(s : ChemrxnthermoView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_range_make(size : Int) -> ChemrxnthermoRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_range_len(s : ChemrxnthermoRange) -> Int { s.size }

pub fn chem_rxn_thermo_range_get(s : ChemrxnthermoRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_range_set(s : ChemrxnthermoRange, i : Int, v : Double) -> ChemrxnthermoRange {
  let result = chem_rxn_thermo_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_range_sum(s : ChemrxnthermoRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_range_mean(s : ChemrxnthermoRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_range_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_range_scale(s : ChemrxnthermoRange, f : Double) -> ChemrxnthermoRange {
  let result = chem_rxn_thermo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_range_add(a : ChemrxnthermoRange, b : ChemrxnthermoRange) -> ChemrxnthermoRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_range_copy(s : ChemrxnthermoRange) -> ChemrxnthermoRange {
  let result = chem_rxn_thermo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_range_fill(s : ChemrxnthermoRange, v : Double) -> ChemrxnthermoRange {
  let result = chem_rxn_thermo_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_range_min(s : ChemrxnthermoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_range_max(s : ChemrxnthermoRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_range_to_string(s : ChemrxnthermoRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnthermoSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_thermo_slice_make(size : Int) -> ChemrxnthermoSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_thermo_slice_len(s : ChemrxnthermoSlice) -> Int { s.size }

pub fn chem_rxn_thermo_slice_get(s : ChemrxnthermoSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_thermo_slice_set(s : ChemrxnthermoSlice, i : Int, v : Double) -> ChemrxnthermoSlice {
  let result = chem_rxn_thermo_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_slice_sum(s : ChemrxnthermoSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_thermo_slice_mean(s : ChemrxnthermoSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_thermo_slice_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_thermo_slice_scale(s : ChemrxnthermoSlice, f : Double) -> ChemrxnthermoSlice {
  let result = chem_rxn_thermo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_thermo_slice_add(a : ChemrxnthermoSlice, b : ChemrxnthermoSlice) -> ChemrxnthermoSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_thermo_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_thermo_slice_copy(s : ChemrxnthermoSlice) -> ChemrxnthermoSlice {
  let result = chem_rxn_thermo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_thermo_slice_fill(s : ChemrxnthermoSlice, v : Double) -> ChemrxnthermoSlice {
  let result = chem_rxn_thermo_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_thermo_slice_min(s : ChemrxnthermoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_slice_max(s : ChemrxnthermoSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_thermo_slice_to_string(s : ChemrxnthermoSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_rxn_thermo_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_thermo_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

