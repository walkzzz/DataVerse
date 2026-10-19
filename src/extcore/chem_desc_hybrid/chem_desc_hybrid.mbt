///===
/// extcore/chem_desc_hybrid

pub(all) struct ChemdeschybridPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn chem_desc_hybrid_make_point(x : Double, y : Double) -> ChemdeschybridPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn chem_desc_hybrid_make_point3(x : Double, y : Double, z : Double) -> ChemdeschybridPoint {
  { x, y, z, label: 0 }
}

pub fn chem_desc_hybrid_point_x(pt : ChemdeschybridPoint) -> Double { pt.x }

pub fn chem_desc_hybrid_point_y(pt : ChemdeschybridPoint) -> Double { pt.y }

pub fn chem_desc_hybrid_point_z(pt : ChemdeschybridPoint) -> Double { pt.z }

pub fn chem_desc_hybrid_point_label(pt : ChemdeschybridPoint) -> Int { pt.label }

pub fn chem_desc_hybrid_point_dist(a : ChemdeschybridPoint, b : ChemdeschybridPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  chem_desc_hybrid_sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn chem_desc_hybrid_point_add(a : ChemdeschybridPoint, b : ChemdeschybridPoint) -> ChemdeschybridPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn chem_desc_hybrid_point_sub(a : ChemdeschybridPoint, b : ChemdeschybridPoint) -> ChemdeschybridPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn chem_desc_hybrid_point_scale(pt : ChemdeschybridPoint, s : Double) -> ChemdeschybridPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn chem_desc_hybrid_point_dot(a : ChemdeschybridPoint, b : ChemdeschybridPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn chem_desc_hybrid_point_cross(a : ChemdeschybridPoint, b : ChemdeschybridPoint) -> ChemdeschybridPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn chem_desc_hybrid_point_norm(pt : ChemdeschybridPoint) -> Double {
  chem_desc_hybrid_sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn chem_desc_hybrid_point_normalize(pt : ChemdeschybridPoint) -> ChemdeschybridPoint {
  let n = chem_desc_hybrid_point_norm(pt)
  if n < 0.0000001 { pt } else { chem_desc_hybrid_point_scale(pt, 1.0 / n) }
}

pub fn chem_desc_hybrid_point_negate(pt : ChemdeschybridPoint) -> ChemdeschybridPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn chem_desc_hybrid_point_mid(a : ChemdeschybridPoint, b : ChemdeschybridPoint) -> ChemdeschybridPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn chem_desc_hybrid_point_lerp(a : ChemdeschybridPoint, b : ChemdeschybridPoint, t : Double) -> ChemdeschybridPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn chem_desc_hybrid_point_to_string(pt : ChemdeschybridPoint) -> String {
  "(" + chem_desc_hybrid_dbl(pt.x) + ", " + chem_desc_hybrid_dbl(pt.y) + ", " + chem_desc_hybrid_dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct ChemdeschybridSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn chem_desc_hybrid_make_series(vals : Array[Double], name : String) -> ChemdeschybridSeries {
  { vals, name, meta: 0 }
}

pub fn chem_desc_hybrid_series_len(s : ChemdeschybridSeries) -> Int { s.vals.length() }

pub fn chem_desc_hybrid_series_sum(s : ChemdeschybridSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn chem_desc_hybrid_series_mean(s : ChemdeschybridSeries) -> Double {
  let n = chem_desc_hybrid_series_len(s)
  if n == 0 { 0.0 } else { chem_desc_hybrid_series_sum(s) / n.to_double() }
}

pub fn chem_desc_hybrid_series_min(s : ChemdeschybridSeries) -> Double {
  let n = chem_desc_hybrid_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_hybrid_series_max(s : ChemdeschybridSeries) -> Double {
  let n = chem_desc_hybrid_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn chem_desc_hybrid_series_range(s : ChemdeschybridSeries) -> Double {
  chem_desc_hybrid_series_max(s) - chem_desc_hybrid_series_min(s)
}

pub fn chem_desc_hybrid_series_var(s : ChemdeschybridSeries) -> Double {
  let n = chem_desc_hybrid_series_len(s)
  if n == 0 { 0.0 } else {
    let m = chem_desc_hybrid_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn chem_desc_hybrid_series_std(s : ChemdeschybridSeries) -> Double { chem_desc_hybrid_sqrt(chem_desc_hybrid_series_var(s)) }

pub fn chem_desc_hybrid_series_median(s : ChemdeschybridSeries) -> Double {
  let n = chem_desc_hybrid_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = chem_desc_hybrid_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_desc_hybrid_series_scale(s : ChemdeschybridSeries, f : Double) -> ChemdeschybridSeries {
  let mut result = []
  for i in 0..<s.vals.length() { result = chem_desc_hybrid_push(result, s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn chem_desc_hybrid_series_add(a : ChemdeschybridSeries, b : ChemdeschybridSeries) -> ChemdeschybridSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_desc_hybrid_push(result, a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn chem_desc_hybrid_series_sub(a : ChemdeschybridSeries, b : ChemdeschybridSeries) -> ChemdeschybridSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let mut result = []
  for i in 0..<n { result = chem_desc_hybrid_push(result, a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn chem_desc_hybrid_series_normalize(s : ChemdeschybridSeries) -> ChemdeschybridSeries {
  let mn = chem_desc_hybrid_series_min(s)
  let mx = chem_desc_hybrid_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let mut result = []
    for i in 0..<s.vals.length() { result = chem_desc_hybrid_push(result, (s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn chem_desc_hybrid_series_cumsum(s : ChemdeschybridSeries) -> ChemdeschybridSeries {
  let mut result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result = chem_desc_hybrid_push(result, total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn chem_desc_hybrid_series_to_string(s : ChemdeschybridSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_desc_hybrid_dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct ChemdeschybridMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn chem_desc_hybrid_make_matrix(rows : Int, cols : Int, val : Double) -> ChemdeschybridMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn chem_desc_hybrid_matrix_identity(n : Int) -> ChemdeschybridMatrix {
  let m = chem_desc_hybrid_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn chem_desc_hybrid_matrix_get(m : ChemdeschybridMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn chem_desc_hybrid_matrix_transpose(m : ChemdeschybridMatrix) -> ChemdeschybridMatrix {
  let result = chem_desc_hybrid_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn chem_desc_hybrid_matrix_add(a : ChemdeschybridMatrix, b : ChemdeschybridMatrix) -> ChemdeschybridMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = chem_desc_hybrid_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn chem_desc_hybrid_matrix_scale(m : ChemdeschybridMatrix, s : Double) -> ChemdeschybridMatrix {
  let result = chem_desc_hybrid_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn chem_desc_hybrid_matrix_multiply(a : ChemdeschybridMatrix, b : ChemdeschybridMatrix) -> ChemdeschybridMatrix {
  if a.cols != b.rows { return chem_desc_hybrid_make_matrix(a.rows, b.cols, 0.0) }
  let result = chem_desc_hybrid_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn chem_desc_hybrid_matrix_trace(m : ChemdeschybridMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn chem_desc_hybrid_matrix_det(m : ChemdeschybridMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn chem_desc_hybrid_matrix_norm(m : ChemdeschybridMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  chem_desc_hybrid_sqrt(sum)
}

pub fn chem_desc_hybrid_matrix_to_string(m : ChemdeschybridMatrix) -> String {
  let mut result = "Mat(" + m.rows.to_string() + "x" + m.cols.to_string() + ")\n"
  let rl = if m.rows < 5 { m.rows } else { 5 }
  let cl = if m.cols < 5 { m.cols } else { 5 }
  for i in 0..<rl {
    result = result + "  ["
    for j in 0..<cl { if j > 0 { result = result + ", " }; result = result + chem_desc_hybrid_dbl(m.data[i][j]) }
    result = result + "]\n"
  }
  result
}

pub(all) struct ChemdeschybridVector {
  comps : Array[Double]
  dim : Int
}

pub fn chem_desc_hybrid_make_vector(comps : Array[Double]) -> ChemdeschybridVector {
  { comps, dim: comps.length() }
}

pub fn chem_desc_hybrid_vector_zero(dim : Int) -> ChemdeschybridVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn chem_desc_hybrid_vector_add(a : ChemdeschybridVector, b : ChemdeschybridVector) -> ChemdeschybridVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_desc_hybrid_push(result, a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_hybrid_vector_sub(a : ChemdeschybridVector, b : ChemdeschybridVector) -> ChemdeschybridVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut result = []
  for i in 0..<n { result = chem_desc_hybrid_push(result, a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn chem_desc_hybrid_vector_scale(v : ChemdeschybridVector, s : Double) -> ChemdeschybridVector {
  let mut result = []
  for i in 0..<v.dim { result = chem_desc_hybrid_push(result, v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn chem_desc_hybrid_vector_dot(a : ChemdeschybridVector, b : ChemdeschybridVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn chem_desc_hybrid_vector_norm(v : ChemdeschybridVector) -> Double { chem_desc_hybrid_sqrt(chem_desc_hybrid_vector_dot(v, v)) }

pub fn chem_desc_hybrid_vector_normalize(v : ChemdeschybridVector) -> ChemdeschybridVector {
  let n = chem_desc_hybrid_vector_norm(v)
  if n < 0.0000001 { v } else { chem_desc_hybrid_vector_scale(v, 1.0 / n) }
}

pub fn chem_desc_hybrid_vector_dist(a : ChemdeschybridVector, b : ChemdeschybridVector) -> Double {
  chem_desc_hybrid_vector_norm(chem_desc_hybrid_vector_sub(a, b))
}

pub fn chem_desc_hybrid_vector_to_string(v : ChemdeschybridVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + chem_desc_hybrid_dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn chem_desc_hybrid_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn chem_desc_hybrid_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = chem_desc_hybrid_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_desc_hybrid_std(data : Array[Double]) -> Double { chem_desc_hybrid_sqrt(chem_desc_hybrid_var(data)) }

pub fn chem_desc_hybrid_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = chem_desc_hybrid_mean(a); let mb = chem_desc_hybrid_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn chem_desc_hybrid_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = chem_desc_hybrid_std(a); let sb = chem_desc_hybrid_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { chem_desc_hybrid_cov(a, b) / (sa * sb) }
}

pub fn chem_desc_hybrid_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = chem_desc_hybrid_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn chem_desc_hybrid_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn chem_desc_hybrid_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn chem_desc_hybrid_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  chem_desc_hybrid_sqrt(chem_desc_hybrid_mse(pred, labels))
}

pub fn chem_desc_hybrid_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + chem_desc_hybrid_abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn chem_desc_hybrid_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = chem_desc_hybrid_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn chem_desc_hybrid_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn chem_desc_hybrid_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn chem_desc_hybrid_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = chem_desc_hybrid_precision(pred, labels, pos); let r = chem_desc_hybrid_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn chem_desc_hybrid_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn chem_desc_hybrid_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = chem_desc_hybrid_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn chem_desc_hybrid_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn chem_desc_hybrid_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn chem_desc_hybrid_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = chem_desc_hybrid_gcd(a, b)
    (a / g) * b
  }
}

pub fn chem_desc_hybrid_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn chem_desc_hybrid_fibonacci(n : Int) -> Int {
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

pub fn chem_desc_hybrid_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = chem_desc_hybrid_min(data); let mx = chem_desc_hybrid_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn chem_desc_hybrid_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = chem_desc_hybrid_mean(data); let sd = chem_desc_hybrid_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn chem_desc_hybrid_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn chem_desc_hybrid_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn chem_desc_hybrid_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn chem_desc_hybrid_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

fn chem_desc_hybrid_sqrt(x : Double) -> Double {
  if x <= 0.0 { 0.0 } else {
    let mut g = x / 2.0
    if g < 1.0 { g = 1.0 }
    for _ in 0..<50 { g = (g + x / g) / 2.0 }
    g
  }
}

fn chem_desc_hybrid_abs(x : Double) -> Double { if x < 0.0 { -x } else { x } }

fn chem_desc_hybrid_dbl(x : Double) -> String {
  let i = if x >= 0.0 { chem_desc_hybrid_int(x) } else { -chem_desc_hybrid_int(-x) }
  let f = x - i.to_double()
  let fi = if f >= 0.0 { chem_desc_hybrid_int(f * 1000000.0) } else { chem_desc_hybrid_int(-f * 1000000.0) }
  i.to_string() + "." + fi.to_string()
}

fn chem_desc_hybrid_int(x : Double) -> Int {
  let mut n = 0; let mut d = x
  while d >= 1.0 { n = n + 1; d = d - 1.0 }
  n
}

fn chem_desc_hybrid_push(arr : Array[Double], v : Double) -> Array[Double] {
  let n = arr.length()
  let result = Array::make(n + 1, 0.0)
  for i in 0..<n { result[i] = arr[i] }
  result[n] = v
  result
}

pub(all) struct ChemdeschybridFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_frame_make(size : Int) -> ChemdeschybridFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_frame_len(s : ChemdeschybridFrame) -> Int { s.size }

pub fn chem_desc_hybrid_frame_get(s : ChemdeschybridFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_frame_set(s : ChemdeschybridFrame, i : Int, v : Double) -> ChemdeschybridFrame {
  let result = chem_desc_hybrid_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_frame_sum(s : ChemdeschybridFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_frame_mean(s : ChemdeschybridFrame) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_frame_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_frame_scale(s : ChemdeschybridFrame, f : Double) -> ChemdeschybridFrame {
  let result = chem_desc_hybrid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_frame_add(a : ChemdeschybridFrame, b : ChemdeschybridFrame) -> ChemdeschybridFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_frame_copy(s : ChemdeschybridFrame) -> ChemdeschybridFrame {
  let result = chem_desc_hybrid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_frame_fill(s : ChemdeschybridFrame, v : Double) -> ChemdeschybridFrame {
  let result = chem_desc_hybrid_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_frame_min(s : ChemdeschybridFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_frame_max(s : ChemdeschybridFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_frame_to_string(s : ChemdeschybridFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_table_make(size : Int) -> ChemdeschybridTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_table_len(s : ChemdeschybridTable) -> Int { s.size }

pub fn chem_desc_hybrid_table_get(s : ChemdeschybridTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_table_set(s : ChemdeschybridTable, i : Int, v : Double) -> ChemdeschybridTable {
  let result = chem_desc_hybrid_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_table_sum(s : ChemdeschybridTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_table_mean(s : ChemdeschybridTable) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_table_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_table_scale(s : ChemdeschybridTable, f : Double) -> ChemdeschybridTable {
  let result = chem_desc_hybrid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_table_add(a : ChemdeschybridTable, b : ChemdeschybridTable) -> ChemdeschybridTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_table_copy(s : ChemdeschybridTable) -> ChemdeschybridTable {
  let result = chem_desc_hybrid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_table_fill(s : ChemdeschybridTable, v : Double) -> ChemdeschybridTable {
  let result = chem_desc_hybrid_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_table_min(s : ChemdeschybridTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_table_max(s : ChemdeschybridTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_table_to_string(s : ChemdeschybridTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_graphn_make(size : Int) -> ChemdeschybridGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_graphn_len(s : ChemdeschybridGraphN) -> Int { s.size }

pub fn chem_desc_hybrid_graphn_get(s : ChemdeschybridGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_graphn_set(s : ChemdeschybridGraphN, i : Int, v : Double) -> ChemdeschybridGraphN {
  let result = chem_desc_hybrid_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_graphn_sum(s : ChemdeschybridGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_graphn_mean(s : ChemdeschybridGraphN) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_graphn_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_graphn_scale(s : ChemdeschybridGraphN, f : Double) -> ChemdeschybridGraphN {
  let result = chem_desc_hybrid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_graphn_add(a : ChemdeschybridGraphN, b : ChemdeschybridGraphN) -> ChemdeschybridGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_graphn_copy(s : ChemdeschybridGraphN) -> ChemdeschybridGraphN {
  let result = chem_desc_hybrid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_graphn_fill(s : ChemdeschybridGraphN, v : Double) -> ChemdeschybridGraphN {
  let result = chem_desc_hybrid_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_graphn_min(s : ChemdeschybridGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_graphn_max(s : ChemdeschybridGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_graphn_to_string(s : ChemdeschybridGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_node_make(size : Int) -> ChemdeschybridNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_node_len(s : ChemdeschybridNode) -> Int { s.size }

pub fn chem_desc_hybrid_node_get(s : ChemdeschybridNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_node_set(s : ChemdeschybridNode, i : Int, v : Double) -> ChemdeschybridNode {
  let result = chem_desc_hybrid_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_node_sum(s : ChemdeschybridNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_node_mean(s : ChemdeschybridNode) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_node_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_node_scale(s : ChemdeschybridNode, f : Double) -> ChemdeschybridNode {
  let result = chem_desc_hybrid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_node_add(a : ChemdeschybridNode, b : ChemdeschybridNode) -> ChemdeschybridNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_node_copy(s : ChemdeschybridNode) -> ChemdeschybridNode {
  let result = chem_desc_hybrid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_node_fill(s : ChemdeschybridNode, v : Double) -> ChemdeschybridNode {
  let result = chem_desc_hybrid_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_node_min(s : ChemdeschybridNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_node_max(s : ChemdeschybridNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_node_to_string(s : ChemdeschybridNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_edge_make(size : Int) -> ChemdeschybridEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_edge_len(s : ChemdeschybridEdge) -> Int { s.size }

pub fn chem_desc_hybrid_edge_get(s : ChemdeschybridEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_edge_set(s : ChemdeschybridEdge, i : Int, v : Double) -> ChemdeschybridEdge {
  let result = chem_desc_hybrid_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_edge_sum(s : ChemdeschybridEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_edge_mean(s : ChemdeschybridEdge) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_edge_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_edge_scale(s : ChemdeschybridEdge, f : Double) -> ChemdeschybridEdge {
  let result = chem_desc_hybrid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_edge_add(a : ChemdeschybridEdge, b : ChemdeschybridEdge) -> ChemdeschybridEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_edge_copy(s : ChemdeschybridEdge) -> ChemdeschybridEdge {
  let result = chem_desc_hybrid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_edge_fill(s : ChemdeschybridEdge, v : Double) -> ChemdeschybridEdge {
  let result = chem_desc_hybrid_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_edge_min(s : ChemdeschybridEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_edge_max(s : ChemdeschybridEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_edge_to_string(s : ChemdeschybridEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_path_make(size : Int) -> ChemdeschybridPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_path_len(s : ChemdeschybridPath) -> Int { s.size }

pub fn chem_desc_hybrid_path_get(s : ChemdeschybridPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_path_set(s : ChemdeschybridPath, i : Int, v : Double) -> ChemdeschybridPath {
  let result = chem_desc_hybrid_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_path_sum(s : ChemdeschybridPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_path_mean(s : ChemdeschybridPath) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_path_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_path_scale(s : ChemdeschybridPath, f : Double) -> ChemdeschybridPath {
  let result = chem_desc_hybrid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_path_add(a : ChemdeschybridPath, b : ChemdeschybridPath) -> ChemdeschybridPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_path_copy(s : ChemdeschybridPath) -> ChemdeschybridPath {
  let result = chem_desc_hybrid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_path_fill(s : ChemdeschybridPath, v : Double) -> ChemdeschybridPath {
  let result = chem_desc_hybrid_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_path_min(s : ChemdeschybridPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_path_max(s : ChemdeschybridPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_path_to_string(s : ChemdeschybridPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_cluster_make(size : Int) -> ChemdeschybridCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_cluster_len(s : ChemdeschybridCluster) -> Int { s.size }

pub fn chem_desc_hybrid_cluster_get(s : ChemdeschybridCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_cluster_set(s : ChemdeschybridCluster, i : Int, v : Double) -> ChemdeschybridCluster {
  let result = chem_desc_hybrid_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_cluster_sum(s : ChemdeschybridCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_cluster_mean(s : ChemdeschybridCluster) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_cluster_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_cluster_scale(s : ChemdeschybridCluster, f : Double) -> ChemdeschybridCluster {
  let result = chem_desc_hybrid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_cluster_add(a : ChemdeschybridCluster, b : ChemdeschybridCluster) -> ChemdeschybridCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_cluster_copy(s : ChemdeschybridCluster) -> ChemdeschybridCluster {
  let result = chem_desc_hybrid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_cluster_fill(s : ChemdeschybridCluster, v : Double) -> ChemdeschybridCluster {
  let result = chem_desc_hybrid_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_cluster_min(s : ChemdeschybridCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_cluster_max(s : ChemdeschybridCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_cluster_to_string(s : ChemdeschybridCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_model_make(size : Int) -> ChemdeschybridModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_model_len(s : ChemdeschybridModel) -> Int { s.size }

pub fn chem_desc_hybrid_model_get(s : ChemdeschybridModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_model_set(s : ChemdeschybridModel, i : Int, v : Double) -> ChemdeschybridModel {
  let result = chem_desc_hybrid_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_model_sum(s : ChemdeschybridModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_model_mean(s : ChemdeschybridModel) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_model_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_model_scale(s : ChemdeschybridModel, f : Double) -> ChemdeschybridModel {
  let result = chem_desc_hybrid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_model_add(a : ChemdeschybridModel, b : ChemdeschybridModel) -> ChemdeschybridModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_model_copy(s : ChemdeschybridModel) -> ChemdeschybridModel {
  let result = chem_desc_hybrid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_model_fill(s : ChemdeschybridModel, v : Double) -> ChemdeschybridModel {
  let result = chem_desc_hybrid_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_model_min(s : ChemdeschybridModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_model_max(s : ChemdeschybridModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_model_to_string(s : ChemdeschybridModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_layer_make(size : Int) -> ChemdeschybridLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_layer_len(s : ChemdeschybridLayer) -> Int { s.size }

pub fn chem_desc_hybrid_layer_get(s : ChemdeschybridLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_layer_set(s : ChemdeschybridLayer, i : Int, v : Double) -> ChemdeschybridLayer {
  let result = chem_desc_hybrid_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_layer_sum(s : ChemdeschybridLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_layer_mean(s : ChemdeschybridLayer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_layer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_layer_scale(s : ChemdeschybridLayer, f : Double) -> ChemdeschybridLayer {
  let result = chem_desc_hybrid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_layer_add(a : ChemdeschybridLayer, b : ChemdeschybridLayer) -> ChemdeschybridLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_layer_copy(s : ChemdeschybridLayer) -> ChemdeschybridLayer {
  let result = chem_desc_hybrid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_layer_fill(s : ChemdeschybridLayer, v : Double) -> ChemdeschybridLayer {
  let result = chem_desc_hybrid_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_layer_min(s : ChemdeschybridLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_layer_max(s : ChemdeschybridLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_layer_to_string(s : ChemdeschybridLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_buffer_make(size : Int) -> ChemdeschybridBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_buffer_len(s : ChemdeschybridBuffer) -> Int { s.size }

pub fn chem_desc_hybrid_buffer_get(s : ChemdeschybridBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_buffer_set(s : ChemdeschybridBuffer, i : Int, v : Double) -> ChemdeschybridBuffer {
  let result = chem_desc_hybrid_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_buffer_sum(s : ChemdeschybridBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_buffer_mean(s : ChemdeschybridBuffer) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_buffer_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_buffer_scale(s : ChemdeschybridBuffer, f : Double) -> ChemdeschybridBuffer {
  let result = chem_desc_hybrid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_buffer_add(a : ChemdeschybridBuffer, b : ChemdeschybridBuffer) -> ChemdeschybridBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_buffer_copy(s : ChemdeschybridBuffer) -> ChemdeschybridBuffer {
  let result = chem_desc_hybrid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_buffer_fill(s : ChemdeschybridBuffer, v : Double) -> ChemdeschybridBuffer {
  let result = chem_desc_hybrid_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_buffer_min(s : ChemdeschybridBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_buffer_max(s : ChemdeschybridBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_buffer_to_string(s : ChemdeschybridBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_cursor_make(size : Int) -> ChemdeschybridCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_cursor_len(s : ChemdeschybridCursor) -> Int { s.size }

pub fn chem_desc_hybrid_cursor_get(s : ChemdeschybridCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_cursor_set(s : ChemdeschybridCursor, i : Int, v : Double) -> ChemdeschybridCursor {
  let result = chem_desc_hybrid_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_cursor_sum(s : ChemdeschybridCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_cursor_mean(s : ChemdeschybridCursor) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_cursor_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_cursor_scale(s : ChemdeschybridCursor, f : Double) -> ChemdeschybridCursor {
  let result = chem_desc_hybrid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_cursor_add(a : ChemdeschybridCursor, b : ChemdeschybridCursor) -> ChemdeschybridCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_cursor_copy(s : ChemdeschybridCursor) -> ChemdeschybridCursor {
  let result = chem_desc_hybrid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_cursor_fill(s : ChemdeschybridCursor, v : Double) -> ChemdeschybridCursor {
  let result = chem_desc_hybrid_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_cursor_min(s : ChemdeschybridCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_cursor_max(s : ChemdeschybridCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_cursor_to_string(s : ChemdeschybridCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_view_make(size : Int) -> ChemdeschybridView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_view_len(s : ChemdeschybridView) -> Int { s.size }

pub fn chem_desc_hybrid_view_get(s : ChemdeschybridView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_view_set(s : ChemdeschybridView, i : Int, v : Double) -> ChemdeschybridView {
  let result = chem_desc_hybrid_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_view_sum(s : ChemdeschybridView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_view_mean(s : ChemdeschybridView) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_view_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_view_scale(s : ChemdeschybridView, f : Double) -> ChemdeschybridView {
  let result = chem_desc_hybrid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_view_add(a : ChemdeschybridView, b : ChemdeschybridView) -> ChemdeschybridView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_view_copy(s : ChemdeschybridView) -> ChemdeschybridView {
  let result = chem_desc_hybrid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_view_fill(s : ChemdeschybridView, v : Double) -> ChemdeschybridView {
  let result = chem_desc_hybrid_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_view_min(s : ChemdeschybridView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_view_max(s : ChemdeschybridView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_view_to_string(s : ChemdeschybridView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_range_make(size : Int) -> ChemdeschybridRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_range_len(s : ChemdeschybridRange) -> Int { s.size }

pub fn chem_desc_hybrid_range_get(s : ChemdeschybridRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_range_set(s : ChemdeschybridRange, i : Int, v : Double) -> ChemdeschybridRange {
  let result = chem_desc_hybrid_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_range_sum(s : ChemdeschybridRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_range_mean(s : ChemdeschybridRange) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_range_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_range_scale(s : ChemdeschybridRange, f : Double) -> ChemdeschybridRange {
  let result = chem_desc_hybrid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_range_add(a : ChemdeschybridRange, b : ChemdeschybridRange) -> ChemdeschybridRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_range_copy(s : ChemdeschybridRange) -> ChemdeschybridRange {
  let result = chem_desc_hybrid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_range_fill(s : ChemdeschybridRange, v : Double) -> ChemdeschybridRange {
  let result = chem_desc_hybrid_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_range_min(s : ChemdeschybridRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_range_max(s : ChemdeschybridRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_range_to_string(s : ChemdeschybridRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct ChemdeschybridSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn chem_desc_hybrid_slice_make(size : Int) -> ChemdeschybridSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn chem_desc_hybrid_slice_len(s : ChemdeschybridSlice) -> Int { s.size }

pub fn chem_desc_hybrid_slice_get(s : ChemdeschybridSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn chem_desc_hybrid_slice_set(s : ChemdeschybridSlice, i : Int, v : Double) -> ChemdeschybridSlice {
  let result = chem_desc_hybrid_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_slice_sum(s : ChemdeschybridSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn chem_desc_hybrid_slice_mean(s : ChemdeschybridSlice) -> Double {
  if s.size == 0 { 0.0 } else { chem_desc_hybrid_slice_sum(s) / s.size.to_double() }
}

pub fn chem_desc_hybrid_slice_scale(s : ChemdeschybridSlice, f : Double) -> ChemdeschybridSlice {
  let result = chem_desc_hybrid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn chem_desc_hybrid_slice_add(a : ChemdeschybridSlice, b : ChemdeschybridSlice) -> ChemdeschybridSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = chem_desc_hybrid_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn chem_desc_hybrid_slice_copy(s : ChemdeschybridSlice) -> ChemdeschybridSlice {
  let result = chem_desc_hybrid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn chem_desc_hybrid_slice_fill(s : ChemdeschybridSlice, v : Double) -> ChemdeschybridSlice {
  let result = chem_desc_hybrid_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn chem_desc_hybrid_slice_min(s : ChemdeschybridSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_slice_max(s : ChemdeschybridSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn chem_desc_hybrid_slice_to_string(s : ChemdeschybridSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub fn chem_desc_hybrid_ext_func_0(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 1.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_1(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 2.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_2(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 3.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_3(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 4.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_4(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 5.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_5(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 6.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_6(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 7.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_7(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 8.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_8(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 9.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_9(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 10.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_10(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 11.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_11(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 12.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_12(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 13.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_13(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 14.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_14(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 15.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_15(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 16.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_16(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 17.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_17(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 18.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_18(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 19.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_19(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 20.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_20(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 21.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_21(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 22.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_22(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 23.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_23(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 24.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

pub fn chem_desc_hybrid_ext_func_24(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut result = 0.0
    let factor = 25.0
    for j in 0..<n { result = result + data[j] * factor }
    result / n.to_double()
  }
}

