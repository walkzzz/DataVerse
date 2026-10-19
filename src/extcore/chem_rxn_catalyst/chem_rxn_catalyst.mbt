///===
/// extcore/chem_rxn_catalyst

pub(all) struct ChemrxncatalystPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_rxn_catalyst_make_point(x : Double, y : Double) -> ChemrxncatalystPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_rxn_catalyst_make_point3(x : Double, y : Double, z : Double) -> ChemrxncatalystPoint {
  { x, y, z, label: 0 }
}

pub fn chem_rxn_catalyst_point_x(pt : ChemrxncatalystPoint) -> Double { pt.x }

pub fn chem_rxn_catalyst_point_y(pt : ChemrxncatalystPoint) -> Double { pt.y }

pub fn chem_rxn_catalyst_point_z(pt : ChemrxncatalystPoint) -> Double { pt.z }

pub fn chem_rxn_catalyst_point_label(pt : ChemrxncatalystPoint) -> Int { pt.label }

pub fn chem_rxn_catalyst_point_dist(a : ChemrxncatalystPoint, b : ChemrxncatalystPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_rxn_catalyst_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_rxn_catalyst_point_add(a : ChemrxncatalystPoint, b : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_rxn_catalyst_point_sub(a : ChemrxncatalystPoint, b : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_rxn_catalyst_point_scale(pt : ChemrxncatalystPoint, s : Double) -> ChemrxncatalystPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_rxn_catalyst_point_dot(a : ChemrxncatalystPoint, b : ChemrxncatalystPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_rxn_catalyst_point_cross(a : ChemrxncatalystPoint, b : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_rxn_catalyst_point_norm(pt : ChemrxncatalystPoint) -> Double {
  chem_rxn_catalyst_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_rxn_catalyst_point_normalize(pt : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  let n = chem_rxn_catalyst_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_rxn_catalyst_point_scale(pt, 1.0 / n) }
}

pub fn chem_rxn_catalyst_point_negate(pt : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_rxn_catalyst_point_mid(a : ChemrxncatalystPoint, b : ChemrxncatalystPoint) -> ChemrxncatalystPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_rxn_catalyst_point_lerp(a : ChemrxncatalystPoint, b : ChemrxncatalystPoint, t : Double) -> ChemrxncatalystPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_rxn_catalyst_point_to_string(pt : ChemrxncatalystPoint) -> String {
  "(" + chem_rxn_catalyst_dbl(pt.x) + ", " + chem_rxn_catalyst_dbl(pt.y) + ", " + chem_rxn_catalyst_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemrxncatalystSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_rxn_catalyst_make_series(vals : Array[Double], name : String) -> ChemrxncatalystSeries {
  { vals, name, meta: 0 }
}

pub fn chem_rxn_catalyst_series_len(s : ChemrxncatalystSeries) -> Int { s.vals.length() }

pub fn chem_rxn_catalyst_series_sum(s : ChemrxncatalystSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_rxn_catalyst_series_mean(s : ChemrxncatalystSeries) -> Double {
  let n = chem_rxn_catalyst_series_len(s)
  if n == 0 { 0.0 } else { chem_rxn_catalyst_series_sum(s) / n.to_double() }
}

pub fn chem_rxn_catalyst_series_min(s : ChemrxncatalystSeries) -> Double {
  let n = chem_rxn_catalyst_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_series_max(s : ChemrxncatalystSeries) -> Double {
  let n = chem_rxn_catalyst_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_series_range(s : ChemrxncatalystSeries) -> Double {
  chem_rxn_catalyst_series_max(s) - chem_rxn_catalyst_series_min(s)
}

pub fn chem_rxn_catalyst_series_var(s : ChemrxncatalystSeries) -> Double {
  let n = chem_rxn_catalyst_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_rxn_catalyst_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_rxn_catalyst_series_std(s : ChemrxncatalystSeries) -> Double { chem_rxn_catalyst_sqrt(chem_rxn_catalyst_series_var(s)) }

pub fn chem_rxn_catalyst_series_median(s : ChemrxncatalystSeries) -> Double {
  let n = chem_rxn_catalyst_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_rxn_catalyst_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_rxn_catalyst_series_scale(s : ChemrxncatalystSeries, f : Double) -> ChemrxncatalystSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_rxn_catalyst_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_rxn_catalyst_series_add(a : ChemrxncatalystSeries, b : ChemrxncatalystSeries) -> ChemrxncatalystSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_rxn_catalyst_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_rxn_catalyst_series_sub(a : ChemrxncatalystSeries, b : ChemrxncatalystSeries) -> ChemrxncatalystSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_rxn_catalyst_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_rxn_catalyst_series_normalize(s : ChemrxncatalystSeries) -> ChemrxncatalystSeries {
  let mn = chem_rxn_catalyst_series_min(s)
  let mx = chem_rxn_catalyst_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_rxn_catalyst_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_rxn_catalyst_series_cumsum(s : ChemrxncatalystSeries) -> ChemrxncatalystSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_rxn_catalyst_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_rxn_catalyst_series_to_string(s : ChemrxncatalystSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_rxn_catalyst_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemrxncatalystMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_rxn_catalyst_make_matrix(rows : Int, cols : Int, val : Double) -> ChemrxncatalystMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_rxn_catalyst_matrix_identity(n : Int) -> ChemrxncatalystMatrix {
  let m = chem_rxn_catalyst_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_rxn_catalyst_matrix_get(m : ChemrxncatalystMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_rxn_catalyst_matrix_transpose(m : ChemrxncatalystMatrix) -> ChemrxncatalystMatrix {
  let result = chem_rxn_catalyst_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_rxn_catalyst_matrix_add(a : ChemrxncatalystMatrix, b : ChemrxncatalystMatrix) -> ChemrxncatalystMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_rxn_catalyst_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_rxn_catalyst_matrix_scale(m : ChemrxncatalystMatrix, s : Double) -> ChemrxncatalystMatrix {
  let result = chem_rxn_catalyst_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_rxn_catalyst_matrix_multiply(a : ChemrxncatalystMatrix, b : ChemrxncatalystMatrix) -> ChemrxncatalystMatrix {
  if a.cols != b.rows { return chem_rxn_catalyst_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_rxn_catalyst_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_rxn_catalyst_matrix_trace(m : ChemrxncatalystMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_rxn_catalyst_matrix_det(m : ChemrxncatalystMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_rxn_catalyst_matrix_norm(m : ChemrxncatalystMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_rxn_catalyst_sqrt(sum)
}

pub fn chem_rxn_catalyst_matrix_to_string(m : ChemrxncatalystMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_rxn_catalyst_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemrxncatalystVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_rxn_catalyst_make_vector(comps : Array[Double]) -> ChemrxncatalystVector {
  { comps, dim: comps.length() }
}

pub fn chem_rxn_catalyst_vector_zero(dim : Int) -> ChemrxncatalystVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_rxn_catalyst_vector_add(a : ChemrxncatalystVector, b : ChemrxncatalystVector) -> ChemrxncatalystVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_rxn_catalyst_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_catalyst_vector_sub(a : ChemrxncatalystVector, b : ChemrxncatalystVector) -> ChemrxncatalystVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_rxn_catalyst_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_rxn_catalyst_vector_scale(v : ChemrxncatalystVector, s : Double) -> ChemrxncatalystVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_rxn_catalyst_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_rxn_catalyst_vector_dot(a : ChemrxncatalystVector, b : ChemrxncatalystVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_rxn_catalyst_vector_norm(v : ChemrxncatalystVector) -> Double { chem_rxn_catalyst_sqrt(chem_rxn_catalyst_vector_dot(v, v)) }

pub fn chem_rxn_catalyst_vector_normalize(v : ChemrxncatalystVector) -> ChemrxncatalystVector {
  let n = chem_rxn_catalyst_vector_norm(v)
  if n < 0.0000001 { v } else { chem_rxn_catalyst_vector_scale(v, 1.0 / n) }
}

pub fn chem_rxn_catalyst_vector_dist(a : ChemrxncatalystVector, b : ChemrxncatalystVector) -> Double {
  chem_rxn_catalyst_vector_norm(chem_rxn_catalyst_vector_sub(a, b))
}

pub fn chem_rxn_catalyst_vector_to_string(v : ChemrxncatalystVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_rxn_catalyst_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_rxn_catalyst_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_rxn_catalyst_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_rxn_catalyst_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_rxn_catalyst_std(data : Array[Double]) -> Double { chem_rxn_catalyst_sqrt(chem_rxn_catalyst_var(data)) }

pub fn chem_rxn_catalyst_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_rxn_catalyst_mean(a); let mb = chem_rxn_catalyst_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_rxn_catalyst_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_rxn_catalyst_std(a); let sb = chem_rxn_catalyst_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_rxn_catalyst_cov(a, b) / (sa * sb) }
}

pub fn chem_rxn_catalyst_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_rxn_catalyst_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_rxn_catalyst_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_rxn_catalyst_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_rxn_catalyst_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_rxn_catalyst_sqrt(chem_rxn_catalyst_mse(pred, labels))
}

pub fn chem_rxn_catalyst_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_rxn_catalyst_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_rxn_catalyst_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_rxn_catalyst_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_rxn_catalyst_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_rxn_catalyst_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_rxn_catalyst_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_rxn_catalyst_precision(pred, labels, pos); let r = chem_rxn_catalyst_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_rxn_catalyst_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_rxn_catalyst_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_rxn_catalyst_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_rxn_catalyst_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_rxn_catalyst_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_rxn_catalyst_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_rxn_catalyst_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_rxn_catalyst_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_rxn_catalyst_fibonacci(n : Int) -> Int {
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

pub fn chem_rxn_catalyst_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_rxn_catalyst_min(data); let mx = chem_rxn_catalyst_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_rxn_catalyst_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_rxn_catalyst_mean(data); let sd = chem_rxn_catalyst_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_rxn_catalyst_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_rxn_catalyst_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_rxn_catalyst_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_rxn_catalyst_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_rxn_catalyst_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_rxn_catalyst_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_rxn_catalyst_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_rxn_catalyst_int(x) } else { -chem_rxn_catalyst_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_rxn_catalyst_int(f * 1000000.0) } else { chem_rxn_catalyst_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_rxn_catalyst_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_rxn_catalyst_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemrxncatalystFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_frame_make(size : Int) -> ChemrxncatalystFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_frame_len(s : ChemrxncatalystFrame) -> Int { s.size }

pub fn chem_rxn_catalyst_frame_get(s : ChemrxncatalystFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_frame_set(s : ChemrxncatalystFrame, i : Int, v : Double) -> ChemrxncatalystFrame {
  let result = chem_rxn_catalyst_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_frame_sum(s : ChemrxncatalystFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_frame_mean(s : ChemrxncatalystFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_frame_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_frame_scale(s : ChemrxncatalystFrame, f : Double) -> ChemrxncatalystFrame {
  let result = chem_rxn_catalyst_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_frame_add(a : ChemrxncatalystFrame, b : ChemrxncatalystFrame) -> ChemrxncatalystFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_frame_copy(s : ChemrxncatalystFrame) -> ChemrxncatalystFrame {
  let result = chem_rxn_catalyst_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_frame_fill(s : ChemrxncatalystFrame, v : Double) -> ChemrxncatalystFrame {
  let result = chem_rxn_catalyst_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_frame_min(s : ChemrxncatalystFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_frame_max(s : ChemrxncatalystFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_frame_to_string(s : ChemrxncatalystFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_table_make(size : Int) -> ChemrxncatalystTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_table_len(s : ChemrxncatalystTable) -> Int { s.size }

pub fn chem_rxn_catalyst_table_get(s : ChemrxncatalystTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_table_set(s : ChemrxncatalystTable, i : Int, v : Double) -> ChemrxncatalystTable {
  let result = chem_rxn_catalyst_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_table_sum(s : ChemrxncatalystTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_table_mean(s : ChemrxncatalystTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_table_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_table_scale(s : ChemrxncatalystTable, f : Double) -> ChemrxncatalystTable {
  let result = chem_rxn_catalyst_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_table_add(a : ChemrxncatalystTable, b : ChemrxncatalystTable) -> ChemrxncatalystTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_table_copy(s : ChemrxncatalystTable) -> ChemrxncatalystTable {
  let result = chem_rxn_catalyst_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_table_fill(s : ChemrxncatalystTable, v : Double) -> ChemrxncatalystTable {
  let result = chem_rxn_catalyst_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_table_min(s : ChemrxncatalystTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_table_max(s : ChemrxncatalystTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_table_to_string(s : ChemrxncatalystTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_graphn_make(size : Int) -> ChemrxncatalystGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_graphn_len(s : ChemrxncatalystGraphN) -> Int { s.size }

pub fn chem_rxn_catalyst_graphn_get(s : ChemrxncatalystGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_graphn_set(s : ChemrxncatalystGraphN, i : Int, v : Double) -> ChemrxncatalystGraphN {
  let result = chem_rxn_catalyst_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_graphn_sum(s : ChemrxncatalystGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_graphn_mean(s : ChemrxncatalystGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_graphn_scale(s : ChemrxncatalystGraphN, f : Double) -> ChemrxncatalystGraphN {
  let result = chem_rxn_catalyst_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_graphn_add(a : ChemrxncatalystGraphN, b : ChemrxncatalystGraphN) -> ChemrxncatalystGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_graphn_copy(s : ChemrxncatalystGraphN) -> ChemrxncatalystGraphN {
  let result = chem_rxn_catalyst_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_graphn_fill(s : ChemrxncatalystGraphN, v : Double) -> ChemrxncatalystGraphN {
  let result = chem_rxn_catalyst_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_graphn_min(s : ChemrxncatalystGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_graphn_max(s : ChemrxncatalystGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_graphn_to_string(s : ChemrxncatalystGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_node_make(size : Int) -> ChemrxncatalystNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_node_len(s : ChemrxncatalystNode) -> Int { s.size }

pub fn chem_rxn_catalyst_node_get(s : ChemrxncatalystNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_node_set(s : ChemrxncatalystNode, i : Int, v : Double) -> ChemrxncatalystNode {
  let result = chem_rxn_catalyst_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_node_sum(s : ChemrxncatalystNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_node_mean(s : ChemrxncatalystNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_node_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_node_scale(s : ChemrxncatalystNode, f : Double) -> ChemrxncatalystNode {
  let result = chem_rxn_catalyst_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_node_add(a : ChemrxncatalystNode, b : ChemrxncatalystNode) -> ChemrxncatalystNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_node_copy(s : ChemrxncatalystNode) -> ChemrxncatalystNode {
  let result = chem_rxn_catalyst_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_node_fill(s : ChemrxncatalystNode, v : Double) -> ChemrxncatalystNode {
  let result = chem_rxn_catalyst_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_node_min(s : ChemrxncatalystNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_node_max(s : ChemrxncatalystNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_node_to_string(s : ChemrxncatalystNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_edge_make(size : Int) -> ChemrxncatalystEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_edge_len(s : ChemrxncatalystEdge) -> Int { s.size }

pub fn chem_rxn_catalyst_edge_get(s : ChemrxncatalystEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_edge_set(s : ChemrxncatalystEdge, i : Int, v : Double) -> ChemrxncatalystEdge {
  let result = chem_rxn_catalyst_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_edge_sum(s : ChemrxncatalystEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_edge_mean(s : ChemrxncatalystEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_edge_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_edge_scale(s : ChemrxncatalystEdge, f : Double) -> ChemrxncatalystEdge {
  let result = chem_rxn_catalyst_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_edge_add(a : ChemrxncatalystEdge, b : ChemrxncatalystEdge) -> ChemrxncatalystEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_edge_copy(s : ChemrxncatalystEdge) -> ChemrxncatalystEdge {
  let result = chem_rxn_catalyst_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_edge_fill(s : ChemrxncatalystEdge, v : Double) -> ChemrxncatalystEdge {
  let result = chem_rxn_catalyst_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_edge_min(s : ChemrxncatalystEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_edge_max(s : ChemrxncatalystEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_edge_to_string(s : ChemrxncatalystEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_path_make(size : Int) -> ChemrxncatalystPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_path_len(s : ChemrxncatalystPath) -> Int { s.size }

pub fn chem_rxn_catalyst_path_get(s : ChemrxncatalystPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_path_set(s : ChemrxncatalystPath, i : Int, v : Double) -> ChemrxncatalystPath {
  let result = chem_rxn_catalyst_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_path_sum(s : ChemrxncatalystPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_path_mean(s : ChemrxncatalystPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_path_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_path_scale(s : ChemrxncatalystPath, f : Double) -> ChemrxncatalystPath {
  let result = chem_rxn_catalyst_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_path_add(a : ChemrxncatalystPath, b : ChemrxncatalystPath) -> ChemrxncatalystPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_path_copy(s : ChemrxncatalystPath) -> ChemrxncatalystPath {
  let result = chem_rxn_catalyst_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_path_fill(s : ChemrxncatalystPath, v : Double) -> ChemrxncatalystPath {
  let result = chem_rxn_catalyst_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_path_min(s : ChemrxncatalystPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_path_max(s : ChemrxncatalystPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_path_to_string(s : ChemrxncatalystPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_cluster_make(size : Int) -> ChemrxncatalystCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_cluster_len(s : ChemrxncatalystCluster) -> Int { s.size }

pub fn chem_rxn_catalyst_cluster_get(s : ChemrxncatalystCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_cluster_set(s : ChemrxncatalystCluster, i : Int, v : Double) -> ChemrxncatalystCluster {
  let result = chem_rxn_catalyst_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_cluster_sum(s : ChemrxncatalystCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_cluster_mean(s : ChemrxncatalystCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_cluster_scale(s : ChemrxncatalystCluster, f : Double) -> ChemrxncatalystCluster {
  let result = chem_rxn_catalyst_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_cluster_add(a : ChemrxncatalystCluster, b : ChemrxncatalystCluster) -> ChemrxncatalystCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_cluster_copy(s : ChemrxncatalystCluster) -> ChemrxncatalystCluster {
  let result = chem_rxn_catalyst_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_cluster_fill(s : ChemrxncatalystCluster, v : Double) -> ChemrxncatalystCluster {
  let result = chem_rxn_catalyst_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_cluster_min(s : ChemrxncatalystCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_cluster_max(s : ChemrxncatalystCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_cluster_to_string(s : ChemrxncatalystCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_model_make(size : Int) -> ChemrxncatalystModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_model_len(s : ChemrxncatalystModel) -> Int { s.size }

pub fn chem_rxn_catalyst_model_get(s : ChemrxncatalystModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_model_set(s : ChemrxncatalystModel, i : Int, v : Double) -> ChemrxncatalystModel {
  let result = chem_rxn_catalyst_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_model_sum(s : ChemrxncatalystModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_model_mean(s : ChemrxncatalystModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_model_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_model_scale(s : ChemrxncatalystModel, f : Double) -> ChemrxncatalystModel {
  let result = chem_rxn_catalyst_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_model_add(a : ChemrxncatalystModel, b : ChemrxncatalystModel) -> ChemrxncatalystModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_model_copy(s : ChemrxncatalystModel) -> ChemrxncatalystModel {
  let result = chem_rxn_catalyst_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_model_fill(s : ChemrxncatalystModel, v : Double) -> ChemrxncatalystModel {
  let result = chem_rxn_catalyst_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_model_min(s : ChemrxncatalystModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_model_max(s : ChemrxncatalystModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_model_to_string(s : ChemrxncatalystModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_layer_make(size : Int) -> ChemrxncatalystLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_layer_len(s : ChemrxncatalystLayer) -> Int { s.size }

pub fn chem_rxn_catalyst_layer_get(s : ChemrxncatalystLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_layer_set(s : ChemrxncatalystLayer, i : Int, v : Double) -> ChemrxncatalystLayer {
  let result = chem_rxn_catalyst_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_layer_sum(s : ChemrxncatalystLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_layer_mean(s : ChemrxncatalystLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_layer_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_layer_scale(s : ChemrxncatalystLayer, f : Double) -> ChemrxncatalystLayer {
  let result = chem_rxn_catalyst_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_layer_add(a : ChemrxncatalystLayer, b : ChemrxncatalystLayer) -> ChemrxncatalystLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_layer_copy(s : ChemrxncatalystLayer) -> ChemrxncatalystLayer {
  let result = chem_rxn_catalyst_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_layer_fill(s : ChemrxncatalystLayer, v : Double) -> ChemrxncatalystLayer {
  let result = chem_rxn_catalyst_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_layer_min(s : ChemrxncatalystLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_layer_max(s : ChemrxncatalystLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_layer_to_string(s : ChemrxncatalystLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_buffer_make(size : Int) -> ChemrxncatalystBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_buffer_len(s : ChemrxncatalystBuffer) -> Int { s.size }

pub fn chem_rxn_catalyst_buffer_get(s : ChemrxncatalystBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_buffer_set(s : ChemrxncatalystBuffer, i : Int, v : Double) -> ChemrxncatalystBuffer {
  let result = chem_rxn_catalyst_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_buffer_sum(s : ChemrxncatalystBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_buffer_mean(s : ChemrxncatalystBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_buffer_scale(s : ChemrxncatalystBuffer, f : Double) -> ChemrxncatalystBuffer {
  let result = chem_rxn_catalyst_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_buffer_add(a : ChemrxncatalystBuffer, b : ChemrxncatalystBuffer) -> ChemrxncatalystBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_buffer_copy(s : ChemrxncatalystBuffer) -> ChemrxncatalystBuffer {
  let result = chem_rxn_catalyst_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_buffer_fill(s : ChemrxncatalystBuffer, v : Double) -> ChemrxncatalystBuffer {
  let result = chem_rxn_catalyst_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_buffer_min(s : ChemrxncatalystBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_buffer_max(s : ChemrxncatalystBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_buffer_to_string(s : ChemrxncatalystBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_cursor_make(size : Int) -> ChemrxncatalystCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_cursor_len(s : ChemrxncatalystCursor) -> Int { s.size }

pub fn chem_rxn_catalyst_cursor_get(s : ChemrxncatalystCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_cursor_set(s : ChemrxncatalystCursor, i : Int, v : Double) -> ChemrxncatalystCursor {
  let result = chem_rxn_catalyst_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_cursor_sum(s : ChemrxncatalystCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_cursor_mean(s : ChemrxncatalystCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_cursor_scale(s : ChemrxncatalystCursor, f : Double) -> ChemrxncatalystCursor {
  let result = chem_rxn_catalyst_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_cursor_add(a : ChemrxncatalystCursor, b : ChemrxncatalystCursor) -> ChemrxncatalystCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_cursor_copy(s : ChemrxncatalystCursor) -> ChemrxncatalystCursor {
  let result = chem_rxn_catalyst_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_cursor_fill(s : ChemrxncatalystCursor, v : Double) -> ChemrxncatalystCursor {
  let result = chem_rxn_catalyst_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_cursor_min(s : ChemrxncatalystCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_cursor_max(s : ChemrxncatalystCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_cursor_to_string(s : ChemrxncatalystCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_view_make(size : Int) -> ChemrxncatalystView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_view_len(s : ChemrxncatalystView) -> Int { s.size }

pub fn chem_rxn_catalyst_view_get(s : ChemrxncatalystView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_view_set(s : ChemrxncatalystView, i : Int, v : Double) -> ChemrxncatalystView {
  let result = chem_rxn_catalyst_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_view_sum(s : ChemrxncatalystView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_view_mean(s : ChemrxncatalystView) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_view_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_view_scale(s : ChemrxncatalystView, f : Double) -> ChemrxncatalystView {
  let result = chem_rxn_catalyst_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_view_add(a : ChemrxncatalystView, b : ChemrxncatalystView) -> ChemrxncatalystView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_view_copy(s : ChemrxncatalystView) -> ChemrxncatalystView {
  let result = chem_rxn_catalyst_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_view_fill(s : ChemrxncatalystView, v : Double) -> ChemrxncatalystView {
  let result = chem_rxn_catalyst_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_view_min(s : ChemrxncatalystView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_view_max(s : ChemrxncatalystView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_view_to_string(s : ChemrxncatalystView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_range_make(size : Int) -> ChemrxncatalystRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_range_len(s : ChemrxncatalystRange) -> Int { s.size }

pub fn chem_rxn_catalyst_range_get(s : ChemrxncatalystRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_range_set(s : ChemrxncatalystRange, i : Int, v : Double) -> ChemrxncatalystRange {
  let result = chem_rxn_catalyst_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_range_sum(s : ChemrxncatalystRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_range_mean(s : ChemrxncatalystRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_range_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_range_scale(s : ChemrxncatalystRange, f : Double) -> ChemrxncatalystRange {
  let result = chem_rxn_catalyst_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_range_add(a : ChemrxncatalystRange, b : ChemrxncatalystRange) -> ChemrxncatalystRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_range_copy(s : ChemrxncatalystRange) -> ChemrxncatalystRange {
  let result = chem_rxn_catalyst_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_range_fill(s : ChemrxncatalystRange, v : Double) -> ChemrxncatalystRange {
  let result = chem_rxn_catalyst_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_range_min(s : ChemrxncatalystRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_range_max(s : ChemrxncatalystRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_range_to_string(s : ChemrxncatalystRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemrxncatalystSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_rxn_catalyst_slice_make(size : Int) -> ChemrxncatalystSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_rxn_catalyst_slice_len(s : ChemrxncatalystSlice) -> Int { s.size }

pub fn chem_rxn_catalyst_slice_get(s : ChemrxncatalystSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_rxn_catalyst_slice_set(s : ChemrxncatalystSlice, i : Int, v : Double) -> ChemrxncatalystSlice {
  let result = chem_rxn_catalyst_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_slice_sum(s : ChemrxncatalystSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_rxn_catalyst_slice_mean(s : ChemrxncatalystSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_rxn_catalyst_slice_sum(s) / s.size.to_double() }
}

pub fn chem_rxn_catalyst_slice_scale(s : ChemrxncatalystSlice, f : Double) -> ChemrxncatalystSlice {
  let result = chem_rxn_catalyst_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_rxn_catalyst_slice_add(a : ChemrxncatalystSlice, b : ChemrxncatalystSlice) -> ChemrxncatalystSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_rxn_catalyst_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_rxn_catalyst_slice_copy(s : ChemrxncatalystSlice) -> ChemrxncatalystSlice {
  let result = chem_rxn_catalyst_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_rxn_catalyst_slice_fill(s : ChemrxncatalystSlice, v : Double) -> ChemrxncatalystSlice {
  let result = chem_rxn_catalyst_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_rxn_catalyst_slice_min(s : ChemrxncatalystSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_slice_max(s : ChemrxncatalystSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_rxn_catalyst_slice_to_string(s : ChemrxncatalystSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_rxn_catalyst_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_rxn_catalyst_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

