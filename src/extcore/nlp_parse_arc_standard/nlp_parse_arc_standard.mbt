///===
/// extcore/nlp_parse_arc_standard

pub(all) struct NlpparsearcstandardPoint {
  x : Double
  y : Double
  z : Double
  label : Int
}

pub fn nlp_parse_arc_standard_make_point(x : Double, y : Double) -> NlpparsearcstandardPoint {
  { x, y, z: 0.0, label: 0 }
}

pub fn nlp_parse_arc_standard_make_point3(x : Double, y : Double, z : Double) -> NlpparsearcstandardPoint {
  { x, y, z, label: 0 }
}

pub fn nlp_parse_arc_standard_point_x(pt : NlpparsearcstandardPoint) -> Double { pt.x }

pub fn nlp_parse_arc_standard_point_y(pt : NlpparsearcstandardPoint) -> Double { pt.y }

pub fn nlp_parse_arc_standard_point_z(pt : NlpparsearcstandardPoint) -> Double { pt.z }

pub fn nlp_parse_arc_standard_point_label(pt : NlpparsearcstandardPoint) -> Int { pt.label }

pub fn nlp_parse_arc_standard_point_dist(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> Double {
  let dx = a.x - b.x
  let dy = a.y - b.y
  let dz = a.z - b.z
  @_common.sqrt(dx * dx + dy * dy + dz * dz)
}

pub fn nlp_parse_arc_standard_point_add(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: a.x + b.x, y: a.y + b.y, z: a.z + b.z, label: a.label }
}

pub fn nlp_parse_arc_standard_point_sub(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: a.x - b.x, y: a.y - b.y, z: a.z - b.z, label: a.label }
}

pub fn nlp_parse_arc_standard_point_scale(pt : NlpparsearcstandardPoint, s : Double) -> NlpparsearcstandardPoint {
  { x: pt.x * s, y: pt.y * s, z: pt.z * s, label: pt.label }
}

pub fn nlp_parse_arc_standard_point_dot(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> Double {
  a.x * b.x + a.y * b.y + a.z * b.z
}

pub fn nlp_parse_arc_standard_point_cross(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: a.y * b.z - a.z * b.y, y: a.z * b.x - a.x * b.z, z: a.x * b.y - a.y * b.x, label: 0 }
}

pub fn nlp_parse_arc_standard_point_norm(pt : NlpparsearcstandardPoint) -> Double {
  @_common.sqrt(pt.x * pt.x + pt.y * pt.y + pt.z * pt.z)
}

pub fn nlp_parse_arc_standard_point_normalize(pt : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  let n = nlp_parse_arc_standard_point_norm(pt)
  if n < 0.0000001 { pt } else { nlp_parse_arc_standard_point_scale(pt, 1.0 / n) }
}

pub fn nlp_parse_arc_standard_point_negate(pt : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: -pt.x, y: -pt.y, z: -pt.z, label: pt.label }
}

pub fn nlp_parse_arc_standard_point_mid(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint) -> NlpparsearcstandardPoint {
  { x: (a.x + b.x) / 2.0, y: (a.y + b.y) / 2.0, z: (a.z + b.z) / 2.0, label: a.label }
}

pub fn nlp_parse_arc_standard_point_lerp(a : NlpparsearcstandardPoint, b : NlpparsearcstandardPoint, t : Double) -> NlpparsearcstandardPoint {
  { x: a.x + (b.x - a.x) * t, y: a.y + (b.y - a.y) * t, z: a.z + (b.z - a.z) * t, label: a.label }
}

pub fn nlp_parse_arc_standard_point_to_string(pt : NlpparsearcstandardPoint) -> String {
  "(" + @_common.dbl(pt.x) + ", " + @_common.dbl(pt.y) + ", " + @_common.dbl(pt.z) + ")[" + pt.label.to_string() + "]"
}

pub(all) struct NlpparsearcstandardSeries {
  vals : Array[Double]
  name : String
  meta : Int
}

pub fn nlp_parse_arc_standard_make_series(vals : Array[Double], name : String) -> NlpparsearcstandardSeries {
  { vals, name, meta: 0 }
}

pub fn nlp_parse_arc_standard_series_len(s : NlpparsearcstandardSeries) -> Int { s.vals.length() }

pub fn nlp_parse_arc_standard_series_sum(s : NlpparsearcstandardSeries) -> Double {
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i] }
  total
}

pub fn nlp_parse_arc_standard_series_mean(s : NlpparsearcstandardSeries) -> Double {
  let n = nlp_parse_arc_standard_series_len(s)
  if n == 0 { 0.0 } else { nlp_parse_arc_standard_series_sum(s) / n.to_double() }
}

pub fn nlp_parse_arc_standard_series_min(s : NlpparsearcstandardSeries) -> Double {
  let n = nlp_parse_arc_standard_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] < m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_series_max(s : NlpparsearcstandardSeries) -> Double {
  let n = nlp_parse_arc_standard_series_len(s)
  if n == 0 { 0.0 } else {
    let mut m = s.vals[0]
    for i in 1..<n { if s.vals[i] > m { m = s.vals[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_series_range(s : NlpparsearcstandardSeries) -> Double {
  nlp_parse_arc_standard_series_max(s) - nlp_parse_arc_standard_series_min(s)
}

pub fn nlp_parse_arc_standard_series_var(s : NlpparsearcstandardSeries) -> Double {
  let n = nlp_parse_arc_standard_series_len(s)
  if n == 0 { 0.0 } else {
    let m = nlp_parse_arc_standard_series_mean(s)
    let mut total = 0.0
    for i in 0..<n { let d = s.vals[i] - m; total = total + d * d }
    total / n.to_double()
  }
}

pub fn nlp_parse_arc_standard_series_std(s : NlpparsearcstandardSeries) -> Double { @_common.sqrt(nlp_parse_arc_standard_series_var(s)) }

pub fn nlp_parse_arc_standard_series_median(s : NlpparsearcstandardSeries) -> Double {
  let n = nlp_parse_arc_standard_series_len(s)
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_arc_standard_sort(s.vals)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_arc_standard_series_scale(s : NlpparsearcstandardSeries, f : Double) -> NlpparsearcstandardSeries {
  let result = []
  for i in 0..<s.vals.length() { result.push(s.vals[i] * f) }
  { vals: result, name: s.name, meta: s.meta }
}

pub fn nlp_parse_arc_standard_series_add(a : NlpparsearcstandardSeries, b : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] + b.vals[i]) }
  { vals: result, name: a.name + "+" + b.name, meta: a.meta }
}

pub fn nlp_parse_arc_standard_series_sub(a : NlpparsearcstandardSeries, b : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  let n = if a.vals.length() < b.vals.length() { a.vals.length() } else { b.vals.length() }
  let result = []
  for i in 0..<n { result.push(a.vals[i] - b.vals[i]) }
  { vals: result, name: a.name + "-" + b.name, meta: a.meta }
}

pub fn nlp_parse_arc_standard_series_normalize(s : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  let mn = nlp_parse_arc_standard_series_min(s)
  let mx = nlp_parse_arc_standard_series_max(s)
  let r = mx - mn
  if r < 0.0000001 { s } else {
    let result = []
    for i in 0..<s.vals.length() { result.push((s.vals[i] - mn) / r) }
    { vals: result, name: s.name, meta: s.meta }
  }
}

pub fn nlp_parse_arc_standard_series_cumsum(s : NlpparsearcstandardSeries) -> NlpparsearcstandardSeries {
  let result = []
  let mut total = 0.0
  for i in 0..<s.vals.length() { total = total + s.vals[i]; result.push(total) }
  { vals: result, name: s.name + "_cumsum", meta: s.meta }
}

pub fn nlp_parse_arc_standard_series_to_string(s : NlpparsearcstandardSeries) -> String {
  let mut result = s.name + "["
  let n = s.vals.length()
  let lim = if n < 10 { n } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(s.vals[i]) }
  if n > 10 { result + "...]" } else { result + "]" }
}

pub(all) struct NlpparsearcstandardMatrix {
  data : Array[Array[Double]]
  rows : Int
  cols : Int
}

pub fn nlp_parse_arc_standard_make_matrix(rows : Int, cols : Int, val : Double) -> NlpparsearcstandardMatrix {
  let data = Array::make(rows, Array::make(cols, val))
  for i in 0..<rows { data[i] = Array::make(cols, val) }
  { data, rows, cols }
}

pub fn nlp_parse_arc_standard_matrix_identity(n : Int) -> NlpparsearcstandardMatrix {
  let m = nlp_parse_arc_standard_make_matrix(n, n, 0.0)
  for i in 0..<n { m.data[i][i] = 1.0 }
  m
}

pub fn nlp_parse_arc_standard_matrix_get(m : NlpparsearcstandardMatrix, i : Int, j : Int) -> Double {
  if i < 0 || i >= m.rows || j < 0 || j >= m.cols { 0.0 } else { m.data[i][j] }
}

pub fn nlp_parse_arc_standard_matrix_transpose(m : NlpparsearcstandardMatrix) -> NlpparsearcstandardMatrix {
  let result = nlp_parse_arc_standard_make_matrix(m.cols, m.rows, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[j][i] = m.data[i][j] } }
  result
}

pub fn nlp_parse_arc_standard_matrix_add(a : NlpparsearcstandardMatrix, b : NlpparsearcstandardMatrix) -> NlpparsearcstandardMatrix {
  if a.rows != b.rows || a.cols != b.cols { return a }
  let result = nlp_parse_arc_standard_make_matrix(a.rows, a.cols, 0.0)
  for i in 0..<a.rows { for j in 0..<a.cols { result.data[i][j] = a.data[i][j] + b.data[i][j] } }
  result
}

pub fn nlp_parse_arc_standard_matrix_scale(m : NlpparsearcstandardMatrix, s : Double) -> NlpparsearcstandardMatrix {
  let result = nlp_parse_arc_standard_make_matrix(m.rows, m.cols, 0.0)
  for i in 0..<m.rows { for j in 0..<m.cols { result.data[i][j] = m.data[i][j] * s } }
  result
}

pub fn nlp_parse_arc_standard_matrix_multiply(a : NlpparsearcstandardMatrix, b : NlpparsearcstandardMatrix) -> NlpparsearcstandardMatrix {
  if a.cols != b.rows { return nlp_parse_arc_standard_make_matrix(a.rows, b.cols, 0.0) }
  let result = nlp_parse_arc_standard_make_matrix(a.rows, b.cols, 0.0)
  for i in 0..<a.rows {
    for j in 0..<b.cols {
      let mut sum = 0.0
      for k in 0..<a.cols { sum = sum + a.data[i][k] * b.data[k][j] }
      result.data[i][j] = sum
    }
  }
  result
}

pub fn nlp_parse_arc_standard_matrix_trace(m : NlpparsearcstandardMatrix) -> Double {
  let n = if m.rows < m.cols { m.rows } else { m.cols }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + m.data[i][i] }
  sum
}

pub fn nlp_parse_arc_standard_matrix_det(m : NlpparsearcstandardMatrix) -> Double {
  if m.rows != m.cols { 0.0 } else if m.rows == 1 { m.data[0][0] } else if m.rows == 2 {
    m.data[0][0] * m.data[1][1] - m.data[0][1] * m.data[1][0]
  } else if m.rows == 3 {
    let a = m.data[0][0] * (m.data[1][1] * m.data[2][2] - m.data[1][2] * m.data[2][1])
    let b = m.data[0][1] * (m.data[1][0] * m.data[2][2] - m.data[1][2] * m.data[2][0])
    let c = m.data[0][2] * (m.data[1][0] * m.data[2][1] - m.data[1][1] * m.data[2][0])
    a - b + c
  } else { 0.0 }
}

pub fn nlp_parse_arc_standard_matrix_norm(m : NlpparsearcstandardMatrix) -> Double {
  let mut sum = 0.0
  for i in 0..<m.rows { for j in 0..<m.cols { sum = sum + m.data[i][j] * m.data[i][j] } }
  @_common.sqrt(sum)
}

pub fn nlp_parse_arc_standard_matrix_to_string(m : NlpparsearcstandardMatrix) -> String {
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

pub(all) struct NlpparsearcstandardVector {
  comps : Array[Double]
  dim : Int
}

pub fn nlp_parse_arc_standard_make_vector(comps : Array[Double]) -> NlpparsearcstandardVector {
  { comps, dim: comps.length() }
}

pub fn nlp_parse_arc_standard_vector_zero(dim : Int) -> NlpparsearcstandardVector {
  { comps: Array::make(dim, 0.0), dim }
}

pub fn nlp_parse_arc_standard_vector_add(a : NlpparsearcstandardVector, b : NlpparsearcstandardVector) -> NlpparsearcstandardVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] + b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_arc_standard_vector_sub(a : NlpparsearcstandardVector, b : NlpparsearcstandardVector) -> NlpparsearcstandardVector {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let result = []
  for i in 0..<n { result.push(a.comps[i] - b.comps[i]) }
  { comps: result, dim: n }
}

pub fn nlp_parse_arc_standard_vector_scale(v : NlpparsearcstandardVector, s : Double) -> NlpparsearcstandardVector {
  let result = []
  for i in 0..<v.dim { result.push(v.comps[i] * s) }
  { comps: result, dim: v.dim }
}

pub fn nlp_parse_arc_standard_vector_dot(a : NlpparsearcstandardVector, b : NlpparsearcstandardVector) -> Double {
  let n = if a.dim < b.dim { a.dim } else { b.dim }
  let mut sum = 0.0
  for i in 0..<n { sum = sum + a.comps[i] * b.comps[i] }
  sum
}

pub fn nlp_parse_arc_standard_vector_norm(v : NlpparsearcstandardVector) -> Double { @_common.sqrt(nlp_parse_arc_standard_vector_dot(v, v)) }

pub fn nlp_parse_arc_standard_vector_normalize(v : NlpparsearcstandardVector) -> NlpparsearcstandardVector {
  let n = nlp_parse_arc_standard_vector_norm(v)
  if n < 0.0000001 { v } else { nlp_parse_arc_standard_vector_scale(v, 1.0 / n) }
}

pub fn nlp_parse_arc_standard_vector_dist(a : NlpparsearcstandardVector, b : NlpparsearcstandardVector) -> Double {
  nlp_parse_arc_standard_vector_norm(nlp_parse_arc_standard_vector_sub(a, b))
}

pub fn nlp_parse_arc_standard_vector_to_string(v : NlpparsearcstandardVector) -> String {
  let mut result = "["
  let lim = if v.dim < 10 { v.dim } else { 10 }
  for i in 0..<lim { if i > 0 { result = result + ", " }; result = result + @_common.dbl(v.comps[i]) }
  if v.dim > 10 { result + "...]" } else { result + "]" }
}

pub fn nlp_parse_arc_standard_mean(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + data[i] }
    sum / n.to_double()
  }
}

pub fn nlp_parse_arc_standard_var(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let m = nlp_parse_arc_standard_mean(data)
    let mut sum = 0.0
    for i in 0..<n { let d = data[i] - m; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_arc_standard_std(data : Array[Double]) -> Double { @_common.sqrt(nlp_parse_arc_standard_var(data)) }

pub fn nlp_parse_arc_standard_cov(a : Array[Double], b : Array[Double]) -> Double {
  let n = if a.length() < b.length() { a.length() } else { b.length() }
  if n == 0 { 0.0 } else {
    let ma = nlp_parse_arc_standard_mean(a); let mb = nlp_parse_arc_standard_mean(b)
    let mut sum = 0.0
    for i in 0..<n { sum = sum + (a[i] - ma) * (b[i] - mb) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_arc_standard_corr(a : Array[Double], b : Array[Double]) -> Double {
  let sa = nlp_parse_arc_standard_std(a); let sb = nlp_parse_arc_standard_std(b)
  if sa < 0.0000001 || sb < 0.0000001 { 0.0 } else { nlp_parse_arc_standard_cov(a, b) / (sa * sb) }
}

pub fn nlp_parse_arc_standard_median(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let sorted = nlp_parse_arc_standard_sort(data)
    if n % 2 == 1 { sorted[n / 2] } else { (sorted[n / 2 - 1] + sorted[n / 2]) / 2.0 }
  }
}

pub fn nlp_parse_arc_standard_accuracy(pred : Array[Int], labels : Array[Int]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut correct = 0
    for i in 0..<n { if pred[i] == labels[i] { correct = correct + 1 } }
    correct.to_double() / n.to_double()
  }
}

pub fn nlp_parse_arc_standard_mse(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { let d = pred[i] - labels[i]; sum = sum + d * d }
    sum / n.to_double()
  }
}

pub fn nlp_parse_arc_standard_rmse(pred : Array[Double], labels : Array[Double]) -> Double {
  @_common.sqrt(nlp_parse_arc_standard_mse(pred, labels))
}

pub fn nlp_parse_arc_standard_mae(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let mut sum = 0.0
    for i in 0..<n { sum = sum + @_common.abs(pred[i] - labels[i]) }
    sum / n.to_double()
  }
}

pub fn nlp_parse_arc_standard_r2(pred : Array[Double], labels : Array[Double]) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  if n == 0 { 0.0 } else {
    let lm = nlp_parse_arc_standard_mean(labels)
    let mut ss_res = 0.0; let mut ss_tot = 0.0
    for i in 0..<n { let r = labels[i] - pred[i]; ss_res = ss_res + r * r; let t = labels[i] - lm; ss_tot = ss_tot + t * t }
    if ss_tot < 0.0000001 { 0.0 } else { 1.0 - ss_res / ss_tot }
  }
}

pub fn nlp_parse_arc_standard_precision(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fp = 0
  for i in 0..<n { if pred[i] == pos { if labels[i] == pos { tp = tp + 1 } else { fp = fp + 1 } } }
  if tp + fp == 0 { 0.0 } else { tp.to_double() / (tp + fp).to_double() }
}

pub fn nlp_parse_arc_standard_recall(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let n = if pred.length() < labels.length() { pred.length() } else { labels.length() }
  let mut tp = 0; let mut fn_ = 0
  for i in 0..<n { if labels[i] == pos { if pred[i] == pos { tp = tp + 1 } else { fn_ = fn_ + 1 } } }
  if tp + fn_ == 0 { 0.0 } else { tp.to_double() / (tp + fn_).to_double() }
}

pub fn nlp_parse_arc_standard_f1(pred : Array[Int], labels : Array[Int], pos : Int) -> Double {
  let p_ = nlp_parse_arc_standard_precision(pred, labels, pos); let r = nlp_parse_arc_standard_recall(pred, labels, pos)
  if p_ + r < 0.0000001 { 0.0 } else { 2.0 * p_ * r / (p_ + r) }
}

pub fn nlp_parse_arc_standard_sort(arr : Array[Double]) -> Array[Double] {
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

pub fn nlp_parse_arc_standard_sort_desc(arr : Array[Double]) -> Array[Double] {
  let sorted = nlp_parse_arc_standard_sort(arr)
  let n = sorted.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = sorted[n - 1 - i] }
  result
}

pub fn nlp_parse_arc_standard_factorial(n : Int) -> Double {
  let mut result = 1.0
  let end = n + 1
  for i in 2..<end { result = result * i.to_double() }
  result
}

pub fn nlp_parse_arc_standard_gcd(a : Int, b : Int) -> Int {
  let mut x = if a < 0 { -a } else { a }
  let mut y = if b < 0 { -b } else { b }
  while y > 0 { let t = y; y = x % y; x = t }
  x
}

pub fn nlp_parse_arc_standard_lcm(a : Int, b : Int) -> Int {
  if a == 0 || b == 0 { 0 } else {
    let g = nlp_parse_arc_standard_gcd(a, b)
    (a / g) * b
  }
}

pub fn nlp_parse_arc_standard_is_prime(n : Int) -> Bool {
  if n < 2 { false } else if n == 2 { true } else if n % 2 == 0 { false } else {
    let mut result = true
    let mut i = 3
    while i * i <= n { if n % i == 0 { result = false }; i = i + 2 }
    result
  }
}

pub fn nlp_parse_arc_standard_fibonacci(n : Int) -> Int {
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

pub fn nlp_parse_arc_standard_normalize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let mn = nlp_parse_arc_standard_min(data); let mx = nlp_parse_arc_standard_max(data)
    let r = mx - mn
    if r < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - mn) / r }
      result
    }
  }
}

pub fn nlp_parse_arc_standard_standardize(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  if n == 0 { [] } else {
    let m = nlp_parse_arc_standard_mean(data); let sd = nlp_parse_arc_standard_std(data)
    if sd < 0.0000001 { Array::make(n, 0.0) } else {
      let result = Array::make(n, 0.0)
      for i in 0..<n { result[i] = (data[i] - m) / sd }
      result
    }
  }
}

pub fn nlp_parse_arc_standard_clip(data : Array[Double], lo : Double, hi : Double) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { let v = data[i]; result[i] = if v < lo { lo } else if v > hi { hi } else { v } }
  result
}

pub fn nlp_parse_arc_standard_min(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] < m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_max(data : Array[Double]) -> Double {
  let n = data.length()
  if n == 0 { 0.0 } else {
    let mut m = data[0]
    for i in 1..<n { if data[i] > m { m = data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_cumsum(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  let mut total = 0.0
  for i in 0..<n { total = total + data[i]; result[i] = total }
  result
}

pub fn nlp_parse_arc_standard_reverse(data : Array[Double]) -> Array[Double] {
  let n = data.length()
  let result = Array::make(n, 0.0)
  for i in 0..<n { result[i] = data[n - 1 - i] }
  result
}

pub fn nlp_parse_arc_standard_concat(a : Array[Double], b : Array[Double]) -> Array[Double] {
  let na = a.length(); let nb = b.length()
  let result = Array::make(na + nb, 0.0)
  for i in 0..<na { result[i] = a[i] }
  for i in 0..<nb { result[na + i] = b[i] }
  result
}

pub(all) struct NlpparsearcstandardFrame {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_frame_make(size : Int) -> NlpparsearcstandardFrame {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_frame_len(s : NlpparsearcstandardFrame) -> Int { s.size }

pub fn nlp_parse_arc_standard_frame_get(s : NlpparsearcstandardFrame, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_frame_set(s : NlpparsearcstandardFrame, i : Int, v : Double) -> NlpparsearcstandardFrame {
  let result = nlp_parse_arc_standard_frame_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_frame_sum(s : NlpparsearcstandardFrame) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_frame_mean(s : NlpparsearcstandardFrame) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_frame_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_frame_scale(s : NlpparsearcstandardFrame, f : Double) -> NlpparsearcstandardFrame {
  let result = nlp_parse_arc_standard_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_frame_add(a : NlpparsearcstandardFrame, b : NlpparsearcstandardFrame) -> NlpparsearcstandardFrame {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_frame_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_frame_copy(s : NlpparsearcstandardFrame) -> NlpparsearcstandardFrame {
  let result = nlp_parse_arc_standard_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_frame_fill(s : NlpparsearcstandardFrame, v : Double) -> NlpparsearcstandardFrame {
  let result = nlp_parse_arc_standard_frame_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_frame_min(s : NlpparsearcstandardFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_frame_max(s : NlpparsearcstandardFrame) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_frame_to_string(s : NlpparsearcstandardFrame) -> String {
  "Frame[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardTable {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_table_make(size : Int) -> NlpparsearcstandardTable {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_table_len(s : NlpparsearcstandardTable) -> Int { s.size }

pub fn nlp_parse_arc_standard_table_get(s : NlpparsearcstandardTable, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_table_set(s : NlpparsearcstandardTable, i : Int, v : Double) -> NlpparsearcstandardTable {
  let result = nlp_parse_arc_standard_table_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_table_sum(s : NlpparsearcstandardTable) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_table_mean(s : NlpparsearcstandardTable) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_table_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_table_scale(s : NlpparsearcstandardTable, f : Double) -> NlpparsearcstandardTable {
  let result = nlp_parse_arc_standard_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_table_add(a : NlpparsearcstandardTable, b : NlpparsearcstandardTable) -> NlpparsearcstandardTable {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_table_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_table_copy(s : NlpparsearcstandardTable) -> NlpparsearcstandardTable {
  let result = nlp_parse_arc_standard_table_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_table_fill(s : NlpparsearcstandardTable, v : Double) -> NlpparsearcstandardTable {
  let result = nlp_parse_arc_standard_table_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_table_min(s : NlpparsearcstandardTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_table_max(s : NlpparsearcstandardTable) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_table_to_string(s : NlpparsearcstandardTable) -> String {
  "Table[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardGraphN {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_graphn_make(size : Int) -> NlpparsearcstandardGraphN {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_graphn_len(s : NlpparsearcstandardGraphN) -> Int { s.size }

pub fn nlp_parse_arc_standard_graphn_get(s : NlpparsearcstandardGraphN, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_graphn_set(s : NlpparsearcstandardGraphN, i : Int, v : Double) -> NlpparsearcstandardGraphN {
  let result = nlp_parse_arc_standard_graphn_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_graphn_sum(s : NlpparsearcstandardGraphN) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_graphn_mean(s : NlpparsearcstandardGraphN) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_graphn_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_graphn_scale(s : NlpparsearcstandardGraphN, f : Double) -> NlpparsearcstandardGraphN {
  let result = nlp_parse_arc_standard_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_graphn_add(a : NlpparsearcstandardGraphN, b : NlpparsearcstandardGraphN) -> NlpparsearcstandardGraphN {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_graphn_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_graphn_copy(s : NlpparsearcstandardGraphN) -> NlpparsearcstandardGraphN {
  let result = nlp_parse_arc_standard_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_graphn_fill(s : NlpparsearcstandardGraphN, v : Double) -> NlpparsearcstandardGraphN {
  let result = nlp_parse_arc_standard_graphn_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_graphn_min(s : NlpparsearcstandardGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_graphn_max(s : NlpparsearcstandardGraphN) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_graphn_to_string(s : NlpparsearcstandardGraphN) -> String {
  "GraphN[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardNode {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_node_make(size : Int) -> NlpparsearcstandardNode {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_node_len(s : NlpparsearcstandardNode) -> Int { s.size }

pub fn nlp_parse_arc_standard_node_get(s : NlpparsearcstandardNode, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_node_set(s : NlpparsearcstandardNode, i : Int, v : Double) -> NlpparsearcstandardNode {
  let result = nlp_parse_arc_standard_node_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_node_sum(s : NlpparsearcstandardNode) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_node_mean(s : NlpparsearcstandardNode) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_node_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_node_scale(s : NlpparsearcstandardNode, f : Double) -> NlpparsearcstandardNode {
  let result = nlp_parse_arc_standard_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_node_add(a : NlpparsearcstandardNode, b : NlpparsearcstandardNode) -> NlpparsearcstandardNode {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_node_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_node_copy(s : NlpparsearcstandardNode) -> NlpparsearcstandardNode {
  let result = nlp_parse_arc_standard_node_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_node_fill(s : NlpparsearcstandardNode, v : Double) -> NlpparsearcstandardNode {
  let result = nlp_parse_arc_standard_node_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_node_min(s : NlpparsearcstandardNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_node_max(s : NlpparsearcstandardNode) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_node_to_string(s : NlpparsearcstandardNode) -> String {
  "Node[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardEdge {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_edge_make(size : Int) -> NlpparsearcstandardEdge {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_edge_len(s : NlpparsearcstandardEdge) -> Int { s.size }

pub fn nlp_parse_arc_standard_edge_get(s : NlpparsearcstandardEdge, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_edge_set(s : NlpparsearcstandardEdge, i : Int, v : Double) -> NlpparsearcstandardEdge {
  let result = nlp_parse_arc_standard_edge_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_edge_sum(s : NlpparsearcstandardEdge) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_edge_mean(s : NlpparsearcstandardEdge) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_edge_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_edge_scale(s : NlpparsearcstandardEdge, f : Double) -> NlpparsearcstandardEdge {
  let result = nlp_parse_arc_standard_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_edge_add(a : NlpparsearcstandardEdge, b : NlpparsearcstandardEdge) -> NlpparsearcstandardEdge {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_edge_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_edge_copy(s : NlpparsearcstandardEdge) -> NlpparsearcstandardEdge {
  let result = nlp_parse_arc_standard_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_edge_fill(s : NlpparsearcstandardEdge, v : Double) -> NlpparsearcstandardEdge {
  let result = nlp_parse_arc_standard_edge_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_edge_min(s : NlpparsearcstandardEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_edge_max(s : NlpparsearcstandardEdge) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_edge_to_string(s : NlpparsearcstandardEdge) -> String {
  "Edge[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardPath {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_path_make(size : Int) -> NlpparsearcstandardPath {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_path_len(s : NlpparsearcstandardPath) -> Int { s.size }

pub fn nlp_parse_arc_standard_path_get(s : NlpparsearcstandardPath, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_path_set(s : NlpparsearcstandardPath, i : Int, v : Double) -> NlpparsearcstandardPath {
  let result = nlp_parse_arc_standard_path_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_path_sum(s : NlpparsearcstandardPath) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_path_mean(s : NlpparsearcstandardPath) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_path_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_path_scale(s : NlpparsearcstandardPath, f : Double) -> NlpparsearcstandardPath {
  let result = nlp_parse_arc_standard_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_path_add(a : NlpparsearcstandardPath, b : NlpparsearcstandardPath) -> NlpparsearcstandardPath {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_path_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_path_copy(s : NlpparsearcstandardPath) -> NlpparsearcstandardPath {
  let result = nlp_parse_arc_standard_path_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_path_fill(s : NlpparsearcstandardPath, v : Double) -> NlpparsearcstandardPath {
  let result = nlp_parse_arc_standard_path_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_path_min(s : NlpparsearcstandardPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_path_max(s : NlpparsearcstandardPath) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_path_to_string(s : NlpparsearcstandardPath) -> String {
  "Path[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardCluster {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_cluster_make(size : Int) -> NlpparsearcstandardCluster {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_cluster_len(s : NlpparsearcstandardCluster) -> Int { s.size }

pub fn nlp_parse_arc_standard_cluster_get(s : NlpparsearcstandardCluster, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_cluster_set(s : NlpparsearcstandardCluster, i : Int, v : Double) -> NlpparsearcstandardCluster {
  let result = nlp_parse_arc_standard_cluster_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_cluster_sum(s : NlpparsearcstandardCluster) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_cluster_mean(s : NlpparsearcstandardCluster) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_cluster_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_cluster_scale(s : NlpparsearcstandardCluster, f : Double) -> NlpparsearcstandardCluster {
  let result = nlp_parse_arc_standard_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_cluster_add(a : NlpparsearcstandardCluster, b : NlpparsearcstandardCluster) -> NlpparsearcstandardCluster {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_cluster_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_cluster_copy(s : NlpparsearcstandardCluster) -> NlpparsearcstandardCluster {
  let result = nlp_parse_arc_standard_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_cluster_fill(s : NlpparsearcstandardCluster, v : Double) -> NlpparsearcstandardCluster {
  let result = nlp_parse_arc_standard_cluster_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_cluster_min(s : NlpparsearcstandardCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_cluster_max(s : NlpparsearcstandardCluster) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_cluster_to_string(s : NlpparsearcstandardCluster) -> String {
  "Cluster[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardModel {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_model_make(size : Int) -> NlpparsearcstandardModel {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_model_len(s : NlpparsearcstandardModel) -> Int { s.size }

pub fn nlp_parse_arc_standard_model_get(s : NlpparsearcstandardModel, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_model_set(s : NlpparsearcstandardModel, i : Int, v : Double) -> NlpparsearcstandardModel {
  let result = nlp_parse_arc_standard_model_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_model_sum(s : NlpparsearcstandardModel) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_model_mean(s : NlpparsearcstandardModel) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_model_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_model_scale(s : NlpparsearcstandardModel, f : Double) -> NlpparsearcstandardModel {
  let result = nlp_parse_arc_standard_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_model_add(a : NlpparsearcstandardModel, b : NlpparsearcstandardModel) -> NlpparsearcstandardModel {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_model_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_model_copy(s : NlpparsearcstandardModel) -> NlpparsearcstandardModel {
  let result = nlp_parse_arc_standard_model_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_model_fill(s : NlpparsearcstandardModel, v : Double) -> NlpparsearcstandardModel {
  let result = nlp_parse_arc_standard_model_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_model_min(s : NlpparsearcstandardModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_model_max(s : NlpparsearcstandardModel) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_model_to_string(s : NlpparsearcstandardModel) -> String {
  "Model[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardLayer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_layer_make(size : Int) -> NlpparsearcstandardLayer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_layer_len(s : NlpparsearcstandardLayer) -> Int { s.size }

pub fn nlp_parse_arc_standard_layer_get(s : NlpparsearcstandardLayer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_layer_set(s : NlpparsearcstandardLayer, i : Int, v : Double) -> NlpparsearcstandardLayer {
  let result = nlp_parse_arc_standard_layer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_layer_sum(s : NlpparsearcstandardLayer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_layer_mean(s : NlpparsearcstandardLayer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_layer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_layer_scale(s : NlpparsearcstandardLayer, f : Double) -> NlpparsearcstandardLayer {
  let result = nlp_parse_arc_standard_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_layer_add(a : NlpparsearcstandardLayer, b : NlpparsearcstandardLayer) -> NlpparsearcstandardLayer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_layer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_layer_copy(s : NlpparsearcstandardLayer) -> NlpparsearcstandardLayer {
  let result = nlp_parse_arc_standard_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_layer_fill(s : NlpparsearcstandardLayer, v : Double) -> NlpparsearcstandardLayer {
  let result = nlp_parse_arc_standard_layer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_layer_min(s : NlpparsearcstandardLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_layer_max(s : NlpparsearcstandardLayer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_layer_to_string(s : NlpparsearcstandardLayer) -> String {
  "Layer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardBuffer {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_buffer_make(size : Int) -> NlpparsearcstandardBuffer {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_buffer_len(s : NlpparsearcstandardBuffer) -> Int { s.size }

pub fn nlp_parse_arc_standard_buffer_get(s : NlpparsearcstandardBuffer, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_buffer_set(s : NlpparsearcstandardBuffer, i : Int, v : Double) -> NlpparsearcstandardBuffer {
  let result = nlp_parse_arc_standard_buffer_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_buffer_sum(s : NlpparsearcstandardBuffer) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_buffer_mean(s : NlpparsearcstandardBuffer) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_buffer_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_buffer_scale(s : NlpparsearcstandardBuffer, f : Double) -> NlpparsearcstandardBuffer {
  let result = nlp_parse_arc_standard_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_buffer_add(a : NlpparsearcstandardBuffer, b : NlpparsearcstandardBuffer) -> NlpparsearcstandardBuffer {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_buffer_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_buffer_copy(s : NlpparsearcstandardBuffer) -> NlpparsearcstandardBuffer {
  let result = nlp_parse_arc_standard_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_buffer_fill(s : NlpparsearcstandardBuffer, v : Double) -> NlpparsearcstandardBuffer {
  let result = nlp_parse_arc_standard_buffer_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_buffer_min(s : NlpparsearcstandardBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_buffer_max(s : NlpparsearcstandardBuffer) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_buffer_to_string(s : NlpparsearcstandardBuffer) -> String {
  "Buffer[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardCursor {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_cursor_make(size : Int) -> NlpparsearcstandardCursor {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_cursor_len(s : NlpparsearcstandardCursor) -> Int { s.size }

pub fn nlp_parse_arc_standard_cursor_get(s : NlpparsearcstandardCursor, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_cursor_set(s : NlpparsearcstandardCursor, i : Int, v : Double) -> NlpparsearcstandardCursor {
  let result = nlp_parse_arc_standard_cursor_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_cursor_sum(s : NlpparsearcstandardCursor) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_cursor_mean(s : NlpparsearcstandardCursor) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_cursor_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_cursor_scale(s : NlpparsearcstandardCursor, f : Double) -> NlpparsearcstandardCursor {
  let result = nlp_parse_arc_standard_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_cursor_add(a : NlpparsearcstandardCursor, b : NlpparsearcstandardCursor) -> NlpparsearcstandardCursor {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_cursor_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_cursor_copy(s : NlpparsearcstandardCursor) -> NlpparsearcstandardCursor {
  let result = nlp_parse_arc_standard_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_cursor_fill(s : NlpparsearcstandardCursor, v : Double) -> NlpparsearcstandardCursor {
  let result = nlp_parse_arc_standard_cursor_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_cursor_min(s : NlpparsearcstandardCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_cursor_max(s : NlpparsearcstandardCursor) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_cursor_to_string(s : NlpparsearcstandardCursor) -> String {
  "Cursor[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardView {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_view_make(size : Int) -> NlpparsearcstandardView {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_view_len(s : NlpparsearcstandardView) -> Int { s.size }

pub fn nlp_parse_arc_standard_view_get(s : NlpparsearcstandardView, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_view_set(s : NlpparsearcstandardView, i : Int, v : Double) -> NlpparsearcstandardView {
  let result = nlp_parse_arc_standard_view_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_view_sum(s : NlpparsearcstandardView) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_view_mean(s : NlpparsearcstandardView) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_view_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_view_scale(s : NlpparsearcstandardView, f : Double) -> NlpparsearcstandardView {
  let result = nlp_parse_arc_standard_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_view_add(a : NlpparsearcstandardView, b : NlpparsearcstandardView) -> NlpparsearcstandardView {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_view_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_view_copy(s : NlpparsearcstandardView) -> NlpparsearcstandardView {
  let result = nlp_parse_arc_standard_view_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_view_fill(s : NlpparsearcstandardView, v : Double) -> NlpparsearcstandardView {
  let result = nlp_parse_arc_standard_view_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_view_min(s : NlpparsearcstandardView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_view_max(s : NlpparsearcstandardView) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_view_to_string(s : NlpparsearcstandardView) -> String {
  "View[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardRange {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_range_make(size : Int) -> NlpparsearcstandardRange {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_range_len(s : NlpparsearcstandardRange) -> Int { s.size }

pub fn nlp_parse_arc_standard_range_get(s : NlpparsearcstandardRange, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_range_set(s : NlpparsearcstandardRange, i : Int, v : Double) -> NlpparsearcstandardRange {
  let result = nlp_parse_arc_standard_range_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_range_sum(s : NlpparsearcstandardRange) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_range_mean(s : NlpparsearcstandardRange) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_range_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_range_scale(s : NlpparsearcstandardRange, f : Double) -> NlpparsearcstandardRange {
  let result = nlp_parse_arc_standard_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_range_add(a : NlpparsearcstandardRange, b : NlpparsearcstandardRange) -> NlpparsearcstandardRange {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_range_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_range_copy(s : NlpparsearcstandardRange) -> NlpparsearcstandardRange {
  let result = nlp_parse_arc_standard_range_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_range_fill(s : NlpparsearcstandardRange, v : Double) -> NlpparsearcstandardRange {
  let result = nlp_parse_arc_standard_range_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_range_min(s : NlpparsearcstandardRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_range_max(s : NlpparsearcstandardRange) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_range_to_string(s : NlpparsearcstandardRange) -> String {
  "Range[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

pub(all) struct NlpparsearcstandardSlice {
  data : Array[Double]
  size : Int
  tag : Int
}

pub fn nlp_parse_arc_standard_slice_make(size : Int) -> NlpparsearcstandardSlice {
  { data: Array::make(size, 0.0), size, tag: 0 }
}

pub fn nlp_parse_arc_standard_slice_len(s : NlpparsearcstandardSlice) -> Int { s.size }

pub fn nlp_parse_arc_standard_slice_get(s : NlpparsearcstandardSlice, i : Int) -> Double {
  if i < 0 || i >= s.size { 0.0 } else { s.data[i] }
}

pub fn nlp_parse_arc_standard_slice_set(s : NlpparsearcstandardSlice, i : Int, v : Double) -> NlpparsearcstandardSlice {
  let result = nlp_parse_arc_standard_slice_make(s.size)
  for j in 0..<s.size { result.data[j] = s.data[j] }
  if i >= 0 && i < s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_slice_sum(s : NlpparsearcstandardSlice) -> Double {
  let mut total = 0.0
  for i in 0..<s.size { total = total + s.data[i] }
  total
}

pub fn nlp_parse_arc_standard_slice_mean(s : NlpparsearcstandardSlice) -> Double {
  if s.size == 0 { 0.0 } else { nlp_parse_arc_standard_slice_sum(s) / s.size.to_double() }
}

pub fn nlp_parse_arc_standard_slice_scale(s : NlpparsearcstandardSlice, f : Double) -> NlpparsearcstandardSlice {
  let result = nlp_parse_arc_standard_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] * f }
  result
}

pub fn nlp_parse_arc_standard_slice_add(a : NlpparsearcstandardSlice, b : NlpparsearcstandardSlice) -> NlpparsearcstandardSlice {
  let n = if a.size < b.size { a.size } else { b.size }
  let result = nlp_parse_arc_standard_slice_make(n)
  for i in 0..<n { result.data[i] = a.data[i] + b.data[i] }
  result
}

pub fn nlp_parse_arc_standard_slice_copy(s : NlpparsearcstandardSlice) -> NlpparsearcstandardSlice {
  let result = nlp_parse_arc_standard_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = s.data[i] }
  result
}

pub fn nlp_parse_arc_standard_slice_fill(s : NlpparsearcstandardSlice, v : Double) -> NlpparsearcstandardSlice {
  let result = nlp_parse_arc_standard_slice_make(s.size)
  for i in 0..<s.size { result.data[i] = v }
  result
}

pub fn nlp_parse_arc_standard_slice_min(s : NlpparsearcstandardSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] < m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_slice_max(s : NlpparsearcstandardSlice) -> Double {
  if s.size == 0 { 0.0 } else {
    let mut m = s.data[0]
    for i in 1..<s.size { if s.data[i] > m { m = s.data[i] } }
    m
  }
}

pub fn nlp_parse_arc_standard_slice_to_string(s : NlpparsearcstandardSlice) -> String {
  "Slice[" + s.size.to_string() + ",tag=" + s.tag.to_string() + "]"
}

