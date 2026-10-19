///===
/// extcore/chem_rxn_mechanism

pub(all) struct ChemrxnmechanismPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_mechanism_make_point(x : Double, y : Double) -> ChemrxnmechanismPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_mechanism_make_point3(x : Double, y : Double, z : Double) -> ChemrxnmechanismPoint {
  { x, y, z, label: 0 }
}

pub fn chem_rxn_mechanism_point_x(pt : ChemrxnmechanismPoint) -> Double { pt.x }

pub fn chem_rxn_mechanism_point_y(pt : ChemrxnmechanismPoint) -> Double { pt.y }

pub fn chem_rxn_mechanism_point_z(pt : ChemrxnmechanismPoint) -> Double { pt.z }

pub fn chem_rxn_mechanism_point_label(pt : ChemrxnmechanismPoint) -> Int { pt.label }

pub fn chem_rxn_mechanism_point_dist(a : ChemrxnmechanismPoint, b : ChemrxnmechanismPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_rxn_mechanism_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_rxn_mechanism_point_add(a : ChemrxnmechanismPoint, b : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_rxn_mechanism_point_sub(a : ChemrxnmechanismPoint, b : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_rxn_mechanism_point_scale(pt : ChemrxnmechanismPoint, s : Double) -> ChemrxnmechanismPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_rxn_mechanism_point_dot(a : ChemrxnmechanismPoint, b : ChemrxnmechanismPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_rxn_mechanism_point_cross(a : ChemrxnmechanismPoint, b : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_rxn_mechanism_point_norm(pt : ChemrxnmechanismPoint) -> Double {
  chem_rxn_mechanism_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_rxn_mechanism_point_normalize(pt : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  let n = chem_rxn_mechanism_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_rxn_mechanism_point_scale(pt, 1.0 / n) }
}

pub fn chem_rxn_mechanism_point_negate(pt : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_rxn_mechanism_point_mid(a : ChemrxnmechanismPoint, b : ChemrxnmechanismPoint) -> ChemrxnmechanismPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_rxn_mechanism_point_lerp(a : ChemrxnmechanismPoint, b : ChemrxnmechanismPoint, t : Double) -> ChemrxnmechanismPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_rxn_mechanism_point_to_string(pt : ChemrxnmechanismPoint) -> String {
  "(" + chem_rxn_mechanism_dbl(pt.x) + ", " + chem_rxn_mechanism_dbl(pt.y) + ", " + chem_rxn_mechanism_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemrxnmechanismSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_mechanism_make_series(vals : Array[Double], name : String) -> ChemrxnmechanismSeries {
  { vals, name, meta: 0 }
}

pub fn chem_rxn_mechanism_series_len(s : ChemrxnmechanismSeries) -> Int { s.vals.length() }

pub fn chem_rxn_mechanism_series_sum(s : ChemrxnmechanismSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_rxn_mechanism_series_mean(s : ChemrxnmechanismSeries) -> Double {
  let n = chem_rxn_mechanism_series_len(s)
  if n == 0 { 0.0 } else { chem_rxn_mechanism_series_sum(s) / n.to_double() }
}

pub fn chem_rxn_mechanism_series_min(s : ChemrxnmechanismSeries) -> Double {
  let n = chem_rxn_mechanism_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_series_max(s : ChemrxnmechanismSeries) -> Double {
  let n = chem_rxn_mechanism_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_series_range(s : ChemrxnmechanismSeries) -> Double {
  chem_rxn_mechanism_series_max(s) - chem_rxn_mechanism_series_min(s)
}

pub fn chem_rxn_mechanism_series_var(s : ChemrxnmechanismSeries) -> Double {
  let n = chem_rxn_mechanism_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_rxn_mechanism_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_rxn_mechanism_series_std(s : ChemrxnmechanismSeries) -> Double { chem_rxn_mechanism_sqrt(chem_rxn_mechanism_series_var(s)) }

pub fn chem_rxn_mechanism_series_median(s : ChemrxnmechanismSeries) -> Double {
  let n = chem_rxn_mechanism_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_rxn_mechanism_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_rxn_mechanism_series_scale(s : ChemrxnmechanismSeries, f : Double) -> ChemrxnmechanismSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_rxn_mechanism_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_rxn_mechanism_series_add(a : ChemrxnmechanismSeries, b : ChemrxnmechanismSeries) -> ChemrxnmechanismSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_rxn_mechanism_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_rxn_mechanism_series_sub(a : ChemrxnmechanismSeries, b : ChemrxnmechanismSeries) -> ChemrxnmechanismSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_rxn_mechanism_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_rxn_mechanism_series_normalize(s : ChemrxnmechanismSeries) -> ChemrxnmechanismSeries {
  let mn = chem_rxn_mechanism_series_min(s)
  let mx = chem_rxn_mechanism_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_rxn_mechanism_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_rxn_mechanism_series_cumsum(s : ChemrxnmechanismSeries) -> ChemrxnmechanismSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_rxn_mechanism_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_rxn_mechanism_series_to_string(s : ChemrxnmechanismSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_rxn_mechanism_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnmechanismMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_mechanism_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnmechanismMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_mechanism_matrix_identity(n : Int) -> ChemrxnmechanismMatrix {
  let m = chem_rxn_mechanism_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_rxn_mechanism_matrix_get(m : ChemrxnmechanismMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_rxn_mechanism_matrix_transpose(m : ChemrxnmechanismMatrix) -> ChemrxnmechanismMatrix {
  let result = chem_rxn_mechanism_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_rxn_mechanism_matrix_add(a : ChemrxnmechanismMatrix, b : ChemrxnmechanismMatrix) -> ChemrxnmechanismMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_rxn_mechanism_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_rxn_mechanism_matrix_scale(m : ChemrxnmechanismMatrix, s : Double) -> ChemrxnmechanismMatrix {
  let result = chem_rxn_mechanism_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_rxn_mechanism_matrix_multiply(a : ChemrxnmechanismMatrix, b : ChemrxnmechanismMatrix) -> ChemrxnmechanismMatrix {
  if a.cols != b.rows { return chem_rxn_mechanism_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_rxn_mechanism_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_rxn_mechanism_matrix_trace(m : ChemrxnmechanismMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_rxn_mechanism_matrix_det(m : ChemrxnmechanismMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_rxn_mechanism_matrix_norm(m : ChemrxnmechanismMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_rxn_mechanism_sqrt(sum)
}

pub fn chem_rxn_mechanism_matrix_to_string(m : ChemrxnmechanismMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_rxn_mechanism_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemrxnmechanismVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_mechanism_make_vector(comps : Array[Double]) -> ChemrxnmechanismVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_mechanism_vector_zero(dim : Int) -> ChemrxnmechanismVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_rxn_mechanism_vector_add(a : ChemrxnmechanismVector, b : ChemrxnmechanismVector) -> ChemrxnmechanismVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_rxn_mechanism_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_mechanism_vector_sub(a : ChemrxnmechanismVector, b : ChemrxnmechanismVector) -> ChemrxnmechanismVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_rxn_mechanism_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_mechanism_vector_scale(v : ChemrxnmechanismVector, s : Double) -> ChemrxnmechanismVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_rxn_mechanism_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_rxn_mechanism_vector_dot(a : ChemrxnmechanismVector, b : ChemrxnmechanismVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_rxn_mechanism_vector_norm(v : ChemrxnmechanismVector) -> Double { chem_rxn_mechanism_sqrt(chem_rxn_mechanism_vector_dot(v, v)) }

pub fn chem_rxn_mechanism_vector_normalize(v : ChemrxnmechanismVector) -> ChemrxnmechanismVector {
  let n = chem_rxn_mechanism_vector_norm(v)
  if n < 0.0000001 { v } else { chem_rxn_mechanism_vector_scale(v, 1.0 / n) }
}

pub fn chem_rxn_mechanism_vector_dist(a : ChemrxnmechanismVector, b : ChemrxnmechanismVector) -> Double {
  chem_rxn_mechanism_vector_norm(chem_rxn_mechanism_vector_sub(a, b))
}

pub fn chem_rxn_mechanism_vector_to_string(v : ChemrxnmechanismVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_rxn_mechanism_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_mechanism_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_rxn_mechanism_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_rxn_mechanism_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_rxn_mechanism_std(data : Array[Double]) -> Double { chem_rxn_mechanism_sqrt(chem_rxn_mechanism_var(data)) }

pub fn chem_rxn_mechanism_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_rxn_mechanism_mean(a); let mb = chem_rxn_mechanism_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_rxn_mechanism_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_rxn_mechanism_std(a); let sb = chem_rxn_mechanism_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_rxn_mechanism_cov(a, b) / (sa * sb) }
}

pub fn chem_rxn_mechanism_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_rxn_mechanism_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_rxn_mechanism_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_rxn_mechanism_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_rxn_mechanism_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_rxn_mechanism_sqrt(chem_rxn_mechanism_mse(pred, labels))
}

pub fn chem_rxn_mechanism_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_rxn_mechanism_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_rxn_mechanism_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_rxn_mechanism_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_rxn_mechanism_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_rxn_mechanism_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_rxn_mechanism_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_rxn_mechanism_precision(pred, labels, pos); let r = chem_rxn_mechanism_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_rxn_mechanism_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_rxn_mechanism_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_rxn_mechanism_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_rxn_mechanism_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_rxn_mechanism_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_rxn_mechanism_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_rxn_mechanism_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_rxn_mechanism_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_rxn_mechanism_fibonacci(n : Int) -> Int {
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

pub fn chem_rxn_mechanism_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_rxn_mechanism_min(data); let mx = chem_rxn_mechanism_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_rxn_mechanism_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_rxn_mechanism_mean(data); let sd = chem_rxn_mechanism_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_rxn_mechanism_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_rxn_mechanism_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_rxn_mechanism_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_rxn_mechanism_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_rxn_mechanism_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_rxn_mechanism_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_rxn_mechanism_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_rxn_mechanism_int(x) } else { -chem_rxn_mechanism_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_rxn_mechanism_int(f * 1000000.0) } else { chem_rxn_mechanism_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_rxn_mechanism_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_rxn_mechanism_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemrxnmechanismFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_frame_make(size : Int) -> ChemrxnmechanismFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_frame_len(s : ChemrxnmechanismFrame) -> Int { s.size }

pub fn chem_rxn_mechanism_frame_get(s : ChemrxnmechanismFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_frame_set(s : ChemrxnmechanismFrame, i : Int, v : Double) -> ChemrxnmechanismFrame {
  let result = chem_rxn_mechanism_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_frame_sum(s : ChemrxnmechanismFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_frame_mean(s : ChemrxnmechanismFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_frame_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_frame_scale(s : ChemrxnmechanismFrame, f : Double) -> ChemrxnmechanismFrame {
  let result = chem_rxn_mechanism_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_frame_add(a : ChemrxnmechanismFrame, b : ChemrxnmechanismFrame) -> ChemrxnmechanismFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_frame_copy(s : ChemrxnmechanismFrame) -> ChemrxnmechanismFrame {
  let result = chem_rxn_mechanism_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_frame_fill(s : ChemrxnmechanismFrame, v : Double) -> ChemrxnmechanismFrame {
  let result = chem_rxn_mechanism_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_frame_min(s : ChemrxnmechanismFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_frame_max(s : ChemrxnmechanismFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_frame_to_string(s : ChemrxnmechanismFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_table_make(size : Int) -> ChemrxnmechanismTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_table_len(s : ChemrxnmechanismTable) -> Int { s.size }

pub fn chem_rxn_mechanism_table_get(s : ChemrxnmechanismTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_table_set(s : ChemrxnmechanismTable, i : Int, v : Double) -> ChemrxnmechanismTable {
  let result = chem_rxn_mechanism_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_table_sum(s : ChemrxnmechanismTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_table_mean(s : ChemrxnmechanismTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_table_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_table_scale(s : ChemrxnmechanismTable, f : Double) -> ChemrxnmechanismTable {
  let result = chem_rxn_mechanism_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_table_add(a : ChemrxnmechanismTable, b : ChemrxnmechanismTable) -> ChemrxnmechanismTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_table_copy(s : ChemrxnmechanismTable) -> ChemrxnmechanismTable {
  let result = chem_rxn_mechanism_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_table_fill(s : ChemrxnmechanismTable, v : Double) -> ChemrxnmechanismTable {
  let result = chem_rxn_mechanism_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_table_min(s : ChemrxnmechanismTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_table_max(s : ChemrxnmechanismTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_table_to_string(s : ChemrxnmechanismTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_graphn_make(size : Int) -> ChemrxnmechanismGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_graphn_len(s : ChemrxnmechanismGraphN) -> Int { s.size }

pub fn chem_rxn_mechanism_graphn_get(s : ChemrxnmechanismGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_graphn_set(s : ChemrxnmechanismGraphN, i : Int, v : Double) -> ChemrxnmechanismGraphN {
  let result = chem_rxn_mechanism_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_graphn_sum(s : ChemrxnmechanismGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_graphn_mean(s : ChemrxnmechanismGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_graphn_scale(s : ChemrxnmechanismGraphN, f : Double) -> ChemrxnmechanismGraphN {
  let result = chem_rxn_mechanism_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_graphn_add(a : ChemrxnmechanismGraphN, b : ChemrxnmechanismGraphN) -> ChemrxnmechanismGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_graphn_copy(s : ChemrxnmechanismGraphN) -> ChemrxnmechanismGraphN {
  let result = chem_rxn_mechanism_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_graphn_fill(s : ChemrxnmechanismGraphN, v : Double) -> ChemrxnmechanismGraphN {
  let result = chem_rxn_mechanism_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_graphn_min(s : ChemrxnmechanismGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_graphn_max(s : ChemrxnmechanismGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_graphn_to_string(s : ChemrxnmechanismGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_node_make(size : Int) -> ChemrxnmechanismNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_node_len(s : ChemrxnmechanismNode) -> Int { s.size }

pub fn chem_rxn_mechanism_node_get(s : ChemrxnmechanismNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_node_set(s : ChemrxnmechanismNode, i : Int, v : Double) -> ChemrxnmechanismNode {
  let result = chem_rxn_mechanism_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_node_sum(s : ChemrxnmechanismNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_node_mean(s : ChemrxnmechanismNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_node_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_node_scale(s : ChemrxnmechanismNode, f : Double) -> ChemrxnmechanismNode {
  let result = chem_rxn_mechanism_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_node_add(a : ChemrxnmechanismNode, b : ChemrxnmechanismNode) -> ChemrxnmechanismNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_node_copy(s : ChemrxnmechanismNode) -> ChemrxnmechanismNode {
  let result = chem_rxn_mechanism_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_node_fill(s : ChemrxnmechanismNode, v : Double) -> ChemrxnmechanismNode {
  let result = chem_rxn_mechanism_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_node_min(s : ChemrxnmechanismNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_node_max(s : ChemrxnmechanismNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_node_to_string(s : ChemrxnmechanismNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_edge_make(size : Int) -> ChemrxnmechanismEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_edge_len(s : ChemrxnmechanismEdge) -> Int { s.size }

pub fn chem_rxn_mechanism_edge_get(s : ChemrxnmechanismEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_edge_set(s : ChemrxnmechanismEdge, i : Int, v : Double) -> ChemrxnmechanismEdge {
  let result = chem_rxn_mechanism_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_edge_sum(s : ChemrxnmechanismEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_edge_mean(s : ChemrxnmechanismEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_edge_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_edge_scale(s : ChemrxnmechanismEdge, f : Double) -> ChemrxnmechanismEdge {
  let result = chem_rxn_mechanism_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_edge_add(a : ChemrxnmechanismEdge, b : ChemrxnmechanismEdge) -> ChemrxnmechanismEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_edge_copy(s : ChemrxnmechanismEdge) -> ChemrxnmechanismEdge {
  let result = chem_rxn_mechanism_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_edge_fill(s : ChemrxnmechanismEdge, v : Double) -> ChemrxnmechanismEdge {
  let result = chem_rxn_mechanism_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_edge_min(s : ChemrxnmechanismEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_edge_max(s : ChemrxnmechanismEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_edge_to_string(s : ChemrxnmechanismEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_path_make(size : Int) -> ChemrxnmechanismPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_path_len(s : ChemrxnmechanismPath) -> Int { s.size }

pub fn chem_rxn_mechanism_path_get(s : ChemrxnmechanismPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_path_set(s : ChemrxnmechanismPath, i : Int, v : Double) -> ChemrxnmechanismPath {
  let result = chem_rxn_mechanism_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_path_sum(s : ChemrxnmechanismPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_path_mean(s : ChemrxnmechanismPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_path_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_path_scale(s : ChemrxnmechanismPath, f : Double) -> ChemrxnmechanismPath {
  let result = chem_rxn_mechanism_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_path_add(a : ChemrxnmechanismPath, b : ChemrxnmechanismPath) -> ChemrxnmechanismPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_path_copy(s : ChemrxnmechanismPath) -> ChemrxnmechanismPath {
  let result = chem_rxn_mechanism_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_path_fill(s : ChemrxnmechanismPath, v : Double) -> ChemrxnmechanismPath {
  let result = chem_rxn_mechanism_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_path_min(s : ChemrxnmechanismPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_path_max(s : ChemrxnmechanismPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_path_to_string(s : ChemrxnmechanismPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_cluster_make(size : Int) -> ChemrxnmechanismCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_cluster_len(s : ChemrxnmechanismCluster) -> Int { s.size }

pub fn chem_rxn_mechanism_cluster_get(s : ChemrxnmechanismCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_cluster_set(s : ChemrxnmechanismCluster, i : Int, v : Double) -> ChemrxnmechanismCluster {
  let result = chem_rxn_mechanism_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_cluster_sum(s : ChemrxnmechanismCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_cluster_mean(s : ChemrxnmechanismCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_cluster_scale(s : ChemrxnmechanismCluster, f : Double) -> ChemrxnmechanismCluster {
  let result = chem_rxn_mechanism_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_cluster_add(a : ChemrxnmechanismCluster, b : ChemrxnmechanismCluster) -> ChemrxnmechanismCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_cluster_copy(s : ChemrxnmechanismCluster) -> ChemrxnmechanismCluster {
  let result = chem_rxn_mechanism_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_cluster_fill(s : ChemrxnmechanismCluster, v : Double) -> ChemrxnmechanismCluster {
  let result = chem_rxn_mechanism_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_cluster_min(s : ChemrxnmechanismCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_cluster_max(s : ChemrxnmechanismCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_cluster_to_string(s : ChemrxnmechanismCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_model_make(size : Int) -> ChemrxnmechanismModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_model_len(s : ChemrxnmechanismModel) -> Int { s.size }

pub fn chem_rxn_mechanism_model_get(s : ChemrxnmechanismModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_model_set(s : ChemrxnmechanismModel, i : Int, v : Double) -> ChemrxnmechanismModel {
  let result = chem_rxn_mechanism_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_model_sum(s : ChemrxnmechanismModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_model_mean(s : ChemrxnmechanismModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_model_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_model_scale(s : ChemrxnmechanismModel, f : Double) -> ChemrxnmechanismModel {
  let result = chem_rxn_mechanism_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_model_add(a : ChemrxnmechanismModel, b : ChemrxnmechanismModel) -> ChemrxnmechanismModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_model_copy(s : ChemrxnmechanismModel) -> ChemrxnmechanismModel {
  let result = chem_rxn_mechanism_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_model_fill(s : ChemrxnmechanismModel, v : Double) -> ChemrxnmechanismModel {
  let result = chem_rxn_mechanism_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_model_min(s : ChemrxnmechanismModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_model_max(s : ChemrxnmechanismModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_model_to_string(s : ChemrxnmechanismModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_layer_make(size : Int) -> ChemrxnmechanismLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_layer_len(s : ChemrxnmechanismLayer) -> Int { s.size }

pub fn chem_rxn_mechanism_layer_get(s : ChemrxnmechanismLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_layer_set(s : ChemrxnmechanismLayer, i : Int, v : Double) -> ChemrxnmechanismLayer {
  let result = chem_rxn_mechanism_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_layer_sum(s : ChemrxnmechanismLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_layer_mean(s : ChemrxnmechanismLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_layer_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_layer_scale(s : ChemrxnmechanismLayer, f : Double) -> ChemrxnmechanismLayer {
  let result = chem_rxn_mechanism_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_layer_add(a : ChemrxnmechanismLayer, b : ChemrxnmechanismLayer) -> ChemrxnmechanismLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_layer_copy(s : ChemrxnmechanismLayer) -> ChemrxnmechanismLayer {
  let result = chem_rxn_mechanism_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_layer_fill(s : ChemrxnmechanismLayer, v : Double) -> ChemrxnmechanismLayer {
  let result = chem_rxn_mechanism_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_layer_min(s : ChemrxnmechanismLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_layer_max(s : ChemrxnmechanismLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_layer_to_string(s : ChemrxnmechanismLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_buffer_make(size : Int) -> ChemrxnmechanismBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_buffer_len(s : ChemrxnmechanismBuffer) -> Int { s.size }

pub fn chem_rxn_mechanism_buffer_get(s : ChemrxnmechanismBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_buffer_set(s : ChemrxnmechanismBuffer, i : Int, v : Double) -> ChemrxnmechanismBuffer {
  let result = chem_rxn_mechanism_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_buffer_sum(s : ChemrxnmechanismBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_buffer_mean(s : ChemrxnmechanismBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_buffer_scale(s : ChemrxnmechanismBuffer, f : Double) -> ChemrxnmechanismBuffer {
  let result = chem_rxn_mechanism_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_buffer_add(a : ChemrxnmechanismBuffer, b : ChemrxnmechanismBuffer) -> ChemrxnmechanismBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_buffer_copy(s : ChemrxnmechanismBuffer) -> ChemrxnmechanismBuffer {
  let result = chem_rxn_mechanism_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_buffer_fill(s : ChemrxnmechanismBuffer, v : Double) -> ChemrxnmechanismBuffer {
  let result = chem_rxn_mechanism_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_buffer_min(s : ChemrxnmechanismBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_buffer_max(s : ChemrxnmechanismBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_buffer_to_string(s : ChemrxnmechanismBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_cursor_make(size : Int) -> ChemrxnmechanismCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_cursor_len(s : ChemrxnmechanismCursor) -> Int { s.size }

pub fn chem_rxn_mechanism_cursor_get(s : ChemrxnmechanismCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_cursor_set(s : ChemrxnmechanismCursor, i : Int, v : Double) -> ChemrxnmechanismCursor {
  let result = chem_rxn_mechanism_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_cursor_sum(s : ChemrxnmechanismCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_cursor_mean(s : ChemrxnmechanismCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_cursor_scale(s : ChemrxnmechanismCursor, f : Double) -> ChemrxnmechanismCursor {
  let result = chem_rxn_mechanism_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_cursor_add(a : ChemrxnmechanismCursor, b : ChemrxnmechanismCursor) -> ChemrxnmechanismCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_cursor_copy(s : ChemrxnmechanismCursor) -> ChemrxnmechanismCursor {
  let result = chem_rxn_mechanism_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_cursor_fill(s : ChemrxnmechanismCursor, v : Double) -> ChemrxnmechanismCursor {
  let result = chem_rxn_mechanism_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_cursor_min(s : ChemrxnmechanismCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_cursor_max(s : ChemrxnmechanismCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_cursor_to_string(s : ChemrxnmechanismCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_view_make(size : Int) -> ChemrxnmechanismView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_view_len(s : ChemrxnmechanismView) -> Int { s.size }

pub fn chem_rxn_mechanism_view_get(s : ChemrxnmechanismView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_view_set(s : ChemrxnmechanismView, i : Int, v : Double) -> ChemrxnmechanismView {
  let result = chem_rxn_mechanism_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_view_sum(s : ChemrxnmechanismView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_view_mean(s : ChemrxnmechanismView) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_view_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_view_scale(s : ChemrxnmechanismView, f : Double) -> ChemrxnmechanismView {
  let result = chem_rxn_mechanism_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_view_add(a : ChemrxnmechanismView, b : ChemrxnmechanismView) -> ChemrxnmechanismView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_view_copy(s : ChemrxnmechanismView) -> ChemrxnmechanismView {
  let result = chem_rxn_mechanism_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_view_fill(s : ChemrxnmechanismView, v : Double) -> ChemrxnmechanismView {
  let result = chem_rxn_mechanism_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_view_min(s : ChemrxnmechanismView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_view_max(s : ChemrxnmechanismView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_view_to_string(s : ChemrxnmechanismView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_range_make(size : Int) -> ChemrxnmechanismRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_range_len(s : ChemrxnmechanismRange) -> Int { s.size }

pub fn chem_rxn_mechanism_range_get(s : ChemrxnmechanismRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_range_set(s : ChemrxnmechanismRange, i : Int, v : Double) -> ChemrxnmechanismRange {
  let result = chem_rxn_mechanism_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_range_sum(s : ChemrxnmechanismRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_range_mean(s : ChemrxnmechanismRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_range_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_range_scale(s : ChemrxnmechanismRange, f : Double) -> ChemrxnmechanismRange {
  let result = chem_rxn_mechanism_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_range_add(a : ChemrxnmechanismRange, b : ChemrxnmechanismRange) -> ChemrxnmechanismRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_range_copy(s : ChemrxnmechanismRange) -> ChemrxnmechanismRange {
  let result = chem_rxn_mechanism_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_range_fill(s : ChemrxnmechanismRange, v : Double) -> ChemrxnmechanismRange {
  let result = chem_rxn_mechanism_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_range_min(s : ChemrxnmechanismRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_range_max(s : ChemrxnmechanismRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_range_to_string(s : ChemrxnmechanismRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnmechanismSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_mechanism_slice_make(size : Int) -> ChemrxnmechanismSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_mechanism_slice_len(s : ChemrxnmechanismSlice) -> Int { s.size }

pub fn chem_rxn_mechanism_slice_get(s : ChemrxnmechanismSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_mechanism_slice_set(s : ChemrxnmechanismSlice, i : Int, v : Double) -> ChemrxnmechanismSlice {
  let result = chem_rxn_mechanism_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_slice_sum(s : ChemrxnmechanismSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_mechanism_slice_mean(s : ChemrxnmechanismSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_mechanism_slice_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_mechanism_slice_scale(s : ChemrxnmechanismSlice, f : Double) -> ChemrxnmechanismSlice {
  let result = chem_rxn_mechanism_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_mechanism_slice_add(a : ChemrxnmechanismSlice, b : ChemrxnmechanismSlice) -> ChemrxnmechanismSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_mechanism_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_mechanism_slice_copy(s : ChemrxnmechanismSlice) -> ChemrxnmechanismSlice {
  let result = chem_rxn_mechanism_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_mechanism_slice_fill(s : ChemrxnmechanismSlice, v : Double) -> ChemrxnmechanismSlice {
  let result = chem_rxn_mechanism_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_mechanism_slice_min(s : ChemrxnmechanismSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_slice_max(s : ChemrxnmechanismSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_mechanism_slice_to_string(s : ChemrxnmechanismSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_rxn_mechanism_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_mechanism_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

