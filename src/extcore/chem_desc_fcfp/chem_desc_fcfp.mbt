///===
/// extcore/chem_desc_fcfp

pub(all) struct ChemdescfcfpPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_fcfp_make_point(x : Double, y : Double) -> ChemdescfcfpPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_fcfp_make_point3(x : Double, y : Double, z : Double) -> ChemdescfcfpPoint {
  { x, y, z, label: 0 }
}

pub fn chem_desc_fcfp_point_x(pt : ChemdescfcfpPoint) -> Double { pt.x }

pub fn chem_desc_fcfp_point_y(pt : ChemdescfcfpPoint) -> Double { pt.y }

pub fn chem_desc_fcfp_point_z(pt : ChemdescfcfpPoint) -> Double { pt.z }

pub fn chem_desc_fcfp_point_label(pt : ChemdescfcfpPoint) -> Int { pt.label }

pub fn chem_desc_fcfp_point_dist(a : ChemdescfcfpPoint, b : ChemdescfcfpPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_desc_fcfp_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_desc_fcfp_point_add(a : ChemdescfcfpPoint, b : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_desc_fcfp_point_sub(a : ChemdescfcfpPoint, b : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_desc_fcfp_point_scale(pt : ChemdescfcfpPoint, s : Double) -> ChemdescfcfpPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_desc_fcfp_point_dot(a : ChemdescfcfpPoint, b : ChemdescfcfpPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_desc_fcfp_point_cross(a : ChemdescfcfpPoint, b : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_desc_fcfp_point_norm(pt : ChemdescfcfpPoint) -> Double {
  chem_desc_fcfp_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_desc_fcfp_point_normalize(pt : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  let n = chem_desc_fcfp_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_desc_fcfp_point_scale(pt, 1.0 / n) }
}

pub fn chem_desc_fcfp_point_negate(pt : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_desc_fcfp_point_mid(a : ChemdescfcfpPoint, b : ChemdescfcfpPoint) -> ChemdescfcfpPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_desc_fcfp_point_lerp(a : ChemdescfcfpPoint, b : ChemdescfcfpPoint, t : Double) -> ChemdescfcfpPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_desc_fcfp_point_to_string(pt : ChemdescfcfpPoint) -> String {
  "(" + chem_desc_fcfp_dbl(pt.x) + ", " + chem_desc_fcfp_dbl(pt.y) + ", " + chem_desc_fcfp_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemdescfcfpSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_fcfp_make_series(vals : Array[Double], name : String) -> ChemdescfcfpSeries {
  { vals, name, meta: 0 }
}

pub fn chem_desc_fcfp_series_len(s : ChemdescfcfpSeries) -> Int { s.vals.length() }

pub fn chem_desc_fcfp_series_sum(s : ChemdescfcfpSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_desc_fcfp_series_mean(s : ChemdescfcfpSeries) -> Double {
  let n = chem_desc_fcfp_series_len(s)
  if n == 0 { 0.0 } else { chem_desc_fcfp_series_sum(s) / n.to_double() }
}

pub fn chem_desc_fcfp_series_min(s : ChemdescfcfpSeries) -> Double {
  let n = chem_desc_fcfp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_fcfp_series_max(s : ChemdescfcfpSeries) -> Double {
  let n = chem_desc_fcfp_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_fcfp_series_range(s : ChemdescfcfpSeries) -> Double {
  chem_desc_fcfp_series_max(s) - chem_desc_fcfp_series_min(s)
}

pub fn chem_desc_fcfp_series_var(s : ChemdescfcfpSeries) -> Double {
  let n = chem_desc_fcfp_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_desc_fcfp_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_desc_fcfp_series_std(s : ChemdescfcfpSeries) -> Double { chem_desc_fcfp_sqrt(chem_desc_fcfp_series_var(s)) }

pub fn chem_desc_fcfp_series_median(s : ChemdescfcfpSeries) -> Double {
  let n = chem_desc_fcfp_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_desc_fcfp_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_desc_fcfp_series_scale(s : ChemdescfcfpSeries, f : Double) -> ChemdescfcfpSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_desc_fcfp_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_desc_fcfp_series_add(a : ChemdescfcfpSeries, b : ChemdescfcfpSeries) -> ChemdescfcfpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_desc_fcfp_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_desc_fcfp_series_sub(a : ChemdescfcfpSeries, b : ChemdescfcfpSeries) -> ChemdescfcfpSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_desc_fcfp_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_desc_fcfp_series_normalize(s : ChemdescfcfpSeries) -> ChemdescfcfpSeries {
  let mn = chem_desc_fcfp_series_min(s)
  let mx = chem_desc_fcfp_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_desc_fcfp_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_desc_fcfp_series_cumsum(s : ChemdescfcfpSeries) -> ChemdescfcfpSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_desc_fcfp_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_desc_fcfp_series_to_string(s : ChemdescfcfpSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_desc_fcfp_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdescfcfpMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_fcfp_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdescfcfpMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_fcfp_matrix_identity(n : Int) -> ChemdescfcfpMatrix {
  let m = chem_desc_fcfp_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_desc_fcfp_matrix_get(m : ChemdescfcfpMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_desc_fcfp_matrix_transpose(m : ChemdescfcfpMatrix) -> ChemdescfcfpMatrix {
  let result = chem_desc_fcfp_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_desc_fcfp_matrix_add(a : ChemdescfcfpMatrix, b : ChemdescfcfpMatrix) -> ChemdescfcfpMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_desc_fcfp_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_desc_fcfp_matrix_scale(m : ChemdescfcfpMatrix, s : Double) -> ChemdescfcfpMatrix {
  let result = chem_desc_fcfp_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_desc_fcfp_matrix_multiply(a : ChemdescfcfpMatrix, b : ChemdescfcfpMatrix) -> ChemdescfcfpMatrix {
  if a.cols != b.rows { return chem_desc_fcfp_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_desc_fcfp_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_desc_fcfp_matrix_trace(m : ChemdescfcfpMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_desc_fcfp_matrix_det(m : ChemdescfcfpMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_desc_fcfp_matrix_norm(m : ChemdescfcfpMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_desc_fcfp_sqrt(sum)
}

pub fn chem_desc_fcfp_matrix_to_string(m : ChemdescfcfpMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_desc_fcfp_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemdescfcfpVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_fcfp_make_vector(comps : Array[Double]) -> ChemdescfcfpVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_fcfp_vector_zero(dim : Int) -> ChemdescfcfpVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_desc_fcfp_vector_add(a : ChemdescfcfpVector, b : ChemdescfcfpVector) -> ChemdescfcfpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_desc_fcfp_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_fcfp_vector_sub(a : ChemdescfcfpVector, b : ChemdescfcfpVector) -> ChemdescfcfpVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_desc_fcfp_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_fcfp_vector_scale(v : ChemdescfcfpVector, s : Double) -> ChemdescfcfpVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_desc_fcfp_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_desc_fcfp_vector_dot(a : ChemdescfcfpVector, b : ChemdescfcfpVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_desc_fcfp_vector_norm(v : ChemdescfcfpVector) -> Double { chem_desc_fcfp_sqrt(chem_desc_fcfp_vector_dot(v, v)) }

pub fn chem_desc_fcfp_vector_normalize(v : ChemdescfcfpVector) -> ChemdescfcfpVector {
  let n = chem_desc_fcfp_vector_norm(v)
  if n < 0.0000001 { v } else { chem_desc_fcfp_vector_scale(v, 1.0 / n) }
}

pub fn chem_desc_fcfp_vector_dist(a : ChemdescfcfpVector, b : ChemdescfcfpVector) -> Double {
  chem_desc_fcfp_vector_norm(chem_desc_fcfp_vector_sub(a, b))
}

pub fn chem_desc_fcfp_vector_to_string(v : ChemdescfcfpVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_desc_fcfp_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_fcfp_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_desc_fcfp_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_desc_fcfp_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_desc_fcfp_std(data : Array[Double]) -> Double { chem_desc_fcfp_sqrt(chem_desc_fcfp_var(data)) }

pub fn chem_desc_fcfp_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_desc_fcfp_mean(a); let mb = chem_desc_fcfp_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_desc_fcfp_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_desc_fcfp_std(a); let sb = chem_desc_fcfp_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_desc_fcfp_cov(a, b) / (sa * sb) }
}

pub fn chem_desc_fcfp_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_desc_fcfp_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_desc_fcfp_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_desc_fcfp_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_desc_fcfp_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_desc_fcfp_sqrt(chem_desc_fcfp_mse(pred, labels))
}

pub fn chem_desc_fcfp_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_desc_fcfp_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_desc_fcfp_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_desc_fcfp_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_desc_fcfp_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_desc_fcfp_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_desc_fcfp_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_desc_fcfp_precision(pred, labels, pos); let r = chem_desc_fcfp_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_desc_fcfp_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_desc_fcfp_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_desc_fcfp_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_desc_fcfp_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_desc_fcfp_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_desc_fcfp_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_desc_fcfp_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_desc_fcfp_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_desc_fcfp_fibonacci(n : Int) -> Int {
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

pub fn chem_desc_fcfp_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_desc_fcfp_min(data); let mx = chem_desc_fcfp_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_desc_fcfp_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_desc_fcfp_mean(data); let sd = chem_desc_fcfp_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_desc_fcfp_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_desc_fcfp_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_desc_fcfp_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_desc_fcfp_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_desc_fcfp_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_desc_fcfp_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_desc_fcfp_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_desc_fcfp_int(x) } else { -chem_desc_fcfp_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_desc_fcfp_int(f * 1000000.0) } else { chem_desc_fcfp_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_desc_fcfp_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_desc_fcfp_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemdescfcfpFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_frame_make(size : Int) -> ChemdescfcfpFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_frame_len(s : ChemdescfcfpFrame) -> Int { s.size }

pub fn chem_desc_fcfp_frame_get(s : ChemdescfcfpFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_frame_set(s : ChemdescfcfpFrame, i : Int, v : Double) -> ChemdescfcfpFrame {
  let result = chem_desc_fcfp_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_frame_sum(s : ChemdescfcfpFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_frame_mean(s : ChemdescfcfpFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_frame_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_frame_scale(s : ChemdescfcfpFrame, f : Double) -> ChemdescfcfpFrame {
  let result = chem_desc_fcfp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_frame_add(a : ChemdescfcfpFrame, b : ChemdescfcfpFrame) -> ChemdescfcfpFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_frame_copy(s : ChemdescfcfpFrame) -> ChemdescfcfpFrame {
  let result = chem_desc_fcfp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_frame_fill(s : ChemdescfcfpFrame, v : Double) -> ChemdescfcfpFrame {
  let result = chem_desc_fcfp_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_frame_min(s : ChemdescfcfpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_frame_max(s : ChemdescfcfpFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_frame_to_string(s : ChemdescfcfpFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_table_make(size : Int) -> ChemdescfcfpTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_table_len(s : ChemdescfcfpTable) -> Int { s.size }

pub fn chem_desc_fcfp_table_get(s : ChemdescfcfpTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_table_set(s : ChemdescfcfpTable, i : Int, v : Double) -> ChemdescfcfpTable {
  let result = chem_desc_fcfp_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_table_sum(s : ChemdescfcfpTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_table_mean(s : ChemdescfcfpTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_table_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_table_scale(s : ChemdescfcfpTable, f : Double) -> ChemdescfcfpTable {
  let result = chem_desc_fcfp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_table_add(a : ChemdescfcfpTable, b : ChemdescfcfpTable) -> ChemdescfcfpTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_table_copy(s : ChemdescfcfpTable) -> ChemdescfcfpTable {
  let result = chem_desc_fcfp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_table_fill(s : ChemdescfcfpTable, v : Double) -> ChemdescfcfpTable {
  let result = chem_desc_fcfp_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_table_min(s : ChemdescfcfpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_table_max(s : ChemdescfcfpTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_table_to_string(s : ChemdescfcfpTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_graphn_make(size : Int) -> ChemdescfcfpGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_graphn_len(s : ChemdescfcfpGraphN) -> Int { s.size }

pub fn chem_desc_fcfp_graphn_get(s : ChemdescfcfpGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_graphn_set(s : ChemdescfcfpGraphN, i : Int, v : Double) -> ChemdescfcfpGraphN {
  let result = chem_desc_fcfp_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_graphn_sum(s : ChemdescfcfpGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_graphn_mean(s : ChemdescfcfpGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_graphn_scale(s : ChemdescfcfpGraphN, f : Double) -> ChemdescfcfpGraphN {
  let result = chem_desc_fcfp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_graphn_add(a : ChemdescfcfpGraphN, b : ChemdescfcfpGraphN) -> ChemdescfcfpGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_graphn_copy(s : ChemdescfcfpGraphN) -> ChemdescfcfpGraphN {
  let result = chem_desc_fcfp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_graphn_fill(s : ChemdescfcfpGraphN, v : Double) -> ChemdescfcfpGraphN {
  let result = chem_desc_fcfp_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_graphn_min(s : ChemdescfcfpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_graphn_max(s : ChemdescfcfpGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_graphn_to_string(s : ChemdescfcfpGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_node_make(size : Int) -> ChemdescfcfpNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_node_len(s : ChemdescfcfpNode) -> Int { s.size }

pub fn chem_desc_fcfp_node_get(s : ChemdescfcfpNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_node_set(s : ChemdescfcfpNode, i : Int, v : Double) -> ChemdescfcfpNode {
  let result = chem_desc_fcfp_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_node_sum(s : ChemdescfcfpNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_node_mean(s : ChemdescfcfpNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_node_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_node_scale(s : ChemdescfcfpNode, f : Double) -> ChemdescfcfpNode {
  let result = chem_desc_fcfp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_node_add(a : ChemdescfcfpNode, b : ChemdescfcfpNode) -> ChemdescfcfpNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_node_copy(s : ChemdescfcfpNode) -> ChemdescfcfpNode {
  let result = chem_desc_fcfp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_node_fill(s : ChemdescfcfpNode, v : Double) -> ChemdescfcfpNode {
  let result = chem_desc_fcfp_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_node_min(s : ChemdescfcfpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_node_max(s : ChemdescfcfpNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_node_to_string(s : ChemdescfcfpNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_edge_make(size : Int) -> ChemdescfcfpEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_edge_len(s : ChemdescfcfpEdge) -> Int { s.size }

pub fn chem_desc_fcfp_edge_get(s : ChemdescfcfpEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_edge_set(s : ChemdescfcfpEdge, i : Int, v : Double) -> ChemdescfcfpEdge {
  let result = chem_desc_fcfp_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_edge_sum(s : ChemdescfcfpEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_edge_mean(s : ChemdescfcfpEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_edge_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_edge_scale(s : ChemdescfcfpEdge, f : Double) -> ChemdescfcfpEdge {
  let result = chem_desc_fcfp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_edge_add(a : ChemdescfcfpEdge, b : ChemdescfcfpEdge) -> ChemdescfcfpEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_edge_copy(s : ChemdescfcfpEdge) -> ChemdescfcfpEdge {
  let result = chem_desc_fcfp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_edge_fill(s : ChemdescfcfpEdge, v : Double) -> ChemdescfcfpEdge {
  let result = chem_desc_fcfp_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_edge_min(s : ChemdescfcfpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_edge_max(s : ChemdescfcfpEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_edge_to_string(s : ChemdescfcfpEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_path_make(size : Int) -> ChemdescfcfpPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_path_len(s : ChemdescfcfpPath) -> Int { s.size }

pub fn chem_desc_fcfp_path_get(s : ChemdescfcfpPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_path_set(s : ChemdescfcfpPath, i : Int, v : Double) -> ChemdescfcfpPath {
  let result = chem_desc_fcfp_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_path_sum(s : ChemdescfcfpPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_path_mean(s : ChemdescfcfpPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_path_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_path_scale(s : ChemdescfcfpPath, f : Double) -> ChemdescfcfpPath {
  let result = chem_desc_fcfp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_path_add(a : ChemdescfcfpPath, b : ChemdescfcfpPath) -> ChemdescfcfpPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_path_copy(s : ChemdescfcfpPath) -> ChemdescfcfpPath {
  let result = chem_desc_fcfp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_path_fill(s : ChemdescfcfpPath, v : Double) -> ChemdescfcfpPath {
  let result = chem_desc_fcfp_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_path_min(s : ChemdescfcfpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_path_max(s : ChemdescfcfpPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_path_to_string(s : ChemdescfcfpPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_cluster_make(size : Int) -> ChemdescfcfpCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_cluster_len(s : ChemdescfcfpCluster) -> Int { s.size }

pub fn chem_desc_fcfp_cluster_get(s : ChemdescfcfpCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_cluster_set(s : ChemdescfcfpCluster, i : Int, v : Double) -> ChemdescfcfpCluster {
  let result = chem_desc_fcfp_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_cluster_sum(s : ChemdescfcfpCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_cluster_mean(s : ChemdescfcfpCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_cluster_scale(s : ChemdescfcfpCluster, f : Double) -> ChemdescfcfpCluster {
  let result = chem_desc_fcfp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_cluster_add(a : ChemdescfcfpCluster, b : ChemdescfcfpCluster) -> ChemdescfcfpCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_cluster_copy(s : ChemdescfcfpCluster) -> ChemdescfcfpCluster {
  let result = chem_desc_fcfp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_cluster_fill(s : ChemdescfcfpCluster, v : Double) -> ChemdescfcfpCluster {
  let result = chem_desc_fcfp_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_cluster_min(s : ChemdescfcfpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_cluster_max(s : ChemdescfcfpCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_cluster_to_string(s : ChemdescfcfpCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_model_make(size : Int) -> ChemdescfcfpModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_model_len(s : ChemdescfcfpModel) -> Int { s.size }

pub fn chem_desc_fcfp_model_get(s : ChemdescfcfpModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_model_set(s : ChemdescfcfpModel, i : Int, v : Double) -> ChemdescfcfpModel {
  let result = chem_desc_fcfp_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_model_sum(s : ChemdescfcfpModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_model_mean(s : ChemdescfcfpModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_model_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_model_scale(s : ChemdescfcfpModel, f : Double) -> ChemdescfcfpModel {
  let result = chem_desc_fcfp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_model_add(a : ChemdescfcfpModel, b : ChemdescfcfpModel) -> ChemdescfcfpModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_model_copy(s : ChemdescfcfpModel) -> ChemdescfcfpModel {
  let result = chem_desc_fcfp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_model_fill(s : ChemdescfcfpModel, v : Double) -> ChemdescfcfpModel {
  let result = chem_desc_fcfp_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_model_min(s : ChemdescfcfpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_model_max(s : ChemdescfcfpModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_model_to_string(s : ChemdescfcfpModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_layer_make(size : Int) -> ChemdescfcfpLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_layer_len(s : ChemdescfcfpLayer) -> Int { s.size }

pub fn chem_desc_fcfp_layer_get(s : ChemdescfcfpLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_layer_set(s : ChemdescfcfpLayer, i : Int, v : Double) -> ChemdescfcfpLayer {
  let result = chem_desc_fcfp_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_layer_sum(s : ChemdescfcfpLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_layer_mean(s : ChemdescfcfpLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_layer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_layer_scale(s : ChemdescfcfpLayer, f : Double) -> ChemdescfcfpLayer {
  let result = chem_desc_fcfp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_layer_add(a : ChemdescfcfpLayer, b : ChemdescfcfpLayer) -> ChemdescfcfpLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_layer_copy(s : ChemdescfcfpLayer) -> ChemdescfcfpLayer {
  let result = chem_desc_fcfp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_layer_fill(s : ChemdescfcfpLayer, v : Double) -> ChemdescfcfpLayer {
  let result = chem_desc_fcfp_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_layer_min(s : ChemdescfcfpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_layer_max(s : ChemdescfcfpLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_layer_to_string(s : ChemdescfcfpLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_buffer_make(size : Int) -> ChemdescfcfpBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_buffer_len(s : ChemdescfcfpBuffer) -> Int { s.size }

pub fn chem_desc_fcfp_buffer_get(s : ChemdescfcfpBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_buffer_set(s : ChemdescfcfpBuffer, i : Int, v : Double) -> ChemdescfcfpBuffer {
  let result = chem_desc_fcfp_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_buffer_sum(s : ChemdescfcfpBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_buffer_mean(s : ChemdescfcfpBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_buffer_scale(s : ChemdescfcfpBuffer, f : Double) -> ChemdescfcfpBuffer {
  let result = chem_desc_fcfp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_buffer_add(a : ChemdescfcfpBuffer, b : ChemdescfcfpBuffer) -> ChemdescfcfpBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_buffer_copy(s : ChemdescfcfpBuffer) -> ChemdescfcfpBuffer {
  let result = chem_desc_fcfp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_buffer_fill(s : ChemdescfcfpBuffer, v : Double) -> ChemdescfcfpBuffer {
  let result = chem_desc_fcfp_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_buffer_min(s : ChemdescfcfpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_buffer_max(s : ChemdescfcfpBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_buffer_to_string(s : ChemdescfcfpBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_cursor_make(size : Int) -> ChemdescfcfpCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_cursor_len(s : ChemdescfcfpCursor) -> Int { s.size }

pub fn chem_desc_fcfp_cursor_get(s : ChemdescfcfpCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_cursor_set(s : ChemdescfcfpCursor, i : Int, v : Double) -> ChemdescfcfpCursor {
  let result = chem_desc_fcfp_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_cursor_sum(s : ChemdescfcfpCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_cursor_mean(s : ChemdescfcfpCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_cursor_scale(s : ChemdescfcfpCursor, f : Double) -> ChemdescfcfpCursor {
  let result = chem_desc_fcfp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_cursor_add(a : ChemdescfcfpCursor, b : ChemdescfcfpCursor) -> ChemdescfcfpCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_cursor_copy(s : ChemdescfcfpCursor) -> ChemdescfcfpCursor {
  let result = chem_desc_fcfp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_cursor_fill(s : ChemdescfcfpCursor, v : Double) -> ChemdescfcfpCursor {
  let result = chem_desc_fcfp_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_cursor_min(s : ChemdescfcfpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_cursor_max(s : ChemdescfcfpCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_cursor_to_string(s : ChemdescfcfpCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_view_make(size : Int) -> ChemdescfcfpView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_view_len(s : ChemdescfcfpView) -> Int { s.size }

pub fn chem_desc_fcfp_view_get(s : ChemdescfcfpView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_view_set(s : ChemdescfcfpView, i : Int, v : Double) -> ChemdescfcfpView {
  let result = chem_desc_fcfp_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_view_sum(s : ChemdescfcfpView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_view_mean(s : ChemdescfcfpView) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_view_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_view_scale(s : ChemdescfcfpView, f : Double) -> ChemdescfcfpView {
  let result = chem_desc_fcfp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_view_add(a : ChemdescfcfpView, b : ChemdescfcfpView) -> ChemdescfcfpView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_view_copy(s : ChemdescfcfpView) -> ChemdescfcfpView {
  let result = chem_desc_fcfp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_view_fill(s : ChemdescfcfpView, v : Double) -> ChemdescfcfpView {
  let result = chem_desc_fcfp_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_view_min(s : ChemdescfcfpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_view_max(s : ChemdescfcfpView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_view_to_string(s : ChemdescfcfpView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_range_make(size : Int) -> ChemdescfcfpRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_range_len(s : ChemdescfcfpRange) -> Int { s.size }

pub fn chem_desc_fcfp_range_get(s : ChemdescfcfpRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_range_set(s : ChemdescfcfpRange, i : Int, v : Double) -> ChemdescfcfpRange {
  let result = chem_desc_fcfp_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_range_sum(s : ChemdescfcfpRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_range_mean(s : ChemdescfcfpRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_range_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_range_scale(s : ChemdescfcfpRange, f : Double) -> ChemdescfcfpRange {
  let result = chem_desc_fcfp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_range_add(a : ChemdescfcfpRange, b : ChemdescfcfpRange) -> ChemdescfcfpRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_range_copy(s : ChemdescfcfpRange) -> ChemdescfcfpRange {
  let result = chem_desc_fcfp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_range_fill(s : ChemdescfcfpRange, v : Double) -> ChemdescfcfpRange {
  let result = chem_desc_fcfp_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_range_min(s : ChemdescfcfpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_range_max(s : ChemdescfcfpRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_range_to_string(s : ChemdescfcfpRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdescfcfpSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_fcfp_slice_make(size : Int) -> ChemdescfcfpSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_fcfp_slice_len(s : ChemdescfcfpSlice) -> Int { s.size }

pub fn chem_desc_fcfp_slice_get(s : ChemdescfcfpSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_fcfp_slice_set(s : ChemdescfcfpSlice, i : Int, v : Double) -> ChemdescfcfpSlice {
  let result = chem_desc_fcfp_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_slice_sum(s : ChemdescfcfpSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_fcfp_slice_mean(s : ChemdescfcfpSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_fcfp_slice_sum(s) / s.size.to_double() }
}

pub fn chem_desc_fcfp_slice_scale(s : ChemdescfcfpSlice, f : Double) -> ChemdescfcfpSlice {
  let result = chem_desc_fcfp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_fcfp_slice_add(a : ChemdescfcfpSlice, b : ChemdescfcfpSlice) -> ChemdescfcfpSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_fcfp_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_fcfp_slice_copy(s : ChemdescfcfpSlice) -> ChemdescfcfpSlice {
  let result = chem_desc_fcfp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_fcfp_slice_fill(s : ChemdescfcfpSlice, v : Double) -> ChemdescfcfpSlice {
  let result = chem_desc_fcfp_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_fcfp_slice_min(s : ChemdescfcfpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_slice_max(s : ChemdescfcfpSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_fcfp_slice_to_string(s : ChemdescfcfpSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_desc_fcfp_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_fcfp_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

