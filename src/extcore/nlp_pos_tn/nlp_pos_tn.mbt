///===
/// extcore/nlp_pos_tn

pub(all) struct NlppostnPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_pos_tn_make_point(x : Double, y : Double) -> NlppostnPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_pos_tn_make_point3(x : Double, y : Double, z : Double) -> NlppostnPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_pos_tn_point_x(pt : NlppostnPoint) -> Double { pt.x }

pub fn nlp_pos_tn_point_y(pt : NlppostnPoint) -> Double { pt.y }

pub fn nlp_pos_tn_point_z(pt : NlppostnPoint) -> Double { pt.z }

pub fn nlp_pos_tn_point_label(pt : NlppostnPoint) -> Int { pt.label }

pub fn nlp_pos_tn_point_dist(a : NlppostnPoint, b : NlppostnPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_pos_tn_point_add(a : NlppostnPoint, b : NlppostnPoint) -> NlppostnPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_pos_tn_point_sub(a : NlppostnPoint, b : NlppostnPoint) -> NlppostnPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_pos_tn_point_scale(pt : NlppostnPoint, s : Double) -> NlppostnPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_pos_tn_point_dot(a : NlppostnPoint, b : NlppostnPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_pos_tn_point_cross(a : NlppostnPoint, b : NlppostnPoint) -> NlppostnPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_pos_tn_point_norm(pt : NlppostnPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_pos_tn_point_normalize(pt : NlppostnPoint) -> NlppostnPoint {
  let n = nlp_pos_tn_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_pos_tn_point_scale(pt, 1.0 / n) }
}

pub fn nlp_pos_tn_point_negate(pt : NlppostnPoint) -> NlppostnPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_pos_tn_point_mid(a : NlppostnPoint, b : NlppostnPoint) -> NlppostnPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_pos_tn_point_lerp(a : NlppostnPoint, b : NlppostnPoint, t : Double) -> NlppostnPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_pos_tn_point_to_string(pt : NlppostnPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlppostnSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_pos_tn_make_series(vals : Array[Double], name : String) -> NlppostnSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_pos_tn_series_len(s : NlppostnSeries) -> Int { s.vals.length() }

pub fn nlp_pos_tn_series_sum(s : NlppostnSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_pos_tn_series_mean(s : NlppostnSeries) -> Double {
  let n = nlp_pos_tn_series_len(s)
  if n == 0 { 0.0 } else { nlp_pos_tn_series_sum(s) / n.to_double() }
}

pub fn nlp_pos_tn_series_min(s : NlppostnSeries) -> Double {
  let n = nlp_pos_tn_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_tn_series_max(s : NlppostnSeries) -> Double {
  let n = nlp_pos_tn_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_pos_tn_series_range(s : NlppostnSeries) -> Double {
  nlp_pos_tn_series_max(s) - nlp_pos_tn_series_min(s)
}

pub fn nlp_pos_tn_series_var(s : NlppostnSeries) -> Double {
  let n = nlp_pos_tn_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_pos_tn_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_pos_tn_series_std(s : NlppostnSeries) -> Double { @_common.sqrt(nlp_pos_tn_series_var(s)) }

pub fn nlp_pos_tn_series_median(s : NlppostnSeries) -> Double {
  let n = nlp_pos_tn_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_tn_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_tn_series_scale(s : NlppostnSeries, f : Double) -> NlppostnSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_pos_tn_series_add(a : NlppostnSeries, b : NlppostnSeries) -> NlppostnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_pos_tn_series_sub(a : NlppostnSeries, b : NlppostnSeries) -> NlppostnSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_pos_tn_series_normalize(s : NlppostnSeries) -> NlppostnSeries {
  let mn = nlp_pos_tn_series_min(s)
  let mx = nlp_pos_tn_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_pos_tn_series_cumsum(s : NlppostnSeries) -> NlppostnSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_pos_tn_series_to_string(s : NlppostnSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlppostnMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_pos_tn_make_matrix(rows : Int, cols : Int, val : Double) -> NlppostnMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_pos_tn_matrix_identity(n : Int) -> NlppostnMatrix {
  let m = nlp_pos_tn_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_pos_tn_matrix_get(m : NlppostnMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_pos_tn_matrix_transpose(m : NlppostnMatrix) -> NlppostnMatrix {
  let result = nlp_pos_tn_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_pos_tn_matrix_add(a : NlppostnMatrix, b : NlppostnMatrix) -> NlppostnMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_pos_tn_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_pos_tn_matrix_scale(m : NlppostnMatrix, s : Double) -> NlppostnMatrix {
  let result = nlp_pos_tn_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_pos_tn_matrix_multiply(a : NlppostnMatrix, b : NlppostnMatrix) -> NlppostnMatrix {
  if a.cols != b.rows { return nlp_pos_tn_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_pos_tn_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_pos_tn_matrix_trace(m : NlppostnMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_pos_tn_matrix_det(m : NlppostnMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_pos_tn_matrix_norm(m : NlppostnMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_pos_tn_matrix_to_string(m : NlppostnMatrix) -> String {
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

pub(all) struct NlppostnVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_pos_tn_make_vector(comps : Array[Double]) -> NlppostnVector {
  { comps, dim: comps.length() }
}

pub fn nlp_pos_tn_vector_zero(dim : Int) -> NlppostnVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_pos_tn_vector_add(a : NlppostnVector, b : NlppostnVector) -> NlppostnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_tn_vector_sub(a : NlppostnVector, b : NlppostnVector) -> NlppostnVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_pos_tn_vector_scale(v : NlppostnVector, s : Double) -> NlppostnVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_pos_tn_vector_dot(a : NlppostnVector, b : NlppostnVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_pos_tn_vector_norm(v : NlppostnVector) -> Double { @_common.sqrt(nlp_pos_tn_vector_dot(v, v)) }

pub fn nlp_pos_tn_vector_normalize(v : NlppostnVector) -> NlppostnVector {
  let n = nlp_pos_tn_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_pos_tn_vector_scale(v, 1.0 / n) }
}

pub fn nlp_pos_tn_vector_dist(a : NlppostnVector, b : NlppostnVector) -> Double {
  nlp_pos_tn_vector_norm(nlp_pos_tn_vector_sub(a, b))
}

pub fn nlp_pos_tn_vector_to_string(v : NlppostnVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_pos_tn_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_pos_tn_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_pos_tn_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_pos_tn_std(data : Array[Double]) -> Double { @_common.sqrt(nlp_pos_tn_var(data)) }

pub fn nlp_pos_tn_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_pos_tn_mean(a); let mb = nlp_pos_tn_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_pos_tn_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_pos_tn_std(a); let sb = nlp_pos_tn_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_pos_tn_cov(a, b) / (sa * sb) }
}

pub fn nlp_pos_tn_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_pos_tn_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_pos_tn_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_pos_tn_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_pos_tn_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(nlp_pos_tn_mse(pred, labels))
}

pub fn nlp_pos_tn_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_pos_tn_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_pos_tn_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_pos_tn_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_pos_tn_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_pos_tn_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_pos_tn_precision(pred, labels, pos); let r = nlp_pos_tn_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_pos_tn_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_pos_tn_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_pos_tn_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_pos_tn_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_pos_tn_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_pos_tn_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_pos_tn_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_pos_tn_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_pos_tn_fibonacci(n : Int) -> Int {
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

pub fn nlp_pos_tn_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_pos_tn_min(data); let mx = nlp_pos_tn_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_pos_tn_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_pos_tn_mean(data); let sd = nlp_pos_tn_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_pos_tn_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_pos_tn_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_pos_tn_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_pos_tn_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_pos_tn_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_pos_tn_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NlppostnFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_frame_make(size : Int) -> NlppostnFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_frame_len(s : NlppostnFrame) -> Int { s.size }

pub fn nlp_pos_tn_frame_get(s : NlppostnFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_frame_set(s : NlppostnFrame, i : Int, v : Double) -> NlppostnFrame {
  let result = nlp_pos_tn_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_frame_sum(s : NlppostnFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_frame_mean(s : NlppostnFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_frame_scale(s : NlppostnFrame, f : Double) -> NlppostnFrame {
  let result = nlp_pos_tn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_frame_add(a : NlppostnFrame, b : NlppostnFrame) -> NlppostnFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_frame_copy(s : NlppostnFrame) -> NlppostnFrame {
  let result = nlp_pos_tn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_frame_fill(s : NlppostnFrame, v : Double) -> NlppostnFrame {
  let result = nlp_pos_tn_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_frame_min(s : NlppostnFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_frame_max(s : NlppostnFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_frame_to_string(s : NlppostnFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_table_make(size : Int) -> NlppostnTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_table_len(s : NlppostnTable) -> Int { s.size }

pub fn nlp_pos_tn_table_get(s : NlppostnTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_table_set(s : NlppostnTable, i : Int, v : Double) -> NlppostnTable {
  let result = nlp_pos_tn_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_table_sum(s : NlppostnTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_table_mean(s : NlppostnTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_table_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_table_scale(s : NlppostnTable, f : Double) -> NlppostnTable {
  let result = nlp_pos_tn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_table_add(a : NlppostnTable, b : NlppostnTable) -> NlppostnTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_table_copy(s : NlppostnTable) -> NlppostnTable {
  let result = nlp_pos_tn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_table_fill(s : NlppostnTable, v : Double) -> NlppostnTable {
  let result = nlp_pos_tn_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_table_min(s : NlppostnTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_table_max(s : NlppostnTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_table_to_string(s : NlppostnTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_graphn_make(size : Int) -> NlppostnGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_graphn_len(s : NlppostnGraphN) -> Int { s.size }

pub fn nlp_pos_tn_graphn_get(s : NlppostnGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_graphn_set(s : NlppostnGraphN, i : Int, v : Double) -> NlppostnGraphN {
  let result = nlp_pos_tn_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_graphn_sum(s : NlppostnGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_graphn_mean(s : NlppostnGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_graphn_scale(s : NlppostnGraphN, f : Double) -> NlppostnGraphN {
  let result = nlp_pos_tn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_graphn_add(a : NlppostnGraphN, b : NlppostnGraphN) -> NlppostnGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_graphn_copy(s : NlppostnGraphN) -> NlppostnGraphN {
  let result = nlp_pos_tn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_graphn_fill(s : NlppostnGraphN, v : Double) -> NlppostnGraphN {
  let result = nlp_pos_tn_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_graphn_min(s : NlppostnGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_graphn_max(s : NlppostnGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_graphn_to_string(s : NlppostnGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_node_make(size : Int) -> NlppostnNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_node_len(s : NlppostnNode) -> Int { s.size }

pub fn nlp_pos_tn_node_get(s : NlppostnNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_node_set(s : NlppostnNode, i : Int, v : Double) -> NlppostnNode {
  let result = nlp_pos_tn_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_node_sum(s : NlppostnNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_node_mean(s : NlppostnNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_node_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_node_scale(s : NlppostnNode, f : Double) -> NlppostnNode {
  let result = nlp_pos_tn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_node_add(a : NlppostnNode, b : NlppostnNode) -> NlppostnNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_node_copy(s : NlppostnNode) -> NlppostnNode {
  let result = nlp_pos_tn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_node_fill(s : NlppostnNode, v : Double) -> NlppostnNode {
  let result = nlp_pos_tn_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_node_min(s : NlppostnNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_node_max(s : NlppostnNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_node_to_string(s : NlppostnNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_edge_make(size : Int) -> NlppostnEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_edge_len(s : NlppostnEdge) -> Int { s.size }

pub fn nlp_pos_tn_edge_get(s : NlppostnEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_edge_set(s : NlppostnEdge, i : Int, v : Double) -> NlppostnEdge {
  let result = nlp_pos_tn_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_edge_sum(s : NlppostnEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_edge_mean(s : NlppostnEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_edge_scale(s : NlppostnEdge, f : Double) -> NlppostnEdge {
  let result = nlp_pos_tn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_edge_add(a : NlppostnEdge, b : NlppostnEdge) -> NlppostnEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_edge_copy(s : NlppostnEdge) -> NlppostnEdge {
  let result = nlp_pos_tn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_edge_fill(s : NlppostnEdge, v : Double) -> NlppostnEdge {
  let result = nlp_pos_tn_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_edge_min(s : NlppostnEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_edge_max(s : NlppostnEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_edge_to_string(s : NlppostnEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_path_make(size : Int) -> NlppostnPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_path_len(s : NlppostnPath) -> Int { s.size }

pub fn nlp_pos_tn_path_get(s : NlppostnPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_path_set(s : NlppostnPath, i : Int, v : Double) -> NlppostnPath {
  let result = nlp_pos_tn_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_path_sum(s : NlppostnPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_path_mean(s : NlppostnPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_path_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_path_scale(s : NlppostnPath, f : Double) -> NlppostnPath {
  let result = nlp_pos_tn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_path_add(a : NlppostnPath, b : NlppostnPath) -> NlppostnPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_path_copy(s : NlppostnPath) -> NlppostnPath {
  let result = nlp_pos_tn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_path_fill(s : NlppostnPath, v : Double) -> NlppostnPath {
  let result = nlp_pos_tn_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_path_min(s : NlppostnPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_path_max(s : NlppostnPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_path_to_string(s : NlppostnPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_cluster_make(size : Int) -> NlppostnCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_cluster_len(s : NlppostnCluster) -> Int { s.size }

pub fn nlp_pos_tn_cluster_get(s : NlppostnCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_cluster_set(s : NlppostnCluster, i : Int, v : Double) -> NlppostnCluster {
  let result = nlp_pos_tn_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_cluster_sum(s : NlppostnCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_cluster_mean(s : NlppostnCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_cluster_scale(s : NlppostnCluster, f : Double) -> NlppostnCluster {
  let result = nlp_pos_tn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_cluster_add(a : NlppostnCluster, b : NlppostnCluster) -> NlppostnCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_cluster_copy(s : NlppostnCluster) -> NlppostnCluster {
  let result = nlp_pos_tn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_cluster_fill(s : NlppostnCluster, v : Double) -> NlppostnCluster {
  let result = nlp_pos_tn_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_cluster_min(s : NlppostnCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_cluster_max(s : NlppostnCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_cluster_to_string(s : NlppostnCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_model_make(size : Int) -> NlppostnModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_model_len(s : NlppostnModel) -> Int { s.size }

pub fn nlp_pos_tn_model_get(s : NlppostnModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_model_set(s : NlppostnModel, i : Int, v : Double) -> NlppostnModel {
  let result = nlp_pos_tn_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_model_sum(s : NlppostnModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_model_mean(s : NlppostnModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_model_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_model_scale(s : NlppostnModel, f : Double) -> NlppostnModel {
  let result = nlp_pos_tn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_model_add(a : NlppostnModel, b : NlppostnModel) -> NlppostnModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_model_copy(s : NlppostnModel) -> NlppostnModel {
  let result = nlp_pos_tn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_model_fill(s : NlppostnModel, v : Double) -> NlppostnModel {
  let result = nlp_pos_tn_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_model_min(s : NlppostnModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_model_max(s : NlppostnModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_model_to_string(s : NlppostnModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_layer_make(size : Int) -> NlppostnLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_layer_len(s : NlppostnLayer) -> Int { s.size }

pub fn nlp_pos_tn_layer_get(s : NlppostnLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_layer_set(s : NlppostnLayer, i : Int, v : Double) -> NlppostnLayer {
  let result = nlp_pos_tn_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_layer_sum(s : NlppostnLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_layer_mean(s : NlppostnLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_layer_scale(s : NlppostnLayer, f : Double) -> NlppostnLayer {
  let result = nlp_pos_tn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_layer_add(a : NlppostnLayer, b : NlppostnLayer) -> NlppostnLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_layer_copy(s : NlppostnLayer) -> NlppostnLayer {
  let result = nlp_pos_tn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_layer_fill(s : NlppostnLayer, v : Double) -> NlppostnLayer {
  let result = nlp_pos_tn_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_layer_min(s : NlppostnLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_layer_max(s : NlppostnLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_layer_to_string(s : NlppostnLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_buffer_make(size : Int) -> NlppostnBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_buffer_len(s : NlppostnBuffer) -> Int { s.size }

pub fn nlp_pos_tn_buffer_get(s : NlppostnBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_buffer_set(s : NlppostnBuffer, i : Int, v : Double) -> NlppostnBuffer {
  let result = nlp_pos_tn_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_buffer_sum(s : NlppostnBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_buffer_mean(s : NlppostnBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_buffer_scale(s : NlppostnBuffer, f : Double) -> NlppostnBuffer {
  let result = nlp_pos_tn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_buffer_add(a : NlppostnBuffer, b : NlppostnBuffer) -> NlppostnBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_buffer_copy(s : NlppostnBuffer) -> NlppostnBuffer {
  let result = nlp_pos_tn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_buffer_fill(s : NlppostnBuffer, v : Double) -> NlppostnBuffer {
  let result = nlp_pos_tn_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_buffer_min(s : NlppostnBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_buffer_max(s : NlppostnBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_buffer_to_string(s : NlppostnBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_cursor_make(size : Int) -> NlppostnCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_cursor_len(s : NlppostnCursor) -> Int { s.size }

pub fn nlp_pos_tn_cursor_get(s : NlppostnCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_cursor_set(s : NlppostnCursor, i : Int, v : Double) -> NlppostnCursor {
  let result = nlp_pos_tn_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_cursor_sum(s : NlppostnCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_cursor_mean(s : NlppostnCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_cursor_scale(s : NlppostnCursor, f : Double) -> NlppostnCursor {
  let result = nlp_pos_tn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_cursor_add(a : NlppostnCursor, b : NlppostnCursor) -> NlppostnCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_cursor_copy(s : NlppostnCursor) -> NlppostnCursor {
  let result = nlp_pos_tn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_cursor_fill(s : NlppostnCursor, v : Double) -> NlppostnCursor {
  let result = nlp_pos_tn_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_cursor_min(s : NlppostnCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_cursor_max(s : NlppostnCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_cursor_to_string(s : NlppostnCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_view_make(size : Int) -> NlppostnView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_view_len(s : NlppostnView) -> Int { s.size }

pub fn nlp_pos_tn_view_get(s : NlppostnView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_view_set(s : NlppostnView, i : Int, v : Double) -> NlppostnView {
  let result = nlp_pos_tn_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_view_sum(s : NlppostnView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_view_mean(s : NlppostnView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_view_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_view_scale(s : NlppostnView, f : Double) -> NlppostnView {
  let result = nlp_pos_tn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_view_add(a : NlppostnView, b : NlppostnView) -> NlppostnView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_view_copy(s : NlppostnView) -> NlppostnView {
  let result = nlp_pos_tn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_view_fill(s : NlppostnView, v : Double) -> NlppostnView {
  let result = nlp_pos_tn_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_view_min(s : NlppostnView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_view_max(s : NlppostnView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_view_to_string(s : NlppostnView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_range_make(size : Int) -> NlppostnRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_range_len(s : NlppostnRange) -> Int { s.size }

pub fn nlp_pos_tn_range_get(s : NlppostnRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_range_set(s : NlppostnRange, i : Int, v : Double) -> NlppostnRange {
  let result = nlp_pos_tn_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_range_sum(s : NlppostnRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_range_mean(s : NlppostnRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_range_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_range_scale(s : NlppostnRange, f : Double) -> NlppostnRange {
  let result = nlp_pos_tn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_range_add(a : NlppostnRange, b : NlppostnRange) -> NlppostnRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_range_copy(s : NlppostnRange) -> NlppostnRange {
  let result = nlp_pos_tn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_range_fill(s : NlppostnRange, v : Double) -> NlppostnRange {
  let result = nlp_pos_tn_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_range_min(s : NlppostnRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_range_max(s : NlppostnRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_range_to_string(s : NlppostnRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlppostnSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_pos_tn_slice_make(size : Int) -> NlppostnSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_pos_tn_slice_len(s : NlppostnSlice) -> Int { s.size }

pub fn nlp_pos_tn_slice_get(s : NlppostnSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_pos_tn_slice_set(s : NlppostnSlice, i : Int, v : Double) -> NlppostnSlice {
  let result = nlp_pos_tn_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_slice_sum(s : NlppostnSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_pos_tn_slice_mean(s : NlppostnSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_pos_tn_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_pos_tn_slice_scale(s : NlppostnSlice, f : Double) -> NlppostnSlice {
  let result = nlp_pos_tn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_pos_tn_slice_add(a : NlppostnSlice, b : NlppostnSlice) -> NlppostnSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_pos_tn_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_pos_tn_slice_copy(s : NlppostnSlice) -> NlppostnSlice {
  let result = nlp_pos_tn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_pos_tn_slice_fill(s : NlppostnSlice, v : Double) -> NlppostnSlice {
  let result = nlp_pos_tn_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_pos_tn_slice_min(s : NlppostnSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_slice_max(s : NlppostnSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_pos_tn_slice_to_string(s : NlppostnSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

