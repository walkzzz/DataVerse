///===
/// extcore/chem_rxn_kinetics

pub(all) struct ChemrxnkineticsPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_kinetics_make_point(x : Double, y : Double) -> ChemrxnkineticsPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_kinetics_make_point3(x : Double, y : Double, z : Double) -> ChemrxnkineticsPoint {
  { x, y, z, label: 0 }
}

pub fn chem_rxn_kinetics_point_x(pt : ChemrxnkineticsPoint) -> Double { pt.x }

pub fn chem_rxn_kinetics_point_y(pt : ChemrxnkineticsPoint) -> Double { pt.y }

pub fn chem_rxn_kinetics_point_z(pt : ChemrxnkineticsPoint) -> Double { pt.z }

pub fn chem_rxn_kinetics_point_label(pt : ChemrxnkineticsPoint) -> Int { pt.label }

pub fn chem_rxn_kinetics_point_dist(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_rxn_kinetics_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_rxn_kinetics_point_add(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_rxn_kinetics_point_sub(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_rxn_kinetics_point_scale(pt : ChemrxnkineticsPoint, s : Double) -> ChemrxnkineticsPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_rxn_kinetics_point_dot(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_rxn_kinetics_point_cross(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_rxn_kinetics_point_norm(pt : ChemrxnkineticsPoint) -> Double {
  chem_rxn_kinetics_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_rxn_kinetics_point_normalize(pt : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  let n = chem_rxn_kinetics_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_rxn_kinetics_point_scale(pt, 1.0 / n) }
}

pub fn chem_rxn_kinetics_point_negate(pt : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_rxn_kinetics_point_mid(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint) -> ChemrxnkineticsPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_rxn_kinetics_point_lerp(a : ChemrxnkineticsPoint, b : ChemrxnkineticsPoint, t : Double) -> ChemrxnkineticsPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_rxn_kinetics_point_to_string(pt : ChemrxnkineticsPoint) -> String {
  "(" + chem_rxn_kinetics_dbl(pt.x) + ", " + chem_rxn_kinetics_dbl(pt.y) + ", " + chem_rxn_kinetics_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemrxnkineticsSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_kinetics_make_series(vals : Array[Double], name : String) -> ChemrxnkineticsSeries {
  { vals, name, meta: 0 }
}

pub fn chem_rxn_kinetics_series_len(s : ChemrxnkineticsSeries) -> Int { s.vals.length() }

pub fn chem_rxn_kinetics_series_sum(s : ChemrxnkineticsSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_rxn_kinetics_series_mean(s : ChemrxnkineticsSeries) -> Double {
  let n = chem_rxn_kinetics_series_len(s)
  if n == 0 { 0.0 } else { chem_rxn_kinetics_series_sum(s) / n.to_double() }
}

pub fn chem_rxn_kinetics_series_min(s : ChemrxnkineticsSeries) -> Double {
  let n = chem_rxn_kinetics_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_series_max(s : ChemrxnkineticsSeries) -> Double {
  let n = chem_rxn_kinetics_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_series_range(s : ChemrxnkineticsSeries) -> Double {
  chem_rxn_kinetics_series_max(s) - chem_rxn_kinetics_series_min(s)
}

pub fn chem_rxn_kinetics_series_var(s : ChemrxnkineticsSeries) -> Double {
  let n = chem_rxn_kinetics_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_rxn_kinetics_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_rxn_kinetics_series_std(s : ChemrxnkineticsSeries) -> Double { chem_rxn_kinetics_sqrt(chem_rxn_kinetics_series_var(s)) }

pub fn chem_rxn_kinetics_series_median(s : ChemrxnkineticsSeries) -> Double {
  let n = chem_rxn_kinetics_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_rxn_kinetics_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_rxn_kinetics_series_scale(s : ChemrxnkineticsSeries, f : Double) -> ChemrxnkineticsSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_rxn_kinetics_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_rxn_kinetics_series_add(a : ChemrxnkineticsSeries, b : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_rxn_kinetics_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_rxn_kinetics_series_sub(a : ChemrxnkineticsSeries, b : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_rxn_kinetics_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_rxn_kinetics_series_normalize(s : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  let mn = chem_rxn_kinetics_series_min(s)
  let mx = chem_rxn_kinetics_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_rxn_kinetics_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_rxn_kinetics_series_cumsum(s : ChemrxnkineticsSeries) -> ChemrxnkineticsSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_rxn_kinetics_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_rxn_kinetics_series_to_string(s : ChemrxnkineticsSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_rxn_kinetics_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxnkineticsMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_kinetics_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxnkineticsMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_kinetics_matrix_identity(n : Int) -> ChemrxnkineticsMatrix {
  let m = chem_rxn_kinetics_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_rxn_kinetics_matrix_get(m : ChemrxnkineticsMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_rxn_kinetics_matrix_transpose(m : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  let result = chem_rxn_kinetics_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_rxn_kinetics_matrix_add(a : ChemrxnkineticsMatrix, b : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_rxn_kinetics_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_rxn_kinetics_matrix_scale(m : ChemrxnkineticsMatrix, s : Double) -> ChemrxnkineticsMatrix {
  let result = chem_rxn_kinetics_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_rxn_kinetics_matrix_multiply(a : ChemrxnkineticsMatrix, b : ChemrxnkineticsMatrix) -> ChemrxnkineticsMatrix {
  if a.cols != b.rows { return chem_rxn_kinetics_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_rxn_kinetics_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_rxn_kinetics_matrix_trace(m : ChemrxnkineticsMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_rxn_kinetics_matrix_det(m : ChemrxnkineticsMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_rxn_kinetics_matrix_norm(m : ChemrxnkineticsMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_rxn_kinetics_sqrt(sum)
}

pub fn chem_rxn_kinetics_matrix_to_string(m : ChemrxnkineticsMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_rxn_kinetics_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemrxnkineticsVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_kinetics_make_vector(comps : Array[Double]) -> ChemrxnkineticsVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_kinetics_vector_zero(dim : Int) -> ChemrxnkineticsVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_rxn_kinetics_vector_add(a : ChemrxnkineticsVector, b : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_rxn_kinetics_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_kinetics_vector_sub(a : ChemrxnkineticsVector, b : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_rxn_kinetics_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_kinetics_vector_scale(v : ChemrxnkineticsVector, s : Double) -> ChemrxnkineticsVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_rxn_kinetics_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_rxn_kinetics_vector_dot(a : ChemrxnkineticsVector, b : ChemrxnkineticsVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_rxn_kinetics_vector_norm(v : ChemrxnkineticsVector) -> Double { chem_rxn_kinetics_sqrt(chem_rxn_kinetics_vector_dot(v, v)) }

pub fn chem_rxn_kinetics_vector_normalize(v : ChemrxnkineticsVector) -> ChemrxnkineticsVector {
  let n = chem_rxn_kinetics_vector_norm(v)
  if n < 0.0000001 { v } else { chem_rxn_kinetics_vector_scale(v, 1.0 / n) }
}

pub fn chem_rxn_kinetics_vector_dist(a : ChemrxnkineticsVector, b : ChemrxnkineticsVector) -> Double {
  chem_rxn_kinetics_vector_norm(chem_rxn_kinetics_vector_sub(a, b))
}

pub fn chem_rxn_kinetics_vector_to_string(v : ChemrxnkineticsVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_rxn_kinetics_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_kinetics_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_rxn_kinetics_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_rxn_kinetics_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_rxn_kinetics_std(data : Array[Double]) -> Double { chem_rxn_kinetics_sqrt(chem_rxn_kinetics_var(data)) }

pub fn chem_rxn_kinetics_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_rxn_kinetics_mean(a); let mb = chem_rxn_kinetics_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_rxn_kinetics_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_rxn_kinetics_std(a); let sb = chem_rxn_kinetics_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_rxn_kinetics_cov(a, b) / (sa * sb) }
}

pub fn chem_rxn_kinetics_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_rxn_kinetics_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_rxn_kinetics_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_rxn_kinetics_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_rxn_kinetics_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_rxn_kinetics_sqrt(chem_rxn_kinetics_mse(pred, labels))
}

pub fn chem_rxn_kinetics_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_rxn_kinetics_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_rxn_kinetics_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_rxn_kinetics_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_rxn_kinetics_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_rxn_kinetics_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_rxn_kinetics_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_rxn_kinetics_precision(pred, labels, pos); let r = chem_rxn_kinetics_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_rxn_kinetics_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_rxn_kinetics_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_rxn_kinetics_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_rxn_kinetics_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_rxn_kinetics_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_rxn_kinetics_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_rxn_kinetics_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_rxn_kinetics_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_rxn_kinetics_fibonacci(n : Int) -> Int {
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

pub fn chem_rxn_kinetics_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_rxn_kinetics_min(data); let mx = chem_rxn_kinetics_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_rxn_kinetics_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_rxn_kinetics_mean(data); let sd = chem_rxn_kinetics_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_rxn_kinetics_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_rxn_kinetics_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_rxn_kinetics_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_rxn_kinetics_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_rxn_kinetics_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_rxn_kinetics_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_rxn_kinetics_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_rxn_kinetics_int(x) } else { -chem_rxn_kinetics_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_rxn_kinetics_int(f * 1000000.0) } else { chem_rxn_kinetics_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_rxn_kinetics_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_rxn_kinetics_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemrxnkineticsFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_frame_make(size : Int) -> ChemrxnkineticsFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_frame_len(s : ChemrxnkineticsFrame) -> Int { s.size }

pub fn chem_rxn_kinetics_frame_get(s : ChemrxnkineticsFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_frame_set(s : ChemrxnkineticsFrame, i : Int, v : Double) -> ChemrxnkineticsFrame {
  let result = chem_rxn_kinetics_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_frame_sum(s : ChemrxnkineticsFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_frame_mean(s : ChemrxnkineticsFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_frame_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_frame_scale(s : ChemrxnkineticsFrame, f : Double) -> ChemrxnkineticsFrame {
  let result = chem_rxn_kinetics_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_frame_add(a : ChemrxnkineticsFrame, b : ChemrxnkineticsFrame) -> ChemrxnkineticsFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_frame_copy(s : ChemrxnkineticsFrame) -> ChemrxnkineticsFrame {
  let result = chem_rxn_kinetics_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_frame_fill(s : ChemrxnkineticsFrame, v : Double) -> ChemrxnkineticsFrame {
  let result = chem_rxn_kinetics_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_frame_min(s : ChemrxnkineticsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_frame_max(s : ChemrxnkineticsFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_frame_to_string(s : ChemrxnkineticsFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_table_make(size : Int) -> ChemrxnkineticsTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_table_len(s : ChemrxnkineticsTable) -> Int { s.size }

pub fn chem_rxn_kinetics_table_get(s : ChemrxnkineticsTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_table_set(s : ChemrxnkineticsTable, i : Int, v : Double) -> ChemrxnkineticsTable {
  let result = chem_rxn_kinetics_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_table_sum(s : ChemrxnkineticsTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_table_mean(s : ChemrxnkineticsTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_table_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_table_scale(s : ChemrxnkineticsTable, f : Double) -> ChemrxnkineticsTable {
  let result = chem_rxn_kinetics_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_table_add(a : ChemrxnkineticsTable, b : ChemrxnkineticsTable) -> ChemrxnkineticsTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_table_copy(s : ChemrxnkineticsTable) -> ChemrxnkineticsTable {
  let result = chem_rxn_kinetics_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_table_fill(s : ChemrxnkineticsTable, v : Double) -> ChemrxnkineticsTable {
  let result = chem_rxn_kinetics_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_table_min(s : ChemrxnkineticsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_table_max(s : ChemrxnkineticsTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_table_to_string(s : ChemrxnkineticsTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_graphn_make(size : Int) -> ChemrxnkineticsGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_graphn_len(s : ChemrxnkineticsGraphN) -> Int { s.size }

pub fn chem_rxn_kinetics_graphn_get(s : ChemrxnkineticsGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_graphn_set(s : ChemrxnkineticsGraphN, i : Int, v : Double) -> ChemrxnkineticsGraphN {
  let result = chem_rxn_kinetics_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_graphn_sum(s : ChemrxnkineticsGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_graphn_mean(s : ChemrxnkineticsGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_graphn_scale(s : ChemrxnkineticsGraphN, f : Double) -> ChemrxnkineticsGraphN {
  let result = chem_rxn_kinetics_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_graphn_add(a : ChemrxnkineticsGraphN, b : ChemrxnkineticsGraphN) -> ChemrxnkineticsGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_graphn_copy(s : ChemrxnkineticsGraphN) -> ChemrxnkineticsGraphN {
  let result = chem_rxn_kinetics_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_graphn_fill(s : ChemrxnkineticsGraphN, v : Double) -> ChemrxnkineticsGraphN {
  let result = chem_rxn_kinetics_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_graphn_min(s : ChemrxnkineticsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_graphn_max(s : ChemrxnkineticsGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_graphn_to_string(s : ChemrxnkineticsGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_node_make(size : Int) -> ChemrxnkineticsNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_node_len(s : ChemrxnkineticsNode) -> Int { s.size }

pub fn chem_rxn_kinetics_node_get(s : ChemrxnkineticsNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_node_set(s : ChemrxnkineticsNode, i : Int, v : Double) -> ChemrxnkineticsNode {
  let result = chem_rxn_kinetics_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_node_sum(s : ChemrxnkineticsNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_node_mean(s : ChemrxnkineticsNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_node_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_node_scale(s : ChemrxnkineticsNode, f : Double) -> ChemrxnkineticsNode {
  let result = chem_rxn_kinetics_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_node_add(a : ChemrxnkineticsNode, b : ChemrxnkineticsNode) -> ChemrxnkineticsNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_node_copy(s : ChemrxnkineticsNode) -> ChemrxnkineticsNode {
  let result = chem_rxn_kinetics_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_node_fill(s : ChemrxnkineticsNode, v : Double) -> ChemrxnkineticsNode {
  let result = chem_rxn_kinetics_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_node_min(s : ChemrxnkineticsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_node_max(s : ChemrxnkineticsNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_node_to_string(s : ChemrxnkineticsNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_edge_make(size : Int) -> ChemrxnkineticsEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_edge_len(s : ChemrxnkineticsEdge) -> Int { s.size }

pub fn chem_rxn_kinetics_edge_get(s : ChemrxnkineticsEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_edge_set(s : ChemrxnkineticsEdge, i : Int, v : Double) -> ChemrxnkineticsEdge {
  let result = chem_rxn_kinetics_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_edge_sum(s : ChemrxnkineticsEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_edge_mean(s : ChemrxnkineticsEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_edge_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_edge_scale(s : ChemrxnkineticsEdge, f : Double) -> ChemrxnkineticsEdge {
  let result = chem_rxn_kinetics_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_edge_add(a : ChemrxnkineticsEdge, b : ChemrxnkineticsEdge) -> ChemrxnkineticsEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_edge_copy(s : ChemrxnkineticsEdge) -> ChemrxnkineticsEdge {
  let result = chem_rxn_kinetics_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_edge_fill(s : ChemrxnkineticsEdge, v : Double) -> ChemrxnkineticsEdge {
  let result = chem_rxn_kinetics_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_edge_min(s : ChemrxnkineticsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_edge_max(s : ChemrxnkineticsEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_edge_to_string(s : ChemrxnkineticsEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_path_make(size : Int) -> ChemrxnkineticsPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_path_len(s : ChemrxnkineticsPath) -> Int { s.size }

pub fn chem_rxn_kinetics_path_get(s : ChemrxnkineticsPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_path_set(s : ChemrxnkineticsPath, i : Int, v : Double) -> ChemrxnkineticsPath {
  let result = chem_rxn_kinetics_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_path_sum(s : ChemrxnkineticsPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_path_mean(s : ChemrxnkineticsPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_path_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_path_scale(s : ChemrxnkineticsPath, f : Double) -> ChemrxnkineticsPath {
  let result = chem_rxn_kinetics_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_path_add(a : ChemrxnkineticsPath, b : ChemrxnkineticsPath) -> ChemrxnkineticsPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_path_copy(s : ChemrxnkineticsPath) -> ChemrxnkineticsPath {
  let result = chem_rxn_kinetics_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_path_fill(s : ChemrxnkineticsPath, v : Double) -> ChemrxnkineticsPath {
  let result = chem_rxn_kinetics_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_path_min(s : ChemrxnkineticsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_path_max(s : ChemrxnkineticsPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_path_to_string(s : ChemrxnkineticsPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_cluster_make(size : Int) -> ChemrxnkineticsCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_cluster_len(s : ChemrxnkineticsCluster) -> Int { s.size }

pub fn chem_rxn_kinetics_cluster_get(s : ChemrxnkineticsCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_cluster_set(s : ChemrxnkineticsCluster, i : Int, v : Double) -> ChemrxnkineticsCluster {
  let result = chem_rxn_kinetics_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_cluster_sum(s : ChemrxnkineticsCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_cluster_mean(s : ChemrxnkineticsCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_cluster_scale(s : ChemrxnkineticsCluster, f : Double) -> ChemrxnkineticsCluster {
  let result = chem_rxn_kinetics_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_cluster_add(a : ChemrxnkineticsCluster, b : ChemrxnkineticsCluster) -> ChemrxnkineticsCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_cluster_copy(s : ChemrxnkineticsCluster) -> ChemrxnkineticsCluster {
  let result = chem_rxn_kinetics_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_cluster_fill(s : ChemrxnkineticsCluster, v : Double) -> ChemrxnkineticsCluster {
  let result = chem_rxn_kinetics_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_cluster_min(s : ChemrxnkineticsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_cluster_max(s : ChemrxnkineticsCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_cluster_to_string(s : ChemrxnkineticsCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_model_make(size : Int) -> ChemrxnkineticsModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_model_len(s : ChemrxnkineticsModel) -> Int { s.size }

pub fn chem_rxn_kinetics_model_get(s : ChemrxnkineticsModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_model_set(s : ChemrxnkineticsModel, i : Int, v : Double) -> ChemrxnkineticsModel {
  let result = chem_rxn_kinetics_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_model_sum(s : ChemrxnkineticsModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_model_mean(s : ChemrxnkineticsModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_model_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_model_scale(s : ChemrxnkineticsModel, f : Double) -> ChemrxnkineticsModel {
  let result = chem_rxn_kinetics_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_model_add(a : ChemrxnkineticsModel, b : ChemrxnkineticsModel) -> ChemrxnkineticsModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_model_copy(s : ChemrxnkineticsModel) -> ChemrxnkineticsModel {
  let result = chem_rxn_kinetics_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_model_fill(s : ChemrxnkineticsModel, v : Double) -> ChemrxnkineticsModel {
  let result = chem_rxn_kinetics_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_model_min(s : ChemrxnkineticsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_model_max(s : ChemrxnkineticsModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_model_to_string(s : ChemrxnkineticsModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_layer_make(size : Int) -> ChemrxnkineticsLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_layer_len(s : ChemrxnkineticsLayer) -> Int { s.size }

pub fn chem_rxn_kinetics_layer_get(s : ChemrxnkineticsLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_layer_set(s : ChemrxnkineticsLayer, i : Int, v : Double) -> ChemrxnkineticsLayer {
  let result = chem_rxn_kinetics_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_layer_sum(s : ChemrxnkineticsLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_layer_mean(s : ChemrxnkineticsLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_layer_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_layer_scale(s : ChemrxnkineticsLayer, f : Double) -> ChemrxnkineticsLayer {
  let result = chem_rxn_kinetics_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_layer_add(a : ChemrxnkineticsLayer, b : ChemrxnkineticsLayer) -> ChemrxnkineticsLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_layer_copy(s : ChemrxnkineticsLayer) -> ChemrxnkineticsLayer {
  let result = chem_rxn_kinetics_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_layer_fill(s : ChemrxnkineticsLayer, v : Double) -> ChemrxnkineticsLayer {
  let result = chem_rxn_kinetics_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_layer_min(s : ChemrxnkineticsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_layer_max(s : ChemrxnkineticsLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_layer_to_string(s : ChemrxnkineticsLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_buffer_make(size : Int) -> ChemrxnkineticsBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_buffer_len(s : ChemrxnkineticsBuffer) -> Int { s.size }

pub fn chem_rxn_kinetics_buffer_get(s : ChemrxnkineticsBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_buffer_set(s : ChemrxnkineticsBuffer, i : Int, v : Double) -> ChemrxnkineticsBuffer {
  let result = chem_rxn_kinetics_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_buffer_sum(s : ChemrxnkineticsBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_buffer_mean(s : ChemrxnkineticsBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_buffer_scale(s : ChemrxnkineticsBuffer, f : Double) -> ChemrxnkineticsBuffer {
  let result = chem_rxn_kinetics_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_buffer_add(a : ChemrxnkineticsBuffer, b : ChemrxnkineticsBuffer) -> ChemrxnkineticsBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_buffer_copy(s : ChemrxnkineticsBuffer) -> ChemrxnkineticsBuffer {
  let result = chem_rxn_kinetics_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_buffer_fill(s : ChemrxnkineticsBuffer, v : Double) -> ChemrxnkineticsBuffer {
  let result = chem_rxn_kinetics_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_buffer_min(s : ChemrxnkineticsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_buffer_max(s : ChemrxnkineticsBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_buffer_to_string(s : ChemrxnkineticsBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_cursor_make(size : Int) -> ChemrxnkineticsCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_cursor_len(s : ChemrxnkineticsCursor) -> Int { s.size }

pub fn chem_rxn_kinetics_cursor_get(s : ChemrxnkineticsCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_cursor_set(s : ChemrxnkineticsCursor, i : Int, v : Double) -> ChemrxnkineticsCursor {
  let result = chem_rxn_kinetics_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_cursor_sum(s : ChemrxnkineticsCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_cursor_mean(s : ChemrxnkineticsCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_cursor_scale(s : ChemrxnkineticsCursor, f : Double) -> ChemrxnkineticsCursor {
  let result = chem_rxn_kinetics_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_cursor_add(a : ChemrxnkineticsCursor, b : ChemrxnkineticsCursor) -> ChemrxnkineticsCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_cursor_copy(s : ChemrxnkineticsCursor) -> ChemrxnkineticsCursor {
  let result = chem_rxn_kinetics_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_cursor_fill(s : ChemrxnkineticsCursor, v : Double) -> ChemrxnkineticsCursor {
  let result = chem_rxn_kinetics_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_cursor_min(s : ChemrxnkineticsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_cursor_max(s : ChemrxnkineticsCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_cursor_to_string(s : ChemrxnkineticsCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_view_make(size : Int) -> ChemrxnkineticsView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_view_len(s : ChemrxnkineticsView) -> Int { s.size }

pub fn chem_rxn_kinetics_view_get(s : ChemrxnkineticsView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_view_set(s : ChemrxnkineticsView, i : Int, v : Double) -> ChemrxnkineticsView {
  let result = chem_rxn_kinetics_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_view_sum(s : ChemrxnkineticsView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_view_mean(s : ChemrxnkineticsView) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_view_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_view_scale(s : ChemrxnkineticsView, f : Double) -> ChemrxnkineticsView {
  let result = chem_rxn_kinetics_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_view_add(a : ChemrxnkineticsView, b : ChemrxnkineticsView) -> ChemrxnkineticsView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_view_copy(s : ChemrxnkineticsView) -> ChemrxnkineticsView {
  let result = chem_rxn_kinetics_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_view_fill(s : ChemrxnkineticsView, v : Double) -> ChemrxnkineticsView {
  let result = chem_rxn_kinetics_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_view_min(s : ChemrxnkineticsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_view_max(s : ChemrxnkineticsView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_view_to_string(s : ChemrxnkineticsView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_range_make(size : Int) -> ChemrxnkineticsRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_range_len(s : ChemrxnkineticsRange) -> Int { s.size }

pub fn chem_rxn_kinetics_range_get(s : ChemrxnkineticsRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_range_set(s : ChemrxnkineticsRange, i : Int, v : Double) -> ChemrxnkineticsRange {
  let result = chem_rxn_kinetics_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_range_sum(s : ChemrxnkineticsRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_range_mean(s : ChemrxnkineticsRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_range_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_range_scale(s : ChemrxnkineticsRange, f : Double) -> ChemrxnkineticsRange {
  let result = chem_rxn_kinetics_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_range_add(a : ChemrxnkineticsRange, b : ChemrxnkineticsRange) -> ChemrxnkineticsRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_range_copy(s : ChemrxnkineticsRange) -> ChemrxnkineticsRange {
  let result = chem_rxn_kinetics_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_range_fill(s : ChemrxnkineticsRange, v : Double) -> ChemrxnkineticsRange {
  let result = chem_rxn_kinetics_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_range_min(s : ChemrxnkineticsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_range_max(s : ChemrxnkineticsRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_range_to_string(s : ChemrxnkineticsRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxnkineticsSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_kinetics_slice_make(size : Int) -> ChemrxnkineticsSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_kinetics_slice_len(s : ChemrxnkineticsSlice) -> Int { s.size }

pub fn chem_rxn_kinetics_slice_get(s : ChemrxnkineticsSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_kinetics_slice_set(s : ChemrxnkineticsSlice, i : Int, v : Double) -> ChemrxnkineticsSlice {
  let result = chem_rxn_kinetics_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_slice_sum(s : ChemrxnkineticsSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_kinetics_slice_mean(s : ChemrxnkineticsSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_kinetics_slice_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_kinetics_slice_scale(s : ChemrxnkineticsSlice, f : Double) -> ChemrxnkineticsSlice {
  let result = chem_rxn_kinetics_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_kinetics_slice_add(a : ChemrxnkineticsSlice, b : ChemrxnkineticsSlice) -> ChemrxnkineticsSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_kinetics_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_kinetics_slice_copy(s : ChemrxnkineticsSlice) -> ChemrxnkineticsSlice {
  let result = chem_rxn_kinetics_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_kinetics_slice_fill(s : ChemrxnkineticsSlice, v : Double) -> ChemrxnkineticsSlice {
  let result = chem_rxn_kinetics_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_kinetics_slice_min(s : ChemrxnkineticsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_slice_max(s : ChemrxnkineticsSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_kinetics_slice_to_string(s : ChemrxnkineticsSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_rxn_kinetics_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_kinetics_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

