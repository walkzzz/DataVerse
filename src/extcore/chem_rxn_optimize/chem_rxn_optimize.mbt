///===
/// extcore/chem_rxn_optimize

pub(all) struct ChemrxnoptimizePoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_optimize_make_point(x : Double, y : Double) -> ChemrxnoptimizePoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_optimize_make_point3(x : Double, y : Double, z : Double) -> ChemrxnoptimizePoint {
  { x, y, z, label: 0 }
}

pub fn chem_rxn_optimize_point_x(pt : ChemrxnoptimizePoint) -> Double { pt.x }

pub fn chem_rxn_optimize_point_y(pt : ChemrxnoptimizePoint) -> Double { pt.y }

pub fn chem_rxn_optimize_point_z(pt : ChemrxnoptimizePoint) -> Double { pt.z }

pub fn chem_rxn_optimize_point_label(pt : ChemrxnoptimizePoint) -> Int { pt.label }

pub fn chem_rxn_optimize_point_dist(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_rxn_optimize_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_rxn_optimize_point_add(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_rxn_optimize_point_sub(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_rxn_optimize_point_scale(pt : ChemrxnoptimizePoint, s : Double) -> ChemrxnoptimizePoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_rxn_optimize_point_dot(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_rxn_optimize_point_cross(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_rxn_optimize_point_norm(pt : ChemrxnoptimizePoint) -> Double {
  chem_rxn_optimize_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_rxn_optimize_point_normalize(pt : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  let n = chem_rxn_optimize_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_rxn_optimize_point_scale(pt, 1.0 / n) }
}

pub fn chem_rxn_optimize_point_negate(pt : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_rxn_optimize_point_mid(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint) -> ChemrxnoptimizePoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_rxn_optimize_point_lerp(a : ChemrxnoptimizePoint, b : ChemrxnoptimizePoint, t : Double) -> ChemrxnoptimizePoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_rxn_optimize_point_to_string(pt : ChemrxnoptimizePoint) -> String {
  "(" + chem_rxn_optimize_dbl(pt.x) + ", " + chem_rxn_optimize_dbl(pt.y) + ", " + chem_rxn_optimize_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_optimize_make_series(vals : Array[Double], name : String) -> ChemrxnoptimizeSeries {
  { vals, name, meta: 0 }
}

pub fn chem_rxn_optimize_series_len(s : ChemrxnoptimizeSeries) -> Int { s.vals.length() }

pub fn chem_rxn_optimize_series_sum(s : ChemrxnoptimizeSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_rxn_optimize_series_mean(s : ChemrxnoptimizeSeries) -> Double {
  let n = chem_rxn_optimize_series_len(s)
  if n == 0 { 0.0 } else { chem_rxn_optimize_series_sum(s) / n.to_double() }
}

pub fn chem_rxn_optimize_series_min(s : ChemrxnoptimizeSeries) -> Double {
  let n = chem_rxn_optimize_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_rxn_optimize_series_max(s : ChemrxnoptimizeSeries) -> Double {
  let n = chem_rxn_optimize_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_rxn_optimize_series_range(s : ChemrxnoptimizeSeries) -> Double {
  chem_rxn_optimize_series_max(s) - chem_rxn_optimize_series_min(s)
}

pub fn chem_rxn_optimize_series_var(s : ChemrxnoptimizeSeries) -> Double {
  let n = chem_rxn_optimize_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_rxn_optimize_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_rxn_optimize_series_std(s : ChemrxnoptimizeSeries) -> Double { chem_rxn_optimize_sqrt(chem_rxn_optimize_series_var(s)) }

pub fn chem_rxn_optimize_series_median(s : ChemrxnoptimizeSeries) -> Double {
  let n = chem_rxn_optimize_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_rxn_optimize_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_rxn_optimize_series_scale(s : ChemrxnoptimizeSeries, f : Double) -> ChemrxnoptimizeSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_rxn_optimize_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_rxn_optimize_series_add(a : ChemrxnoptimizeSeries, b : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_rxn_optimize_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_rxn_optimize_series_sub(a : ChemrxnoptimizeSeries, b : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_rxn_optimize_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_rxn_optimize_series_normalize(s : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  let mn = chem_rxn_optimize_series_min(s)
  let mx = chem_rxn_optimize_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_rxn_optimize_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_rxn_optimize_series_cumsum(s : ChemrxnoptimizeSeries) -> ChemrxnoptimizeSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_rxn_optimize_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_rxn_optimize_series_to_string(s : ChemrxnoptimizeSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_rxn_optimize_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnoptimizeMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_optimize_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnoptimizeMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_optimize_matrix_identity(n : Int) -> ChemrxnoptimizeMatrix {
  let m = chem_rxn_optimize_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_rxn_optimize_matrix_get(m : ChemrxnoptimizeMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_rxn_optimize_matrix_transpose(m : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  let result = chem_rxn_optimize_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_rxn_optimize_matrix_add(a : ChemrxnoptimizeMatrix, b : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_rxn_optimize_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_rxn_optimize_matrix_scale(m : ChemrxnoptimizeMatrix, s : Double) -> ChemrxnoptimizeMatrix {
  let result = chem_rxn_optimize_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_rxn_optimize_matrix_multiply(a : ChemrxnoptimizeMatrix, b : ChemrxnoptimizeMatrix) -> ChemrxnoptimizeMatrix {
  if a.cols != b.rows { return chem_rxn_optimize_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_rxn_optimize_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_rxn_optimize_matrix_trace(m : ChemrxnoptimizeMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_rxn_optimize_matrix_det(m : ChemrxnoptimizeMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_rxn_optimize_matrix_norm(m : ChemrxnoptimizeMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_rxn_optimize_sqrt(sum)
}

pub fn chem_rxn_optimize_matrix_to_string(m : ChemrxnoptimizeMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_rxn_optimize_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemrxnoptimizeVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_optimize_make_vector(comps : Array[Double]) -> ChemrxnoptimizeVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_optimize_vector_zero(dim : Int) -> ChemrxnoptimizeVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_rxn_optimize_vector_add(a : ChemrxnoptimizeVector, b : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_rxn_optimize_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_optimize_vector_sub(a : ChemrxnoptimizeVector, b : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_rxn_optimize_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_optimize_vector_scale(v : ChemrxnoptimizeVector, s : Double) -> ChemrxnoptimizeVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_rxn_optimize_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_rxn_optimize_vector_dot(a : ChemrxnoptimizeVector, b : ChemrxnoptimizeVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_rxn_optimize_vector_norm(v : ChemrxnoptimizeVector) -> Double { chem_rxn_optimize_sqrt(chem_rxn_optimize_vector_dot(v, v)) }

pub fn chem_rxn_optimize_vector_normalize(v : ChemrxnoptimizeVector) -> ChemrxnoptimizeVector {
  let n = chem_rxn_optimize_vector_norm(v)
  if n < 0.0000001 { v } else { chem_rxn_optimize_vector_scale(v, 1.0 / n) }
}

pub fn chem_rxn_optimize_vector_dist(a : ChemrxnoptimizeVector, b : ChemrxnoptimizeVector) -> Double {
  chem_rxn_optimize_vector_norm(chem_rxn_optimize_vector_sub(a, b))
}

pub fn chem_rxn_optimize_vector_to_string(v : ChemrxnoptimizeVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_rxn_optimize_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_optimize_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_rxn_optimize_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_rxn_optimize_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_rxn_optimize_std(data : Array[Double]) -> Double { chem_rxn_optimize_sqrt(chem_rxn_optimize_var(data)) }

pub fn chem_rxn_optimize_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_rxn_optimize_mean(a); let mb = chem_rxn_optimize_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_rxn_optimize_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_rxn_optimize_std(a); let sb = chem_rxn_optimize_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_rxn_optimize_cov(a, b) / (sa * sb) }
}

pub fn chem_rxn_optimize_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_rxn_optimize_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_rxn_optimize_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_rxn_optimize_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_rxn_optimize_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_rxn_optimize_sqrt(chem_rxn_optimize_mse(pred, labels))
}

pub fn chem_rxn_optimize_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_rxn_optimize_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_rxn_optimize_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_rxn_optimize_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_rxn_optimize_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_rxn_optimize_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_rxn_optimize_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_rxn_optimize_precision(pred, labels, pos); let r = chem_rxn_optimize_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_rxn_optimize_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_rxn_optimize_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_rxn_optimize_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_rxn_optimize_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_rxn_optimize_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_rxn_optimize_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_rxn_optimize_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_rxn_optimize_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_rxn_optimize_fibonacci(n : Int) -> Int {
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

pub fn chem_rxn_optimize_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_rxn_optimize_min(data); let mx = chem_rxn_optimize_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_rxn_optimize_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_rxn_optimize_mean(data); let sd = chem_rxn_optimize_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_rxn_optimize_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_rxn_optimize_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_rxn_optimize_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_rxn_optimize_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_rxn_optimize_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_rxn_optimize_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_rxn_optimize_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_rxn_optimize_int(x) } else { -chem_rxn_optimize_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_rxn_optimize_int(f * 1000000.0) } else { chem_rxn_optimize_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_rxn_optimize_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_rxn_optimize_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemrxnoptimizeFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_frame_make(size : Int) -> ChemrxnoptimizeFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_frame_len(s : ChemrxnoptimizeFrame) -> Int { s.size }

pub fn chem_rxn_optimize_frame_get(s : ChemrxnoptimizeFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_frame_set(s : ChemrxnoptimizeFrame, i : Int, v : Double) -> ChemrxnoptimizeFrame {
  let result = chem_rxn_optimize_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_frame_sum(s : ChemrxnoptimizeFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_frame_mean(s : ChemrxnoptimizeFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_frame_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_frame_scale(s : ChemrxnoptimizeFrame, f : Double) -> ChemrxnoptimizeFrame {
  let result = chem_rxn_optimize_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_frame_add(a : ChemrxnoptimizeFrame, b : ChemrxnoptimizeFrame) -> ChemrxnoptimizeFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_frame_copy(s : ChemrxnoptimizeFrame) -> ChemrxnoptimizeFrame {
  let result = chem_rxn_optimize_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_frame_fill(s : ChemrxnoptimizeFrame, v : Double) -> ChemrxnoptimizeFrame {
  let result = chem_rxn_optimize_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_frame_min(s : ChemrxnoptimizeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_frame_max(s : ChemrxnoptimizeFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_frame_to_string(s : ChemrxnoptimizeFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_table_make(size : Int) -> ChemrxnoptimizeTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_table_len(s : ChemrxnoptimizeTable) -> Int { s.size }

pub fn chem_rxn_optimize_table_get(s : ChemrxnoptimizeTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_table_set(s : ChemrxnoptimizeTable, i : Int, v : Double) -> ChemrxnoptimizeTable {
  let result = chem_rxn_optimize_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_table_sum(s : ChemrxnoptimizeTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_table_mean(s : ChemrxnoptimizeTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_table_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_table_scale(s : ChemrxnoptimizeTable, f : Double) -> ChemrxnoptimizeTable {
  let result = chem_rxn_optimize_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_table_add(a : ChemrxnoptimizeTable, b : ChemrxnoptimizeTable) -> ChemrxnoptimizeTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_table_copy(s : ChemrxnoptimizeTable) -> ChemrxnoptimizeTable {
  let result = chem_rxn_optimize_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_table_fill(s : ChemrxnoptimizeTable, v : Double) -> ChemrxnoptimizeTable {
  let result = chem_rxn_optimize_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_table_min(s : ChemrxnoptimizeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_table_max(s : ChemrxnoptimizeTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_table_to_string(s : ChemrxnoptimizeTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_graphn_make(size : Int) -> ChemrxnoptimizeGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_graphn_len(s : ChemrxnoptimizeGraphN) -> Int { s.size }

pub fn chem_rxn_optimize_graphn_get(s : ChemrxnoptimizeGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_graphn_set(s : ChemrxnoptimizeGraphN, i : Int, v : Double) -> ChemrxnoptimizeGraphN {
  let result = chem_rxn_optimize_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_graphn_sum(s : ChemrxnoptimizeGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_graphn_mean(s : ChemrxnoptimizeGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_graphn_scale(s : ChemrxnoptimizeGraphN, f : Double) -> ChemrxnoptimizeGraphN {
  let result = chem_rxn_optimize_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_graphn_add(a : ChemrxnoptimizeGraphN, b : ChemrxnoptimizeGraphN) -> ChemrxnoptimizeGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_graphn_copy(s : ChemrxnoptimizeGraphN) -> ChemrxnoptimizeGraphN {
  let result = chem_rxn_optimize_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_graphn_fill(s : ChemrxnoptimizeGraphN, v : Double) -> ChemrxnoptimizeGraphN {
  let result = chem_rxn_optimize_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_graphn_min(s : ChemrxnoptimizeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_graphn_max(s : ChemrxnoptimizeGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_graphn_to_string(s : ChemrxnoptimizeGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_node_make(size : Int) -> ChemrxnoptimizeNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_node_len(s : ChemrxnoptimizeNode) -> Int { s.size }

pub fn chem_rxn_optimize_node_get(s : ChemrxnoptimizeNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_node_set(s : ChemrxnoptimizeNode, i : Int, v : Double) -> ChemrxnoptimizeNode {
  let result = chem_rxn_optimize_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_node_sum(s : ChemrxnoptimizeNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_node_mean(s : ChemrxnoptimizeNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_node_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_node_scale(s : ChemrxnoptimizeNode, f : Double) -> ChemrxnoptimizeNode {
  let result = chem_rxn_optimize_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_node_add(a : ChemrxnoptimizeNode, b : ChemrxnoptimizeNode) -> ChemrxnoptimizeNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_node_copy(s : ChemrxnoptimizeNode) -> ChemrxnoptimizeNode {
  let result = chem_rxn_optimize_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_node_fill(s : ChemrxnoptimizeNode, v : Double) -> ChemrxnoptimizeNode {
  let result = chem_rxn_optimize_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_node_min(s : ChemrxnoptimizeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_node_max(s : ChemrxnoptimizeNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_node_to_string(s : ChemrxnoptimizeNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_edge_make(size : Int) -> ChemrxnoptimizeEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_edge_len(s : ChemrxnoptimizeEdge) -> Int { s.size }

pub fn chem_rxn_optimize_edge_get(s : ChemrxnoptimizeEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_edge_set(s : ChemrxnoptimizeEdge, i : Int, v : Double) -> ChemrxnoptimizeEdge {
  let result = chem_rxn_optimize_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_edge_sum(s : ChemrxnoptimizeEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_edge_mean(s : ChemrxnoptimizeEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_edge_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_edge_scale(s : ChemrxnoptimizeEdge, f : Double) -> ChemrxnoptimizeEdge {
  let result = chem_rxn_optimize_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_edge_add(a : ChemrxnoptimizeEdge, b : ChemrxnoptimizeEdge) -> ChemrxnoptimizeEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_edge_copy(s : ChemrxnoptimizeEdge) -> ChemrxnoptimizeEdge {
  let result = chem_rxn_optimize_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_edge_fill(s : ChemrxnoptimizeEdge, v : Double) -> ChemrxnoptimizeEdge {
  let result = chem_rxn_optimize_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_edge_min(s : ChemrxnoptimizeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_edge_max(s : ChemrxnoptimizeEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_edge_to_string(s : ChemrxnoptimizeEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizePath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_path_make(size : Int) -> ChemrxnoptimizePath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_path_len(s : ChemrxnoptimizePath) -> Int { s.size }

pub fn chem_rxn_optimize_path_get(s : ChemrxnoptimizePath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_path_set(s : ChemrxnoptimizePath, i : Int, v : Double) -> ChemrxnoptimizePath {
  let result = chem_rxn_optimize_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_path_sum(s : ChemrxnoptimizePath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_path_mean(s : ChemrxnoptimizePath) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_path_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_path_scale(s : ChemrxnoptimizePath, f : Double) -> ChemrxnoptimizePath {
  let result = chem_rxn_optimize_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_path_add(a : ChemrxnoptimizePath, b : ChemrxnoptimizePath) -> ChemrxnoptimizePath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_path_copy(s : ChemrxnoptimizePath) -> ChemrxnoptimizePath {
  let result = chem_rxn_optimize_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_path_fill(s : ChemrxnoptimizePath, v : Double) -> ChemrxnoptimizePath {
  let result = chem_rxn_optimize_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_path_min(s : ChemrxnoptimizePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_path_max(s : ChemrxnoptimizePath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_path_to_string(s : ChemrxnoptimizePath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_cluster_make(size : Int) -> ChemrxnoptimizeCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_cluster_len(s : ChemrxnoptimizeCluster) -> Int { s.size }

pub fn chem_rxn_optimize_cluster_get(s : ChemrxnoptimizeCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_cluster_set(s : ChemrxnoptimizeCluster, i : Int, v : Double) -> ChemrxnoptimizeCluster {
  let result = chem_rxn_optimize_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_cluster_sum(s : ChemrxnoptimizeCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_cluster_mean(s : ChemrxnoptimizeCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_cluster_scale(s : ChemrxnoptimizeCluster, f : Double) -> ChemrxnoptimizeCluster {
  let result = chem_rxn_optimize_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_cluster_add(a : ChemrxnoptimizeCluster, b : ChemrxnoptimizeCluster) -> ChemrxnoptimizeCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_cluster_copy(s : ChemrxnoptimizeCluster) -> ChemrxnoptimizeCluster {
  let result = chem_rxn_optimize_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_cluster_fill(s : ChemrxnoptimizeCluster, v : Double) -> ChemrxnoptimizeCluster {
  let result = chem_rxn_optimize_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_cluster_min(s : ChemrxnoptimizeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_cluster_max(s : ChemrxnoptimizeCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_cluster_to_string(s : ChemrxnoptimizeCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_model_make(size : Int) -> ChemrxnoptimizeModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_model_len(s : ChemrxnoptimizeModel) -> Int { s.size }

pub fn chem_rxn_optimize_model_get(s : ChemrxnoptimizeModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_model_set(s : ChemrxnoptimizeModel, i : Int, v : Double) -> ChemrxnoptimizeModel {
  let result = chem_rxn_optimize_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_model_sum(s : ChemrxnoptimizeModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_model_mean(s : ChemrxnoptimizeModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_model_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_model_scale(s : ChemrxnoptimizeModel, f : Double) -> ChemrxnoptimizeModel {
  let result = chem_rxn_optimize_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_model_add(a : ChemrxnoptimizeModel, b : ChemrxnoptimizeModel) -> ChemrxnoptimizeModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_model_copy(s : ChemrxnoptimizeModel) -> ChemrxnoptimizeModel {
  let result = chem_rxn_optimize_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_model_fill(s : ChemrxnoptimizeModel, v : Double) -> ChemrxnoptimizeModel {
  let result = chem_rxn_optimize_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_model_min(s : ChemrxnoptimizeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_model_max(s : ChemrxnoptimizeModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_model_to_string(s : ChemrxnoptimizeModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_layer_make(size : Int) -> ChemrxnoptimizeLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_layer_len(s : ChemrxnoptimizeLayer) -> Int { s.size }

pub fn chem_rxn_optimize_layer_get(s : ChemrxnoptimizeLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_layer_set(s : ChemrxnoptimizeLayer, i : Int, v : Double) -> ChemrxnoptimizeLayer {
  let result = chem_rxn_optimize_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_layer_sum(s : ChemrxnoptimizeLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_layer_mean(s : ChemrxnoptimizeLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_layer_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_layer_scale(s : ChemrxnoptimizeLayer, f : Double) -> ChemrxnoptimizeLayer {
  let result = chem_rxn_optimize_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_layer_add(a : ChemrxnoptimizeLayer, b : ChemrxnoptimizeLayer) -> ChemrxnoptimizeLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_layer_copy(s : ChemrxnoptimizeLayer) -> ChemrxnoptimizeLayer {
  let result = chem_rxn_optimize_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_layer_fill(s : ChemrxnoptimizeLayer, v : Double) -> ChemrxnoptimizeLayer {
  let result = chem_rxn_optimize_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_layer_min(s : ChemrxnoptimizeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_layer_max(s : ChemrxnoptimizeLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_layer_to_string(s : ChemrxnoptimizeLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_buffer_make(size : Int) -> ChemrxnoptimizeBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_buffer_len(s : ChemrxnoptimizeBuffer) -> Int { s.size }

pub fn chem_rxn_optimize_buffer_get(s : ChemrxnoptimizeBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_buffer_set(s : ChemrxnoptimizeBuffer, i : Int, v : Double) -> ChemrxnoptimizeBuffer {
  let result = chem_rxn_optimize_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_buffer_sum(s : ChemrxnoptimizeBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_buffer_mean(s : ChemrxnoptimizeBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_buffer_scale(s : ChemrxnoptimizeBuffer, f : Double) -> ChemrxnoptimizeBuffer {
  let result = chem_rxn_optimize_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_buffer_add(a : ChemrxnoptimizeBuffer, b : ChemrxnoptimizeBuffer) -> ChemrxnoptimizeBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_buffer_copy(s : ChemrxnoptimizeBuffer) -> ChemrxnoptimizeBuffer {
  let result = chem_rxn_optimize_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_buffer_fill(s : ChemrxnoptimizeBuffer, v : Double) -> ChemrxnoptimizeBuffer {
  let result = chem_rxn_optimize_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_buffer_min(s : ChemrxnoptimizeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_buffer_max(s : ChemrxnoptimizeBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_buffer_to_string(s : ChemrxnoptimizeBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_cursor_make(size : Int) -> ChemrxnoptimizeCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_cursor_len(s : ChemrxnoptimizeCursor) -> Int { s.size }

pub fn chem_rxn_optimize_cursor_get(s : ChemrxnoptimizeCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_cursor_set(s : ChemrxnoptimizeCursor, i : Int, v : Double) -> ChemrxnoptimizeCursor {
  let result = chem_rxn_optimize_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_cursor_sum(s : ChemrxnoptimizeCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_cursor_mean(s : ChemrxnoptimizeCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_cursor_scale(s : ChemrxnoptimizeCursor, f : Double) -> ChemrxnoptimizeCursor {
  let result = chem_rxn_optimize_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_cursor_add(a : ChemrxnoptimizeCursor, b : ChemrxnoptimizeCursor) -> ChemrxnoptimizeCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_cursor_copy(s : ChemrxnoptimizeCursor) -> ChemrxnoptimizeCursor {
  let result = chem_rxn_optimize_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_cursor_fill(s : ChemrxnoptimizeCursor, v : Double) -> ChemrxnoptimizeCursor {
  let result = chem_rxn_optimize_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_cursor_min(s : ChemrxnoptimizeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_cursor_max(s : ChemrxnoptimizeCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_cursor_to_string(s : ChemrxnoptimizeCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_view_make(size : Int) -> ChemrxnoptimizeView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_view_len(s : ChemrxnoptimizeView) -> Int { s.size }

pub fn chem_rxn_optimize_view_get(s : ChemrxnoptimizeView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_view_set(s : ChemrxnoptimizeView, i : Int, v : Double) -> ChemrxnoptimizeView {
  let result = chem_rxn_optimize_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_view_sum(s : ChemrxnoptimizeView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_view_mean(s : ChemrxnoptimizeView) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_view_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_view_scale(s : ChemrxnoptimizeView, f : Double) -> ChemrxnoptimizeView {
  let result = chem_rxn_optimize_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_view_add(a : ChemrxnoptimizeView, b : ChemrxnoptimizeView) -> ChemrxnoptimizeView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_view_copy(s : ChemrxnoptimizeView) -> ChemrxnoptimizeView {
  let result = chem_rxn_optimize_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_view_fill(s : ChemrxnoptimizeView, v : Double) -> ChemrxnoptimizeView {
  let result = chem_rxn_optimize_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_view_min(s : ChemrxnoptimizeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_view_max(s : ChemrxnoptimizeView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_view_to_string(s : ChemrxnoptimizeView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_range_make(size : Int) -> ChemrxnoptimizeRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_range_len(s : ChemrxnoptimizeRange) -> Int { s.size }

pub fn chem_rxn_optimize_range_get(s : ChemrxnoptimizeRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_range_set(s : ChemrxnoptimizeRange, i : Int, v : Double) -> ChemrxnoptimizeRange {
  let result = chem_rxn_optimize_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_range_sum(s : ChemrxnoptimizeRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_range_mean(s : ChemrxnoptimizeRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_range_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_range_scale(s : ChemrxnoptimizeRange, f : Double) -> ChemrxnoptimizeRange {
  let result = chem_rxn_optimize_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_range_add(a : ChemrxnoptimizeRange, b : ChemrxnoptimizeRange) -> ChemrxnoptimizeRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_range_copy(s : ChemrxnoptimizeRange) -> ChemrxnoptimizeRange {
  let result = chem_rxn_optimize_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_range_fill(s : ChemrxnoptimizeRange, v : Double) -> ChemrxnoptimizeRange {
  let result = chem_rxn_optimize_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_range_min(s : ChemrxnoptimizeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_range_max(s : ChemrxnoptimizeRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_range_to_string(s : ChemrxnoptimizeRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnoptimizeSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_optimize_slice_make(size : Int) -> ChemrxnoptimizeSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_optimize_slice_len(s : ChemrxnoptimizeSlice) -> Int { s.size }

pub fn chem_rxn_optimize_slice_get(s : ChemrxnoptimizeSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_optimize_slice_set(s : ChemrxnoptimizeSlice, i : Int, v : Double) -> ChemrxnoptimizeSlice {
  let result = chem_rxn_optimize_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_slice_sum(s : ChemrxnoptimizeSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_optimize_slice_mean(s : ChemrxnoptimizeSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_optimize_slice_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_optimize_slice_scale(s : ChemrxnoptimizeSlice, f : Double) -> ChemrxnoptimizeSlice {
  let result = chem_rxn_optimize_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_optimize_slice_add(a : ChemrxnoptimizeSlice, b : ChemrxnoptimizeSlice) -> ChemrxnoptimizeSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_optimize_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_optimize_slice_copy(s : ChemrxnoptimizeSlice) -> ChemrxnoptimizeSlice {
  let result = chem_rxn_optimize_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_optimize_slice_fill(s : ChemrxnoptimizeSlice, v : Double) -> ChemrxnoptimizeSlice {
  let result = chem_rxn_optimize_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_optimize_slice_min(s : ChemrxnoptimizeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_slice_max(s : ChemrxnoptimizeSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_optimize_slice_to_string(s : ChemrxnoptimizeSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_rxn_optimize_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_optimize_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

