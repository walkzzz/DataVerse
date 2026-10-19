///===
/// extcore/chem_desc_atompair

pub(all) struct ChemdescatompairPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_atompair_make_point(x : Double, y : Double) -> ChemdescatompairPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_atompair_make_point3(x : Double, y : Double, z : Double) -> ChemdescatompairPoint {
  { x, y, z, label: 0 }
}

pub fn chem_desc_atompair_point_x(pt : ChemdescatompairPoint) -> Double { pt.x }

pub fn chem_desc_atompair_point_y(pt : ChemdescatompairPoint) -> Double { pt.y }

pub fn chem_desc_atompair_point_z(pt : ChemdescatompairPoint) -> Double { pt.z }

pub fn chem_desc_atompair_point_label(pt : ChemdescatompairPoint) -> Int { pt.label }

pub fn chem_desc_atompair_point_dist(a : ChemdescatompairPoint, b : ChemdescatompairPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_desc_atompair_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_desc_atompair_point_add(a : ChemdescatompairPoint, b : ChemdescatompairPoint) -> ChemdescatompairPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_desc_atompair_point_sub(a : ChemdescatompairPoint, b : ChemdescatompairPoint) -> ChemdescatompairPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_desc_atompair_point_scale(pt : ChemdescatompairPoint, s : Double) -> ChemdescatompairPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_desc_atompair_point_dot(a : ChemdescatompairPoint, b : ChemdescatompairPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_desc_atompair_point_cross(a : ChemdescatompairPoint, b : ChemdescatompairPoint) -> ChemdescatompairPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_desc_atompair_point_norm(pt : ChemdescatompairPoint) -> Double {
  chem_desc_atompair_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_desc_atompair_point_normalize(pt : ChemdescatompairPoint) -> ChemdescatompairPoint {
  let n = chem_desc_atompair_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_desc_atompair_point_scale(pt, 1.0 / n) }
}

pub fn chem_desc_atompair_point_negate(pt : ChemdescatompairPoint) -> ChemdescatompairPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_desc_atompair_point_mid(a : ChemdescatompairPoint, b : ChemdescatompairPoint) -> ChemdescatompairPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_desc_atompair_point_lerp(a : ChemdescatompairPoint, b : ChemdescatompairPoint, t : Double) -> ChemdescatompairPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_desc_atompair_point_to_string(pt : ChemdescatompairPoint) -> String {
  "(" + chem_desc_atompair_dbl(pt.x) + ", " + chem_desc_atompair_dbl(pt.y) + ", " + chem_desc_atompair_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemdescatompairSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_atompair_make_series(vals : Array[Double], name : String) -> ChemdescatompairSeries {
  { vals, name, meta: 0 }
}

pub fn chem_desc_atompair_series_len(s : ChemdescatompairSeries) -> Int { s.vals.length() }

pub fn chem_desc_atompair_series_sum(s : ChemdescatompairSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_desc_atompair_series_mean(s : ChemdescatompairSeries) -> Double {
  let n = chem_desc_atompair_series_len(s)
  if n == 0 { 0.0 } else { chem_desc_atompair_series_sum(s) / n.to_double() }
}

pub fn chem_desc_atompair_series_min(s : ChemdescatompairSeries) -> Double {
  let n = chem_desc_atompair_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_atompair_series_max(s : ChemdescatompairSeries) -> Double {
  let n = chem_desc_atompair_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_atompair_series_range(s : ChemdescatompairSeries) -> Double {
  chem_desc_atompair_series_max(s) - chem_desc_atompair_series_min(s)
}

pub fn chem_desc_atompair_series_var(s : ChemdescatompairSeries) -> Double {
  let n = chem_desc_atompair_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_desc_atompair_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_desc_atompair_series_std(s : ChemdescatompairSeries) -> Double { chem_desc_atompair_sqrt(chem_desc_atompair_series_var(s)) }

pub fn chem_desc_atompair_series_median(s : ChemdescatompairSeries) -> Double {
  let n = chem_desc_atompair_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_desc_atompair_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_desc_atompair_series_scale(s : ChemdescatompairSeries, f : Double) -> ChemdescatompairSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_desc_atompair_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_desc_atompair_series_add(a : ChemdescatompairSeries, b : ChemdescatompairSeries) -> ChemdescatompairSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_desc_atompair_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_desc_atompair_series_sub(a : ChemdescatompairSeries, b : ChemdescatompairSeries) -> ChemdescatompairSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_desc_atompair_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_desc_atompair_series_normalize(s : ChemdescatompairSeries) -> ChemdescatompairSeries {
  let mn = chem_desc_atompair_series_min(s)
  let mx = chem_desc_atompair_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_desc_atompair_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_desc_atompair_series_cumsum(s : ChemdescatompairSeries) -> ChemdescatompairSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_desc_atompair_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_desc_atompair_series_to_string(s : ChemdescatompairSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_desc_atompair_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescatompairMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_atompair_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescatompairMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_atompair_matrix_identity(n : Int) -> ChemdescatompairMatrix {
  let m = chem_desc_atompair_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_desc_atompair_matrix_get(m : ChemdescatompairMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_desc_atompair_matrix_transpose(m : ChemdescatompairMatrix) -> ChemdescatompairMatrix {
  let result = chem_desc_atompair_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_desc_atompair_matrix_add(a : ChemdescatompairMatrix, b : ChemdescatompairMatrix) -> ChemdescatompairMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_desc_atompair_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_desc_atompair_matrix_scale(m : ChemdescatompairMatrix, s : Double) -> ChemdescatompairMatrix {
  let result = chem_desc_atompair_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_desc_atompair_matrix_multiply(a : ChemdescatompairMatrix, b : ChemdescatompairMatrix) -> ChemdescatompairMatrix {
  if a.cols != b.rows { return chem_desc_atompair_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_desc_atompair_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_desc_atompair_matrix_trace(m : ChemdescatompairMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_desc_atompair_matrix_det(m : ChemdescatompairMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_desc_atompair_matrix_norm(m : ChemdescatompairMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_desc_atompair_sqrt(sum)
}

pub fn chem_desc_atompair_matrix_to_string(m : ChemdescatompairMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_desc_atompair_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemdescatompairVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_atompair_make_vector(comps : Array[Double]) -> ChemdescatompairVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_atompair_vector_zero(dim : Int) -> ChemdescatompairVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_desc_atompair_vector_add(a : ChemdescatompairVector, b : ChemdescatompairVector) -> ChemdescatompairVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_desc_atompair_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_atompair_vector_sub(a : ChemdescatompairVector, b : ChemdescatompairVector) -> ChemdescatompairVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_desc_atompair_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_atompair_vector_scale(v : ChemdescatompairVector, s : Double) -> ChemdescatompairVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_desc_atompair_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_desc_atompair_vector_dot(a : ChemdescatompairVector, b : ChemdescatompairVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_desc_atompair_vector_norm(v : ChemdescatompairVector) -> Double { chem_desc_atompair_sqrt(chem_desc_atompair_vector_dot(v, v)) }

pub fn chem_desc_atompair_vector_normalize(v : ChemdescatompairVector) -> ChemdescatompairVector {
  let n = chem_desc_atompair_vector_norm(v)
  if n < 0.0000001 { v } else { chem_desc_atompair_vector_scale(v, 1.0 / n) }
}

pub fn chem_desc_atompair_vector_dist(a : ChemdescatompairVector, b : ChemdescatompairVector) -> Double {
  chem_desc_atompair_vector_norm(chem_desc_atompair_vector_sub(a, b))
}

pub fn chem_desc_atompair_vector_to_string(v : ChemdescatompairVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_desc_atompair_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_atompair_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_desc_atompair_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_desc_atompair_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_desc_atompair_std(data : Array[Double]) -> Double { chem_desc_atompair_sqrt(chem_desc_atompair_var(data)) }

pub fn chem_desc_atompair_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_desc_atompair_mean(a); let mb = chem_desc_atompair_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_desc_atompair_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_desc_atompair_std(a); let sb = chem_desc_atompair_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_desc_atompair_cov(a, b) / (sa * sb) }
}

pub fn chem_desc_atompair_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_desc_atompair_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_desc_atompair_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_desc_atompair_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_desc_atompair_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_desc_atompair_sqrt(chem_desc_atompair_mse(pred, labels))
}

pub fn chem_desc_atompair_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_desc_atompair_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_desc_atompair_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_desc_atompair_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_desc_atompair_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_desc_atompair_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_desc_atompair_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_desc_atompair_precision(pred, labels, pos); let r = chem_desc_atompair_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_desc_atompair_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_desc_atompair_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_desc_atompair_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_desc_atompair_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_desc_atompair_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_desc_atompair_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_desc_atompair_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_desc_atompair_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_desc_atompair_fibonacci(n : Int) -> Int {
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

pub fn chem_desc_atompair_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_desc_atompair_min(data); let mx = chem_desc_atompair_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_desc_atompair_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_desc_atompair_mean(data); let sd = chem_desc_atompair_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_desc_atompair_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_desc_atompair_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_desc_atompair_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_desc_atompair_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_desc_atompair_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_desc_atompair_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_desc_atompair_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_desc_atompair_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_desc_atompair_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_desc_atompair_int(x) } else { -chem_desc_atompair_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_desc_atompair_int(f * 1000000.0) } else { chem_desc_atompair_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_desc_atompair_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_desc_atompair_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemdescatompairFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_frame_make(size : Int) -> ChemdescatompairFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_frame_len(s : ChemdescatompairFrame) -> Int { s.size }

pub fn chem_desc_atompair_frame_get(s : ChemdescatompairFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_frame_set(s : ChemdescatompairFrame, i : Int, v : Double) -> ChemdescatompairFrame {
  let result = chem_desc_atompair_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_frame_sum(s : ChemdescatompairFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_frame_mean(s : ChemdescatompairFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_frame_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_frame_scale(s : ChemdescatompairFrame, f : Double) -> ChemdescatompairFrame {
  let result = chem_desc_atompair_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_frame_add(a : ChemdescatompairFrame, b : ChemdescatompairFrame) -> ChemdescatompairFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_frame_copy(s : ChemdescatompairFrame) -> ChemdescatompairFrame {
  let result = chem_desc_atompair_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_frame_fill(s : ChemdescatompairFrame, v : Double) -> ChemdescatompairFrame {
  let result = chem_desc_atompair_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_frame_min(s : ChemdescatompairFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_frame_max(s : ChemdescatompairFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_frame_to_string(s : ChemdescatompairFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_table_make(size : Int) -> ChemdescatompairTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_table_len(s : ChemdescatompairTable) -> Int { s.size }

pub fn chem_desc_atompair_table_get(s : ChemdescatompairTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_table_set(s : ChemdescatompairTable, i : Int, v : Double) -> ChemdescatompairTable {
  let result = chem_desc_atompair_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_table_sum(s : ChemdescatompairTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_table_mean(s : ChemdescatompairTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_table_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_table_scale(s : ChemdescatompairTable, f : Double) -> ChemdescatompairTable {
  let result = chem_desc_atompair_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_table_add(a : ChemdescatompairTable, b : ChemdescatompairTable) -> ChemdescatompairTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_table_copy(s : ChemdescatompairTable) -> ChemdescatompairTable {
  let result = chem_desc_atompair_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_table_fill(s : ChemdescatompairTable, v : Double) -> ChemdescatompairTable {
  let result = chem_desc_atompair_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_table_min(s : ChemdescatompairTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_table_max(s : ChemdescatompairTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_table_to_string(s : ChemdescatompairTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_graphn_make(size : Int) -> ChemdescatompairGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_graphn_len(s : ChemdescatompairGraphN) -> Int { s.size }

pub fn chem_desc_atompair_graphn_get(s : ChemdescatompairGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_graphn_set(s : ChemdescatompairGraphN, i : Int, v : Double) -> ChemdescatompairGraphN {
  let result = chem_desc_atompair_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_graphn_sum(s : ChemdescatompairGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_graphn_mean(s : ChemdescatompairGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_graphn_scale(s : ChemdescatompairGraphN, f : Double) -> ChemdescatompairGraphN {
  let result = chem_desc_atompair_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_graphn_add(a : ChemdescatompairGraphN, b : ChemdescatompairGraphN) -> ChemdescatompairGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_graphn_copy(s : ChemdescatompairGraphN) -> ChemdescatompairGraphN {
  let result = chem_desc_atompair_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_graphn_fill(s : ChemdescatompairGraphN, v : Double) -> ChemdescatompairGraphN {
  let result = chem_desc_atompair_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_graphn_min(s : ChemdescatompairGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_graphn_max(s : ChemdescatompairGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_graphn_to_string(s : ChemdescatompairGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_node_make(size : Int) -> ChemdescatompairNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_node_len(s : ChemdescatompairNode) -> Int { s.size }

pub fn chem_desc_atompair_node_get(s : ChemdescatompairNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_node_set(s : ChemdescatompairNode, i : Int, v : Double) -> ChemdescatompairNode {
  let result = chem_desc_atompair_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_node_sum(s : ChemdescatompairNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_node_mean(s : ChemdescatompairNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_node_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_node_scale(s : ChemdescatompairNode, f : Double) -> ChemdescatompairNode {
  let result = chem_desc_atompair_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_node_add(a : ChemdescatompairNode, b : ChemdescatompairNode) -> ChemdescatompairNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_node_copy(s : ChemdescatompairNode) -> ChemdescatompairNode {
  let result = chem_desc_atompair_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_node_fill(s : ChemdescatompairNode, v : Double) -> ChemdescatompairNode {
  let result = chem_desc_atompair_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_node_min(s : ChemdescatompairNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_node_max(s : ChemdescatompairNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_node_to_string(s : ChemdescatompairNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_edge_make(size : Int) -> ChemdescatompairEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_edge_len(s : ChemdescatompairEdge) -> Int { s.size }

pub fn chem_desc_atompair_edge_get(s : ChemdescatompairEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_edge_set(s : ChemdescatompairEdge, i : Int, v : Double) -> ChemdescatompairEdge {
  let result = chem_desc_atompair_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_edge_sum(s : ChemdescatompairEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_edge_mean(s : ChemdescatompairEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_edge_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_edge_scale(s : ChemdescatompairEdge, f : Double) -> ChemdescatompairEdge {
  let result = chem_desc_atompair_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_edge_add(a : ChemdescatompairEdge, b : ChemdescatompairEdge) -> ChemdescatompairEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_edge_copy(s : ChemdescatompairEdge) -> ChemdescatompairEdge {
  let result = chem_desc_atompair_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_edge_fill(s : ChemdescatompairEdge, v : Double) -> ChemdescatompairEdge {
  let result = chem_desc_atompair_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_edge_min(s : ChemdescatompairEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_edge_max(s : ChemdescatompairEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_edge_to_string(s : ChemdescatompairEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_path_make(size : Int) -> ChemdescatompairPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_path_len(s : ChemdescatompairPath) -> Int { s.size }

pub fn chem_desc_atompair_path_get(s : ChemdescatompairPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_path_set(s : ChemdescatompairPath, i : Int, v : Double) -> ChemdescatompairPath {
  let result = chem_desc_atompair_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_path_sum(s : ChemdescatompairPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_path_mean(s : ChemdescatompairPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_path_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_path_scale(s : ChemdescatompairPath, f : Double) -> ChemdescatompairPath {
  let result = chem_desc_atompair_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_path_add(a : ChemdescatompairPath, b : ChemdescatompairPath) -> ChemdescatompairPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_path_copy(s : ChemdescatompairPath) -> ChemdescatompairPath {
  let result = chem_desc_atompair_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_path_fill(s : ChemdescatompairPath, v : Double) -> ChemdescatompairPath {
  let result = chem_desc_atompair_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_path_min(s : ChemdescatompairPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_path_max(s : ChemdescatompairPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_path_to_string(s : ChemdescatompairPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_cluster_make(size : Int) -> ChemdescatompairCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_cluster_len(s : ChemdescatompairCluster) -> Int { s.size }

pub fn chem_desc_atompair_cluster_get(s : ChemdescatompairCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_cluster_set(s : ChemdescatompairCluster, i : Int, v : Double) -> ChemdescatompairCluster {
  let result = chem_desc_atompair_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_cluster_sum(s : ChemdescatompairCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_cluster_mean(s : ChemdescatompairCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_cluster_scale(s : ChemdescatompairCluster, f : Double) -> ChemdescatompairCluster {
  let result = chem_desc_atompair_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_cluster_add(a : ChemdescatompairCluster, b : ChemdescatompairCluster) -> ChemdescatompairCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_cluster_copy(s : ChemdescatompairCluster) -> ChemdescatompairCluster {
  let result = chem_desc_atompair_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_cluster_fill(s : ChemdescatompairCluster, v : Double) -> ChemdescatompairCluster {
  let result = chem_desc_atompair_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_cluster_min(s : ChemdescatompairCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_cluster_max(s : ChemdescatompairCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_cluster_to_string(s : ChemdescatompairCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_model_make(size : Int) -> ChemdescatompairModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_model_len(s : ChemdescatompairModel) -> Int { s.size }

pub fn chem_desc_atompair_model_get(s : ChemdescatompairModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_model_set(s : ChemdescatompairModel, i : Int, v : Double) -> ChemdescatompairModel {
  let result = chem_desc_atompair_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_model_sum(s : ChemdescatompairModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_model_mean(s : ChemdescatompairModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_model_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_model_scale(s : ChemdescatompairModel, f : Double) -> ChemdescatompairModel {
  let result = chem_desc_atompair_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_model_add(a : ChemdescatompairModel, b : ChemdescatompairModel) -> ChemdescatompairModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_model_copy(s : ChemdescatompairModel) -> ChemdescatompairModel {
  let result = chem_desc_atompair_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_model_fill(s : ChemdescatompairModel, v : Double) -> ChemdescatompairModel {
  let result = chem_desc_atompair_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_model_min(s : ChemdescatompairModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_model_max(s : ChemdescatompairModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_model_to_string(s : ChemdescatompairModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_layer_make(size : Int) -> ChemdescatompairLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_layer_len(s : ChemdescatompairLayer) -> Int { s.size }

pub fn chem_desc_atompair_layer_get(s : ChemdescatompairLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_layer_set(s : ChemdescatompairLayer, i : Int, v : Double) -> ChemdescatompairLayer {
  let result = chem_desc_atompair_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_layer_sum(s : ChemdescatompairLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_layer_mean(s : ChemdescatompairLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_layer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_layer_scale(s : ChemdescatompairLayer, f : Double) -> ChemdescatompairLayer {
  let result = chem_desc_atompair_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_layer_add(a : ChemdescatompairLayer, b : ChemdescatompairLayer) -> ChemdescatompairLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_layer_copy(s : ChemdescatompairLayer) -> ChemdescatompairLayer {
  let result = chem_desc_atompair_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_layer_fill(s : ChemdescatompairLayer, v : Double) -> ChemdescatompairLayer {
  let result = chem_desc_atompair_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_layer_min(s : ChemdescatompairLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_layer_max(s : ChemdescatompairLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_layer_to_string(s : ChemdescatompairLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_buffer_make(size : Int) -> ChemdescatompairBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_buffer_len(s : ChemdescatompairBuffer) -> Int { s.size }

pub fn chem_desc_atompair_buffer_get(s : ChemdescatompairBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_buffer_set(s : ChemdescatompairBuffer, i : Int, v : Double) -> ChemdescatompairBuffer {
  let result = chem_desc_atompair_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_buffer_sum(s : ChemdescatompairBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_buffer_mean(s : ChemdescatompairBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_buffer_scale(s : ChemdescatompairBuffer, f : Double) -> ChemdescatompairBuffer {
  let result = chem_desc_atompair_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_buffer_add(a : ChemdescatompairBuffer, b : ChemdescatompairBuffer) -> ChemdescatompairBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_buffer_copy(s : ChemdescatompairBuffer) -> ChemdescatompairBuffer {
  let result = chem_desc_atompair_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_buffer_fill(s : ChemdescatompairBuffer, v : Double) -> ChemdescatompairBuffer {
  let result = chem_desc_atompair_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_buffer_min(s : ChemdescatompairBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_buffer_max(s : ChemdescatompairBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_buffer_to_string(s : ChemdescatompairBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_cursor_make(size : Int) -> ChemdescatompairCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_cursor_len(s : ChemdescatompairCursor) -> Int { s.size }

pub fn chem_desc_atompair_cursor_get(s : ChemdescatompairCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_cursor_set(s : ChemdescatompairCursor, i : Int, v : Double) -> ChemdescatompairCursor {
  let result = chem_desc_atompair_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_cursor_sum(s : ChemdescatompairCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_cursor_mean(s : ChemdescatompairCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_cursor_scale(s : ChemdescatompairCursor, f : Double) -> ChemdescatompairCursor {
  let result = chem_desc_atompair_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_cursor_add(a : ChemdescatompairCursor, b : ChemdescatompairCursor) -> ChemdescatompairCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_cursor_copy(s : ChemdescatompairCursor) -> ChemdescatompairCursor {
  let result = chem_desc_atompair_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_cursor_fill(s : ChemdescatompairCursor, v : Double) -> ChemdescatompairCursor {
  let result = chem_desc_atompair_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_cursor_min(s : ChemdescatompairCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_cursor_max(s : ChemdescatompairCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_cursor_to_string(s : ChemdescatompairCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_view_make(size : Int) -> ChemdescatompairView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_view_len(s : ChemdescatompairView) -> Int { s.size }

pub fn chem_desc_atompair_view_get(s : ChemdescatompairView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_view_set(s : ChemdescatompairView, i : Int, v : Double) -> ChemdescatompairView {
  let result = chem_desc_atompair_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_view_sum(s : ChemdescatompairView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_view_mean(s : ChemdescatompairView) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_view_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_view_scale(s : ChemdescatompairView, f : Double) -> ChemdescatompairView {
  let result = chem_desc_atompair_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_view_add(a : ChemdescatompairView, b : ChemdescatompairView) -> ChemdescatompairView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_view_copy(s : ChemdescatompairView) -> ChemdescatompairView {
  let result = chem_desc_atompair_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_view_fill(s : ChemdescatompairView, v : Double) -> ChemdescatompairView {
  let result = chem_desc_atompair_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_view_min(s : ChemdescatompairView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_view_max(s : ChemdescatompairView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_view_to_string(s : ChemdescatompairView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_range_make(size : Int) -> ChemdescatompairRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_range_len(s : ChemdescatompairRange) -> Int { s.size }

pub fn chem_desc_atompair_range_get(s : ChemdescatompairRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_range_set(s : ChemdescatompairRange, i : Int, v : Double) -> ChemdescatompairRange {
  let result = chem_desc_atompair_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_range_sum(s : ChemdescatompairRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_range_mean(s : ChemdescatompairRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_range_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_range_scale(s : ChemdescatompairRange, f : Double) -> ChemdescatompairRange {
  let result = chem_desc_atompair_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_range_add(a : ChemdescatompairRange, b : ChemdescatompairRange) -> ChemdescatompairRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_range_copy(s : ChemdescatompairRange) -> ChemdescatompairRange {
  let result = chem_desc_atompair_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_range_fill(s : ChemdescatompairRange, v : Double) -> ChemdescatompairRange {
  let result = chem_desc_atompair_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_range_min(s : ChemdescatompairRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_range_max(s : ChemdescatompairRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_range_to_string(s : ChemdescatompairRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescatompairSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_atompair_slice_make(size : Int) -> ChemdescatompairSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_atompair_slice_len(s : ChemdescatompairSlice) -> Int { s.size }

pub fn chem_desc_atompair_slice_get(s : ChemdescatompairSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_atompair_slice_set(s : ChemdescatompairSlice, i : Int, v : Double) -> ChemdescatompairSlice {
  let result = chem_desc_atompair_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_slice_sum(s : ChemdescatompairSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_atompair_slice_mean(s : ChemdescatompairSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_atompair_slice_sum(s) / s.size.to_double() }
}

pub fn chem_desc_atompair_slice_scale(s : ChemdescatompairSlice, f : Double) -> ChemdescatompairSlice {
  let result = chem_desc_atompair_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_atompair_slice_add(a : ChemdescatompairSlice, b : ChemdescatompairSlice) -> ChemdescatompairSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_atompair_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_atompair_slice_copy(s : ChemdescatompairSlice) -> ChemdescatompairSlice {
  let result = chem_desc_atompair_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_atompair_slice_fill(s : ChemdescatompairSlice, v : Double) -> ChemdescatompairSlice {
  let result = chem_desc_atompair_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_atompair_slice_min(s : ChemdescatompairSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_slice_max(s : ChemdescatompairSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_atompair_slice_to_string(s : ChemdescatompairSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_desc_atompair_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_atompair_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

